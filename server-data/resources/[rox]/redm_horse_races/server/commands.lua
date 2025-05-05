RegisterCommand('hostrace', function(source, args)
    local dataId = tonumber(args[1])
    if not dataId then
        return
    end

    local numLaps = tonumber(args[2]) or 1
    if (not numLaps) or numLaps < 1 then
        return
    end

    local warmupTime = tonumber(args[3])
    local race = CreateRace(dataId, numLaps, warmupTime)
    if race then
        printd('%s hosted race %i.', GetPlayerName(source), race.id)
    end
end, true)

RegisterCommand('joinrace', function(source, args)
    local raceId = tonumber(args[1])
    if not raceId then
        return
    end

    if not DoesRaceExist(raceId) then
        return
    end

    if JoinRace(source, raceId) then
        printd('%s joined race %i.', GetPlayerName(source), raceId)
    end
end, true)

RegisterCommand('leaverace', function(source, args)
    local raceId = GetPlayerRaceId(source)
    if not raceId then
        return
    end

    if LeaveRace(source) then
        printd('%s left race %i.', GetPlayerName(source), raceId)
    end
end, true)

RegisterCommand('endracetimer', function(source, args)
    local raceId = tonumber(args[1])
    if not raceId then
        return
    end

    if not DoesRaceExist(raceId) then
        return
    end

    if EndRaceTimer(raceId) then
        printd('%s started race end timer %i.', GetPlayerName(source), raceId)
    end
end, true)

RegisterCommand('endrace', function(source, args)
    local raceId = tonumber(args[1])
    if not raceId then
        return
    end

    if not DoesRaceExist(raceId) then
        return
    end

    if EndRace(raceId) then
        printd('%s ended race %i.', GetPlayerName(source), raceId)
    end
end, true)
