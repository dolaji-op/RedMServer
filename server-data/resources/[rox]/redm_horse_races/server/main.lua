Races = {}
Players = {}
Coronas = {}
Buckets = {}
LastRaceId = 0

DoesRaceExist = function(raceId)
    return GetRaceById(raceId) ~= nil
end

GetRaceById = function(raceId)
    return Races[raceId]
end

GetNextRaceId = function()
    LastRaceId = LastRaceId + 1

    return LastRaceId
end

GetRaceRoute = function(raceId)
    local race = GetRaceById(raceId)
    if not race then
        return nil
    end

    local data = Config.Races[race.dataId]
    if not data then
        return nil
    end

    return data.route
end

CreateRace = function(dataId, numLaps, startDelay)
    local data = Config.Races[dataId]
    if not data then
        return
    end

    local raceId = GetNextRaceId()
    if Races[raceId] then
        return
    end

    startDelay = startDelay or Config.DefaultRaceStartDelay

    local bucket = GetFreeRoutingBucket()
    local startTimstamp = os.time() + startDelay
    local maxPlayers = #data.startPoints > 32 and 32 or #data.startPoints
    local race = {
        id = raceId,
        bucket = bucket,
        name = data.name,
        dataId = dataId,
        laps = numLaps,
        startTimestamp = startTimstamp,
        startClock = nil,
        hasStarted = false,
        players = {},
        maxPlayers = maxPlayers,
        leaderboard = {}
    }

    Races[raceId] = race

    printd('[CreateRace] RACE_(%i): Race created:\ndataId: %i\nlaps: %i\nmaxPlayers: %i', raceId, race.dataId, race.laps, race.maxPlayers)

    printd('[CreateRace] RACE_(%i): Race starting in %i seconds.', raceId, startDelay)
    StartRaceTimer(raceId, function(timeToStart)
        ForEachRacePlayer(raceId, function(player)
            TriggerClientEvent('redm_horse_races:joinedRaceTimer', player.id, timeToStart)
        end)
    end, function(timerStopped)
        if Coronas[race.name] then
            TriggerClientEvent('redm_horse_races:syncCoronaState', -1, race.name, false, -1)

            Coronas[race.name] = nil
        end

        if timerStopped then
            return
        end

        StartRace(raceId)
    end, startDelay)

    return race
end

