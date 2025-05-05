IsRaceActive = false
IsMatchmakingActive = false
HasRaceStarted = false
HasRaceFinished = false
HasRaceEnded = false
WaitingForRaceInit = false

Players = {}
Props = {}
Checkpoints = {}
CurrentMount = nil
CurrentCheckpointId = nil
CurrentLap = 0

CentralInfoData = nil
RevTransAnimScene = nil
IntroFlowAnimScene = nil
FinishCam = nil
EndTimerSoundId = nil
EndFlowAnimScene = nil
EndFlowRegion = nil
SceneToPhotoTrans = nil
CloudsTransAnimScene = nil
PopulationVolume = nil

Coronas = {}
CurrentCorona = nil
CoronaUi = nil
CoronaFlowblock = nil
CoronaPrompts = nil
CoronaLaps = nil

EndFlowRegions = {
    ['HEARTLANDS'] = {
        offset = vector3(0.0, 0.0, 0.0),
        ipls = {_H('MP001_U_07P_WINLOSE'), 435889881, -1616778617, -1852748182},
        districts = {_H('BIGVALLEY'), _H('GREATPLAINS'), _H('HEARTLANDS'), _H('SCARLETTMEADOWS'), _H('HENNIGANSSTEAD')}
    },
    ['SWAMP'] = {
        offset = vector3(0.0, -440.0, 0.0),
        ipls = {_H('MP001_MP_WINLOSE_SWAMP'), -2036638644, -209782407, -1068985587},
        districts = {_H('BAYOUNWA'), _H('BLUEWATERMARSH'), _H('GUARMAD'), _H('ROANOKE')}
    },
    ['SNOW'] = {
        offset = vector3(0.0, -880.0, 0.0),
        ipls = {_H('MP001_MP_WINLOSE_SNOW'), 908140270, 1417440092, 649433039},
        districts = {_H('GRIZZLIESEAST'), _H('GRIZZLIESWEST')}
    },
    ['DESERT'] = {
        offset = vector3(0.0, -1320.0, 0.0),
        ipls = {_H('MP001_MP_WINLOSE_DESERT'), 2077558044, -1336911409, -1029570958},
        districts = {_H('GAPTOOTHRIDGE'), _H('RIOBRAVO'), _H('CHOLLASPRINGS')}
    },
    ['FOREST'] = {
        offset = vector3(0.0, -1760.0, 0.0),
        ipls = {_H('MP001_MP_WINLOSE_FOREST'), 205032683, 686788855, -1228362565},
        districts = {_H('CUMBERLAND'), _H('TALLTREES')}
    }
}

LoadRaceAssets = function()
    _TextBlockRequest('UIC')
    while not _TextBlockIsLoaded('UIC') do
        Citizen.Wait(0)
    end

    _TextBlockRequest('RC_PLAY')
    while not _TextBlockIsLoaded('RC_PLAY') do
        Citizen.Wait(0)
    end

    RequestModel(_H('P_CRATE05X'))
    while not HasModelLoaded(_H('P_CRATE05X')) do
        Citizen.Wait(0)
    end

    RequestNamedPtfxAsset(_H('SCR_NET_RACE_CHECKPOINTS'))
    while not HasNamedPtfxAssetLoaded(_H('SCR_NET_RACE_CHECKPOINTS')) do
        Citizen.Wait(0)
    end

    while not _PrepareSoundset('RDRO_Race_sounds', 0) do
        Citizen.Wait(0)
    end

    while not _PrepareSoundset('RDRO_Countdown_Sounds', 0) do
        Citizen.Wait(0)
    end

    while not _PrepareSoundset('rdro_gamemode_transition_sounds', 0) do
        Citizen.Wait(0)
    end

    while not _PrepareSoundset('MP_Leaderboard_Sounds', 0) do
        Citizen.Wait(0)
    end

    printd('LoadRaceAssets(): Loaded all race assets.')
end

UnloadRaceAssets = function()
    _TextBlockDelete('UIC')
    _TextBlockDelete('RC_PLAY')
    SetModelAsNoLongerNeeded(_H('P_CRATE05X'))
    RemoveNamedPtfxAsset(_H('SCR_NET_RACE_CHECKPOINTS'))
    _ReleaseSoundset('RDRO_Race_sounds')
    _ReleaseSoundset('RDRO_Countdown_Sounds')
    _ReleaseSoundset('rdro_gamemode_transition_sounds')
    _ReleaseSoundset('MP_Leaderboard_Sounds')

    printd('UnloadRaceAssets(): Unloaded all race assets.')
end

LoadRaceProps = function(props)
    if not props or #props == 0 then
        return printd('LoadRaceProps(): Invalid race props, skipped loading.')
    end

    for index, prop in ipairs(props) do
        local model = tonumber(prop.model) or GetHashKey(prop.model)

        if IsModelInCdimage(model) then
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end

            local entity = CreateObjectNoOffset(model, prop.pos, false, true, false, false)
            SetEntityRotation(entity, prop.rot, 2, false)

            if not prop.noAutoAlignToGround then
                local ground = FindGroundIntersection(prop.pos, 2, 20, false, true)

                if ground then
                    SetEntityCoordsNoOffset(entity, prop.pos.x, prop.pos.y, ground, false, false, false)
                else
                    printw('LoadRaceProps(): Failed to auto align prop (i=%i, pos=%s) to ground.', index, prop.pos)
                end
            end

            if prop.isTrackElement then
                _SetAutoJumpableByHorse(entity, false)
                _SetNotJumpableByHorse(entity, true)
                SetCanClimbOnEntity(entity, false)
                SetCanAutoVaultOnEntity(entity, false)
            end

            FreezeEntityPosition(entity, true)
            SetModelAsNoLongerNeeded(model)

            table.insert(Props, entity)
        else
            printe('LoadRaceProps(): Failed to create prop (i=%i) invalid model %s.', index, prop.model)
        end
    end

    printd('LoadRaceProps(): Loaded all race props.')
end

