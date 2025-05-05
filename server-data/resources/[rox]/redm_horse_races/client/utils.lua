HashMap = {}

for _, hashName in ipairs({
    'BAYOUNWA', 'BIGVALLEY', 'BLIP_MP_PLAYLIST_RACES', 'BLIZZARD', 'BLUEWATERMARSH', 'CHECKPOINT_RDR_BONFIRE_FINISH', 'CHECKPOINT_RDR_RACE',
    'CHECKPOINT_RDR_RACE_FX', 'CHOLLASPRINGS', 'CLOUDS', 'COLOR_BLACK', 'COLOR_BLUE', 'COLOR_BRONZE', 'COLOR_GOLD', 'COLOR_GREYMID', 'COLOR_PLATINUM',
    'COLOR_POSSE_ENEMY', 'COLOR_PURE_WHITE', 'COLOR_RED', 'COLOR_WHITE', 'COLOR_YELLOW', 'CUMBERLAND', 'DEFAULT_SCRIPTED_CAMERA', 'DRIZZLE', 'FOG',
    'GAPTOOTHRIDGE', 'GATLINGMAXIM02', 'GENERIC_PLAYER', 'GREATPLAINS', 'GRIZZLIESEAST', 'GRIZZLIESWEST', 'GROUNDBLIZZARD', 'GUARMAD', 'HAIL',
    'HEARTLANDS', 'HENNIGANSSTEAD', 'HUD_CTX_MP_MATCHMAKING_TRANSITION', 'HURRICANE', 'INPUT_CONTEXT_X', 'ITEM_SELECTED', 'KING', 'LEADERBOARDS',
    'MINIGAMES', 'MISTY', 'MP001_MP_WINLOSE_DESERT', 'MP001_MP_WINLOSE_FOREST', 'MP001_MP_WINLOSE_SNOW', 'MP001_MP_WINLOSE_SWAMP',
    'MP001_P_MP_FINISHLINE_BONFIRE02X', 'mp001_s_mpcorona01x', 'MP001_U_07P_WINLOSE', 'NET_PLAYLIST_RACE_SERIES', 'OVERCAST', 'OVERCASTDARK',
    'POSSE_DEPUTY', 'POSSE_LEADER', 'RAIN', 'RIOBRAVO', 'ROANOKE', 'SANDSTORM', 'SCARLETTMEADOWS', 'SCR_NET_RACE_CHECKPOINTS', 'SHORT_TIMED_EVENT',
    'SHOWER', 'SLEET', 'SNOW', 'SNOWCLEARING', 'SNOWLIGHT', 'TALLTREES', 'THUNDER', 'THUNDERSTORM', 'transition_root', 'WHITEOUT', 'INPUT_ATTACK',
    'INPUT_MELEE_ATTACK', 'INPUT_HORSE_ATTACK', 'INPUT_VEH_PASSENGER_ATTACK', 'INPUT_VEH_CAR_ATTACK', 'INPUT_VEH_BOAT_ATTACK',
    'INPUT_VEH_DRAFT_ATTACK', 'INPUT_VEH_ATTACK', 'INPUT_VEH_EXIT', 'INPUT_HORSE_EXIT', 'INPUT_HORSE_MELEE', 'INPUT_MELEE_HORSE_ATTACK_PRIMARY',
    'INPUT_MELEE_HORSE_ATTACK_SECONDARY', 'INPUT_FRONTEND_UP', 'INPUT_FRONTEND_DOWN', 'P_CRATE05X', 'menu_icon_mp_playlist_races'
}) do
    HashMap[hashName] = GetHashKey(hashName)
end

_H = function(hashName)
    if not HashMap[hashName] then
        printe('Missing entry %s in HashMap, returning 0!', hashName)

        return 0
    end

    return HashMap[hashName]
end