StartRace = function(raceId)
    local race = GetRaceById(raceId)
    if not race then
        return false
    end

    if race.hasStarted then
        return false
    end

    if #race.players < 2 and Config.Debug then
        Citizen.CreateThread(function()
            ForEachRacePlayer(race.id, function(player)
                TriggerClientEvent('redm_horse_races:raceCanceled', player.id)

                LeaveRace(player.id)
            end)

            SetRoutingBucketAsFree(race.bucket)
            Races[race.id] = nil

            printd('[StartRace] RACE_(%i): Can\'t start race, not enough players!', raceId)
        end)

        return false
    end

    if IsOneSyncEnabled() then
        ResetRacePlayersReadyStatus(race.id)
        ForEachRacePlayer(race.id, function(player)
            TriggerClientEvent('redm_horse_races:os:requestPlayerMount', player.id)
        end)

        printd('[StartRace][OS] RACE_(%i): Waiting for players to register their mounts...', raceId)
        while not IsRacePlayersReady(race.id, Config.SyncedActionRegisterMountsTimeout) do
            Citizen.Wait(500)
        end

        printd('[StartRace][OS] RACE_(%i): All players has registered their mounts.', raceId)
    end

    race.hasStarted = true

    ResetRacePlayersReadyStatus(race.id)
    ForEachRacePlayer(race.id, function(player)
        if race.bucket then
            SetPlayerRoutingBucket(player.id, race.bucket)

            if player.horseId and DoesEntityExist(player.horseId) then
                SetEntityRoutingBucket(player.horseId, race.bucket)
            else
                printe('[StartRace][OS] RACE_(%i): %s has invalid mount!', raceId, player.name)
            end
        end

        TriggerClientEvent('redm_horse_races:initRace', player.id, race.dataId, race.laps, race.players)
    end)

    if race.bucket then
        printd('[StartRace][OS] RACE_(%i): All players & mounts moved to routing bucket %s.', raceId, race.bucket)
    end

    Citizen.CreateThread(function()
        printd('[StartRace] RACE_(%i): Waiting for players to init race route...', raceId)
        while not IsRacePlayersReady(race.id, Config.SyncedActionInitRaceTimeout) do
            Citizen.Wait(500)
        end

        printd('[StartRace] RACE_(%i): All players has initiated race route.', raceId)

        if Config.EnableIntroFlowCutscene then
            ResetRacePlayersReadyStatus(race.id)
            ForEachRacePlayer(race.id, function(player)
                TriggerClientEvent('redm_horse_races:startRaceIntroFlow', player.id)
            end)

            printd('[StartRace] RACE_(%i): Waiting for players to finish intro flow cutscene...', raceId)
            while not IsRacePlayersReady(race.id, Config.SyncedActionFinishIntroFlowTimeout) do
                Citizen.Wait(500)
            end

            printd('[StartRace] RACE_(%i): All players has finished intro flow cutscene.', raceId)
        end

        ResetRacePlayersReadyStatus(race.id)
        ForEachRacePlayer(race.id, function(player)
            TriggerClientEvent('redm_horse_races:prepareRaceCountdown', player.id)
        end)

        printd('[StartRace] RACE_(%i): Waiting for players to prepare countdown...', raceId)
        while not IsRacePlayersReady(race.id, Config.SyncedActionPrepareCountdownTimeout) do
            Citizen.Wait(500)
        end

        printd('[StartRace] RACE_(%i): All players has prepared countdown.', raceId)
        ResetRacePlayersReadyStatus(race.id)
        ForEachRacePlayer(race.id, function(player)
            TriggerClientEvent('redm_horse_races:startRaceCountdown', player.id)
        end)

        printd('[StartRace] RACE_(%i): Waiting for players to finish countdown...', raceId)
        while not IsRacePlayersReady(race.id, Config.SyncedActionFinishCountdownTimeout) do
            Citizen.Wait(500)
        end

        printd('[StartRace] RACE_(%i): All players has finished countdown.', raceId)
        race.startClock = os.clock()
        ForEachRacePlayer(race.id, function(player)
            TriggerClientEvent('redm_horse_races:startRace', player.id)
        end)

        printd('[StartRace] RACE_(%i): Race started!', raceId)
    end)
end

EndRaceTimer = function(raceId, endTimerDelay)
    local race = GetRaceById(raceId)
    if not race then
        return false
    end

    if not race.hasStarted then
        return false
    end

    if race.hasEnded then
        return false
    end

    if race.hasEndTimerStarted then
        return false
    end

    race.hasEndTimerStarted = true
    endTimerDelay = endTimerDelay or Config.DefaultRaceEndTimerDelay

    ForEachRacePlayer(race.id, function(player)
        TriggerClientEvent('redm_horse_races:startRaceEndTimer', player.id)
    end)

    StartRaceTimer(raceId, function(timeToEnd, stopTimerFnc)
        if race.hasEnded then
            return stopTimerFnc()
        end

        ForEachRacePlayer(raceId, function(player)
            TriggerClientEvent('redm_horse_races:updateRaceEndTimer', player.id, timeToEnd, endTimerDelay)
        end)
    end, function(timerStopped)
        if timerStopped then
            return
        end

        EndRace(race.id)
    end, endTimerDelay)

    printd('[EndRaceTimer] RACE_(%i): Started end race timer (%ss).', raceId, endTimerDelay)

    return true
end