UnloadRaceProps = function()
    if not Props or (#Props == 0) then
        return
    end

    for _, entity in ipairs(Props) do
        if DoesEntityExist(entity) then
            DeleteEntity(entity)
        end
    end

    printd('UnloadRaceProps(): Unloaded all race props.')
end

InitRace = function(raceId, numLaps, players)
    if IsRaceActive then
        return false
    end

    local race = Config.Races[raceId]
    if not race then
        return false
    end

    IsRaceActive, HasRaceStarted, HasRaceFinished, HasRaceEnded, Players, Props = true, false, false, false, players, {}

    CurrentMount = GetMount(PlayerPedId())
    local isMountValid, exitCode = ValidateLocalPlayerMount(CurrentMount)
    if not isMountValid then
        CleanupRace()

        printe('InitRace(): Failed to validate player mount (%s).', exitCode)

        return false
    end

    if not AssignPlayerStartPosition(race.startPoints) then
        CleanupRace()

        printe('InitRace(): Failed to assign player start position.')
        
        return false
    end

    LoadRaceAssets()
    LoadRaceProps(race.props)
    StartRouteControllerThread(race.route, numLaps)
    StarHudControllerThread(race.route, numLaps)
    StartMusicControllerThread(race.route, numLaps)
    StartPlayerControllerThread(race.route, race.startPoints)
    StartPopulationControllerThread(race.population)
    StartPadControllerThread()
    StartDebugThread(race.route, numLaps)
    printd('InitRace(): Race with route %i created with %i laps.', raceId, numLaps)

    return true
end

CleanupRace = function()
    StopReverseCamTransition()
    StopRaceIntroFlow()
    RemoveFinishCam()
    StopEndTimerCountdownSound()
    StopRaceEndFlow()
    StopSceneToPhotoTransition()
    HideTransitionData()
    HideLeaderboard(true)
    StopCloudsTransition()
    BusyspinnerOff()
    ShutdownLoadingScreen()
    _UiFeedClearChannel(11, 1, 0)
    _UiFeedClearChannel(12, 1, 0)
    UnlockLocalPlayer()
    ShowLocalPlayer()
    _SetLocalPlayerAsGhost(false)
    DoScreenFadeIn(0)

    if not IsRaceActive then
        return
    end

    IsRaceActive = false
    UnloadRaceAssets()
    UnloadRaceProps()
    RemoveRacePopulationRestrictions()
    CleanupCheckpoints()
    RemoveCentralInfoHud(CentralInfoData)
    TriggerMusicEvent('MC_MUSIC_STOP')
    SetAudioFlag('MusicIgnoreDeathArrest', false)
    _StopAllScriptedAudioSounds()
end

ValidateLocalPlayerMount = function(mount)
    if not DoesEntityExist(mount) then
        return false, 'VPM_MOUNT_NOT_FOUND'
    end

    if not (NetworkGetEntityIsNetworked(mount) == 1) then
        return false, 'VPM_MOUNT_NOT_NETWORKED'
    end

    if not (_GetRiderOfMount(mount, true) == PlayerPedId()) then
        return false, 'VPM_MOUNT_INVALID_RIDER'
    end

    if not _IsMountSeatFree(mount, 0) then
        return false, 'VPM_MOUNT_SEAT_NOT_FREE'
    end

    return true
end

AssignPlayerStartPosition = function(startPoints)
    if #startPoints < #Players then
        printe('AssignPlayerStartPosition(): There isn\'t enough start points for players (%i/%i).', #startPoints, #Players)

        return false
    end

    local startPos = GetLocalPlayerStartPos()
    if not startPos then
        printe('AssignPlayerStartPosition(): Failed to find start position for player.')

        return false
    end

    local startPoint = startPoints[startPos]
    if not startPoint then
        printe('AssignPlayerStartPosition(): Failed to find start point for player.')

        return false
    end

    StartPlayerTeleport(PlayerId(), startPoint, true, true, false, false)
    while not _UpdatePlayerTeleport(PlayerId()) do
        Citizen.Wait(0)
    end

    printd('AssignPlayerStartPosition(): Teleported player to startPoint %i.', startPos)

    if not RespawnLocalPlayer(false, CurrentMount) then
        printe('AssignPlayerStartPosition(): Failed to respawn player.')

        return false
    end

    _PlaceEntityOnGroundProperly(CurrentMount)
    printd('AssignPlayerStartPosition(): Respawned player.')

    LockLocalPlayer()
    printd('AssignPlayerStartPosition(): Locked player.')

    return true
end

GetReverseCamTransAnimDict = function(playerPed)
    if IsPedOnMount(playerPed) then
        if IsPedMale(playerPed) then
            return 'script@mp@trans@ReverseAngleCam_OnHorse_M'
        else
            return 'script@mp@trans@ReverseAngleCam_OnHorse_F'
        end
    else
        if IsPedMale(playerPed) then
            return 'script@mp@trans@ReverseAngleCam_M'
        else
            return 'script@mp@trans@ReverseAngleCam_F'
        end
    end
end

GetReverseCamTransCamIndex = function(playerPed)
    local _, currWeapon = GetCurrentPedWeapon(playerPed, true, 0, false)
    if _IsWeaponPistol(currWeapon) or _IsWeaponRevolver(currWeapon) then
        return 0
    end

    if _IsPedArmed(playerPed, 6) then
        if math.random(0, 10) < 5 then
            return 0
        else
            return 2
        end
    else
        return GetGameTimer() % 4
    end
end

GetReverseCamTransAimCoords = function(playerPed, animScene, camIndex)
    local result = {
        x = nil,
        y = nil,
        z = nil
    }

    ClearPedTasksImmediately(playerPed, false, true)

    local camOffset = {
        x = 0.56,
        y = 0.9,
        z = -0.04
    }
    if camIndex == 0 then
        camOffset = {
            x = -0.38,
            y = 0.0,
            z = -0.03
        }
    elseif camIndex == 1 then
        camOffset = {
            x = -1.0,
            y = 0.58,
            z = -0.06
        }
    elseif camIndex == 2 then
        camOffset = {
            x = 0.44,
            y = 0.14,
            z = -0.02
        }
    end

    if IsPedOnMount(playerPed) then
        camOffset.y = camOffset.y + 0.5
    end

    camOffset.y = camOffset.y + 0.165

    local entityName = 'Camera' .. ((camIndex > 0 and '_' .. camIndex) or '')
    local camMatrix = exports[GetCurrentResourceName()]:GetAnimSceneEntityLocationData(animScene, entityName, false, 'LIVE', 2)

    local cos = Cos(camMatrix[4])
    local sin = Sin(camMatrix[4])
    result.x = camOffset.x
    result.y = ((cos * camOffset.y) - (sin * camOffset.z))
    result.z = ((sin * camOffset.y) + (cos * camOffset.z))
    camOffset = {
        x = result.x,
        y = result.y,
        z = result.z
    }

    cos = Cos(camMatrix[5])
    sin = Sin(camMatrix[5])
    result.x = ((cos * camOffset.x) + (sin * camOffset.z))
    result.y = camOffset.y;
    result.z = ((cos * camOffset.z) - (sin * camOffset.x))
    camOffset = {
        x = result.x,
        y = result.y,
        z = result.z
    }

    cos = Cos(camMatrix[6])
    sin = Sin(camMatrix[6])
    result.x = ((cos * camOffset.x) - (sin * camOffset.y));
    result.y = ((sin * camOffset.x) + (cos * camOffset.y));
    result.z = camOffset.z;
    camOffset = {
        x = result.x,
        y = result.y,
        z = result.z
    }

    return vector3(camMatrix[1], camMatrix[2], camMatrix[3]) + vector3(camOffset.x, camOffset.y, camOffset.z)
end

IsReadyForReverseCamTrans = function(playerPed)
    if IsPedOnMount(playerPed) then
        SetPedMaxMoveBlendRatio(playerPed, 0.0)

        if not IsMoveBlendRatioStill(GetPedDesiredMoveBlendRatio(playerPed)) then
            return false
        end
    end

    if GetEntitySpeed(playerPed) > 0.01 then
        return false
    end

    return true
end

StartReverseCamTransition = function()
    if not Config.EnableReverseCamTransition then
        return printe('StartReverseCamTransition(): Reverse cam transition is disabled (Config.EnableReverseCamTransition = false).')
    end

    if RevTransAnimScene then
        return
    end

    local playerPed = PlayerPedId()
    local animDict = GetReverseCamTransAnimDict(playerPed)
    RevTransAnimScene = CreateAnimScene(animDict, 129, 0, false, true)
    _RequestAnimScenePlayList(RevTransAnimScene, 'LIVE', true)
    LoadAnimScene(RevTransAnimScene)

    while not _IsAnimSceneLoaded(RevTransAnimScene) do
        Citizen.Wait(0)
    end

    local camIndex = GetReverseCamTransCamIndex(playerPed)
    SetAnimSceneInt(RevTransAnimScene, 'CameraIndex', camIndex, false)
    _SetAnimScenePlayList(RevTransAnimScene, 'LIVE', true)
    SetPlayerControl(PlayerId(), false, 256, false)
    printd('StartReverseCamTransition(): Reverse cam transition cam index: %s', camIndex)

    if not IsReadyForReverseCamTrans(playerPed) then
        if IsPedOnMount(playerPed) then
            local mount = GetMount(playerPed)

            if DoesEntityExist(mount) then
                SetPedMaxMoveBlendRatio(mount, 0.0)
                TaskHorseAction(mount, 1, 0, 0)
                printd('StartReverseCamTransition(): Player is in motion on mount, waiting for mount to stop.')

                while GetScriptTaskStatus(mount, 1041577989, true) == 0 or GetScriptTaskStatus(mount, 1041577989, true) == 1 do
                    Citizen.Wait(0)
                end

                TaskStandStill(mount, 10000)
            end
        end

        while not IsReadyForReverseCamTrans(playerPed) do
            Citizen.Wait(0)
        end
    end

    local playerCoords = GetEntityCoords(playerPed, true, true)
    SetAnimSceneOrigin(RevTransAnimScene, playerCoords, GetEntityRotation(playerPed, 2), 2)
    _ForceAllHeadingValuesToAlign(playerPed)
    printd('StartReverseCamTransition(): Player ready for transition, updated anim scene origin.')

    if _IsPedArmed(playerPed, 6) and not (_IsPedHogtying(playerPed) or _IsPedHogtied(playerPed)) then
        local aimCoords = GetReverseCamTransAimCoords(playerPed, RevTransAnimScene, camIndex)
        printd('StartReverseCamTransition(): Player is armed, setting up TaskShootWithWeapon() at coords %s.',
            vector3(aimCoords.x, aimCoords.y, aimCoords.z))

        exports[GetCurrentResourceName()]:TaskShootWithWeapon(PlayerPedId(), aimCoords.x, aimCoords.y, aimCoords.z, 10000, 1, 1)
    end

    StartAnimScene(RevTransAnimScene)

    printd('StartReverseCamTransition(): Reverse cam transition started.')
end

StopReverseCamTransition = function()
    if not RevTransAnimScene then
        return
    end

    if _IsAnimScenePlaybackListPhaseLoaded(RevTransAnimScene, 'LIVE') then
        _ReleaseAnimScenePlayList(RevTransAnimScene, 'LIVE')
    end

    if _IsAnimSceneRunning(RevTransAnimScene) then
        AbortAnimScene(RevTransAnimScene)
    end

    ResetAnimScene(RevTransAnimScene, 0)
    _DeleteAnimScene(RevTransAnimScene)

    SetPlayerControl(PlayerId(), true, 256, false)

    RevTransAnimScene = nil

    printd('StopReverseCamTransition(): Reverse cam transition stopped.')
end

GetLoadingScreenTags = function()
    local tags = {1914027275, -2122032152, -938054684, -1177563305}

    local modeTag = tags[math.random(1, #tags)]
    local objectiveTag = nil

    while (objectiveTag == nil or objectiveTag == modeTag) do
        objectiveTag = tags[math.random(1, #tags)]

        Citizen.Wait(0)
    end

    return modeTag, objectiveTag
end

GetLoadingScreenRouteTags = function(dataId)
    local race = Config.Races[dataId]
    if not race then
        return 'Invalid nameTag', 'Invalid descriptionTag'
    end

    return race.name or 'Invalid nameTag', race.description or ''
end

RegisterNetEvent('redm_horse_races:os:requestPlayerMount', function()
    if IsRaceActive then
        return
    end

    local mount = GetMount(PlayerPedId())
    local isMountValid, exitCode = ValidateLocalPlayerMount(mount)
    if not isMountValid then
        local toastText = nil

        if exitCode == 'VPM_MOUNT_NOT_FOUND' or exitCode == 'VPM_MOUNT_NOT_NETWORKED' then
            toastText = Config.MsgMountNotFound
        elseif exitCode == 'VPM_MOUNT_INVALID_RIDER' then
            toastText = Config.MsgMountInvalidRider
        elseif exitCode == 'VPM_MOUNT_SEAT_NOT_FREE' then
            toastText = Config.MsgMountSeatNotFree
        end

        if toastText then
            _UiFeedPostSampleToast(8000, GetLabelText('GST_RACE_STANDA'), toastText, -1393740907, _H('menu_icon_mp_playlist_races'))
        end

        return printe('EV_RequestPlayerMount()(OS): Failed to register player mount (%s).', exitCode)
    end

    local netId = NetworkGetNetworkIdFromEntity(mount)
    if not NetworkDoesNetworkIdExist(netId) then
        _UiFeedPostSampleToast(8000, GetLabelText('GST_RACE_STANDA'), Config.MsgMountNotFound, -1393740907, _H('menu_icon_mp_playlist_races'))
        
        return printe('EV_RequestPlayerMount()(OS): Player mount netId is invalid.')
    end

    TriggerServerEvent('redm_horse_races:os:registerRaceMount', netId)

    printd('EV_RequestPlayerMount()(OS): Registering mount.')
end)

RegisterNetEvent('redm_horse_races:initRace', function(dataId, numLaps, players)
    if IsRaceActive then
        return
    end

    WaitingForRaceInit = false

    if Config.EnableReverseCamTransition then
        StartReverseCamTransition()
        Citizen.Wait(5000)
    end

    BusyspinnerOff()

    if not IsScreenFadedOut() then
        DoScreenFadeOut(2500)

        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
    end

    StopReverseCamTransition()

    if Config.EnableIntroLoadingScreen then
        if not GetIsLoadingScreenActive() then
            local modeTag, objectiveTag = GetLoadingScreenTags()
            local nameTag, descriptionTag = GetLoadingScreenRouteTags(dataId)

            _DisplayLoadingScreens(modeTag, objectiveTag, 0, GetLabelText('GST_RACE_STANDA'), nameTag, descriptionTag)
        end
    end

    if InitRace(dataId, numLaps, players) then
        TriggerServerEvent('redm_horse_races:markMeAsReady')
    else
        TriggerServerEvent('redm_horse_races:leaveRace')
    end
end)

RegisterNetEvent('redm_horse_races:joinedRace', function(raceId)
    if IsRaceActive or IsMatchmakingActive then
        return
    end

    local mount = GetMount(PlayerPedId())
    local isMountValid, exitCode = ValidateLocalPlayerMount(mount)
    if not isMountValid then
        TriggerServerEvent('redm_horse_races:leaveRace')

        local toastText = nil
        if exitCode == 'VPM_MOUNT_NOT_FOUND' or exitCode == 'VPM_MOUNT_NOT_NETWORKED' then
            toastText = Config.MsgMountNotFound
        elseif exitCode == 'VPM_MOUNT_INVALID_RIDER' then
            toastText = Config.MsgMountInvalidRider
        elseif exitCode == 'VPM_MOUNT_SEAT_NOT_FREE' then
            toastText = Config.MsgMountSeatNotFree
        end

        if toastText then
            _UiFeedPostSampleToast(8000, GetLabelText('GST_RACE_STANDA'), toastText, -1393740907, _H('menu_icon_mp_playlist_races'))
        end

        return printe('EV_JoinedRace(): Failed to validate player mount (%s).', exitCode)
    end

    IsMatchmakingActive = true
    _BusyspinnerSetText(GetLabelText('GAME_START_TIMER_WAITING'))

    printw('EV_JoinedRace: Joined race (raceId: %s).', raceId)
end)

RegisterNetEvent('redm_horse_races:joinedRaceTimer', function(timeToStart)
    if IsRaceActive or not IsMatchmakingActive then
        return
    end

    if timeToStart == 0 then
        WaitingForRaceInit = true

        _BusyspinnerSetText(GetLabelText('JIP_ERROR_INIRC'))
    else
        local gxtLabel = GetLabelText('GAME_START_TIMER_WAITING')

        _BusyspinnerSetText(('%s (%i)'):format(gxtLabel, timeToStart))
    end
end)

StartPlayerRespawnThread = function(dataId)
    if not IsScreenFadedOut() then
        DoScreenFadeOut(0)

        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
    end

    if Config.EnableRespawnProtection then
        _SetLocalPlayerAsGhost(true)
        printd('PlayerRespawnThread(): Ghosted player (Respawn protection).')
    end

    Citizen.CreateThread(function()
        RespawnLocalPlayerAtTrackEnd(dataId)
        _PlaceEntityOnGroundProperly(CurrentMount)
        printd('PlayerRespawnThread(): Respawned player.')

        if Config.EnableCloudsTransition then
            if _AudioIsMusicPlaying() then
                printd('PlayerRespawnThread(): Waiting for music stop.')

                TriggerMusicEvent('MC_MUSIC_STOP')
                _StopAllScriptedAudioSounds()

                while _AudioIsMusicPlaying() do
                    Citizen.Wait(0)
                end
            end

            StartCloudsTransition()

            while not HasCloudsTransitionFinished() do
                Citizen.Wait(0)
            end

            while not IsScreenFadedOut() do
                DoScreenFadeOut(0)

                Citizen.Wait(0)
            end
        end

        while not _UpdatePlayerTeleport(PlayerId()) do
            Citizen.Wait(0)
        end

        printd('PlayerRespawnThread(): Teleported player.')
        DoScreenFadeIn(3500)

        if Config.EnableRespawnProtection then
            local ghostedCoords, ghostedTimestamp = GetEntityCoords(PlayerPedId()), GetGameTimer()
            while not ShouldPlayerBeUnGhosted(ghostedCoords, ghostedTimestamp, Config.RespawnProtectionMinSpeed, Config.RespawnProtectionMinDist,
                Config.RespawnProtectionMaxTime) do
                Citizen.Wait(0)
            end

            _SetLocalPlayerAsGhost(false)
            printd('PlayerRespawnThread(): Unghosted player (Respawn protection | (minSpeed: %s, minDist: %s, maxTime: %s)).',
                Config.RespawnProtectionMinSpeed, Config.RespawnProtectionMinDist, Config.RespawnProtectionMaxTime)
        end
    end)
end

StartCloudsTransition = function()
    if not Config.EnableCloudsTransition then
        return printe('StartCloudsTransition(): Clouds transition is disabled (Config.EnableCloudsTransition = false).')
    end

    if CloudsTransAnimScene then
        return
    end

    local timeStr = GetCloudsTransitionTime()
    local weatherStr = GetCloudsTransitionWeather()
    local animDict = ('script@respawn@sky@skytl_%s_%s'):format(timeStr, weatherStr)

    CloudsTransAnimScene = CreateAnimScene(animDict, 16512, 0, false, true)

    LoadAnimScene(CloudsTransAnimScene)
    while not _IsAnimSceneLoaded(CloudsTransAnimScene) do
        Citizen.Wait(0)
    end

    while not PrepareMusicEvent('MP_CLOUDS_TRANSITION_MUSIC') do
        Citizen.Wait(0)
    end

    TriggerMusicEvent('MP_CLOUDS_TRANSITION_MUSIC')
    _SetAudioOnlineTransitionStage('clouds')
    _EnableHudContext(_H('HUD_CTX_MP_MATCHMAKING_TRANSITION'))
    StartAnimScene(CloudsTransAnimScene)

    while not _IsAnimSceneRunning(CloudsTransAnimScene) do
        Citizen.Wait(0)
    end

    DoScreenFadeIn(0)

    Citizen.CreateThread(function()
        while not HasCloudsTransitionFinished() do
            Citizen.Wait(0)
        end

        _DisableHudContext(_H('HUD_CTX_MP_MATCHMAKING_TRANSITION'))
        TriggerMusicEvent('SLEEP_TRANSITION_STOP')
        _SetAudioOnlineTransitionStage('gameplay')

        StopCloudsTransition()
    end)
end

HasCloudsTransitionFinished = function()
    if not CloudsTransAnimScene then
        return true
    end

    return _IsAnimSceneFinished(CloudsTransAnimScene, false)
end

StopCloudsTransition = function()
    if not CloudsTransAnimScene then
        return
    end

    if _IsAnimSceneRunning(CloudsTransAnimScene) then
        AbortAnimScene(CloudsTransAnimScene)
    end

    ResetAnimScene(CloudsTransAnimScene, 0)
    _DeleteAnimScene(CloudsTransAnimScene)

    CloudsTransAnimScene = nil
end

GetCloudsTransitionTime = function()
    local time = (GetClockHours() * 60 + GetClockMinutes())

    if (time > 1350 or time <= 90) then
        return '0000'
    elseif (time > 90 and time <= 270) then
        return '0300'
    elseif (time > 270 and time <= 450) then
        return '0600'
    elseif (time > 450 and time <= 630) then
        return '0900'
    elseif (time > 630 and time <= 810) then
        return '1200'
    elseif (time > 810 and time <= 990) then
        return '1500'
    elseif (time > 990 and time <= 1170) then
        return '1800'
    elseif (time > 1170 and time <= 1350) then
        return '2100'
    end

    return '0000'
end

GetCloudsTransitionWeather = function()
    local weather = _GetNextWeatherTypeHashName()

    if (weather == _H('DRIZZLE') or weather == _H('OVERCAST') or weather == _H('FOG') or weather == _H('SHOWER') or weather == _H('OVERCASTDARK') or
        weather == _H('CLOUDS') or weather == _H('RAIN') or weather == _H('MISTY')) then
        return '03clouds'
    elseif (weather == _H('SANDSTORM') or weather == _H('THUNDER') or weather == _H('SNOW') or weather == _H('SLEET') or weather == _H('SNOWLIGHT') or
        weather == _H('BLIZZARD') or weather == _H('WHITEOUT') or weather == _H('HURRICANE') or weather == _H('SNOWCLEARING') or weather == _H('HAIL') or
        weather == _H('THUNDERSTORM') or weather == _H('GROUNDBLIZZARD')) then
        return '04storm'
    end

    return '01clear'
end

RegisterNetEvent('redm_horse_races:leftRace', function(dataId)
    local wasRaceActive = (IsRaceActive == true)

    IsMatchmakingActive = false
    if CurrentCorona then
        TriggerEvent('redm_horse_races:setCoronaState', CurrentCorona)
    end

    CleanupRace()

    if wasRaceActive then
        StartPlayerRespawnThread(dataId)

        printw('EV_LeftRace: Left race.')
    else
        printw('EV_LeftRace: Race canceled.')
    end
end)

RegisterNetEvent('redm_horse_races:raceCanceled', function()
    if not IsMatchmakingActive then
        return
    end

    WaitingForRaceInit = false

    _UiFeedPostSampleToast(8000, GetLabelText('GST_RACE_STANDA'), Config.MsgRcNotEnoughPlayers, -1393740907, _H('menu_icon_mp_playlist_races'))
end)

StartRace = function()
    if HasRaceStarted then
        return
    end

    UnlockLocalPlayer()
    printd('StartRace(): Unlocked player.')

    PlaySoundFrontend('match_start', 'RDRO_Adversary_Sounds', true, 0);
    HasRaceStarted = true

    printd('StartRace(): Race started.')
end

RegisterNetEvent('redm_horse_races:startRace', function()
    if not IsRaceActive then
        return
    end

    if HasRaceStarted then
        return
    end

    StartRace()
end)

StartRaceCountdown = function()
    if not IsRaceActive or HasRaceStarted then
        return
    end

    StopRaceIntroFlow()

    if DatabindingReadDataBool(CentralInfoData.countDownTimer.isVisible) == 1 then
        return
    end

    DatabindingWriteDataBool(CentralInfoData.countDownTimer.isVisible, true)
    PlaySoundFrontend('321_GO', 'RDRO_Race_sounds', true, 0)
    Citizen.Wait(2500)

    TriggerServerEvent('redm_horse_races:markMeAsReady')

    printd('StartRace(): Race countdown finished.')
end

RegisterNetEvent('redm_horse_races:prepareRaceCountdown', function()
    if not IsRaceActive then
        return
    end

    if HasRaceStarted then
        return
    end

    if GetIsLoadingScreenActive() then
        ShutdownLoadingScreen()

        while GetIsLoadingScreenActive() do
            Citizen.Wait(0)
        end
    end

    StopRaceIntroFlow()
    ShowLocalPlayer()
    DatabindingWriteDataBool(CentralInfoData.centralInfo.isVisible, true)
    DatabindingWriteDataBool(CentralInfoData.score.visible, true)
    SetGameplayCamRelativeHeading(0.0, 1.0)
    Citizen.Wait(2500)

    if not IsScreenFadedIn() then
        DoScreenFadeIn(350)

        while not IsScreenFadedIn() do
            Citizen.Wait(0)
        end
    end

    TriggerServerEvent('redm_horse_races:markMeAsReady')
end)

RegisterNetEvent('redm_horse_races:startRaceCountdown', function()
    if not IsRaceActive then
        return
    end

    if HasRaceStarted then
        return
    end

    StartRaceCountdown()
end)

StartRaceIntroFlow = function()
    if not Config.EnableIntroFlowCutscene then
        return printe('StartRaceIntroFlow(): Introflow cutscene is disabled (Config.EnableIntroFlowCutscene = false).')
    end

    if IntroFlowAnimScene then
        return
    end

    local playerPed = PlayerPedId()
    local playerMount = GetMount(playerPed)
    if not DoesEntityExist(playerMount) then
        return printe('StartRaceIntroFlow(): Player mount doesn\'t exist.')
    end

    local mountCoords = GetEntityCoords(playerMount, true, false)
    local mountRot = GetEntityRotation(playerMount, 2)
    local adjustedCoords = GetOffsetFromEntityInWorldCoords(playerMount, 0.0, 4.75, 0.0)
    local ground = FindGroundIntersection(mountCoords, 5, 5, false, true)
    if ground then
        adjustedCoords = vector3(adjustedCoords.x, adjustedCoords.y, ground)
    end

    mountRot = vector3(mountRot.x, mountRot.y, mountRot.z + 180.0)

    IntroFlowAnimScene = CreateAnimScene('script@mp@introflow@soloonhorse', 130, 0, false, true, true)
    SetAnimSceneOrigin(IntroFlowAnimScene, adjustedCoords, mountRot, 2)
    SetAnimSceneInt(IntroFlowAnimScene, 'BGVariation_Int', math.random(1, 4), false)
    SetAnimSceneInt(IntroFlowAnimScene, 'CameraIndex', math.random(0, 3), false)

    local playerClone = ClonePed(playerPed, 0.0, false, false)
    SetEntityAsMissionEntity(playerClone, true, true)
    SetEntityCollision(playerClone, false, false)
    FreezeEntityPosition(playerClone, true)
    SetAnimSceneEntity(IntroFlowAnimScene, ('Ped_%s_0'):format(GetPedGender(playerClone)), playerClone, 0)

    local mountClone = ClonePed(playerMount, 0.0, false, false)
    SetEntityAsMissionEntity(mountClone, true, true)
    SetEntityCollision(mountClone, false, false)
    FreezeEntityPosition(mountClone, true)
    SetAnimSceneEntity(IntroFlowAnimScene, 'Horse_0', mountClone, 0)

    LoadAnimScene(IntroFlowAnimScene)
    while not _IsAnimSceneLoaded(IntroFlowAnimScene) do
        Citizen.Wait(0)
    end

    StartAnimScene(IntroFlowAnimScene)

    printd('StartRaceIntroFlow(): Intro flow started.')
end

StopRaceIntroFlow = function()
    if not IntroFlowAnimScene then
        return
    end

    for _, gender in ipairs({'M', 'F'}) do
        local ped = _GetAnimScenePed(IntroFlowAnimScene, ('Ped_%s_0'):format(gender), false)

        if DoesEntityExist(ped) then
            DeletePed(ped)
        end
    end

    local mount = _GetAnimScenePed(IntroFlowAnimScene, 'Horse_0', false)
    if DoesEntityExist(mount) then
        DeletePed(mount)
    end

    if _IsAnimSceneRunning(IntroFlowAnimScene) then
        AbortAnimScene(IntroFlowAnimScene)
    end

    ResetAnimScene(IntroFlowAnimScene, 0)
    _DeleteAnimScene(IntroFlowAnimScene)

    IntroFlowAnimScene = nil

    printd('StopRaceIntroFlow(): Intro flow stopped.')
end

GetPedGender = function(ped)
    return (IsPedMale(ped) and 'M') or 'F'
end

RegisterNetEvent('redm_horse_races:startRaceIntroFlow', function()
    if not Config.EnableIntroFlowCutscene then
        return printe('EV_StartRaceIntroflow(): Introflow cutscene is disabled (Config.EnableIntroFlowCutscene = false).')
    end

    if not IsRaceActive then
        return
    end

    if HasRaceStarted then
        return
    end

    if GetIsLoadingScreenActive() then
        ShutdownLoadingScreen()

        while GetIsLoadingScreenActive() do
            Citizen.Wait(0)
        end
    end

    if not IsScreenFadedOut() then
        DoScreenFadeOut(0)
    end

    HideLocalPlayer()
    StartRaceIntroFlow()
    DoScreenFadeIn(350)

    while _GetAnimScenePhase(IntroFlowAnimScene) < 0.7 do
        Citizen.Wait(0)
    end

    if not IsScreenFadedOut() then
        DoScreenFadeOut(1000)

        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
    end

    TriggerServerEvent('redm_horse_races:markMeAsReady')
end)

FinishRace = function(route, laps)
    if not IsRaceActive or not HasRaceStarted or HasRaceFinished then
        return false
    end

    if not (CurrentCheckpointId == #route) or not (CurrentLap == laps) then
        return false
    end

    HasRaceFinished = true

    StartFinishCamThread()

    _SetLocalPlayerAsGhost(true)
    printd('FinishRace(): Ghosted player.')

    printd('FinishRace(): Race finished, waiting for other players.')

    return true
end

StartFinishCamThread = function()
    StartPlayerFinishCamTask()
    CreateFinishCam()

    Citizen.CreateThread(function()
        while IsRaceActive do
            if not IsEntityOnScreen(PlayerPedId()) and not IsCamShaking(FinishCam) then
                ShakeCam(FinishCam, 'HAND_SHAKE', 1.0)
            end

            if HasRaceEnded then
                RemoveFinishCam()

                return printd('FinishCamThread(): Stopped thread (HasRaceEnded = true).')
            end

            Citizen.Wait(300)
        end
    end)
end

StartPlayerFinishCamTask = function()
    local playerPed = PlayerPedId()
    local moveBlendEntity = playerPed
    if _IsPedFullyOnMount(playerPed, true) then
        moveBlendEntity = GetMount(playerPed)
    end

    local speedY = _GetPedCurrentMoveBlendRatio(moveBlendEntity)[2]
    local coords = GetOffsetFromEntityInWorldCoords(moveBlendEntity, -1.0, 20.0, 0.0)
    local ground = FindGroundIntersection(coords, 5, 5, false, true)
    if ground then
        coords = vector3(coords.x, coords.y, ground)
    end

    TaskGoStraightToCoord(playerPed, coords, speedY, 20000, 40000.0, 0.5, 0)

    printd('StartPlayerFinishCamTask(): Called TASK_GO_STRAIGHT_TO_COORD to %s with moveBlendY %s.', coords, speedY)
end

CreateFinishCam = function()
    local camPos, pointPos, camFov = nil, nil, nil

    if customPos and customPointPos then
        camPos, pointPos, camFov = customPos, customPointPos, 40.0

        printd('CreateFinishCam(): Using custom cam pos:\ncamPos = %s\npointPos = %s\ncamFov = %s.', camPos, pointPos, camFov)
    else
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed, true, false)
        local heading = GetEntityHeading(playerPed)

        camPos, pointPos = GetFinishCamAdjustedPos(coords, heading)
        camFov = 35.0

        printd('CreateFinishCam(): Found safe cam pos:\ncamPos = %s\npointPos = %s\ncamFov = %s.', camPos, pointPos, camFov)
    end

    FinishCam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
    SetCamCoord(FinishCam, camPos)
    PointCamAtCoord(FinishCam, pointPos)
    SetCamFov(FinishCam, camFov)
    SetCamActive(FinishCam, true)
    RenderScriptCams(true, false, 3000, true, false, 0)

    printd('CreateFinishCam(): Finish cam created.')
end

RemoveFinishCam = function()
    if not FinishCam then
        return
    end

    DestroyCam(FinishCam, false)
    RenderScriptCams(false, false, 3000, true, false, 0)

    FinishCam = nil

    printd('RemoveFinishCam(): Finish cam destroyed.')
end

GetFinishCamAdjustedPos = function(coords, heading)
    local placementAttempts = 0
    local adjustedCamStartPos = nil
    while not adjustedCamStartPos do
        local offset = GetFinishCamOffset(placementAttempts) * GetFinishCamOffsetDistanceMultiplier()
        local camStartPos = _GetOffsetFromCoordAndHeadingInWorldCoords(coords, heading, offset)

        adjustedCamStartPos, placementAttempts = IsAreaAroundFinishCamClear(coords, camStartPos, placementAttempts)
    end

    local groundCheckCoords = adjustedCamStartPos + vector3(5.0, 0.0, 0.0)
    local groundZ = FindGroundIntersection(groundCheckCoords, 5, 10, false, true)
    if not groundZ then
        groundZ = coords.z - 1.0

        printd('GetFinishCamAdjustedPos(): Failed to get ground level at %s, using (playerCoords.z - 1.0).', groundCheckCoords)
    else
        printd('GetFinishCamAdjustedPos(): Using ground level %s at %s.', groundZ, groundCheckCoords)
    end

    local groundZ = coords.z

    adjustedCamStartPos = vector3(adjustedCamStartPos.x, adjustedCamStartPos.y, groundZ + 1.2)
    local pointOffset = GetFinishCamPointOffset(placementAttempts)
    local camPointPos = _GetOffsetFromCoordAndHeadingInWorldCoords(coords, heading, pointOffset)

    return adjustedCamStartPos, camPointPos
end

GetFinishCamOffset = function(placementAttempts)
    if placementAttempts == 0 then
        return vector3(-1.0, 13.0, -10.0)
    elseif placementAttempts == 1 then
        return vector3(1.0, 13.0, -10.0)
    end

    return vector3(5.64, -7.12, 1.41)
end

GetFinishCamOffsetDistanceMultiplier = function()
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
        local model = GetEntityModel(GetVehiclePedIsUsing(playerPed))
        local min, max = GetModelDimensions(model)

        return (1.0 + ((max - min) * 0.2))
    end

    return 1.0
end

IsAreaAroundFinishCamClear = function(playerCoords, camStartPos, placementAttempts)
    local groundCheckCoords = camStartPos + vector3(10.0, 0.0, 0.0)

    local adjustedZ = FindGroundIntersection(groundCheckCoords, 5, 10, false, true)
    if not adjustedZ then
        adjustedZ = playerCoords.z - 1.0

        printd('IsAreaAroundFinishCamClear(): Failed to get adjusted ground level at %s, using (playerCoords.z - 1.0).', groundCheckCoords)
    else
        printd('IsAreaAroundFinishCamClear(): Using ground level %s at %s.', adjustedZ, groundCheckCoords)
    end

    local adjustedPos = vector3(camStartPos.x, camStartPos.y, adjustedZ)
    local shapeTest = StartShapeTestLosProbe(playerCoords, adjustedPos, 1, PlayerPedId(), 7)
    local result, hitCount = nil, nil

    while true do
        result, hitCount = GetShapeTestResult(shapeTest)
        if result == 0 or result == 2 then
            break
        end

        Citizen.Wait(0)
    end

    if result == 2 then
        if hitCount == 0 then
            printd('IsAreaAroundFinishCamClear(): Shapetest returned hitCount = %i, safe pos found after %i attempts.', hitCount, placementAttempts)

            return adjustedPos, placementAttempts
        else
            placementAttempts = placementAttempts + 1

            printd('IsAreaAroundFinishCamClear(): Shapetest returned hitCount = %i, updated placementAttempts = %i.', hitCount, placementAttempts)
        end
    elseif result == 0 then
        printd('IsAreaAroundFinishCamClear(): Shapetest returned status = SHAPETEST_STATUS_NONEXISTENT, adjustedPos = %s.', adjustedPos)

        return adjustedPos, placementAttempts
    end

    if placementAttempts > 2 then
        printd('IsAreaAroundFinishCamClear(): Limit of placementAttempts (%i/2) excedeed, adjustedPos = %s.', placementAttempts, adjustedPos)

        return adjustedPos, placementAttempts
    end

    return false, placementAttempts
end

GetFinishCamPointOffset = function(placementAttempts)
    if placementAttempts == 0 or placementAttempts == 1 then
        return vector3(0.0, 6.5, 0.8)
    end

    return vector3(0.0, 0.0, 0.81)
end

StartEndTimerCountdownSound = function(timeMs)
    if EndTimerSoundId then
        return
    end

    local time = (timeMs + 500) / 1000

    EndTimerSoundId = GetSoundId()
    _PlaySoundFrontendWithSoundId(EndTimerSoundId, 'Match_End_Timer', 'RDRO_Countdown_Sounds', 0)
    _SetVariableOnSoundWithId(EndTimerSoundId, 'Time', time)

    printd('StartEndTimerCountdownSound(): Started end timer countdown sound for time %ss.', time)
end

UpdateEndTimerCountdownSound = function(timeMs)
    if not EndTimerSoundId then
        return
    end

    local newTime = (timeMs + 500) / 1000
    _PlaySoundFrontendWithSoundId(EndTimerSoundId, 'Match_End_Timer', 'RDRO_Countdown_Sounds', 0)
    _SetVariableOnSoundWithId(EndTimerSoundId, 'Time', newTime)

    printd('UpdateEndTimerCountdownSound(): Updated end timer countdown sound time to %ss.', newTime)
end

StopEndTimerCountdownSound = function()
    if not EndTimerSoundId then
        return
    end

    ReleaseSoundId(EndTimerSoundId)
    EndTimerSoundId = nil

    printd('StopEndTimerCountdownSound(): Stopped end time countdown sound.')
end

RegisterNetEvent('redm_horse_races:startRaceEndTimer', function(endTimestamp, endDelay)
    if not Config.EnableRaceEndTimer then
        return printe('EV_StartRaceEndTimer(): Race end timer is disabled (Config.EnableRaceEndTimer = false).')
    end

    if not IsRaceActive then
        return
    end

    if HasRaceEnded then
        return printe('EV_StartRaceEndTimer(): Aborting (HasRaceEnded = true).')
    end

    if not CentralInfoData then
        return printe('EV_StartRaceEndTimer(): Invalid CentralInfoData.')
    end

    local meter0 = CentralInfoData.meters['meter0']
    if not DatabindingReadDataBool(meter0.visible) == 0 then
        return
    end

    DatabindingWriteDataBool(meter0.visible, true)

    printd('EV_StartRaceEndTimer(): Started race end timer.')
end)

RegisterNetEvent('redm_horse_races:updateRaceEndTimer', function(timeToEnd, endDelay)
    if not Config.EnableRaceEndTimer then
        return printe('EV_UpdateRaceEndTimer(): Race end timer is disabled (Config.EnableRaceEndTimer = false).')
    end

    if not IsRaceActive then
        return
    end

    if HasRaceEnded then
        return printe('EV_UpdateRaceEndTimer(): Aborting (HasRaceEnded = true).')
    end

    if not CentralInfoData then
        return printe('EV_UpdateRaceEndTimer(): Invalid CentralInfoData.')
    end

    local meter0 = CentralInfoData.meters['meter0']

    if timeToEnd >= 0 then
        if DatabindingReadDataBool(meter0.visible) == 1 then
            local newMeterValue = timeToEnd / endDelay

            DatabindingWriteDataFloat(meter0.meterValue, newMeterValue)

            if timeToEnd == 10 and not EndTimerSoundId then
                StartEndTimerCountdownSound(10000)
            end

            if timeToEnd == 0 then
                printd('EV_UpdateRaceEndTimer(): Finished end timer, calling StopEndTimerCountdownSound() with a 1500ms delay.')

                Citizen.SetTimeout(1500, function()
                    StopEndTimerCountdownSound()
                end)
            end
        else
            printe('EV_UpdateRaceEndTimer(): Failed to update meter value (meter0.visible == 0).')
        end
    end
end)

EndRace = function()
    if CentralInfoData then
        if DatabindingReadDataBool(CentralInfoData.centralInfo.isVisible) == 1 then
            local meter0 = CentralInfoData.meters['meter0']

            if DatabindingReadDataBool(meter0.visible) == 1 then
                local meterValue = _DatabindingReadFloat(meter0.meterValue)

                if meterValue ~= 0.0 then
                    DatabindingWriteDataFloat(meter0.meterValue, 0.0)

                    if EndTimerSoundId then
                        printd('EndRace(): Stopping race end timer countdown sound.')

                        if HasRaceFinished then
                            StopEndTimerCountdownSound()
                        else
                            UpdateEndTimerCountdownSound(-500)

                            Citizen.SetTimeout(1500, function()
                                StopEndTimerCountdownSound()
                            end)
                        end
                    end
                end
            end

            _UiFeedClearChannel(11, 1, 0)
            _UiFeedClearChannel(12, 1, 0)
            DatabindingWriteDataBool(meter0.visible, false)
            DatabindingWriteDataBool(CentralInfoData.score.visible, false)
            DatabindingWriteDataBool(CentralInfoData.centralInfo.isVisible, false)

            printd('EndRace(): CentralInfoHud has been hidden.')
        end
    else
        printe('EndRace(): Invalid CentralInfoData.')
    end

    if not HasRaceFinished then
        local playerPed = PlayerPedId()

        SetPlayerControl(PlayerId(), false, 256, false)

        if not IsReadyForReverseCamTrans(playerPed) then
            if IsPedOnMount(playerPed) then
                local mount = GetMount(playerPed)

                if DoesEntityExist(mount) then
                    printd('EndRace(): Player has not finished race yet, stopping mount.')

                    SetPedMaxMoveBlendRatio(mount, 0.0)
                    TaskHorseAction(mount, 1, 0, 0)

                    while GetScriptTaskStatus(mount, 1041577989, true) == 0 or GetScriptTaskStatus(mount, 1041577989, true) == 1 do
                        Citizen.Wait(0)
                    end

                    TaskStandStill(mount, 10000)
                end
            end

            while not IsReadyForReverseCamTrans(playerPed) do
                Citizen.Wait(0)
            end
        end
    end

    printd('EndRace(): HasRaceEnded variable update has been delayed (4s).')
    Citizen.Wait(4000)

    if not IsScreenFadedOut() then
        DoScreenFadeOut(2500)

        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
    end

    _SetLocalPlayerAsGhost(false)
    printd('EndRace(): Unghosted player.')

    HasRaceEnded = true

    TriggerServerEvent('redm_horse_races:markMeAsReady')

    printd('EndRace(): Race ended.')
end

RegisterNetEvent('redm_horse_races:raceEnded', function()
    if not IsRaceActive or HasRaceEnded then
        return
    end

    EndRace()
end)

PrepareRaceEndFlow = function()
    if not Config.EnableEndFlowCutsceneAndLeaderboard then
        return printe('PrepareRaceEndFlow(): End flow cutscene and leaderboard is disabled (Config.EnableEndFlowCutsceneAndLeaderboard = false).')
    end

    EndFlowRegion = GetCurrentPedRegion(PlayerPedId())
    if not EndFlowRegion then
        return printe('PrepareRaceEndFlow(): Failed to find current player region.')
    end

    local pos = GetPositionForRegion(EndFlowRegion)
    if not pos then
        return printe('PrepareRaceEndFlow(): Failed to get region end flow location.')
    end

    local ipls = GetRegionIpls(EndFlowRegion)
    if ipls then
        for i = 1, #ipls do
            _RequestIplByHash(ipls[i])
        end
    end

    local scene = GetEndFlowScene()
    if scene.disableIpls then
        for i = 1, #scene.disableIpls do
            _RemoveIplByHash(scene.disableIpls[i])
        end
    end

    local timeCycle = GetTimeCycleForRegion(EndFlowRegion)
    if timeCycle then
        SetTimecycleModifier(timeCycle)
    end

    local cullBox = GetCullBoxForRegion(EndFlowRegion)
    if cullBox then
        SetMapdatacullboxEnabled(cullBox, true)
    end

    printd('PrepareRaceEndFlow(): Initialized region %s.', EndFlowRegion)

    _SetLocalPlayerAsGhost(true)
    printd('PrepareRaceEndFlow(): Ghosted player.')

    StartPlayerTeleport(PlayerId(), pos + vector3(0.0, 0.0, -5.0), 0.0, true, false, false, false)
    while not _UpdatePlayerTeleport(PlayerId()) do
        Citizen.Wait(0)
    end
    printd('PrepareRaceEndFlow(): Teleported player.')

    if not RespawnLocalPlayer(false, CurrentMount, nil, nil, true) then
        return printe('EV_PrepareRaceEndFlow(): Failed to respawn player.')
    end
    printd('PrepareRaceEndFlow(): Respawned player.')

    LockLocalPlayer()
    printd('PrepareRaceEndFlow(): Locked player.')

    TriggerServerEvent('redm_horse_races:markMeAsReady')
end

StartRaceEndFlow = function(data)
    if not Config.EnableEndFlowCutsceneAndLeaderboard then
        return printe('StartRaceEndFlow(): End flow cutscene and leaderboard is disabled (Config.EnableEndFlowCutsceneAndLeaderboard = false).')
    end

    if EndFlowAnimScene then
        return
    end

    if not EndFlowRegion then
        return printe('StartRaceEndFlow(): End flow region isn\'t loaded properly, aborting.')
    end

    local raceWinner = data.elements[1]
    if not raceWinner then
        return printe('StartRaceEndFlow(): Aborting (raceWinner = nil)')
    end

    if not IsScreenFadedOut() then
        DoScreenFadeOut(0)
    end

    if _AudioIsMusicPlaying() then
        printd('RaceEndFlow(): Waiting for music stop.')

        TriggerMusicEvent('MC_MUSIC_STOP')
        _StopAllScriptedAudioSounds()

        while _AudioIsMusicPlaying() do
            Citizen.Wait(0)
        end
    end

    if not StartRaceEndFlowCutscene(data.elements) then
        return printe('StartRaceEndFlow(): Failed to start end flow cutscene.')
    end
    
    DoScreenFadeIn(1000)
    TriggerMusicEvent('MP_CELEB_SCREEN_MUSIC')

    while _GetAnimScenePhase(EndFlowAnimScene) < 1.0 do
        Citizen.Wait(0)
    end

    printd('RaceEndFlow(): Cutscene finished, preparing transition data.')

    if raceWinner.finishedPlace then
        local finishPlaceStr = GetLabelText(('POS_%i'):format(raceWinner.finishedPlace))
        local finishTimeStr = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, 'UIC_EF_TIM', GetHudRaceTimerString(math.ceil(raceWinner.finishedTime * 1000)),
            Citizen.ResultAsString())
            
        ShowTransitionData('to_winner_screen', raceWinner.gamertag, finishPlaceStr, nil, finishTimeStr)
    end

    StartSceneToPhotoTransition()
    Citizen.Wait(10000)

    printd('RaceEndFlow(): Transition finished.')

    HideTransitionData()
    TriggerServerEvent('redm_horse_races:markMeAsReady')

    local nameTag = GetLoadingScreenRouteTags(data.dataId)
    local heading = ('%s - %s'):format(GetLabelText('GST_RACE_STANDA'), nameTag)
    local statRounds = GetLabelTextIfExist(data.config.statRounds)
    local stat1 = GetLabelTextIfExist(data.config.stat1)
    local stat2 = GetLabelTextIfExist(data.config.stat2)
    local stat3 = GetLabelTextIfExist(data.config.stat3)
    local elements = LocalizeLeaderboardElements(data.elements)
    ShowLeaderboard(heading, statRounds, stat1, stat2, stat3, elements, data.rewards, data.winners, data.mvp, function(action)
        if action == 'enter' then
            DoScreenFadeOut(350)
            while not IsScreenFadedOut() do
                Citizen.Wait(0)
            end

            TriggerServerEvent('redm_horse_races:leaveRace')
        end
    end, true)

    printd('RaceEndFlow(): Leaderboard app started.')
end

StopRaceEndFlow = function()
    if not EndFlowRegion and not EndFlowAnimScene then
        return
    end

    if EndFlowRegion then
        local ipls = GetRegionIpls(EndFlowRegion)
        if ipls then
            for i = 1, #ipls do
                _RemoveIplByHash(ipls[i])
            end
        end

        local timeCycle = GetTimeCycleForRegion(EndFlowRegion)
        if timeCycle then
            ClearTimecycleModifier()
        end

        local cullBox = GetCullBoxForRegion(EndFlowRegion)
        if cullBox then
            SetMapdatacullboxEnabled(cullBox, false)
        end

        _SetLocalPlayerAsGhost(false)
        printd('RaceEndFlow(): Unghosted player.')
    
        UnlockLocalPlayer()
        printd('RaceEndFlow(): Unlocked player.')
    end

    if EndFlowAnimScene then
        HideTransitionData()
        CleanupRaceEndFlowCutscene()
        StopSceneToPhotoTransition()
    end

    printd('RaceEndFlow(): End flow stopped.')
end

StartRaceEndFlowCutscene = function(racePlayers)
    if not Config.EnableEndFlowCutsceneAndLeaderboard then
        return printe(
            'StartRaceEndFlowCutscene(): End flow cutscene and leaderboard is disabled (Config.EnableEndFlowCutsceneAndLeaderboard = false).')
    end

    if EndFlowAnimScene then
        return printe('StartRaceEndFlowCutscene(): Aborting (EndFlowAnimScene = nil).')
    end

    if not EndFlowRegion then
        return printe('StartRaceEndFlowCutscene(): End flow region isn\'t loaded properly, aborting.')
    end
 
    local pos = GetPositionForRegion(EndFlowRegion)
    if not pos then
        return printe('PrepareRaceEndFlow(): Failed to get region end flow location.')
    end

    local scene = GetEndFlowScene()
    if not scene then
        return printe('PrepareRaceEndFlow(): Failed to get region end flow scene data.')
    end

    EndFlowAnimScene = CreateAnimScene(scene.animDict, 130, 0, false, true)
    SetAnimSceneOrigin(EndFlowAnimScene, pos, vector3(0.0, 0.0, 0.0), 2)
    AddEntitiesToEndFlowAnimscene(EndFlowAnimScene, scene, racePlayers)

    LoadAnimScene(EndFlowAnimScene)
    while not _IsAnimSceneLoaded(EndFlowAnimScene) do
        Citizen.Wait(0)
    end

    StartAnimScene(EndFlowAnimScene)
    while not _IsAnimSceneRunning(EndFlowAnimScene) do
        Citizen.Wait(0)
    end

    printd('RaceEndFlowCutscene(): Started end flow cutscene.')

    return true
end

CleanupRaceEndFlowCutscene = function()
    if not EndFlowAnimScene then
        return printe('CleanupRaceEndFlowCutscene(): Aborting (EndFlowAnimScene = nil).')
    end

    CleanupEntitiesFromEndFlowAnimscene(EndFlowAnimScene)

    if _IsAnimSceneRunning(EndFlowAnimScene) then
        AbortAnimScene(EndFlowAnimScene)
    end

    ResetAnimScene(EndFlowAnimScene, 0)
    _DeleteAnimScene(EndFlowAnimScene)

    EndFlowAnimScene = nil

    printd('RaceEndFlowCutscene(): End flow cutscene stopped.')
end

AddEntitiesToEndFlowAnimscene = function(animscene, scene, elements)
    local maxPeds = (scene and scene.maxPeds) or 3

    for place = 1, maxPeds, 1 do
        local elem = elements[place]

        if elem and elem.finishedPlace then
            local player = GetPlayerFromServerId(elem.source)

            if NetworkIsPlayerActive(player) then
                local playerPed = GetPlayerPed(player)

                if DoesEntityExist(playerPed) then
                    local pedClone = ClonePed(playerPed, 0.0, false, false)
                    SetEntityAsMissionEntity(pedClone, true, true)
                    SetEntityCollision(pedClone, false, false)
                    FreezeEntityPosition(pedClone, true)

                    if place == 1 then
                        local isPedOnMount = CreateTimeoutFunction(function (result)
                            local playerMount = GetMount(playerPed)

                            if IsPedOnMount(playerPed) or DoesEntityExist(playerMount) then
                                result(true)
                            end
                        end, 5000, 500)

                        if isPedOnMount then
                            local playerMount = GetMount(playerPed)

                            if DoesEntityExist(playerMount) then
                                local mountClone = ClonePed(playerMount, 0.0, false, false)
                                SetEntityAsMissionEntity(mountClone, true, true)
                                SetEntityCollision(mountClone, false, false)
                                FreezeEntityPosition(mountClone, true)
                                SetAnimSceneEntity(animscene, ('horse_%02d'):format(place), mountClone, 0)
                            else
                                printe('AddEntitiesToEndFlowAnimscene(): PLACE_(%i) mount entity doesn\'t exist (%s)!', place, playerMount)
                            end
                        else
                            printe('AddEntitiesToEndFlowAnimscene(): PLACE_(%i) mount not found (timeout)!', place)
                        end
                    end

                    local tag = _CreateMpGamerTagOnEntity(pedClone, elem.gamertag)
                    _SetMpGamerTagType(tag, _H('MINIGAMES'))
                    _SetMpGamerTagNamePosse(tag, '')
                    _SetMpGamerTagVisibility(tag, 3)

                    if (place == 1) then
                        _SetMpGamerTagTopIcon(tag, _H('KING'))
                        _SetMpGamerTagColour(tag, _H('COLOR_GOLD'))
                    elseif (place == 2) then
                        _SetMpGamerTagTopIcon(tag, _H('POSSE_LEADER'))
                        _SetMpGamerTagColour(tag, _H('COLOR_PLATINUM'))
                    elseif (place == 3) then
                        _SetMpGamerTagTopIcon(tag, _H('POSSE_DEPUTY'))
                        _SetMpGamerTagColour(tag, _H('COLOR_BRONZE'))
                    else
                        _SetMpGamerTagTopIcon(tag, _H('GENERIC_PLAYER'))
                        _SetMpGamerTagColour(tag, _H('COLOR_GREYMID'))
                    end

                    if (place == 2) then
                        local propCrate = CreateObject(_H('P_CRATE05X'), vector3(-596.927, -3639.072, 80.6997), false, true, false, false, true)
                        SetEntityCollision(propCrate, false, false)
                        FreezeEntityPosition(propCrate, true)
                        SetAnimSceneEntity(animscene, 'CRATE_03', propCrate, 0)
                    end

                    SetAnimSceneEntity(animscene, ('win_%02d'):format(place) .. (((not IsPedMale(pedClone)) and 'F') or ''), pedClone, 0)
                else
                    printe('AddEntitiesToEndFlowAnimscene(): PLACE_(%i) ped not found!', place)
                end
            end
        else
            break
        end
    end
end

CleanupEntitiesFromEndFlowAnimscene = function(animScene)
    for i = 1, 3, 1 do
        local ped = _GetAnimScenePed(animScene, ('win_%02d'):format(i), false)

        if DoesEntityExist(ped) then
            DeletePed(ped)
        end
    end

    local horse = _GetAnimScenePed(animScene, 'horse_01', false)
    if DoesEntityExist(horse) then
        DeletePed(horse)
    end

    local crate03 = _GetAnimSceneObject(animScene, 'CRATE_03', false)
    if DoesEntityExist(crate03) then
        DeleteObject(crate03)
    end
end

GetCurrentPedRegion = function(ped)
    local dist = _GetMapZoneAtCoords(GetEntityCoords(ped), 10)

    for region, data in pairs(EndFlowRegions) do
        for _, district in ipairs(data.districts) do
            if district == dist then
                return region
            end
        end
    end

    return 'HEARTLANDS'
end

GetEndFlowScene = function(peds, force)
    return {
        animDict = 'SCRIPT@MP@ENDFLOW@ENDCELEBRATION@HORSE_RACE@HORSE_RACE_v6',
        disableIpls = {-1852748182, -1068985587, -1029570958, 649433039, -1228362565},
        maxPeds = 3
    }
end

GetPositionForRegion = function(region)
    if not EndFlowRegions[region] then
        return nil
    end

    return vector3(-580.2, -3626.5, 79.94) + EndFlowRegions[region].offset
end

GetRegionIpls = function(region)
    if not EndFlowRegions[region] then
        return nil
    end

    return EndFlowRegions[region].ipls
end

GetTimeCycleForRegion = function(region)
    local hour = GetClockHours()

    local time
    if (hour >= 20 and hour <= 5) then
        time = 'night'
    elseif ((hour >= 5 and hour <= 8) and (hour >= 17 and hour <= 20)) then
        time = 'dusk'
    else
        time = 'day'
    end

    return ('mp_winlose_%s_%s'):format(region:lower(), time)
end

GetCullBoxForRegion = function(region)
    return ('mp_winlose_%s'):format(region:lower())
end

StartSceneToPhotoTransition = function()
    if SceneToPhotoTrans then
        return
    end

    TogglePausedRenderphases(false)

    SceneToPhotoTrans = _AnimpostfxGetStackhash('MP_Trans_SceneToPhoto')
    _AnimpostfxPreloadPostfxByStackhash(SceneToPhotoTrans)
    while _AnimpostfxIsPreloadingByStackhash(SceneToPhotoTrans) do
        Citizen.Wait(0)
    end

    _AnimpostfxPlayTag(SceneToPhotoTrans)
    PlaySoundFrontend('photograph', 'rdro_gamemode_transition_sounds', true, 0)
    _SetAudioOnlineTransitionStage('photograph')

    printd('SceneToPhotoTransition(): Started scene to photo transition.')
end

StopSceneToPhotoTransition = function()
    if not SceneToPhotoTrans then
        return
    end

    if _AnimpostfxIsStackhashPlaying(SceneToPhotoTrans) then
        _AnimpostfxStopStackhashPostfx(SceneToPhotoTrans)
    end

    _SetAudioOnlineTransitionStage('gameplay')
    TogglePausedRenderphases(true)

    SceneToPhotoTrans = nil

    printd('SceneToPhotoTransition(): Stopped scene to photo transition.')
end

ShowTransitionData = function(transition, gamerTag, teamName, teamNameColor, info0, info1, info2, info3)
    --[[ to_player_intro, to_team_intro, to_player_outro, to_winner_screen, to_mvp_screen ]] --

    if TransitionData then
        return
    end

    if type(transition) ~= 'number' then
        transition = GetHashKey(transition)
    end
    TransitionData = {}

    if DatabindingIsDataIdValid(TransitionData.base) == 0 then
        TransitionData.base = DatabindingAddDataContainerFromPath('', 'transitionData')
    end

    if not (DatabindingIsDataIdValid(TransitionData.gamerTag) == 0) then
        DatabindingWriteDataString(TransitionData.gamerTag, gamerTag)
    else
        TransitionData.gamerTag = DatabindingAddDataString(TransitionData.base, 'gamerTag', gamerTag or ' ')
    end

    if not (DatabindingIsDataIdValid(TransitionData.teamName) == 0) then
        DatabindingWriteDataString(TransitionData.teamName, teamName)
    else
        TransitionData.teamName = DatabindingAddDataString(TransitionData.base, 'teamName', teamName or ' ')
    end

    if not (DatabindingIsDataIdValid(TransitionData.teamNameColor) == 0) then
        DatabindingWriteDataInt(TransitionData.teamNameColor, teamNameColor)
    else
        TransitionData.teamNameColor = DatabindingAddDataInt(TransitionData.base, 'teamNameColor', teamNameColor or _H('COLOR_WHITE'));
    end

    if not (DatabindingIsDataIdValid(TransitionData.info0) == 0) then
        DatabindingWriteDataString(TransitionData.info0, info0)
    else
        TransitionData.info0 = DatabindingAddDataString(TransitionData.base, 'info0', info0 or ' ')
    end

    if not (DatabindingIsDataIdValid(TransitionData.teamNameColor) == 0) then
        DatabindingWriteDataString(TransitionData.info1, info1)
    else
        TransitionData.info1 = DatabindingAddDataString(TransitionData.base, 'info1', info1 or ' ')
    end

    if not (DatabindingIsDataIdValid(TransitionData.info2) == 0) then
        DatabindingWriteDataString(TransitionData.info2, info2)
    else
        TransitionData.info2 = DatabindingAddDataString(TransitionData.base, 'info2', info2 or ' ')
    end

    if not (DatabindingIsDataIdValid(TransitionData.info3) == 0) then
        DatabindingWriteDataString(TransitionData.info3, info3)
    else
        TransitionData.info3 = DatabindingAddDataString(TransitionData.base, 'info3', info3 or ' ')
    end

    if not (DatabindingIsDataIdValid(TransitionData.showTransitionScreen) == 0) then
        DatabindingWriteDataBool(TransitionData.showTransitionScreen, false)
    else
        TransitionData.showTransitionScreen = DatabindingAddDataBool(TransitionData.base, 'showTransitionScreen', false)
    end

    local uiFlowblock = _UiflowblockRequest(-242590942)
    while not _UiflowblockIsLoaded(uiFlowblock) do
        Citizen.Wait(0)
    end

    _UiflowblockEnter(uiFlowblock, _H('transition_root'))
    _UiStateMachineCreate(1825312110, uiFlowblock)
    while not _UiStateMachineRequestTransition(1825312110, transition) do
        Citizen.Wait(0)
    end

    DatabindingWriteDataBool(TransitionData.showTransitionScreen, true)
end

HideTransitionData = function()
    if not TransitionData then
        return
    end

    for _, entry in pairs(TransitionData) do
        DatabindingRemoveDataEntry(entry)
    end

    if _UiStateMachineExists(1825312110) then
        _UiStateMachineDestroy(1825312110)
    end

    TransitionData = nil
end

IsLeaderboardActive = function()
    return _IsUiappRunningByHash(_H('LEADERBOARDS'))
end

ShowLeaderboard = function(heading, statRounds, stat1, stat2, stat3, elements, rewards, winner, mvp, onAction, skipRating, enableRating)
    if IsLeaderboardActive() then
        _CloseUiappByHashImmediate(_H('LEADERBOARDS'))
    end

    local leaderboard = DatabindingAddDataContainerFromPath('', 'PostMatchAndLeaderboard')

    local title = DatabindingAddDataContainer(leaderboard, 'Title')
    DatabindingAddDataString(title, 'Heading', heading or '')
    DatabindingAddDataString(title, 'StatRounds', statRounds or '')
    DatabindingAddDataString(title, 'Stat1', stat1 or '')
    DatabindingAddDataString(title, 'Stat2', stat2 or '')
    DatabindingAddDataString(title, 'Stat3', stat3 or '')

    local list1 = DatabindingAddUiItemList(leaderboard, 'LeaderboardList')
    DatabindingClearBindingArray(list1)

    local list2 = DatabindingAddUiItemList(leaderboard, 'LeaderboardList')
    DatabindingClearBindingArray(list2)

    local likeButton = DatabindingAddDataContainer(leaderboard, 'likeButton')
    DatabindingAddDataBool(likeButton, 'visible', enableRating or false)
    DatabindingAddDataBool(likeButton, 'enabled', enableRating or false)

    local dislikeButton = DatabindingAddDataContainer(leaderboard, 'dislikeButton')
    DatabindingAddDataBool(dislikeButton, 'visible', enableRating or false)
    DatabindingAddDataBool(dislikeButton, 'enabled', enableRating or false)

    local revealScoreboardButton = DatabindingAddDataContainer(leaderboard, 'revealScoreboardButton')
    DatabindingAddDataBool(revealScoreboardButton, 'visible', true)
    DatabindingAddDataBool(revealScoreboardButton, 'enabled', true)

    local acceptButton = DatabindingAddDataContainer(leaderboard, 'acceptButton')
    DatabindingAddDataBool(acceptButton, 'visible', true)
    DatabindingAddDataBool(acceptButton, 'enabled', true)

    if elements and type(elements) == 'table' then
        for index, element in ipairs(elements) do
            local entry = DatabindingAddDataContainer(leaderboard, ('LeaderboardListItem_%02d'):format(index))
            local showRank = (element.showRank ~= nil and element.showRank) or true
            local spectating = (element.spectating ~= nil and element.spectating) or false
            local showCross = (element.showCross ~= nil and element.showCross) or false
            local showBlip = (element.showBlip ~= nil and element.showBlip) or true
            local headsetIconVisible = (element.headsetIconVisible ~= nil and element.headsetIconVisible) or false
            local showOverlay = (element.showOverlay ~= nil and element.showOverlay) or false
            local isHighlighted = (element.isHighlighted ~= nil and element.isHighlighted) or false

            DatabindingAddDataInt(entry, 'Position', index)
            DatabindingAddDataString(entry, 'Gamertag', element.gamertag or '')
            DatabindingAddDataInt(entry, 'GamertagColor', element.gamertagColor or 0)
            DatabindingAddDataBool(entry, 'ShowRank', showRank)
            DatabindingAddDataString(entry, 'Rank', element.rank or '')
            DatabindingAddDataBool(entry, 'Spectating', spectating)
            DatabindingAddDataString(entry, 'StatRounds', element.statRounds or '')
            DatabindingAddDataString(entry, 'Stat0', element.stat0 or '')
            DatabindingAddDataString(entry, 'Stat1', element.stat1 or '')
            DatabindingAddDataString(entry, 'Stat2', element.stat2 or '')
            DatabindingAddDataString(entry, 'Stat3', element.stat3 or '')
            DatabindingAddDataBool(entry, 'ShowCross', showCross)
            DatabindingAddDataHash(entry, 'CrossColor', element.crossColor or _H('COLOR_RED'))
            DatabindingAddDataBool(entry, 'ShowBlip', showBlip)
            DatabindingAddDataString(entry, 'Blip', element.blip or 'BLIP_AMBIENT_PED_MEDIUM')
            DatabindingAddDataInt(entry, 'BlipColor', element.blipColor or 0)
            DatabindingAddDataString(entry, 'AvatarDictionary', element.avatarDictionary or 'mp_lobby_textures')
            DatabindingAddDataString(entry, 'AvatarTexture', element.avatarTexture or 'TEMP_PEDSHOT')
            DatabindingAddDataBool(entry, 'HeadsetIconVisible', headsetIconVisible)
            DatabindingAddDataHash(entry, 'HeadsetIconColor', element.headsetIconColor or _H('COLOR_PURE_WHITE'))
            DatabindingAddDataInt(entry, 'SetOverlayImg', element.setOverlayImg or 1)
            DatabindingAddDataBool(entry, 'ShowOverlay', showOverlay)
            DatabindingAddDataBool(entry, 'isHighlighted', isHighlighted)

            DatabindingInsertUiItemToListFromContextStringAlias(list1, index, 'LeaderboardListItem', entry) -- // LeaderboardListItemBlank
        end
    end

    local gold = DatabindingAddDataBool(leaderboard, 'info_visible_06', false)
    local cash = DatabindingAddDataBool(leaderboard, 'info_visible_07', false)
    local xp = DatabindingAddDataBool(leaderboard, 'info_visible_08', false)
    if rewards and type(rewards) == 'table' then
        if rewards.gold then
            DatabindingAddDataString(leaderboard, 'info_value_06', tostring(rewards.gold))
            DatabindingWriteDataBool(gold, true)
        end

        if rewards.cash then
            DatabindingAddDataString(leaderboard, 'info_value_07', tostring(rewards.cash))
            DatabindingWriteDataBool(cash, true)
        end

        if rewards.xp then
            DatabindingAddDataString(leaderboard, 'info_value_08', tostring(rewards.xp))
            DatabindingWriteDataBool(xp, true)
        end
    end

    local winnerComponent = DatabindingAddDataBool(leaderboard, 'showWinnerComponent', false);
    if winner and type(winner) == 'table' then
        DatabindingAddDataString(leaderboard, 'winnerLabelRawText', winner.label or GetLabelText('UIC_EF_WINS'))
        DatabindingAddDataInt(leaderboard, 'winnerLabelColor', winner.labelColor or _H('COLOR_WHITE'))
        DatabindingAddDataString(leaderboard, 'winnerNameRawText', winner.name or '')
        DatabindingAddDataInt(leaderboard, 'winnerNameColor', winner.nameColor or _H('COLOR_WHITE'))

        DatabindingWriteDataBool(winnerComponent, true)
    end

    local mvpComponent = DatabindingAddDataBool(leaderboard, 'showMvpComponent', false);
    if mvp and type(mvp) == 'table' then
        DatabindingAddDataString(leaderboard, 'mvpLabelRawText', mvp.label or GetLabelText('UGC_END_MVP'))
        DatabindingAddDataInt(leaderboard, 'mvpLabelColor', mvp.labelColor or _H('COLOR_WHITE'))
        DatabindingAddDataString(leaderboard, 'mvpNameRawText', mvp.name or '')
        DatabindingAddDataInt(leaderboard, 'mvpNameColor', mvp.nameColor or _H('COLOR_WHITE'))

        DatabindingWriteDataBool(mvpComponent, true)
    end

    if skipRating then
        DatabindingAddDataBool(likeButton, 'visible', false)
        DatabindingAddDataBool(likeButton, 'enabled', false)
        DatabindingAddDataBool(dislikeButton, 'visible', false)
        DatabindingAddDataBool(dislikeButton, 'enabled', false)
        DatabindingAddDataBool(revealScoreboardButton, 'visible', false)
        DatabindingAddDataBool(revealScoreboardButton, 'enabled', false)

        DatabindingAddDataBool(leaderboard, 'revealScoreboard', true)
    end

    _LaunchUiappByHashWithEntry(_H('LEADERBOARDS'), -987928333)
    _RequestUiappTransitionByHash(_H('LEADERBOARDS'), 205122612)

    Citizen.CreateThread(function()
        while not IsLeaderboardActive() do
            Citizen.Wait(0)
        end

        if skipRating then
            PlaySoundFrontend('Leaderboard_Show', 'MP_Leaderboard_Sounds', true, 0)
        end

        while IsLeaderboardActive() do
            if _EventsUiIsPending(361663434) then
                local eventData = exports[GetCurrentResourceName()]:EventsUiPeekMessage(361663434)

                if eventData then
                    if (eventData.eventType == _H('ITEM_SELECTED')) then
                        if eventData.hashParam == -871313792 then
                            PlaySoundFrontend('like', 'RDRO_Winners_Screen_Sounds', true, 0)

                            if onAction then
                                onAction('like')
                            end
                        elseif eventData.hashParam == -1691214074 then
                            PlaySoundFrontend('dislike', 'RDRO_Winners_Screen_Sounds', true, 0)

                            if onAction then
                                onAction('dislike')
                            end
                        elseif eventData.hashParam == -1823128591 then
                            local reveal = DatabindingReadDataBoolFromParent(leaderboard, 'revealScoreboard') == 0
                            DatabindingAddDataBool(leaderboard, 'revealScoreboard', reveal)

                            if onAction then
                                onAction('reveal', reveal)
                            end
                        elseif eventData.hashParam == 1535578700 then
                            PlaySoundFrontend('enter', 'RDRO_Winners_Screen_Sounds', true, 0)
                            _CloseUiappByHash(_H('LEADERBOARDS'))

                            if onAction then
                                onAction('enter')
                            end
                        end
                    end

                    _EventsUiPopMessage(361663434)
                end
            end

            Citizen.Wait(0)
        end

        if skipRating then
            PlaySoundFrontend('Leaderboard_Hide', 'MP_Leaderboard_Sounds', true, 0)
        end
    end)
end

HideLeaderboard = function(immediate)
    if not IsLeaderboardActive() then
        return
    end

    if immediate then
        return _CloseUiappByHashImmediate(_H('LEADERBOARDS'))
    end

    _CloseUiappByHash(_H('LEADERBOARDS'))
end

LocalizeLeaderboardElements = function(elements)
    for _, elem in ipairs(elements) do
        for _, fieldName in ipairs({'statRounds', 'stat0', 'stat1', 'stat2', 'stat3'}) do
            if elem[fieldName] then
                elem[fieldName] = GetLabelTextIfExist(elem[fieldName])
            end
        end
    end

    return elements
end

RegisterNetEvent('redm_horse_races:prepareRaceEndFlow', function(endFlowData)
    if not Config.EnableEndFlowCutsceneAndLeaderboard then
        return printe('EV_PrepareRaceEndFlow(): End flow cutscene and leaderboard is disabled (Config.EnableEndFlowCutsceneAndLeaderboard = false).')
    end

    if not IsRaceActive or not HasRaceEnded or EndFlowRegion then
        return
    end

    PrepareRaceEndFlow()
end)

RegisterNetEvent('redm_horse_races:startRaceEndFlow', function(endFlowData)
    if not Config.EnableEndFlowCutsceneAndLeaderboard then
        return printe('EV_StartRaceEndFlow(): End flow cutscene and leaderboard is disabled (Config.EnableEndFlowCutsceneAndLeaderboard = false).')
    end

    if not IsRaceActive or not HasRaceEnded then
        return
    end

    if not EndFlowRegion then
        return printe('EV_StartRaceEndFlow(): End flow region isn\'t loaded properly, aborting.')
    end

    StartRaceEndFlow(endFlowData)
end)

StartRouteControllerThread = function(route, numLaps)
    Checkpoints, CurrentCheckpointId, CurrentLap = {}, 1, 1

    Citizen.CreateThread(function()
        local checkpointCoords = GetNextRouteCheckpoint(route, 0)
        local finalCheckpointAhead = false

        while IsRaceActive do
            local playerCoords = GetEntityCoords(PlayerPedId())

            if HasRaceStarted and not IsPlayerDead(PlayerId()) then
                if #(playerCoords - checkpointCoords) < 3.0 then
                    local isLastCheckpoint = (CurrentCheckpointId == #route)

                    TriggerServerEvent('redm_horse_races:completedCheckpoint')

                    DeleteCheckpoint(1)
                    UseParticleFxAsset('scr_net_race_checkpoints')
                    StartParticleFxNonLoopedAtCoord('scr_net_race_checkpoint', checkpointCoords, 0.0, 0.0, 0.0, 1.0, false, false, false)
                    PlayCheckpointHitSound(#route, numLaps)
                    printd('RouteControllerThread(): Completed checkpoint (%i/%i).', CurrentCheckpointId, #route)

                    if isLastCheckpoint and (CurrentLap + 1) <= numLaps then
                        CurrentLap = CurrentLap + 1

                        ShowRouteLapNotification(CurrentLap, numLaps)

                        printd('RouteControllerThread(): We\'re out of checkpoints, starting new lap (%i/%i).', CurrentLap, numLaps)
                    elseif isLastCheckpoint then
                        printd('RouteControllerThread(): We\'re out of laps, race ended.')
                        printd('RouteControllerThread(): Stopped thread (isLastCheckpoint = true), calling FinishRace().')

                        return FinishRace(route, numLaps)
                    end

                    checkpointCoords, CurrentCheckpointId = GetNextRouteCheckpoint(route, CurrentCheckpointId)
                end
            end

            if not finalCheckpointAhead and (#Checkpoints < 2) then
                local isLastLap = CurrentLap == numLaps

                for i = #Checkpoints, (2 - 1) do
                    local checkpointId, nextCheckpointId = ((CurrentCheckpointId + i) - 1), (CurrentCheckpointId + i)
                    local canCreateCheckpoints = (nextCheckpointId <= #route or CurrentLap < numLaps)

                    if canCreateCheckpoints then
                        if CreateCheckpoint(route, checkpointId, nextCheckpointId, numLaps) then
                            printd('RouteControllerThread(): Created checkpoint %i.', checkpointId)
                        end
                    elseif isLastLap then
                        finalCheckpointAhead = true

                        ShowRouteFinalCheckpointNotification()
                    end
                end
            end

            if HasRaceFinished then
                return printd('RouteControllerThread(): Stopped thread (HasRaceFinished = true).')
            end

            Citizen.Wait(100)
        end
    end)
end

CreateCheckpoint = function(route, checkpointId, nextCheckpointId, numLaps)
    local isFinalCheckpoint = (nextCheckpointId == #route) and (CurrentLap == numLaps)

    local coords = GetNextRouteCheckpoint(route, checkpointId)
    local ground = FindGroundIntersection(coords, 2, 5, false, true)
    coords = vector3(coords.x, coords.y, ground or coords.z)

    local nextCoords = nil
    if not isFinalCheckpoint then
        local coords = GetNextRouteCheckpoint(route, nextCheckpointId, true)
        local ground = FindGroundIntersection(coords, 2, 5, false, true)

        nextCoords = vector3(coords.x, coords.y, ground or coords.z)
    end

    local checkpointFxName = 'CHECKPOINT_RDR_RACE_FX'
    if isFinalCheckpoint then
        checkpointFxName = 'CHECKPOINT_RDR_BONFIRE_FINISH'
    end

    local blip = _BlipAddForCoords(681199565, coords)
    SetBlipNameFromTextFile(blip, 'RC_CHECKPM')
    _BlipAddStyle(blip, 681199565)

    if isFinalCheckpoint then
        SetBlipNameFromTextFile(blip, 'RC_BLP_FIN')
        _BlipAddStyle(blip, -282719360)
    else
        _BlipAddStyle(blip, 408396114)
    end

    table.insert(Checkpoints, {
        checkpoints = {
            _CreateCheckpointWithNamehash(_H('CHECKPOINT_RDR_RACE'), coords, nextCoords or coords, 1.0, 255, 100, 0, 100, 0),
            _CreateCheckpointWithNamehash(_H(checkpointFxName), coords, nextCoords or coords, 1.0, 255, 100, 0, 100, 0)
        },
        blip = blip
    })

    return true
end

DeleteCheckpoint = function(checkpointIndex, skipTableRemove)
    local checkpoint = Checkpoints[checkpointIndex]
    if not checkpoint then
        return
    end

    for _, handle in ipairs(checkpoint.checkpoints) do
        _DeleteCheckpoint(handle)
    end

    if checkpoint.blip then
        RemoveBlip(checkpoint.blip)
    end

    if not skipTableRemove then
        table.remove(Checkpoints, checkpointIndex)
    end
end

CleanupCheckpoints = function()
    for checkpointIndex in ipairs(Checkpoints) do
        DeleteCheckpoint(checkpointIndex, true)
    end
end

GetNextRouteCheckpoint = function(route, currCheckpointId, useForwarding)
    local nextCheckpointId = GetNextRouteCheckpointId(route, currCheckpointId, useForwarding)

    return ToV3(route[nextCheckpointId]), nextCheckpointId
end

GetNextRouteCheckpointId = function(route, currCheckpointId, useForwarding)
    local nextCheckpointId, checkpointId = currCheckpointId + 1, 1
    if #route >= nextCheckpointId then
        checkpointId = nextCheckpointId
    elseif useForwarding then
        checkpointId = checkpointId + (currCheckpointId - #route)
    end

    return checkpointId
end

ShowRouteLapNotification = function(lap, numLaps)
    local str = ('%s %i %s %i'):format(GetLabelText('RC_LAP_LAP'), lap, GetLabelText('RC_LAP_OF'), numLaps)
    -- GetLabelText('RC_LAP_LT')
    -- GetLabelText('RC_LAP_FSL')

    _UiFeedPostOneTextShard(3000, CreateVarString(10, 'LITERAL_STRING', str))
end

ShowRouteFinalCheckpointNotification = function()
    _UiFeedPostOneTextShard(-2, CreateVarString(10, 'LITERAL_STRING', GetLabelText('RC_TO_FINISHS')))
end

PlayCheckpointHitSound = function(numCheckpoints, numLaps)
    local isFinalCheckpoint = (CurrentCheckpointId == numCheckpoints and CurrentLap == numLaps)
    local audioName = (isFinalCheckpoint and 'race_end') or 'checkpoint_target'

    _StopSoundWithName(audioName, 'RDRO_Race_sounds')
    if isFinalCheckpoint then
        _PlaySoundFromEntity(audioName, PlayerPedId(), 'RDRO_Race_sounds', true, 0, 0)
    else
        PlaySoundFrontend(audioName, 'RDRO_Race_sounds', false, 0)
    end
end

RegisterNetEvent('redm_horse_races:playerCompletedCheckpoint', function(id, checkpoint, lap, finishedPlace, finishedTime)
    if not IsRaceActive or not HasRaceStarted then
        return
    end

    local playerId = GetPlayerServerId(PlayerId())
    for _, player in ipairs(Players) do
        if player.id == id then
            player.checkpoint = checkpoint
            player.lap = lap
            player.finishedPlace = finishedPlace
            player.finishedTime = finishedTime

            if player.id == playerId and HasRaceFinished then
                local timerStr = GetHudRaceTimerString(math.ceil(player.finishedTime * 1000))
                DatabindingWriteDataString(CentralInfoData.centralInfo.timerString, timerStr)

                printd('EV_PlayerCompletedCheckpoint: Synced central hud timer with server time (%s).', timerStr)
            end

            return printd('EV_PlayerCompletedCheckpoint: Updated player %s:\ncheckpoint: %s\nlap: %s\nfinishedPlace: %s\nfinishedTime: %s\n',
                player.id, player.checkpoint, player.lap, player.finishedPlace, player.finishedTime)
        end
    end

    return printe('EV_PlayerCompletedCheckpoint: Couldn\'t find race player with id %s!', id)
end)

StarHudControllerThread = function(route, numLaps)
    local numCheckpoints = #route

    CentralInfoData = CreateCentralInfoHud('msTimer_and_scores', {
        timerString = '00:00.00',
        timerMessageString = '',

        score = {
            leftScore = GetHudRacePosString(1),
            rightScore = GetHudRaceCheckpointsString(0, numCheckpoints),
            leftScoreColor = _H('COLOR_PURE_WHITE'),
            rightScoreColor = _H('COLOR_YELLOW')
        },

        meters = {
            {
                rootName = 'meter0',
                meterValue = 1.0,
                meterColor = _H('COLOR_RED'),
                txd = 'blips_mp',
                txn = 'BLIP_MP_PLAYLIST_RACES'
            }
        }
    })

    Citizen.CreateThread(function()
        local lapStartTimestamp = nil
        local lastPlayerPos = nil
        local lastCheckpointId = nil
        local finalHudUpdate = false

        while IsRaceActive do
            if HasRaceStarted and not HasRaceFinished then
                local playerPos = GetLocalPlayerCurrentPos(route)
                if playerPos ~= lastPlayerPos then
                    local posStr = GetHudRacePosString(playerPos)
                    DatabindingWriteDataString(CentralInfoData.score.leftScore, posStr)

                    lastPlayerPos = playerPos
                end

                if lastCheckpointId ~= CurrentCheckpointId then
                    local checkpointStr = GetHudRaceCheckpointsString(CurrentCheckpointId - 1, numCheckpoints)
                    DatabindingWriteDataString(CentralInfoData.score.rightScore, checkpointStr)

                    lastCheckpointId = CurrentCheckpointId
                end

                if not lapStartTimestamp then
                    lapStartTimestamp = GetGameTimer()
                else
                    local timeElapsed = GetGameTimer() - lapStartTimestamp

                    if timeElapsed > 0 then
                        local timerStr = GetHudRaceTimerString(timeElapsed)
                        DatabindingWriteDataString(CentralInfoData.centralInfo.timerString, timerStr)
                    end
                end
            end

            if HasRaceFinished and not finalHudUpdate then
                local checkpointStr = GetHudRaceCheckpointsString(CurrentCheckpointId, numCheckpoints)
                DatabindingWriteDataString(CentralInfoData.score.rightScore, checkpointStr)

                finalHudUpdate = true
            end

            if HasRaceEnded then
                RemoveCentralInfoHud(CentralInfoData)
                _UiFeedClearChannel(11, 1, 0)
                _UiFeedClearChannel(12, 1, 0)

                return printd('HudControllerThread(): Stopped thread and removed central info hud (HasRaceEnded = true).')
            end

            Citizen.Wait(25)
        end
    end)
end

CreateCentralInfoHud = function(styleName, cfg)
    local styleHash = GetHashKey(styleName)

    local uiFlowblock = _UiflowblockRequest(-119209833)
    while not _UiflowblockIsLoaded(uiFlowblock) do
        Citizen.Wait(0)
    end

    local centralInfo = {}
    if not cfg then
        cfg = {}
    end

    centralInfo.root = DatabindingAddDataContainerFromPath('', 'centralInfoDatastore')
    centralInfo.timerString = DatabindingAddDataString(centralInfo.root, 'timerString', cfg.timerString or '00:00')
    centralInfo.timerMessageString = DatabindingAddDataString(centralInfo.root, 'timerMessageString', cfg.timerMessageString or 'Message')
    centralInfo.isTimerLow = DatabindingAddDataBool(centralInfo.root, 'isTimerLow', cfg.isTimerLow or false)
    centralInfo.isTimerMessageLow = DatabindingAddDataBool(centralInfo.root, 'isTimerMessageLow', cfg.isTimerMessageLow or false)
    centralInfo.isVisible = DatabindingAddDataBool(centralInfo.root, 'isVisible', cfg.isVisible or false)

    local countDownTimer = {}
    if not cfg.countDownTimer then
        cfg.countDownTimer = {}
    end

    countDownTimer.root = DatabindingAddDataContainer(centralInfo.root, 'countDownTimer')
    countDownTimer.isVisible = DatabindingAddDataBool(countDownTimer.root, 'isVisible', cfg.countDownTimer.isVisible or false)

    local score = {}
    if not cfg.score then
        cfg.score = {}
    end

    score.root = DatabindingAddDataContainer(centralInfo.root, 'score')
    score.visible = DatabindingAddDataBool(score.root, 'visible', cfg.score.visible or false)
    score.leftScore = DatabindingAddDataString(score.root, 'leftScore', cfg.score.leftScore or '0')
    score.rightScore = DatabindingAddDataString(score.root, 'rightScore', cfg.score.rightScore or '0')
    score.leftScoreColor = DatabindingAddDataHash(score.root, 'leftScoreColor', cfg.score.leftScoreColor or _H('COLOR_BLUE'))
    score.rightScoreColor = DatabindingAddDataHash(score.root, 'rightScoreColor', cfg.score.rightScoreColor or _H('COLOR_RED'))
    score.leftScoreTextColor = DatabindingAddDataHash(score.root, 'leftScoreTextColor', cfg.score.leftScoreTextColor or _H('COLOR_BLACK'))
    score.rightScoreTextColor = DatabindingAddDataHash(score.root, 'rightScoreTextColor', cfg.score.rightScoreTextColor or _H('COLOR_BLACK'))

    local fistingMeter = {}
    if not cfg.fistingMeter then
        cfg.fistingMeter = {}
    end

    fistingMeter.root = DatabindingAddDataContainer(centralInfo.root, 'fistingMeter')
    fistingMeter.setLeftMeter = DatabindingAddDataInt(fistingMeter.root, 'setLeftMeter', cfg.fistingMeter.setLeftMeter or 0)
    fistingMeter.setRightMeter = DatabindingAddDataInt(fistingMeter.root, 'setRightMeter', cfg.fistingMeter.setRightMeter or 0)
    fistingMeter.setLeftMeterColor = DatabindingAddDataHash(fistingMeter.root, 'setLeftMeterColor',
        cfg.fistingMeter.setLeftMeterColor or _H('COLOR_BLUE'))
    fistingMeter.setRightMeterColor = DatabindingAddDataHash(fistingMeter.root, 'setRightMeterColor',
        cfg.fistingMeter.setRightMeterColor or _H('COLOR_RED'))
    fistingMeter.visible = DatabindingAddDataBool(fistingMeter.root, 'visible', cfg.fistingMeter.visible or false)

    local wrongWay = {}
    if not cfg.wrongWay then
        cfg.wrongWay = {}
    end

    wrongWay.root = DatabindingAddDataContainer(centralInfo.root, 'wrongWay')
    wrongWay.isVisible = DatabindingAddDataBool(wrongWay.root, 'isVisible', cfg.wrongWay.isVisible or false)

    local meters = {}
    if not cfg.meters then
        cfg.meters = {}
    end

    for _, data in ipairs(cfg.meters) do
        if data.rootName then
            local meter = {}

            meter.root = DatabindingAddDataContainer(centralInfo.root, data.rootName)
            meter.visible = DatabindingAddDataBool(meter.root, 'visible', data.visible or false)
            meter.text = DatabindingAddDataString(meter.root, 'text', data.text or '')
            meter.meterValue = DatabindingAddDataFloat(meter.root, 'meterValue', data.meterValue or 0.0)
            meter.meterColor = DatabindingAddDataHash(meter.root, 'meterColor', data.meterColor or _H('COLOR_PURE_WHITE'))
            meter.txd = DatabindingAddDataString(meter.root, 'txd', data.txd or '')
            meter.txn = DatabindingAddDataString(meter.root, 'txn', data.txn or '')
            meter.imgColor = DatabindingAddDataHash(meter.root, 'imgColor', data.imgColor or _H('COLOR_PURE_WHITE'))
            meter.secondaryTxd = DatabindingAddDataString(meter.root, 'secondaryTxd', data.secondaryTxd or '')
            meter.secondaryTxn = DatabindingAddDataString(meter.root, 'secondaryTxn', data.secondaryTxn or '')
            meter.secondaryImgColor = DatabindingAddDataHash(meter.root, 'secondaryImgColor', data.secondaryImgColor or _H('COLOR_PURE_WHITE'))
            meter.overlayVisible = DatabindingAddDataBool(meter.root, 'overlayVisible', data.overlayVisible or false)
            meter.overlayColor = DatabindingAddDataHash(meter.root, 'overlayColor', data.overlayColor or _H('COLOR_PURE_WHITE'))
            meter.overlayTxd = DatabindingAddDataString(meter.root, 'overlayTxd', 'scoretimer_textures')
            meter.overlayTxn = DatabindingAddDataString(meter.root, 'overlayTxn', 'SCORETIMER_GENERIC_CROSS')
            meter.meterVisible = DatabindingAddDataBool(meter.root, 'meterVisible', true)
            meter.isIconBackgroundVisible = DatabindingAddDataBool(meter.root, 'isIconBackgroundVisible', false)
            meter.showBlinkIcon = DatabindingAddDataBool(meter.root, 'showBlinkIcon', false)
            meter.showPulse = DatabindingAddDataBool(meter.root, 'showPulse', false)
            meter.showAlternateIcons = DatabindingAddDataBool(meter.root, 'showAlternateIcons', false)

            meters[data.rootName] = meter
        end
    end

    _UiflowblockEnter(uiFlowblock, styleHash or 0)
    _UiStateMachineCreate(1546991729, uiFlowblock)

    return {
        centralInfo = centralInfo,
        countDownTimer = countDownTimer,
        score = score,
        fistingMeter = fistingMeter,
        wrongWay = wrongWay,
        meters = meters
    }
end

RemoveCentralInfoHud = function(centralInfoData)
    if centralInfoData then
        for moduleName, moduleEntries in pairs(centralInfoData) do
            for _, entry in ipairs(moduleEntries) do
                DatabindingRemoveDataEntry(entry)
            end
        end

        centralInfoData = nil
    end

    if _UiStateMachineExists(1546991729) then
        _UiStateMachineDestroy(1546991729)
    end
end

GetLocalPlayerStartPos = function()
    local myId = GetPlayerServerId(PlayerId())

    for startPos, player in ipairs(Players) do
        if player.id == myId then
            return startPos
        end
    end

    return nil
end

GetLocalPlayerCurrentPos = function(route, laps)
    local distances = {}
    local totalDist = nil

    for index, player in ipairs(Players) do
        local playerDist = 0.0

        if player.finishedPlace then
            local distToAdd = #Players - player.finishedPlace

            if not totalDist then
                totalDist = GetRouteTotalDistance(route, laps)
            end

            playerDist = totalDist + distToAdd
        else
            playerDist = GetRoutePlayerDistance(route, player.id, player.lap, player.checkpoint)
        end

        table.insert(distances, {
            id = player.id,
            dist = playerDist
        })
    end

    table.sort(distances, function(a, b)
        return a.dist > b.dist
    end)

    local myId = GetPlayerServerId(PlayerId())
    for pos, data in ipairs(distances) do
        if data.id == myId then
            return pos
        end
    end

    return nil
end

GetHudRacePosString = function(playerPos)
    return CreateVarString(2, ('RACE_POS_%i'):format(playerPos))
end

GetHudRaceCheckpointsString = function(currentCheckpoint, numCheckpoints)
    return ('%i/%i'):format(currentCheckpoint, numCheckpoints)
end

GetHudRaceTimerString = function(timeElapsed)
    local seconds = math.floor(timeElapsed / 1000)
    local mins = string.format('%02.f', math.floor(seconds / 60))
    local secs = string.format('%02.f', math.floor(seconds - (mins * 60)))
    local ms = string.format('%02.f', math.floor((timeElapsed % 1000) / 10))

    return ('%02d:%02d.%02d'):format(mins, secs, ms)
end

CreateTickerFinishVarString = function(name, place, color)
    name = _FormatPlayerNameString(name)
    name = CreateVarString(10, 'PLAYER_STRING', name)
    name = CreateColorString(name, color)

    place = place .. GetLabelText(GetOrdinalNumberGxt(place))
    place = CreateVarString(10, 'LITERAL_STRING', place)

    return Citizen.InvokeNative(0xFA925AC00EB830B9, 42, 'RC_TCK_FIN', name, place, Citizen.ResultAsLong())
end

GetOrdinalNumberGxt = function(num)
    local iVar0 = num % 10
    local iVar1 = num % 100

    if (iVar0 == 1 and iVar1 ~= 11) then
        return 'RC_TCK_ORDST'
    elseif (iVar0 == 2 and iVar1 ~= 12) then
        return 'RC_TCK_ORDND'
    elseif (iVar0 == 3 and iVar1 ~= 13) then
        return 'RC_TCK_ORDRD'
    end

    return 'RC_TCK_ORDTH'
end

RegisterNetEvent('redm_horse_races:playerFinishedRaceFeed', function(id, name, place)
    if not IsRaceActive or not HasRaceStarted then
        return
    end

    local tickerColor = GetPlayerFeedColor(id)
    if IsPlayerALocalPlayer(id) then
        _UiFeedPostOneTextShard(-1, CreateVarString(10, 'LITERAL_STRING', GetLabelText('POS_' .. place)))
    end

    _UiFeedPostFeedTicker(4000, CreateTickerFinishVarString(name, place, tickerColor))
end)

StartMusicControllerThread = function(route, numLaps)
    if not Config.EnableRaceMusic then
        return
    end

    if _AudioIsMusicPlaying() then
        printd('MusicControllerThread(): Waiting for music stop.')

        TriggerMusicEvent('MC_MUSIC_STOP')
        _StopAllScriptedAudioSounds()

        while _AudioIsMusicPlaying() do
            Citizen.Wait(0)
        end
    end

    TriggerMusicEvent('MP_HORSE_RACE_START')

    Citizen.CreateThread(function()
        local musicStage = 0

        while IsRaceActive do
            if HasRaceStarted then
                local newMusicStage = GetRaceMusicStage(musicStage, route, numLaps)

                if newMusicStage ~= musicStage then
                    local musicEvent = nil

                    if newMusicStage == 1 then
                        musicEvent = 'MP_HORSE_RACE_FAIL'
                    elseif newMusicStage == 2 then
                        musicEvent = 'MP_HORSE_RACE_BEGINS'
                    elseif newMusicStage == 3 then
                        musicEvent = 'MP_HORSE_RACE_MID'
                    elseif newMusicStage == 4 then
                        musicEvent = 'MP_HORSE_RACE_FINAL'
                    elseif newMusicStage == 5 then
                        musicEvent = 'MP_HORSE_RACE_END'
                    end

                    if musicEvent then
                        musicStage = newMusicStage

                        TriggerMusicEvent(musicEvent)

                        if musicStage == 2 then
                            SetAudioFlag('MusicIgnoreDeathArrest', true)
                        end

                        printd('MusicControllerThread(): Activated musicStage: %i (%s)', musicStage, musicEvent)
                    end
                end

                if HasRaceEnded then
                    return printd('MusicControllerThread(): Stopped thread (HasRaceFinished = true).')
                end
            end

            Citizen.Wait(250)
        end
    end)
end

GetRaceMusicStage = function(lastMusicStage, route, numLaps)
    lastMusicStage = lastMusicStage or 0

    if IsPlayerDead(PlayerId()) and not IsScreenFadedOut() then
        return 1
    end

    if HasRaceEnded and lastMusicStage < 5 then
        return 5
    end

    if HasRaceFinished and lastMusicStage < 4 then
        return 4
    end

    local myId = GetPlayerServerId(PlayerId())
    if GetRoutePlayerProgress(route, numLaps, myId, CurrentLap, CurrentCheckpointId) > 50 and lastMusicStage < 3 then
        return 3
    end

    if lastMusicStage < 2 then
        return 2
    end

    return lastMusicStage
end

StartPlayerControllerThread = function(route, startPoints)
    Citizen.CreateThread(function()
        local respawnTimeouts = {}
        local lastRespawnTimeout = 0

        while IsRaceActive do
            if HasRaceStarted then
                local ped = PlayerPedId()

                if not _IsPedFullyOnMount(ped, false) or IsPedFatallyInjured(CurrentMount) then
                    SetEntityHealth(ped, 0, ped)

                    while not IsPedFatallyInjured(ped) do
                        Citizen.Wait(0)
                    end
                end

                if IsPedFatallyInjured(ped) then
                    local death = GetLocalPlayerDeathReport()
                    if death then
                        TriggerServerEvent('redm_horse_race:playerDeath', death)
                    end

                    StartPlayerDeathThread(route, startPoints)

                    while IsPedFatallyInjured(ped) do
                        Citizen.Wait(0)
                    end
                end

                if HasRaceFinished then
                    return printd('PlayerControllerThread(): Stopped thread (HasRaceFinished = true).')
                end
            end

            Citizen.Wait(250)
        end
    end)
end

StartPlayerDeathThread = function(route, startPoints)
    local playerPed = PlayerPedId()
    if not IsPedFatallyInjured(playerPed) then
        return
    end

    local timestamp = GetGameTimer() + 4000
    local timeLeft = timestamp - GetGameTimer()

    Citizen.CreateThread(function()
        while timeLeft > 0 and IsPedFatallyInjured(playerPed) do
            timeLeft = timestamp - GetGameTimer()

            Citizen.Wait(300)
        end

        if timeLeft <= 0 then
            DoScreenFadeOut(350)
            while not IsScreenFadedOut() do
                Citizen.Wait(0)
            end

            _SetLocalPlayerAsGhost(true)
            printd('PlayerDeathThread(): Ghosted player.')

            local respawnCheckpoint = CurrentCheckpointId - 1
            RespawnLocalPlayerAtCheckpoint(route, startPoints, respawnCheckpoint)
            _PlaceEntityOnGroundProperly(CurrentMount)
            printd('PlayerDeathThread(): Respawned player at checkpoint: %s.', respawnCheckpoint)

            _ForceAllHeadingValuesToAlign(playerPed)
            DoScreenFadeIn(350)

            local ghostedCoords, ghostedTimestamp = GetEntityCoords(PlayerPedId()), GetGameTimer()
            while not ShouldPlayerBeUnGhosted(ghostedCoords, ghostedTimestamp, 6.0, 3.0, 4000) do
                Citizen.Wait(0)
            end

            _SetLocalPlayerAsGhost(false)
            printd('PlayerDeathThread(): Unghosted player.')
        else
            printw('PlayerDeathThread(): Player respawned before timer.')
        end

        printd('PlayerDeathThread(): Stopped thread.')
    end)

    printd('PlayerDeathThread(): Started thread.')
end

RespawnLocalPlayerAtCheckpoint = function(route, startPoints, checkpointId)
    local target = nil

    if checkpointId == 0 then
        local startPos = GetLocalPlayerStartPos()
        if not startPos then
            return false
        end

        local startPoint = startPoints[startPos]
        if not startPoint then
            return false
        end

        target = startPoint
    else
        local checkpoint = route[checkpointId]
        if not checkpoint then
            return false
        end

        target = checkpoint
    end

    if not target then
        return false
    end

    StartPlayerTeleport(PlayerId(), target, true, true, false, false)
    while not _UpdatePlayerTeleport(PlayerId()) do
        Citizen.Wait(0)
    end

    return RespawnLocalPlayer(true, CurrentMount)
end

RespawnLocalPlayerAtTrackEnd = function(dataId)
    if not dataId then
        return
    end

    local race = Config.Races[dataId]
    if not race then
        return
    end

    local respawnCoords = race.route[#race.route]
    if race.corona then
        local coords, heading = race.corona.coords, race.corona.heading
        local adjustedPos = GetCoronaRespawnAdjustedPos(coords, heading)
        local adjustedHeading = GetCoronaRespawnAdjustedHeading(coords, adjustedPos)

        respawnCoords = vector4(adjustedPos.x, adjustedPos.y, adjustedPos.z, adjustedHeading)
    end

    StartPlayerTeleport(PlayerId(), respawnCoords, true, true, false, false)
    while not _UpdatePlayerTeleport(PlayerId()) do
        Citizen.Wait(0)
    end

    return RespawnLocalPlayer(true, CurrentMount)
end

RespawnLocalPlayerAtCoords = function(coords, heading, unFreeze, mount)
    return RespawnLocalPlayer(unFreeze, mount, coords, heading)
end

RespawnLocalPlayer = function(unFreeze, mount, coords, heading, disableGroundAdjusting)
    local player, ped = PlayerId(), PlayerPedId()

    if not coords then
        coords = GetEntityCoords(ped)
    end

    if not heading then
        heading = GetEntityHeading(ped)
    end

    if not disableGroundAdjusting then
        local ground = FindGroundIntersection(coords, 5, 5, false, true)
        
        if ground then
            coords = vector3(coords.x, coords.y, ground)
        end  
    end

    if Config.UseIntegration == 'vorp' then
        local wasScreenFadedOut = IsScreenFadedOut()

        TriggerEvent('vorp:resurrectPlayer', true)
        while IsPedFatallyInjured(PlayerPedId()) do
            Citizen.Wait(0)
        end

        printd('RespawnLocalPlayer(): Resurrected player using VORP death system.')

        if wasScreenFadedOut then
            Citizen.CreateThread(function ()
                printd('RespawnLocalPlayer(): Waiting to skip VORP fade in.')
            
                while IsScreenFadedOut() do
                    if IsScreenFadedIn() or IsScreenFadingIn() then
                        break
                    end

                    Citizen.Wait(0)
                end

                DoScreenFadeOut(0)
            end)
        end
    elseif Config.UseIntegration == 'redemrp' then
        TriggerEvent('redemrp_respawn:respawnCoords', coords)
        while IsPedFatallyInjured(PlayerPedId()) do
            Citizen.Wait(0)
        end
    
        printd('RespawnLocalPlayer(): Resurrected player using RedEM:RP death system.')
    end

    SetEntityCoordsNoOffset(ped, coords, false, false, false)
    SetEntityHeading(ped, heading)
    ClearPedTasksImmediately(ped)
    NetworkResurrectLocalPlayer(coords, heading, 0, true, true, true)
    FreezeEntityPosition(ped, true)
    player, ped = PlayerId(), PlayerPedId()

    while IsPedFatallyInjured(ped) do
        Citizen.Wait(0)
    end

    if DoesEntityExist(mount) then
        SetEntityCoordsNoOffset(mount, coords, false, false, false)
        SetEntityHeading(mount, heading)
        FreezeEntityPosition(mount, true)

        ClearPedTasksImmediately(mount)
        ResurrectPed(mount)
        SetEntityHealth(mount, GetEntityMaxHealth(mount), 0)
        _SetAttributeCoreValue(mount, 0, 100)
        _SetAttributeCoreValue(mount, 1, 100)

        while IsPedFatallyInjured(mount) do
            Citizen.Wait(0)
        end

        TaskMountAnimal(ped, mount, 1, -1, 2.0, 16, 0, 0)
        while not IsPedOnMount(ped, mount) do
            if GetPedConfigFlag(mount, 136, true) then
                SetPedConfigFlag(mount, 136, false)

                printd('RespawnLocalPlayer(): Mount PCF_136 set to false.')
            end

            TaskMountAnimal(ped, mount, 1, -1, 2.0, 16, 0, 0)

            Citizen.Wait(0)
        end

        if unFreeze then
            FreezeEntityPosition(mount, false)
        end
    end

    if unFreeze then
        FreezeEntityPosition(ped, false)
    end

    AnimpostfxStopAll()

    return true
end

GetLocalPlayerDeathReport = function()
    local player, ped = PlayerId(), PlayerPedId()
    if not IsPedFatallyInjured(ped) then
        return nil
    end

    local death = {}
    death.pos = GetEntityCoords(ped, true, true)
    death.weaponHash = GetPedCauseOfDeath(ped)
    death.weaponName = _GetWeaponName(death.weaponHash)
    death.damagedBone = table.pack(GetPedLastDamageBone(ped))[2]
    ClearPedLastDamageBone(ped)

    local killerEntity = table.pack(NetworkGetEntityKillerOfPlayer(player))[1]
    if (killerEntity ~= -1) and (killerEntity ~= ped) then
        local killerPlayer = GetPlayerByPedIndex(killerEntity)

        if NetworkIsPlayerActive(killerPlayer) then
            local killer = {}
            killer.source = GetPlayerServerId(killerPlayer)
            killer.pos = GetEntityCoords(killerEntity, true, true)
            killer.dist = #(killer.pos - death.pos)

            death.killer = killer
        end
    end

    printd('GetLocalPlayerDeathReport(): Created player death report:\npos: %s\nweaponHash: %s\nweaponName: %s\ndamagedBone: %s\nkillerFound: %s',
        death.pos, death.weaponHash, death.weaponName, death.damagedBone, death.killer ~= nil)

    return death
end

GetPlayerByPedIndex = function(ped)
    for _, player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == ped then
            return player
        end
    end

    return nil
end

GetCoronaRespawnAdjustedPos = function(coords, heading)
    local randomPoint = math.random(1, 14)
    local adjustedPos = _GetOffsetFromCoordAndHeadingInWorldCoords(coords, heading, GetCoronaRespawnOffset(randomPoint))
    local placementAttempts = 0

    while IsPositionOccupied(adjustedPos, 4.0, false, true, true, false, false, CurrentMount, true) do
        placementAttempts = placementAttempts + 1
        if placementAttempts > 32 then
            adjustedPos = _GetOffsetFromCoordAndHeadingInWorldCoords(coords, heading, vector3(0.0, -4.0, 0.0))
            printd('GetCoronaRespawnAdjustedPos(): Limit of placementAttempts (%i/32) excedeed, adjustedPos = %s, randomPoint = %i.',
                placementAttempts, adjustedPos, randomPoint)

            return adjustedPos
        end

        local nextRandomPoint = math.random(0, 14)
        while randomPoint == nextRandomPoint do
            nextRandomPoint = math.random(0, 14)

            Citizen.Wait(0)
        end

        adjustedPos = _GetOffsetFromCoordAndHeadingInWorldCoords(coords, heading, GetCoronaRespawnOffset(nextRandomPoint))

        printd('GetCoronaRespawnAdjustedPos(): Position %i is occupied, checking next position %i. Updated placementAttempts = %i.', randomPoint,
            nextRandomPoint, placementAttempts)

        randomPoint = nextRandomPoint
    end

    printd('GetCoronaRespawnAdjustedPos(): Safe respawn place found after %i attempts.', placementAttempts)

    local adjustedZ = FindGroundIntersection(adjustedPos, 2, 20, false)
    if adjustedZ then
        adjustedPos = vector3(adjustedPos.x, adjustedPos.y, adjustedZ)

        printd('GetCoronaRespawnAdjustedPos(): Using ground level %s at %s.', adjustedZ, adjustedPos)
    else
        printd('GetCoronaRespawnAdjustedPos(): Failed to get adjusted ground level at %s, using (coronaCoords.z).', adjustedPos)
    end

    return adjustedPos
end

GetCoronaRespawnAdjustedHeading = function(coords, adjustedPos)
    return (180.0 + GetHeadingFromVector_2d((coords.x - adjustedPos.x), (coords.y - adjustedPos.y)))
end

GetCoronaRespawnOffset = function(placementAttempts)
    local placementStage = math.floor((placementAttempts - 1) / 7) + 1
    local placementAttempt = placementAttempts - (7 * (placementStage - 1))
    local baseY = -4.0 * (placementStage * 1.3)
    local offsetX = 2.0 * placementStage

    if placementAttempt == 0 then
        return vector3(0.0, baseY, 0.0)
    elseif placementAttempt > 0 and placementAttempt <= 3 then
        local adjustedY = baseY + (placementAttempt * (placementAttempt * 0.4))

        return vector3(ToFloat(placementAttempt * offsetX), adjustedY, 0.0)
    elseif placementAttempt > 3 and placementAttempt <= 7 then
        local adjustedAttempt = placementAttempt - 4
        local adjustedY = baseY + (adjustedAttempt * (adjustedAttempt * 0.4))

        return vector3(-(ToFloat(adjustedAttempt * offsetX)), adjustedY, 0.0)
    end

    return vector3(0.0, baseY, 0.0)
end

StartPopulationControllerThread = function(population)
    if not Config.EnablePopulationRestrictions then
        return
    end

    if not population then
        population = {}
    end

    local pedDensity = population.pedDensity or Config.DefaultPedDensity
    local animalDensity = population.animalDensity or Config.DefaultAnimalDensity
    local vehicleDensity = population.vehicleDensity or Config.DefaultVehicleDensity

    AddRacePopulationRestrictions(pedDensity, animalDensity)

    Citizen.CreateThread(function()
        while IsRaceActive do
            _SetAmbientPedDensityMultiplierThisFrame(Clamp(pedDensity, animalDensity))
            SetVehicleDensityMultiplierThisFrame(vehicleDensity)
            _SetAmbientAnimalDensityMultiplierThisFrame(animalDensity)
            _SetScenarioAnimalDensityMultiplierThisFrame(animalDensity)
            _SetAmbientHumanDensityMultiplierThisFrame(pedDensity)
            _SetScenarioHumanDensityMultiplierThisFrame(pedDensity)
            SetRandomVehicleDensityMultiplierThisFrame(vehicleDensity)
            SetParkedVehicleDensityMultiplierThisFrame(vehicleDensity)

            Citizen.Wait(0)
        end
    end)
end

CreatePopulationVolume = function()
    local worldMin = vector3(-16000.0, -16000.0, -1700.0)
    local worldMax = vector3(16000.0, 16000.0, 2700.0)

    return CreateVolumeBox((worldMin + worldMax / vector3(2.0, 2.0, 2.0)), 0.0, 0.0, 0.0, (worldMax - worldMin))
end

AddRacePopulationRestrictions = function(pedDensity, animalDensity)
    if not Config.EnablePopulationRestrictions then
        return printe('AddRacePopulationRestrictions(): Population restrictions is disabled (Config.EnablePopulationRestrictions = false).')
    end

    if PopulationVolume then
        return
    end

    local includeFlags = 0
    local excludeFlags = 262144

    if pedDensity == 0.0 then
        includeFlags = includeFlags + 8192
    else
        excludeFlags = excludeFlags + 8192
    end

    if animalDensity == 0.0 then
        includeFlags = includeFlags + 2016
    else
        excludeFlags = excludeFlags + 2016
    end

    ClearArea(GetEntityCoords(PlayerPedId()), 5000.0, 2442122 + 1)
    printd('AddRacePopulationRestrictions(): Cleared race area population.')

    PopulationVolume = CreatePopulationVolume()
    printd('AddRacePopulationRestrictions(): Created restriction volume.')

    _AddAmbientAvoidanceRestriction(PopulationVolume, includeFlags, excludeFlags, false, -1, -1, 0)
    _AddAmbientSpawnRestriction(PopulationVolume, includeFlags, excludeFlags, false, -1, -1, 0)
    printd('AddRacePopulationRestrictions(): Added restriction zones.')
end

RemoveRacePopulationRestrictions = function()
    if not PopulationVolume then
        return
    end

    _RemoveAmbientAvoidanceRestriction(PopulationVolume);
    _RemoveAmbientSpawnRestriction(PopulationVolume);
    printd('RemoveRacePopulationRestrictions(): Removed restriction zones.')

    _DeleteVolume(PopulationVolume)
    printd('RemoveRacePopulationRestrictions(): Deleted restriction volume.')

    PopulationVolume = nil
end

StartPadControllerThread = function()
    Citizen.CreateThread(function()
        while IsRaceActive do
            DisablePlayerFiring(PlayerId(), true)
            DisableControlAction(0, _H('INPUT_ATTACK'), false)
            DisableControlAction(0, _H('INPUT_MELEE_ATTACK'))
            DisableControlAction(0, _H('INPUT_HORSE_ATTACK'), false)
            DisableControlAction(0, _H('INPUT_MELEE_HORSE_ATTACK_PRIMARY'), false)
            DisableControlAction(0, _H('INPUT_MELEE_HORSE_ATTACK_SECONDARY'), false)
            DisableControlAction(0, _H('INPUT_HORSE_MELEE'), false)
            DisableControlAction(0, _H('INPUT_VEH_PASSENGER_ATTACK'), false)
            DisableControlAction(0, _H('INPUT_VEH_CAR_ATTACK'), false)
            DisableControlAction(0, _H('INPUT_VEH_BOAT_ATTACK'), false)
            DisableControlAction(0, _H('INPUT_VEH_DRAFT_ATTACK'), false)
            DisableControlAction(0, _H('INPUT_VEH_ATTACK'), false)
            DisableControlAction(0, _H('INPUT_VEH_EXIT'), false)
            DisableControlAction(0, _H('INPUT_HORSE_EXIT'), false)
            SetPedCanBeKnockedOffVehicle(PlayerPedId(), 1)

            Citizen.Wait(0)
        end

        SetPedCanBeKnockedOffVehicle(PlayerPedId(), 0)

        printd('PadControllerThread(): Stopped thread (IsRaceActive = false).')
    end)
end

StartDebugThread = function(route, numLaps)
    if not Config.Debug then
        return
    end

    Citizen.CreateThread(function()
        local myId = GetPlayerServerId(PlayerId())
        local eStartX, eStartY, eMargin = 0.008, 0.5, 0.030

        while IsRaceActive do
            local routeTotalDist = GetRouteTotalDistance(route, numLaps)
            local routePlayerDist = GetRoutePlayerDistance(route, myId, CurrentLap, CurrentCheckpointId)
            local routeProgress = math.ceil((routePlayerDist / routeTotalDist) * 100)

            DrawTxt('Race live data:', eStartX, eStartY + eMargin * 0, true, false, 255, 255, 0, 255)
            DrawTxt(('totalRaceDistance: %s'):format(routeTotalDist), eStartX, eStartY + eMargin * 1, true, false, 255, 255, 0, 255)
            DrawTxt(('playerRaceDistance: %s'):format(routePlayerDist), eStartX, eStartY + eMargin * 2, true, false, 255, 255, 0, 255)
            DrawTxt(('raceProgress: %s'):format(routeProgress), eStartX, eStartY + eMargin * 3, true, false, 255, 255, 0, 255)
            DrawTxt(('currentCheckpoint: %s'):format(CurrentCheckpointId), eStartX, eStartY + eMargin * 4, true, false, 255, 255, 0, 255)
            DrawTxt(('currentLap: %s'):format(CurrentLap), eStartX, eStartY + eMargin * 5, true, false, 255, 255, 0, 255)
            DrawTxt(('currentRegion: %s'):format(tostring(GetCurrentPedRegion(PlayerPedId()))), eStartX, eStartY + eMargin * 6, true, false, 255, 255, 0, 255)
            DrawTxt(('imGhost: %s'):format(tostring(_IsEntityAGhost(PlayerPedId()))), eStartX, eStartY + eMargin * 7, true, false, 255, 255, 0, 255)

            Citizen.Wait(0)
        end
    end)
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

    return ToFloat(dist * (laps or 1))
end

GetRouteDistanceBetweenParts = function(route, partId, partId2)
    if route[partId] and route[partId2] then
        return #(route[partId] - route[partId2])
    end

    return 0.0
end

GetRoutePlayerDistance = function(route, playerId, currentLap, currentCheckpoint)
    local dist = GetRouteTotalDistance(route, currentLap - 1)
    if currentCheckpoint > 1 then
        dist = dist + GetRouteDistanceBetweenParts(route, 1, #route)
    end

    local player = GetPlayerFromServerId(playerId)
    if not NetworkIsPlayerActive(player) then
        return dist
    end

    local ped = GetPlayerPed(player)
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

GetRoutePlayerProgress = function(route, numLaps, playerId, currentLap, currentCheckpoint)
    local routeTotalDist = GetRouteTotalDistance(route, numLaps)
    local playerRouteDist = GetRoutePlayerDistance(route, playerId, currentLap, currentCheckpoint)

    return math.ceil((playerRouteDist / routeTotalDist) * 100)
end

Citizen.CreateThread(function()
    if not Config.CoronasEnabled then
        return
    end

    if Config.CoronasEnableUi then
        CoronaUi, CoronaFlowblock = CreateCoronaUiFlow()
    end

    SetupCoronas()

    TriggerServerEvent('redm_horse_races:requestCoronasStateSync')

    local ambientZoneSet = false
    local prompt = nil
    local lastCoronaIdUi = nil
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local foundAnyCorona, delay = false, 500

        for id, corona in ipairs(Coronas) do
            local dist = #(playerCoords - corona.coords)

            if not IsRaceActive and not corona.blip then
                corona.blip = CreateCoronaBlip(corona.coords)

                printd('CoronaControllerThread(): Created corona blip (%s).', corona.name)
            elseif IsRaceActive and corona.blip then
                RemoveBlip(corona.blip)
                corona.blip = nil

                printd('CoronaControllerThread(): Removed corona blip (%s).', corona.name)
            end

            if not IsRaceActive and dist <= Config.CoronasRenderDistance and not corona.obj then
                corona.obj = CreateCoronaObject(corona.coords, corona.heading)

                printd('CoronaControllerThread(): Created corona object (%s).', corona.name)
            elseif (IsRaceActive or (dist > Config.CoronasRenderDistance)) and corona.obj and DoesEntityExist(corona.obj) then
                DeleteObject(corona.obj)
                corona.obj = nil

                printd('CoronaControllerThread(): Deleted corona object (%s).', corona.name)
            end

            if not IsRaceActive and dist <= 80.0 then
                foundAnyCorona = true

                local suppressCoronas = ShouldSuppressCoronas()
                if suppressCoronas then
                    foundAnyCorona = false
                end

                if not ambientZoneSet and not suppressCoronas then
                    SetAmbientZoneState('AZ_rdro_corona_area_00', true, true)
                    _SetAmbientZonePosition('AZ_rdro_corona_area_00', corona.coords, 0.0)
                    ambientZoneSet = true

                    printd('CoronaControllerThread(): Enabled ambient zone (%s).', corona.name)
                end

                if CoronaUi and dist <= 15.0 and not (lastCoronaIdUi == id) then
                    DatabindingWriteDataString(CoronaUi.gameModeText, 'GST_RACE_STANDA')
                    DatabindingWriteDataString(CoronaUi.playerCountText, corona.name)
                    lastCoronaIdUi = id

                    printd('CoronaControllerThread(): Displayed text on corona (%s).', corona.name)
                end

                if dist <= 5.0 and not suppressCoronas and not CoronaPrompts then
                    CoronaPrompts = CreateCoronaPrompts(corona.coords, corona.name, corona.laps, corona.active)
                    CurrentCorona = corona.name

                    if IsCoronaMode(corona.active, 'host') then
                        CoronaLaps = 3

                        _UiPromptSetText(CoronaPrompts.main, GetCoronaPromptText(corona.name, CoronaLaps, corona.active))

                        printd('CoronaControllerThread(): We are in host mode, initialized corona (%s) laps %i.', corona.name, CoronaLaps)
                    end

                    printd('CoronaControllerThread(): Created corona prompt (%s).', corona.name)
                elseif (dist > 5.0 or suppressCoronas) and CoronaPrompts then
                    CleanupCoronaPrompts()
                    CurrentCorona = nil

                    printd('CoronaControllerThread(): Deleted corona prompt (%s).', corona.name)
                end

                if CoronaPrompts then
                    delay = 100

                    if IsCoronaMode(corona.active, 'host') then
                        delay = 0

                        if _UiPromptHasStandardModeCompleted(CoronaPrompts.increase) then
                            if (CoronaLaps + 1) <= 12 then
                                CoronaLaps = CoronaLaps + 1

                                _UiPromptSetText(CoronaPrompts.main, GetCoronaPromptText(corona.name, CoronaLaps, corona.active))

                                printd('CoronaControllerThread(): Increased laps on corona prompts (%s), new laps %i.', corona.name, CoronaLaps)
                            end
                        elseif _UiPromptHasStandardModeCompleted(CoronaPrompts.lower) then
                            if (CoronaLaps - 1) >= 1 then
                                CoronaLaps = CoronaLaps - 1

                                _UiPromptSetText(CoronaPrompts.main, GetCoronaPromptText(corona.name, CoronaLaps, corona.active))

                                printd('CoronaControllerThread(): Lowered laps on corona prompts (%s), new laps %i.', corona.name, CoronaLaps)
                            end
                        end
                    end

                    if _UiPromptHasHoldModeCompleted(CoronaPrompts.main) then
                        local coronaMode = GetCoronaMode(corona.active)

                        if coronaMode == 'quit' then
                            TriggerServerEvent('redm_horse_races:leaveRace')
                        elseif coronaMode == 'join' then
                            TriggerServerEvent('redm_horse_races:joinCorona', corona.name)
                        elseif coronaMode == 'host' then
                            TriggerServerEvent('redm_horse_races:hostCorona', corona.name, CoronaLaps)
                        end

                        CleanupCoronaPrompts()

                        printd('CoronaControllerThread(): Completed corona prompt (%s).', corona.name)

                        Citizen.Wait(1000)
                    end
                end
            end
        end

        if not foundAnyCorona then
            if ambientZoneSet then
                ClearAmbientZoneState('AZ_rdro_corona_area_00', true)
                ambientZoneSet = false

                printd('CoronaControllerThread(): Left nearby coronas, ambient zone cleared.')
            end

            if CurrentCorona then
                CurrentCorona = nil
            end
        end

        Citizen.Wait(delay)
    end
end)

ShouldSuppressCoronas = function()
    if WaitingForRaceInit then
        return true
    end

    if RevTransAnimScene then
        return true
    end

    if CloudsTransAnimScene then
        return true
    end

    if GetIsLoadingScreenActive() then
        return true
    end

    if not IsPedOnMount(PlayerPedId()) then
        return true
    end

    local mount = GetMount(PlayerPedId())
    if not ValidateLocalPlayerMount(mount) then
        return true
    end

    return false
end

IsCoronaMode = function(isActive, mode)
    return (GetCoronaMode(isActive) == mode)
end

GetCoronaMode = function(isActive)
    if IsMatchmakingActive then
        return 'quit'
    elseif isActive then
        return 'join'
    end

    return 'host'
end

SetupCoronas = function()
    for id, race in ipairs(Config.Races) do
        local corona = race.corona

        if corona then
            table.insert(Coronas, {
                blip = blip,
                obj = nil,

                coords = corona.coords,
                heading = corona.heading,
                name = race.name,
                laps = -1,
                active = false
            })
        end
    end

    printd('SetupCoronas(): Created %i coronas.', #Coronas)
end

CreateCoronaUiFlow = function()
    local ui = {}

    ui.root = DatabindingAddDataContainerFromPath('', 'CoronaTitle')
    ui.gameModeText = DatabindingAddDataString(ui.root, 'GameModeText', '')
    ui.playerCountText = DatabindingAddDataString(ui.root, 'PlayerCountText', '')

    local flowblock = _UiflowblockRequest(41788007)
    while not _UiflowblockIsLoaded(flowblock) do
        Citizen.Wait(0)
    end

    _UiflowblockEnter(flowblock, 1769708826)
    _UiStateMachineCreate(-470163491, flowblock)
    while not _UiStateMachineCanRequestTransition(-470163491) do
        Citizen.Wait(0)
    end

    return ui, flowblock
end

CreateCoronaPrompts = function(coords, name, laps, isActive)
    local prompts = {}

    prompts.main = _UiPromptRegisterBegin()
    _UiPromptSetControlAction(prompts.main, _H('INPUT_CONTEXT_X'))
    _UiPromptSetText(prompts.main, GetCoronaPromptText(name, laps, isActive))
    _UiPromptContextSetPoint(prompts.main, coords)
    _UiPromptContextSetRadius(prompts.main, 5.0)
    _UiPromptSetAttribute(prompts.main, 18, true)
    _UiPromptSetStandardizedHoldMode(prompts.main, _H('SHORT_TIMED_EVENT'))
    _UiPromptRegisterEnd(prompts.main)

    if GetCoronaMode(isActive) == 'host' then
        prompts.increase = _UiPromptRegisterBegin()
        _UiPromptSetControlAction(prompts.increase, _H('INPUT_FRONTEND_UP'))
        _UiPromptSetText(prompts.increase, CreateVarString(10, 'LITERAL_STRING', Config.UiCoronaHostIncreaseRace))
        _UiPromptContextSetPoint(prompts.increase, coords)
        _UiPromptContextSetRadius(prompts.increase, 5.0)
        _UiPromptSetAttribute(prompts.increase, 18, true)
        _UiPromptSetStandardMode(prompts.increase, true)
        _UiPromptRegisterEnd(prompts.increase)

        prompts.lower = _UiPromptRegisterBegin()
        _UiPromptSetControlAction(prompts.lower, _H('INPUT_FRONTEND_DOWN'))
        _UiPromptSetText(prompts.lower, CreateVarString(10, 'LITERAL_STRING', Config.UiCoronaHostLowerRace))
        _UiPromptContextSetPoint(prompts.lower, coords)
        _UiPromptContextSetRadius(prompts.lower, 5.0)
        _UiPromptSetAttribute(prompts.lower, 18, true)
        _UiPromptSetStandardMode(prompts.lower, true)
        _UiPromptRegisterEnd(prompts.lower)
    end

    for _, prompt in pairs(prompts) do
        _UiPromptSetVisible(prompt, true)
        _UiPromptSetEnabled(prompt, true)
    end

    return prompts
end

GetCoronaPromptText = function(name, laps, isActive)
    if IsMatchmakingActive then
        return CreateVarString(10, 'LITERAL_STRING', Config.UiCoronaQuitRace:format(name, laps))
    else
        if isActive then
            return CreateVarString(10, 'LITERAL_STRING', Config.UiCoronaJoinRace:format(name, laps))
        else
            return CreateVarString(10, 'LITERAL_STRING', Config.UiCoronaHostRace:format(name, laps))
        end
    end
end

CleanupCoronaPrompts = function()
    if not CoronaPrompts then
        return
    end

    for _, prompt in pairs(CoronaPrompts) do
        _UiPromptDelete(prompt)
    end

    CoronaPrompts = nil
    CoronaLaps = nil
end

CreateCoronaBlip = function(coords)
    local blip = _BlipAddForCoords(-346940613, coords)
    SetBlipSprite(blip, _H('BLIP_MP_PLAYLIST_RACES'), true)
    SetBlipNameFromTextFile(blip, 'GST_RACE_STANDA')
    SetBlipFlashTimer(blip, 92, _H('NET_PLAYLIST_RACE_SERIES'))

    return blip
end

CreateCoronaObject = function(coords, heading)
    RequestModel(_H('mp001_s_mpcorona01x'))
    while not HasModelLoaded(_H('mp001_s_mpcorona01x')) do
        Citizen.Wait(0)
    end

    local obj = CreateObjectNoOffset(_H('mp001_s_mpcorona01x'), coords, false, true, false, false)
    SetEntityHeading(obj, heading)

    if not _PlaceEntityOnGroundProperly(obj) then
        local ground = FindGroundIntersection(coords, 2, 20, false, true)

        if ground then
            SetEntityCoordsNoOffset(obj, coords.x, coords.y, ground, false, false, false)
        end
    end

    FreezeEntityPosition(obj, true)
    SetModelAsNoLongerNeeded(_H('mp001_s_mpcorona01x'))

    return obj
end

CleanupCoronas = function()
    for _, corona in ipairs(Coronas) do
        if corona.blip then
            RemoveBlip(corona.blip)
        end

        if corona.obj and DoesEntityExist(corona.obj) then
            DeleteObject(corona.obj)
        end
    end

    ClearAmbientZoneState('AZ_rdro_corona_area_00', true)

    if CoronaUi then
        for _, entry in pairs(CoronaUi) do
            DatabindingRemoveDataEntry(entry)
        end
    end

    if CoronaFlowblock then
        exports[GetCurrentResourceName()]:UiflowblockRelease(CoronaFlowblock, 1769708826)
    end

    if _UiStateMachineExists(-470163491) then
        _UiStateMachineDestroy(-470163491)
    end

    if CoronaPrompts then
        CleanupCoronaPrompts()
    end
end

RegisterNetEvent('redm_horse_races:syncCoronaState', function(name, active, laps)
    for _, corona in ipairs(Coronas) do
        if corona.name == name then
            if active ~= nil then
                corona.active = active
            end

            if laps ~= nil then
                corona.laps = laps
            end

            if CoronaPrompts and CurrentCorona == corona.name then
                CleanupCoronaPrompts()
            end

            return printd('EV_UpdateCoronaState(): Updated corona %s state (active = %s, laps = %s).', name, corona.active, corona.laps)
        end
    end

    printd('EV_UpdateCoronaState(): Failed to update corona %s state.', name)
end)

RegisterNetEvent('redm_horse_races:syncCoronasState', function(activeCoronas)
    for _, corona in ipairs(Coronas) do
        for _, coronaData in ipairs(activeCoronas) do
            if corona.name == coronaData.name then
                corona.active = true
                corona.laps = coronaData.laps

                if CoronaPrompts and CurrentCorona == corona.name then
                    CleanupCoronaPrompts()
                end
            end
        end
    end

    printd('EV_UpdateCoronaState(): Synced %i coronas state.', #activeCoronas)
end)

Citizen.CreateThread(function()
    while true do
        local myId = PlayerId()

        for _, player in ipairs(GetActivePlayers()) do
            if player ~= myId then
                local ped = GetPlayerPed(player)

                if DoesEntityExist(ped) then
                    local shouldBeGhosted = _IsEntityAGhost(ped)
                    local entities = {ped}

                    if IsPedOnMount(ped) then
                        local mount = GetMount(ped)

                        if DoesEntityExist(mount) then
                            table.insert(entities, mount)
                        end
                    else
                        local lastMount = _GetLastMount(ped)

                        if DoesEntityExist(lastMount) and GetEntityAlpha(lastMount) ~= 255 then
                            ResetEntityAlpha(lastMount)
                        end
                    end

                    for _, entity in ipairs(entities) do
                        local opacity = GetEntityAlpha(entity)

                        if shouldBeGhosted and opacity == 255 then
                            SetEntityAlpha(entity, 80)
                        elseif not shouldBeGhosted and opacity ~= 255 then
                            ResetEntityAlpha(entity)
                        end
                    end
                end
            end
        end

        Citizen.Wait(300)
    end
end)

AddEventHandler('onResourceStop', function(rsc)
    if GetCurrentResourceName() == rsc then
        CleanupCoronas()
        CleanupRace()
    end
end)