for _, native in ipairs({
    {'CreateCheckpointWithNamehash', 0x175668836B44CBB0}, {'DeleteCheckpoint', 0x0DED5B0C8EBAAE12}, {'BlipAddForCoords', 0x554D9D53F696D002},
    {'BlipAddStyle', 0xBD62D98799A3DAF0}, {'UiflowblockRequest', 0xC0081B34E395CE48}, {'UiflowblockIsLoaded', 0x10A93C057B6BD944},
    {'UiflowblockEnter', 0x3B7519720C9DCB45}, {'UiStateMachineCreate', 0x4C6F2C4B7A03A266},
    {'UiStateMachineCanRequestTransition', 0xF7C180F57F85D0B8, 'bool'}, {'UiStateMachineRequestTransition', 0x7EA9C3547E80350E},
    {'UiStateMachineExists', 0x5D15569C0FEBF757}, {'UiStateMachineDestroy', 0x4EB122210A90E2D8}, {'UiFeedClearChannel', 0xDD1232B332CBB9E7},
    {'UiPromptRegisterBegin', 0x04F97DE45A519419}, {'UiPromptSetControlAction', 0xB5352B7494A08258}, {'UiPromptSetText', 0x5DD02A8318420DD7},
    {'UiPromptContextSetPoint', 0xAE84C5EE2C384FB3}, {'UiPromptContextSetRadius', 0x0C718001B77CA468}, {'UiPromptSetAttribute', 0x560E76D5E2E1803F},
    {'UiPromptSetStandardizedHoldMode', 0x74C7D7B72ED0D3CF}, {'UiPromptRegisterEnd', 0xF7AA2696A22AD8B9}, {'UiPromptSetVisible', 0x71215ACCFDE075EE},
    {'UiPromptSetEnabled', 0x8A0FB4D03A630D21}, {'UiPromptHasHoldModeCompleted', 0xE0F65F0640EF0617}, {'UiPromptDelete', 0x00EDE88D4D13CF59},
    {'LaunchUiappByHashWithEntry', 0xC1BCF31E975B3195}, {'RequestUiappTransitionByHash', 0x7689CD255655BFD7},
    {'IsUiappRunningByHash', 0x4E511D093A86AD49}, {'CloseUiappByHash', 0x2FF10C9C3F92277E}, {'CloseUiappByHashImmediate', 0x04428420A248A354},
    {'DatabindingReadFloat', 0x5FE444EB67C70AD4, 'float'}, {'DisplayLoadingScreens', 0x1E5B70E53DB661E5},
    {'CreateColorString', 0xBCC2CFADEA1AEA6C, 'string'}, {'FormatPlayerNameString', 0x5B6193813E03E4E9, 'string'},
    {'TextBlockRequest', 0xF66090013DE648D5}, {'TextBlockIsLoaded', 0xD0976CC34002DB57, 'bool'}, {'TextBlockDelete', 0xAA03F130A637D923},
    {'PrepareSoundset', 0xD9130842D7226045, 'bool'}, {'ReleaseSoundset', 0x531A78D6BF27014B}, {'PlaySoundFromEntity', 0x6FB1DA3CA9DA7D90},
    {'PlaySoundFrontendWithSoundId', 0xCE5D0FFE83939AF1}, {'SetVariableOnSoundWithId', 0x503703EC1781B7D6}, {'StopSoundWithName', 0x0F2A2175734926D8},
    {'StopAllScriptedAudioSounds', 0x2E399EAFBEEA74D5}, {'SetAudioOnlineTransitionStage', 0x9B1FC259187C97C0},
    {'AudioIsMusicPlaying', 0x845FFC3A4FEEFA3E, 'bool'}, {'SetAmbientZonePosition', 0x3743CE6948194349},
    {'IsAnimSceneLoaded', 0x477122B8D05E7968, 'bool'}, {'IsAnimSceneRunning', 0xCBFC7725DE6CE2E0, 'bool'},
    {'IsAnimScenePlaybackListPhaseLoaded', 0x23E33CB9F4A3F547, 'bool'}, {'IsAnimSceneFinished', 0xD8254CB2C586412B, 'bool'},
    {'GetAnimScenePed', 0xE5822422197BBBA3}, {'GetAnimSceneObject', 0xFB5674687A1B2814}, {'GetAnimScenePhase', 0x3FBC3F51BF12DFBF, 'float'},
    {'RequestAnimScenePlayList', 0xDF7B5144E25CD3FE, 'bool'}, {'SetAnimScenePlayList', 0x15598CFB25F3DC7E},
    {'ReleaseAnimScenePlayList', 0xAE6ADA8FE7E84ACC, 'bool'}, {'DeleteAnimScene', 0x84EEDB2C6E650000},
    {'CreateMpGamerTagOnEntity', 0xE961BF23EAB76B12}, {'SetMpGamerTagType', 0x25B9C78A25105C35}, {'SetMpGamerTagNamePosse', 0x1EA716E0628A6F44},
    {'SetMpGamerTagVisibility', 0x93171DDDAB274EB8}, {'SetMpGamerTagTopIcon', 0x5F57522BC1EB9D9D}, {'SetMpGamerTagColour', 0x84BD27DDF9575816},
    {'AnimpostfxGetStackhash', 0x842CCC9491FFCD9B}, {'AnimpostfxPreloadPostfxByStackhash', 0xF3E039322BFBD4D8},
    {'AnimpostfxIsPreloadingByStackhash', 0x59EA80079B86D8C7, 'bool'}, {'AnimpostfxPlayTag', 0x9B8D5D4CB8AF58B3},
    {'AnimpostfxIsStackhashPlaying', 0xEEF83A759AE06A27, 'bool'}, {'AnimpostfxStopStackhashPostfx', 0xEDA5CBECF56E1386},
    {'EventsUiIsPending', 0x67ED5A7963F2F722, 'bool'}, {'EventsUiPopMessage', 0x8E8A2369F48EC839}, {'IsWeaponPistol', 0xDDC64F5E31EEDAB6, 'bool'},
    {'IsWeaponRevolver', 0xC212F1D05A8232BB, 'bool'}, {'GetWeaponName', 0x89CF5FF3D363311E, 'string'}, {'GetMapZoneAtCoords', 0x43AD8FC02B429D33},
    {'IsIplActiveHash', 0xD779B9B910BD3B7C, 'bool'}, {'RequestIplByHash', 0x9E211A378F95C97C}, {'RemoveIplByHash', 0x431E3AB760629B34},
    {'IsPedArmed', 0xCB690F680A3EA971, 'bool'}, {'IsPedHogtying', 0x42429C674B61238B, 'bool'}, {'IsPedHogtied', 0x3AA24CCC0D451379, 'bool'},
    {'IsPedFullyOnMount', 0x95CBC65780DE7EB1, 'bool'}, {'PlaceEntityOnGroundProperly', 0x9587913B9E772D29, 'bool'},
    {'SetRandomOutfitVariation', 0x283978A15512B2FE}, {'UpdatePlayerTeleport', 0xC39DCE4672CBFBC1},
    {'ForceAllHeadingValuesToAlign', 0xFF287323B0E2C69A}, {'SetLocalPlayerAsGhost', 0x5FFE9B4144F9712F},
    {'GetNextWeatherTypeHashName', 0x51021D36F62AAA83}, {'EnableHudContext', 0x4CC5F2FC1332577F}, {'DisableHudContext', 0x8BC7C1F929D07BF3},
    {'AddAmbientAvoidanceRestriction', 0xB56D41A694E42E86}, {'AddAmbientSpawnRestriction', 0x18262CAFEBB5FBE1},
    {'RemoveAmbientAvoidanceRestriction', 0x74C2B3DC0B294102}, {'RemoveAmbientSpawnRestriction', 0xA1CFB35069D23C23},
    {'DeleteVolume', 0x43F867EF5C463A53}, {'SetAmbientPedDensityMultiplierThisFrame', 0xAB0D553FE20A6E25},
    {'SetAmbientAnimalDensityMultiplierThisFrame', 0xC0258742B034DFAF}, {'SetScenarioAnimalDensityMultiplierThisFrame', 0xDB48E99F8E064E56},
    {'SetAmbientHumanDensityMultiplierThisFrame', 0xBA0980B5C0A11924}, {'SetScenarioHumanDensityMultiplierThisFrame', 0x28CB6391ACEDD9DB},
    {'SetAttributeCoreValue', 0xC6258F41D86676E0}, {'UiPromptSetStandardMode', 0xCC6656799977741B},
    {'UiPromptHasStandardModeCompleted', 0xC92AC953F0A982AE}, {'SetAutoJumpableByHorse', 0x98D2D9C053A1F449},
    {'SetNotJumpableByHorse', 0xE1C708BA4885796B}, {'IsEntityAGhost', 0x21D04D7BC538C146, 'bool'}, {'GetLastMount', 0x4C8B59171957BCF7},
    {'DrawMarker', 0x2A32FAA57B937173}, {'IsMountSeatFree', 0xAAB0FE202E9FC9F0, 'bool'}, {'GetRiderOfMount', 0xB676EFDA03DADA52}
}) do
    local name, hash, type = table.unpack(native)

    if _G[name] then
        printd('Native %s (%s) is already registered.', name, hash)
    end

    _G['_' .. name] = function(...)
        if type == 'bool' then
            return Citizen.InvokeNative(hash, ...) == 1
        elseif type == 'float' then
            return Citizen.InvokeNative(hash, ..., Citizen.ResultAsFloat())
        elseif type == 'string' then
            return Citizen.InvokeNative(hash, ..., Citizen.ResultAsString())
        end

        return Citizen.InvokeNative(hash, ...)
    end