EndRace = function(raceId, cleanupDelay)
    local race = GetRaceById(raceId)
    if not race then
        return false
    end

    if not race.hasStarted then
        return false
    end

    if race.hasEnded then
        return false
    end

    race.hasEnded = true
    cleanupDelay = cleanupDelay or Config.DefaultRaceCleanupDelay

    ResetRacePlayersReadyStatus(race.id)
    ForEachRacePlayer(race.id, function(player)
        TriggerClientEvent('redm_horse_races:raceEnded', player.id)
    end)

    Citizen.CreateThread(function()
        printd('[EndRace] RACE_(%i): Waiting for players to end race...', raceId)
        while not IsRacePlayersReady(race.id, Config.SyncedActionEndRaceTimeout) do
            Citizen.Wait(500)
        end

        printd('[EndRace] RACE_(%i): All players has ended race.', raceId)

        if Config.EnableEndFlowCutsceneAndLeaderboard then
            ResetRacePlayersReadyStatus(race.id)
            ForEachRacePlayer(race.id, function(player)
                TriggerClientEvent('redm_horse_races:prepareRaceEndFlow', player.id)
            end)

            printd('[EndRace] RACE_(%i): Waiting for players to prepare end flow cutscene...', raceId)
            while not IsRacePlayersReady(race.id, Config.SyncedActionPrepareEndFlowTimeout) do
                Citizen.Wait(500)
            end

            printd('[EndRace] RACE_(%i): All players has prepared end flow cutscene.', raceId)

            local endFlowElements = GetRaceEndFlowElements(raceId)
            ResetRacePlayersReadyStatus(race.id)
            ForEachRacePlayer(race.id, function(player)
                TriggerClientEvent('redm_horse_races:startRaceEndFlow', player.id, {
                    dataId = race.dataId,

                    config = {
                        statRounds = '',
                        stat1 = 'UIC_LB_KILLS',
                        stat2 = 'UIC_LB_TIME',
                        stat3 = ''
                    },

                    elements = endFlowElements
                })
            end)

            printd('[EndRace] RACE_(%i): Waiting for players to finish end flow cutscene...', raceId)
            while not IsRacePlayersReady(race.id, Config.SyncedActionFinishEndFlowTimeout) do
                Citizen.Wait(500)
            end

            printd('[EndRace] RACE_(%i): All players has finished end flow cutscene.', raceId)
        end

        printd('[EndRace] RACE_(%i): Started cleanup timer (%ss).', raceId, cleanupDelay)

        Citizen.SetTimeout(cleanupDelay * 1000, function()
            if not DoesRaceExist(race.id) then
                return
            end

            ForEachRacePlayer(race.id, function(player)
                LeaveRace(player.id)
            end)

            SetRoutingBucketAsFree(race.bucket)
            Races[race.id] = nil

            printd('[EndRace] RACE_(%i): Race ended!', raceId)
        end)
    end)

    return true
end

GetRaceEndFlowElements = function(raceId)
    local race = GetRaceById(raceId)
    if not race then
        return false
    end

    local elements = {}
    for _, player in pairs(race.players) do
        local stat2 = 'POS_DNF'

        if not player.leftRace then
            if player.finishedTime then
                stat2 = GetRaceTimerString(player.finishedTime * 1000)
            else
                stat2 = 'POS_OOT'
            end
        end

        table.insert(elements, {
            source = player.id,
            finishedPlace = player.finishedPlace,
            finishedTime = player.finishedTime,

            gamertag = player.name,
            showRank = false,
            stat1 = tostring(player.kills),
            stat2 = stat2,
            stat3 = ''
        })
    end

    table.sort(elements, function(a, b)
        return (a.finishedPlace or 99999) < (b.finishedPlace or 99999)
    end)

    for place = 1, 3 do
        if elements[place] and elements[place].finishedPlace then
            if place == 1 then
                elements[place].gamertagColor = GetHashKey('COLOR_GOLD')
                elements[place].blip = 'BLIP_MVP'
                elements[place].blipColor = GetHashKey('COLOR_GOLD')
                elements[place].stat0 = 'POS_LEAD'
            elseif place == 2 then
                elements[place].gamertagColor = GetHashKey('COLOR_PLATINUM')
                elements[place].blipColor = GetHashKey('COLOR_PLATINUM')
            elseif place == 3 then
                elements[place].gamertagColor = GetHashKey('COLOR_BRONZE')
                elements[place].blipColor = GetHashKey('COLOR_BRONZE')
            end
        end
    end

    return elements
end

GetRaceTimerString = function(timeElapsed)
    local seconds = math.floor(timeElapsed / 1000)
    local mins = string.format('%02.f', math.floor(seconds / 60))
    local secs = string.format('%02.f', math.floor(seconds - (mins * 60)))
    local ms = string.format('%02.f', math.floor((timeElapsed % 1000) / 10))

    return ('%02d:%02d.%02d'):format(mins, secs, ms)
