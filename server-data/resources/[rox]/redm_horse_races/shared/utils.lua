Citizen.CreateThread(function()
    if Config.UseIntegration == 'redemrp' then
        printw('Resource started with RedEM:RP framework integration.')
    elseif Config.UseIntegration == 'vorp' then
        printw('Resource started with VORP framework integration.')
    end    

    if not Config.EnableRespawnProtection then
        printw('[FEATURE] Respawn protection is disabled (Config.EnableRespawnProtection).')
    end

    if not Config.EnablePopulationRestrictions then
        printw('[FEATURE] Population restrictions are disabled (Config.EnablePopulationRestrictions).')
    end

    if not Config.EnableRoutingBuckets then
        printw('[FEATURE] Routing buckets are disabled (Config.EnableRoutingBuckets).')
    elseif Config.EnableRoutingBuckets and not IsOneSyncEnabled() and IsDuplicityVersion() then
        printe('[FEATURE] Routing buckets are only available with OneSync enabled!')
    end

    if not Config.CoronasEnabled then
        printw('[FEATURE] Coronas are disabled (Config.CoronasEnabled).')
    else
        if not Config.CoronasEnableUi then
            printw('[FEATURE] Coronas UI are disabled (Config.CoronasEnableUi).')
        end
    end

    if not Config.EnableReverseCamTransition then
        printw('[FEATURE] Reverse cam transition is disabled (Config.EnableReverseCamTransition).')
    end

    if not Config.EnableIntroLoadingScreen then
        printw('[FEATURE] Loading screen is disabled (Config.EnableIntroLoadingScreen).')
    end

    if not Config.EnableIntroFlowCutscene then
        printw('[FEATURE] Intro flow cutscene is disabled (Config.EnableIntroFlowCutscene).')
    end

    if not Config.EnableRaceEndTimer then
        printw('[FEATURE] Race end timer is disabled (Config.EnableRaceEndTimer).')
    end

    if not Config.EnableEndFlowCutsceneAndLeaderboard then
        printw('[FEATURE] End flow cutscene and leaderboard is disabled (Config.EnableEndFlowCutsceneAndLeaderboard).')
    end

    if not Config.EnableCloudsTransition then
        printw('[FEATURE] Clouds transition is disabled (Config.EnableCloudsTransition).')
    end
end)

CreateTimeoutFunction = function(fnc, maxTimeMs, intervalMs)
    local done, result = false, nil
    local time = GetGameTimer()

    while not done and ((GetGameTimer() - time) <= maxTimeMs) do
        fnc(function (res)
            done, result = true, res
        end)

        Citizen.Wait(0)
    end

    return result, done
end

ToFloat = function(src)
    return src + 0.0
end

ToV3 = function(src)
    return vector3(src.x, src.y, src.z)
end

Clamp = function(x, min, max)
    if min and (x < min) then
        return min
    end
    if max and (x > max) then
        return max
    end

    return x
end

IsOneSyncEnabled = function()
    return GetConvar('onesync', 'off') ~= 'off'
end

printd = function(str, ...)
    if not Config.Debug then
        return
    end

    print('[DEBUG] ' .. str:format(...))
end

printw = function(str, ...)
    print('[WARN] ' .. str:format(...))
end

printe = function(str, ...)
    print('[ERROR] ' .. str:format(...))
end