end

_BusyspinnerSetText = function(text)
    return Citizen.InvokeNative(0x7F78CD75CC4539E4, CreateVarString(10, 'LITERAL_STRING', text))
end

_GetOffsetFromCoordAndHeadingInWorldCoords = function(coords, heading, offset)
    return Citizen.InvokeNative(0x163E252DE035A133, coords, heading, offset, Citizen.ResultAsVector())
end

_UiFeedPostFeedTicker = function(...)
    exports[GetCurrentResourceName()]:UiFeedPostFeedTicker(...)
end

_UiFeedPostSampleToast = function(...)
    exports[GetCurrentResourceName()]:UiFeedPostSampleToast(...)
end

_UiFeedPostOneTextShard = function(...)
    exports[GetCurrentResourceName()]:UiFeedPostOneTextShard(...)
end

_GetPedCurrentMoveBlendRatio = function(...)
    return exports[GetCurrentResourceName()]:GetPedCurrentMoveBlendRatio(...)
end

LockLocalPlayer = function()
    local ped = PlayerPedId()

    if DoesEntityExist(ped) then
        SetPlayerControl(PlayerId(), false, 256, false)
        FreezeEntityPosition(ped, true)

        if IsPedOnMount(ped) then
            local mount = GetMount(ped)

            if DoesEntityExist(mount) then
                FreezeEntityPosition(mount, true)
            end
        end
    end