end

StartRaceTimer = function(raceId, onTick, onEnd, delay)
    local race = GetRaceById(raceId)
    if not race then
        return
    end

    local timerTimestamp = os.time() + delay
    local stopTimer = false
    local stopTimerFnc = function()
        stopTimer = true
    end

    Citizen.CreateThread(function()
        local time = timerTimestamp - os.time()

        while time >= 0 and not stopTimer do
            if not DoesRaceExist(raceId) then
                stopTimer = true

                break
            end

            if onTick then
                onTick(time, stopTimerFnc)
            end

            time = timerTimestamp - os.time()

            Citizen.Wait(1000)
        end

        if onEnd then
            onEnd(stopTimer)
        end
    end)

    return stopTimerFnc
end

RegisterNetEvent('redm_horse_races:os:registerRaceMount', function(netId)
    local _source = source

    if not IsOneSyncEnabled() then
        return
    end

    local raceId = GetPlayerRaceId(_source)
    if not raceId then
        return
    end

    local race = GetRaceById(raceId)
    if not race or race.hasStarted then
        return
    end

    local player = GetRacePlayerById(raceId, _source)
    if not player or player.horseId then
        return
    end

    local mount = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(mount) then
        printe('EV_RegisterMount()(OS): Unable to register %s mount, invalid entity.', player.name)

        return LeaveRace(player.id)
    end

    if GetEntityType(mount) ~= 1 then
        printe('EV_RegisterMount()(OS): Unable to register %s mount, invalid entity type.', player.name)

        return LeaveRace(player.id)
    end

    if NetworkGetEntityOwner(mount) ~= player.id then
        printe('EV_RegisterMount()(OS): Unable to register %s mount, invalid entity owner.', player.name)

        return LeaveRace(player.id)
    end

    player.horseId = mount
    player.horseNetId = netId
    printd('EV_RegisterMount()(OS): Registered %s (netId: %s) as %s race mount.', mount, netId, player.name)

    return MarkRacePlayerAsReady(race.id, player.id)
end)

RegisterNetEvent('redm_horse_races:completedCheckpoint', function(checkpointId, lap)
    local _source = source

    local raceId = GetPlayerRaceId(_source)
    if not raceId then
        return
    end

    local race = GetRaceById(raceId)
    if not race or not race.hasStarted then
        return
    end

    local route = GetRaceRoute(raceId)
    if not route then
        return
    end
    local player = GetRacePlayerById(raceId, _source)
    if not player then
        return
    end

    printd('[EV_CompletedCheckpoint] RACE_(%i): Player %s completed checkpoint (%i/%i)!', raceId, player.name, player.checkpoint, #route)

    local isFinalCheckpoint = (player.checkpoint == (#route - 1))
    if isFinalCheckpoint and (player.lap + 1) >= race.laps then
        TriggerClientEvent('redm_horse_races:playerFinalCheckpoint', player.id)
    end

    local isLastCheckpoint = (player.checkpoint == #route)
    if isLastCheckpoint and (player.lap + 1) <= race.laps then
        player.lap = player.lap + 1

        printd('[EV_CompletedCheckpoint] RACE_(%i): Player %s started new lap (%i/%i)!', raceId, player.name, player.lap, race.laps)
    elseif isLastCheckpoint then
        local finishPlace = #race.leaderboard + 1
        local finishTime = os.clock() - race.startClock
        table.insert(race.leaderboard, player)

        player.finishedPlace = finishPlace
        player.finishedTime = finishTime

        ForEachRacePlayer(race.id, function(rPlayer)
            TriggerClientEvent('redm_horse_races:playerFinishedRaceFeed', rPlayer.id, player.id, player.name, player.finishedPlace)
        end)

        printd('[EV_CompletedCheckpoint] RACE_(%i): Player %s finished race at %i place with time %s.', raceId, player.name, finishPlace, finishTime)

        local activePlayers = #GetRacePlayers(race.id)
        local activePlayersFinishedRace = #GetRacePlayersFinishedRace(race.id)

        if activePlayersFinishedRace >= activePlayers then
            return EndRace(race.id)
        end

        if Config.EnableRaceEndTimer and (activePlayersFinishedRace >= (activePlayers / 2)) then
            printd('[EV_CompletedCheckpoint] RACE_(%i): More than half active players finished race (%i/%i), starting end timer.', raceId,
                activePlayersFinishedRace, activePlayers)

            EndRaceTimer(race.id)
        end
    end

    if not player.finishedPlace then
        local _, nextCheckpointId = GetNextRouteCheckpoint(route, player.checkpoint)
        if not nextCheckpointId then
            return
        end

        player.checkpoint = nextCheckpointId
    end

    ForEachRacePlayer(raceId, function(rPlayer)
        TriggerClientEvent('redm_horse_races:playerCompletedCheckpoint', rPlayer.id, player.id, player.checkpoint, player.lap, player.finishedPlace,
            player.finishedTime)
    end)
end)

RegisterNetEvent('redm_horse_race:playerDeath', function(death)
    local _source = source

    local raceId = GetPlayerRaceId(_source)
    if not raceId then
        return
    end

    local race = GetRaceById(raceId)
    if not race or not race.hasStarted or race.hasEnded then
        return
    end

    local player = GetRacePlayerById(raceId, _source)
    if not player then
        return
    end

    player.deaths = player.deaths + 1

    if death.killer then
        local killer = GetRacePlayerById(raceId, death.killer.source)
        if not killer then
            return
        end

        killer.kills = killer.kills + 1

        return printd('[EV_PlayerDeath] RACE_(%i): Player %s got killed by %s, updated deaths/kills stat (D: %i | K: %i). ', raceId, player.name,
            killer.name, player.deaths, killer.kills)
    end

    printd('[EV_PlayerDeath] RACE_(%i): Player %s got killed, updated deaths stat (%i). ', raceId, player.name, player.deaths)
end)

-- // Join/Leave
JoinRace = function(playerId, raceId)
    if IsPlayerInRace(playerId) then
        return false
    end

    local race = GetRaceById(raceId)
    if not race then
        return false
    end

    if race.hasStarted then
        return false
    end

    if not ((#race.players + 1) <= race.maxPlayers) then
        return false
    end

    table.insert(race.players, {
        id = playerId,
        name = GetPlayerName(playerId),
        horseId = nil,
        horseNetId = nil,
        checkpoint = 1,
        lap = 1,
        kills = 0,
        deaths = 0,
        finishedPlace = nil,
        finishedTime = nil,
        leftRace = false,
        ack = false,
        ackTime = nil
    })

    Players[playerId] = race.id

    TriggerClientEvent('redm_horse_races:joinedRace', playerId, race.id)

    return true
end

LeaveRace = function(playerId)
    local raceId = GetPlayerRaceId(playerId)
    if not raceId then
        return false
    end

    local race = GetRaceById(raceId)
    if not race then
        return false
    end

    for index, player in ipairs(race.players) do
        if player.id == playerId then
            if race.hasStarted then
                player.leftRace = true
            else
                table.remove(race.players, index)
            end

            if race.bucket and (GetPlayerRoutingBucket(player.id) ~= 0) then
                SetPlayerRoutingBucket(player.id, 0)

                if player.horseId and DoesEntityExist(player.horseId) then
                    if GetEntityRoutingBucket(player.horseId) ~= 0 then
                        SetEntityRoutingBucket(player.horseId, 0)
                    end
                else
                    printe('[LeaveRace][OS] RACE_(%i): Failed to move mount of %s to routing bucket 0, mount invalid!', raceId, player.name)
                end

                printd('[LeaveRace][OS] RACE_(%i): %s moved to routing bucket 0.', raceId, player.name)
            end

            Players[playerId] = nil
            TriggerClientEvent('redm_horse_races:leftRace', playerId, race.dataId)

            if #GetRacePlayers(race.id) == 0 then
                SetRoutingBucketAsFree(race.bucket)
                Races[race.id] = nil

                printd('[LeaveRace] RACE_(%i): Race ended, not enough players!', raceId)
            end

            return true
        end
    end

    return false
end

RegisterNetEvent('redm_horse_races:leaveRace', function()
    local _source = source
    local raceId = GetPlayerRaceId(_source)
    if not raceId then
        return
    end

    if not DoesRaceExist(raceId) then
        return
    end

    if LeaveRace(_source) then
        printd('[EV_LeaveRace] RACE_(%i): Player %s left race!', raceId, GetPlayerName(_source))
    end
end)

-- // Players ready
IsRacePlayersReady = function(raceId, maxTimeoutSecs)
    local race = GetRaceById(raceId)
    if not race then
        return false
    end

    if maxTimeoutSecs == -1 then
        maxTimeoutSecs = nil
    end

    local result = true
    local timeoutedPlayers = {}
    for _, player in ipairs(race.players) do
        if not player.leftRace then
            if not player.ack then
                if maxTimeoutSecs and ((os.time() - player.ackTime) > maxTimeoutSecs) then
                    table.insert(timeoutedPlayers, player.id)
                end

                result = false
            end
        end
    end

    for _, playerId in ipairs(timeoutedPlayers) do
        if LeaveRace(playerId) then
            printw('[SyncedAction] RACE_(%i): Player %s removed from race, due to excedeed synced action timeout (maxTimeout: %s).', raceId, GetPlayerName(playerId), maxTimeoutSecs)
        end
    end

    return result
end

MarkRacePlayerAsReady = function(raceId, playerId)
    local race = GetRaceById(raceId)
    if not race then
        return false
    end

    for _, player in ipairs(race.players) do
        if player.id == playerId then
            player.ack = true

            return true
        end
    end

    return false
end

ResetRacePlayersReadyStatus = function(raceId)
    local race = GetRaceById(raceId)
    if not race then
        return false
    end

    for _, player in ipairs(race.players) do
        player.ack = false
        player.ackTime = os.time()
    end

    return true
end

RegisterNetEvent('redm_horse_races:markMeAsReady', function()
    local _source = source
    local raceId = GetPlayerRaceId(_source)
    if not raceId then
        return
    end

    if not DoesRaceExist(raceId) then
        return
    end

    if MarkRacePlayerAsReady(raceId, _source) then
        printd('[EV_MarkMeAsReady] RACE_(%i): Player %s marked as ready!', raceId, GetPlayerName(_source))
    end
end)

-- // Race player utils
IsPlayerInRace = function(playerId)
    return GetPlayerRaceId(playerId) ~= nil
end

GetPlayerRaceId = function(playerId)
    return Players[playerId]
end

GetRacePlayerById = function(raceId, playerId)
    local race = GetRaceById(raceId)
    if not race then
        return nil
    end

    for index, data in ipairs(race.players) do
        if data.id == playerId then
            return data, index
        end
    end

    return nil
end

GetRacePlayers = function(raceId)
    local race = GetRaceById(raceId)
    if not race then
        return
    end

    local players = {}
    for index, player in ipairs(race.players) do
        if not player.leftRace then
            table.insert(players, player)
        end
    end

    return players
end

GetRacePlayersFinishedRace = function(raceId)
    local race = GetRaceById(raceId)
    if not race then
        return
    end

    local players = {}
    for index, player in ipairs(race.players) do
        if not player.leftRace then
            if player.finishedPlace then
                table.insert(players, player)
            end
        end
    end

    return players
end

ForEachRacePlayer = function(raceId, action)
    local race = GetRaceById(raceId)
    if not race then
        return
    end

    for index, player in ipairs(race.players) do
        if not player.leftRace then
            action(player, index)
        end
    end
end

-- // Route utils
GetNextRouteCheckpoint = function(route, currCheckpointId, useForwarding)
    local nextCheckpointId = GetNextRouteCheckpointId(route, currCheckpointId, useForwarding)

    return route[nextCheckpointId], nextCheckpointId
end

GetNextRouteCheckpointId = function(route, currCheckpointId, useForwarding)
    local nextCheckpointId, checkpointId = currCheckpointId + 1, 1
    if #route >= nextCheckpointId then
        checkpointId = nextCheckpointId
    elseif useForwarding then
        checkpointId = checkpointId + (nextCheckpointId - #route)
    end

    return checkpointId
end

GetRouteTotalDistance = function(route, laps)
    local partsChecked = {}
    local dist = 0.0

    for index, part in ipairs(route) do
        local nextIndex = index + 1

        if route[nextIndex] and not partsChecked[nextIndex] then
            dist = dist + #(part - route[nextIndex])
            partsChecked[nextIndex] = true
        end
    end

    dist = dist + GetRouteDistanceBetweenParts(route, 1, #route)

    return (dist * (laps or 1)) + 0.0
end

GetRouteDistanceBetweenParts = function(route, partId, partId2)
    if route[partId] and route[partId2] then
        return #(route[partId] - route[partId2])
    end

    return 0.0
end

GetRouteRacePlayerDistance = function(route, playerId, currentLap, currentCheckpoint)
    local dist = GetRouteTotalDistance(route, currentLap - 1)
    if currentCheckpoint > 1 then
        dist = dist + GetRouteDistanceBetweenParts(route, 1, #route)
    end

    local ped = GetPlayerPed(playerId)
    if not DoesEntityExist(ped) then
        return dist
    end

    local partsChecked, isFirstCheckpoint = {}, (currentCheckpoint == 1)
    for index, part in ipairs(route) do
        local nextIndex = (isFirstCheckpoint and index) or index + 1
        if nextIndex > currentCheckpoint then
            break
        end

        if route[nextIndex] and not partsChecked[nextIndex] then
            local nextPart = ToV3(route[nextIndex])

            if isFirstCheckpoint then
                part = route[#route]
            end

            local distToNextPart = #(ToV3(part) - nextPart)
            if (nextIndex == currentCheckpoint) then
                distToNextPart = (distToNextPart - #(GetEntityCoords(ped) - nextPart))

                if distToNextPart < 0.0 then
                    distToNextPart = 0.0
                end
            end

            dist = dist + distToNextPart
            partsChecked[nextIndex] = true
        end
    end

    return dist
end

-- // Coronas
GetDataIdByName = function(name)
    for id, data in ipairs(Config.Races) do
        if data.name == name then
            return id
        end
    end

    return nil
end

RegisterNetEvent('redm_horse_races:requestCoronasStateSync', function()
    local _source = source
    local activeCoronas = {}

    for name, data in pairs(Coronas) do
        table.insert(activeCoronas, {
            name = name,
            laps = data.laps
        })
    end

    if #activeCoronas == 0 then
        return
    end

    TriggerClientEvent('redm_horse_races:syncCoronasState', _source, activeCoronas)
end)

RegisterNetEvent('redm_horse_races:joinCorona', function(name)
    local _source = source

    if not Coronas[name] then
        return
    end

    if not JoinRace(_source, Coronas[name].raceId) then
        return
    end

    printd('EV_JoinCorona(): %s joined race %i using corona.', GetPlayerName(_source), Coronas[name].raceId)
end)

RegisterNetEvent('redm_horse_races:hostCorona', function(name, laps)
    local _source = source

    local dataId = GetDataIdByName(name)
    if not dataId then
        return
    end

    if Coronas[name] then
        return
    end

    local race = CreateRace(dataId, Clamp(laps, 1, 32))
    if not race then
        return printe('EV_HostCorona(): %s failed to host race using corona (%s).', GetPlayerName(_source), name)
    end

    if not JoinRace(_source, race.id) then
        return printe('EV_HostCorona(): %s failed to join race using corona (%s).', GetPlayerName(_source), name)
    end

    Coronas[name] = {
        raceId = race.id,
        laps = laps
    }

    TriggerClientEvent('redm_horse_races:syncCoronaState', -1, name, true, laps)

    printd('%s hosted race %s using corona.', GetPlayerName(_source), dataId)
end)

-- // Buckets
GetFreeRoutingBucket = function()
    if not IsOneSyncEnabled() then
        return nil
    end

    if not Config.EnableRoutingBuckets then
        return nil
    end

    for i = Config.RoutingBucketRangeStart, Config.RoutingBucketRangeEnd do
        if not Buckets[i] then
            Buckets[i] = true

            return i
        end
    end

    return nil
end

SetRoutingBucketAsFree = function(bucket)
    if Buckets[bucket] then
        Buckets[bucket] = nil
    end
end

AddEventHandler('onResourceStop', function (rsc)
    if GetCurrentResourceName() == rsc then
        for _, playerId in pairs(Players) do
            LeaveRace(playerId)
        end
    end
end)