end

UnlockLocalPlayer = function()
    local ped = PlayerPedId()

    if DoesEntityExist(ped) then
        SetPlayerControl(PlayerId(), true, 256, false)
        FreezeEntityPosition(ped, false)

        if IsPedOnMount(ped) then
            local mount = GetMount(ped)

            if DoesEntityExist(mount) then
                FreezeEntityPosition(mount, false)
            end
        end
    end
end

HideLocalPlayer = function()
    local ped = PlayerPedId()

    if DoesEntityExist(ped) then
        SetEntityAlpha(ped, 0, false)

        if IsPedOnMount(ped) then
            local mount = GetMount(ped)

            if DoesEntityExist(mount) then
                SetEntityAlpha(mount, 0, false)
            end
        end
    end
end

ShowLocalPlayer = function()
    local ped = PlayerPedId()

    if DoesEntityExist(ped) then
        ResetEntityAlpha(ped)

        if IsPedOnMount(ped) then
            local mount = GetMount(ped)

            if DoesEntityExist(mount) then
                ResetEntityAlpha(mount)
            end
        end
    end
end

ShouldPlayerBeUnGhosted = function(coords, timestamp, minSpeed, minDist, minTimeMs)
    return (GetEntitySpeed(PlayerPedId()) > minSpeed) or (#(GetEntityCoords(PlayerPedId()) - coords) > minDist) or
               ((GetGameTimer() - timestamp) > minTimeMs)
end

IsPlayerALocalPlayer = function(playerId)
    return GetPlayerServerId(PlayerId()) == playerId
end

GetPlayerFeedColor = function(playerId)
    return (IsPlayerALocalPlayer(playerId) and _H('COLOR_WHITE')) or _H('COLOR_POSSE_ENEMY')
end

FindGroundIntersection = function(coords, steep, maxIters, ignoreWater, probeLower)
    local pos = {
        x = coords.x,
        y = coords.y,
        z = coords.z
    }
    local iters = 0

    RequestCollisionAtCoord(pos.x, pos.y, pos.z)

    local ground = false
    while not ground do
        if (iters < maxIters) then
            pos.z = (pos.z + steep)
            iters = (iters + 1)

            RequestCollisionAtCoord(pos.x, pos.y, pos.z)
            ground = exports[GetCurrentResourceName()]:GetGroundZFor_3dCoord(pos.x, pos.y, pos.z, ignoreWater)

            if ground then
                return ground
            end
        else
            break
        end

        Citizen.Wait(0)
    end

    if probeLower then
        pos = {
            x = coords.x,
            y = coords.y,
            z = coords.z - steep
        }
        iters = 0

        RequestCollisionAtCoord(pos.x, pos.y, pos.z)

        ground = false
        while not ground do
            if (iters < maxIters) then
                pos.z = (pos.z - steep)
                iters = (iters + 1)

                RequestCollisionAtCoord(pos.x, pos.y, pos.z)
                ground = exports[GetCurrentResourceName()]:GetGroundZFor_3dCoord(pos.x, pos.y, pos.z, ignoreWater)

                if ground then
                    return ground
                end
            else
                break
            end

            Citizen.Wait(0)
        end
    end

    return nil
end

DrawTxt = function(str, x, y, shadow, center, r, g, b, a)
    local str = CreateVarString(10, 'LITERAL_STRING', str)

    SetTextColor(math.floor(r), math.floor(g), math.floor(b), math.floor(a))
    SetTextScale(0.5, 0.5)

    if shadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    if center then
        SetTextCentre(true)
    end

    Citizen.InvokeNative(0xD79334A4BB99BAD1, str, x, y)
    SetTextRenderId(0)
end

CreateColorString = function(varStr, colorHash)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, 42, 'COLOR_STRING', _CreateColorString(colorHash), varStr, Citizen.ResultAsLong())
end

GetLabelTextIfExist = function(label)
    if not label then
        return nil
    end

    if DoesTextLabelExist(label) then
        local literal = GetLabelText(label)

        if literal ~= 'NULL' and literal ~= '' then
            return literal
        end
    end

    return label
end

GetLabelTextIfExistOrVarString = function(label)
    if not label then
        return nil
    end

    if DoesTextLabelExist(label) then
        local literal = GetLabelText(label)

        if literal ~= 'NULL' and literal ~= '' then
            return literal
        end
    end

    return CreateVarString(10, 'LITERAL_STRING', label)
end
