CurrentWheelSelectedWeapon = nil
HasGunOil = true
WeaponWheelSlotAttachPoints = {
    ['WEAPONS_SIDEARMS'] = { 2, 3 },
    ['WEAPONS_LONGARMS_AND_BOWS'] = { 7, 9, 1 },
    ['OFFHAND'] = { 8, 10 }
}
JammedWeapons = {}

if IsAnyIntegrationEnabled() and Config.EnableGunOilCheck then
    HasGunOil = false

    printd('EnableGunOilCheck = true, setting HasGunOil to false.')
end

Citizen.CreateThread(function ()
    while true do
        if IsControlPressed(0, `INPUT_OPEN_WHEEL_MENU`) then
            if IsControlJustPressed(0, `INPUT_QUICK_SELECT_INSPECT`) then
                print('CurrentWheelSelectedWeapon: %s', CurrentWheelSelectedWeapon)
                StartWeaponInspection(CurrentWheelSelectedWeapon)
            end
        else
            Citizen.Wait(250)
        end

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function ()
    while true do
        if _IsUiappRunningByHash(`HUD_QUICK_SELECT`) then
            if Citizen.InvokeNative(0x67ED5A7963F2F722, `HUD_QUICK_SELECT`) then
                local eventData = exports[GetCurrentResourceName()]:EventsUiPeekMessage(`HUD_QUICK_SELECT`)

                if eventData['eventType'] == -1740156697 then
                    local foundWeapon = false

                    for slotName in pairs(WeaponWheelSlotAttachPoints) do
                        if GetHashKey(slotName) == eventData['hashParam'] then
                            local slotWeapon = GetWeaponInWeaponWheelSlot(slotName)

                            if slotWeapon then
                                if exports[GetCurrentResourceName()]:_InventorySetInventoryItemInspectionEnabled(slotWeapon, 1) ~= 1 then
                                    printe('Failed to enable inspection mode for weapon %s at slot %s.', _GetWeaponName(slotWeapon), slotName)
                                end

                                CurrentWheelSelectedWeapon = slotWeapon
                                foundWeapon = true
                            end
                        end
                    end

                    if not foundWeapon then
                        CurrentWheelSelectedWeapon = nil
                    end
                end

                Citizen.InvokeNative(0x8E8A2369F48EC839, `HUD_QUICK_SELECT`)
            end
        else
            Citizen.Wait(250)
        end

        Citizen.Wait(0)
    end
end)

StartWeaponInspection = function(weaponHash)
    if not IsWeaponValid(weaponHash) then
        return
    end

    local playerPed = PlayerPedId()
    local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)
    local stateNameHash = GetValidStateNameHashForWeapon(weaponHash)

    if stateNameHash then
        local initPermDegradation, initDamage, initDirt, initSoot
        local isCleaning = false

        TaskItemInteraction_2(playerPed, weaponHash, weaponObject, 0, stateNameHash, 0, 0, 0.0)
        Citizen.Wait(0)

        if CanPlayerInspectWeapon() then
            local flowblock, databind = SetupInspectionDatabinding(weaponHash, weaponObject)
            N_0x6339c1ea3979b5f7("weapon", "Inspect_Item_Scenes") --// _START_AUDIO_SCENESET

            if Config.UseIntegration == 'vorp' then
                TriggerServerEvent('redm_weapon_maintenance:vorp:requestGunOil')
            end

            while CanPlayerInspectWeapon() do
                local intState = N_0x6aa3dca2c6f5eb6d(playerPed) --// GET_ITEM_INTERACTION_STATE

                if DatabindingReadDataBool(databind.visible) == 0 then
                    if intState == `LONGARM_HOLD` or intState == `SHORTARM_HOLD` then
                        if CanPlayerCleanWeapon(weaponObject) then
                            N_0xcb9401f918cb0f75(playerPed, 'GENERIC_WEAPON_CLEAN_PROMPT_AVAILABLE', true, -1)
                        else
                            if Config.EnableNotifications then
                                local degradation = Round(_GetWeaponDegradation(weaponObject), 6)

                                if _GetWeaponPermanentDegradation(weaponObject) > 0.0 and (degradation <= _GetWeaponPermanentDegradation(weaponObject)) then
                                    exports[GetCurrentResourceName()]:UiFeedPostHelpText(GetLabelText('WEAPON_PERM_DEGREDATION'), 10000)
                                end

                                if not HasGunOil and (degradation > _GetWeaponPermanentDegradation(weaponObject)) then
                                    exports[GetCurrentResourceName()]:UiFeedPostHelpText(GetLabelText('NO_GUN_OIL'), 10000)
                                end
                            end

                            N_0xcb9401f918cb0f75(playerPed, 'GENERIC_WEAPON_CLEAN_PROMPT_AVAILABLE', false, -1)
                        end

                        DatabindingWriteDataBool(databind.visible, true)
                    end

                    DisableControlAction(0, `INPUT_NEXT_CAMERA`, false)
                end

                if not isCleaning and (intState == `LONGARM_CLEAN_ENTER` or intState == `SHORTARM_CLEAN_ENTER`) then
                    initDegradation = NormalizeFloat((_GetWeaponDegradation(weaponObject) - _GetWeaponPermanentDegradation(weaponObject)), 0.0, 1.0)
                    initDamage = NormalizeFloat((_GetWeaponDamage(weaponObject) - _GetWeaponPermanentDegradation(weaponObject)), 0.0, 1.0)
                    initDirt = _GetWeaponDirt(weaponObject)
                    initSoot = _GetWeaponSoot(weaponObject)
                    isCleaning = true

                    if Config.EnableGunOilCheck then
                        if Config.UseIntegration == 'redemrp' then
                            TriggerServerEvent('redm_weapon_maintenance:redemrp:removeGunOil')
                        elseif Config.UseIntegration == 'vorp' then
                            TriggerServerEvent('redm_weapon_maintenance:vorp:removeGunOil')
                        end
                    end
                end

                if isCleaning then
                    if intState == `LONGARM_CLEAN_EXIT` or intState == `SHORTARM_CLEAN_EXIT` then
                        local permDegradation = _GetWeaponPermanentDegradation(weaponObject)

                        ApplyWeaponObjectProps(weaponObject, permDegradation, permDegradation, 0.0, 0.0)
                        UpdateInspectionDatabinding(databind, weaponHash, weaponObject)
                        N_0xcb9401f918cb0f75(playerPed, 'GENERIC_WEAPON_CLEAN_PROMPT_AVAILABLE', false, -1)
                        TriggerEvent('redm_weapon_maintenance:forceSaveWeaponProps', weaponHash, true)

                        isCleaning = false
                    else
                        local promptProgress = Citizen.InvokeNative(0xBC864A70AD55E0C1, playerPed, `INPUT_CONTEXT_X`, Citizen.ResultAsFloat()) --// GET_ITEM_INTERACTION_PROMPT_PROGRESS

                        if promptProgress > 0.0 and promptProgress < 1.0 then
                            local permDegradation = _GetWeaponPermanentDegradation(weaponObject)
                            local newDegradation = ((initDegradation + permDegradation) - (promptProgress * initDegradation))
                            local newDamage = ((initDamage + permDegradation) - (promptProgress * initDamage))
                            local newDirt = (initDirt - (promptProgress * initDirt))
                            local newSoot = (initSoot - (promptProgress * initSoot))

                            ApplyWeaponObjectProps(weaponObject, newDegradation, newDamage, newDirt, newSoot)
                            UpdateInspectionDatabinding(databind, weaponHash, weaponObject)
                        end
                    end
                end

                if intState == `LONGARM_HOLD_EXIT` or intState == `SHORTARM_HOLD_EXIT` then
                    break
                end

                Citizen.Wait(0)
            end

            CleanupInspectionDatabinding(flowblock, databind)
        end
    end
end

CanPlayerInspectWeapon = function()
    local playerPed = PlayerPedId()

    if IsEntityDead(playerPed) then
        return false
    end

    if IsPedSwimming(playerPed) then
        ClearPedTasks(playerPed, true, false)

        return false
    end

    if N_0x038b1f1674f0e242(playerPed) == 0 then --// IS_PED_RUNNING_INSPECTION_TASK
        return false
    end

	return true
end

CanPlayerCleanWeapon = function(weaponObject)
    if Config.DisableCleaningViaWheelMenu then
        return false
    end

    if not HasGunOil then
        return false
    end

    local degradation = Round(_GetWeaponDegradation(weaponObject), 6)
    if not ((degradation ~= 0.0) and (degradation > _GetWeaponPermanentDegradation(weaponObject))) then
        return false
    end

    return true
end

SetupInspectionDatabinding = function(weaponHash, weaponObject)
    local itemLabel = GetWeaponObjectLabel(weaponHash, weaponObject)
    local tipText = GetWeaponObjectTipText(weaponObject)

    local databind = {}
    databind.container = DatabindingAddDataContainerFromPath("", "ItemInspection")
    databind.visible = DatabindingAddDataBool(databind.container, "Visible", false)
    databind.stats = exports[GetCurrentResourceName()]:N_0x46db71883ee9d5af(databind.container, weaponHash)
    databind.itemLabel = DatabindingAddDataHash(databind.container, "itemLabel", itemLabel)
    databind.tipText = DatabindingAddDataString(databind.container, "tipText", tipText)

    N_0x4cc5f2fc1332577f(-1847602092) --// _ENABLE_HUD_CONTEXT

    local flowblock = Citizen.InvokeNative(0xC0081B34E395CE48, 1069234796) --// _UIFLOWBLOCK_REQUEST
    while not Citizen.InvokeNative(0x10A93C057B6BD944, flowblock) do --// _UIFLOWBLOCK_IS_LOADED
        Citizen.Wait(0)
    end

    Citizen.InvokeNative(0x3B7519720C9DCB45, flowblock, 0) --// _UIFLOWBLOCK_ENTER
    if not Citizen.InvokeNative(0x5D15569C0FEBF757, -813354801) then --// UI_STATE_MACHINE_EXISTS
        Citizen.InvokeNative(0x4C6F2C4B7A03A266, -813354801, flowblock) --// UI_STATE_MACHINE_CREATE
    end

    return flowblock, databind
end

UpdateInspectionDatabinding = function(databind, weaponHash, weaponObject)
    local itemLabel = GetWeaponObjectLabel(weaponHash, weaponObject)
    local tipText = GetWeaponObjectTipText(weaponObject)

    exports[GetCurrentResourceName()]:N_0x951847cef3d829ff(databind.stats, weaponHash)
    DatabindingWriteDataHashString(databind.itemLabel, itemLabel)
    DatabindingWriteDataString(databind.tipText, tipText)
end

CleanupInspectionDatabinding = function(flowblock, databind)
    N_0x9428447ded71fc7e("Inspect_Item_Scenes")
    Citizen.InvokeNative(0x4EB122210A90E2D8, -813354801) --// UI_STATE_MACHINE_DESTROY
	DatabindingRemoveDataEntry(databind.container)
	N_0x8bc7c1f929d07bf3(-1847602092) --// _DISABLE_HUD_CONTEXT
end

ApplyWeaponObjectProps = function(weaponObject, degradation, damage, dirt, soot)
    N_0xa7a57e89e965d839(weaponObject, degradation) --// _SET_WEAPON_DEGRADATION
    N_0xe22060121602493b(weaponObject, damage, false) --// _SET_WEAPON_DAMAGE
    N_0x812ce61debcab948(weaponObject, dirt, false) --// _SET_WEAPON_DIRT
    N_0xa9ef4ad10bdddb57(weaponObject, soot, false) --// _SET_WEAPON_SOOT
end

GetValidStateNameHashForWeapon = function(weaponHash)
    if N_0x705be297eebdb95d(weaponHash) == 1 and N_0xc4dec3ca8c365a5d(weaponHash) == 0 then
        if N_0x0556e9d2ecf39d01(weaponHash) == 1 then --// _IS_WEAPON_TWO_HANDED
            return `LONGARM_HOLD_ENTER`
        end

        return `SHORTARM_HOLD_ENTER`
    end

    return nil
end

GetObjectIndexOfPedWeapon = function(ped, weaponHash)
	for attachPoint=0, 29 do
		local _, _weaponHash = GetCurrentPedWeapon(ped, true, attachPoint, false)

		if _weaponHash == weaponHash then
			return GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(ped, attachPoint))
		end
	end

	return nil
end

GetWeaponInWeaponWheelSlot = function(slotName)
    if WeaponWheelSlotAttachPoints[slotName] then
        for _, attachPoint in ipairs(WeaponWheelSlotAttachPoints[slotName]) do
            local hasWeapon, weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, attachPoint, false)

            if hasWeapon and weaponHash ~= `WEAPON_UNARMED` then
                return weaponHash
            end
        end
    end

    local _, currWeapon = GetCurrentPedWeapon(PlayerPedId(), false, 0, false)
    if currWeapon ~= `WEAPON_UNARMED` then
        return currWeapon
    end

    return nil
end

GetWeaponObjectLabel = function(weaponHash, weaponObject)
    local permDegradation = _GetWeaponPermanentDegradation(weaponObject)
    local weaponName = Citizen.InvokeNative(0x89CF5FF3D363311E, weaponHash, Citizen.ResultAsString()) --// _GET_WEAPON_NAME

    if permDegradation > 0.0 then
        weaponName = Citizen.InvokeNative(0x7A56D66C78D8EF8E, weaponHash, permDegradation, Citizen.ResultAsString()) --// _GET_WEAPON_NAME_WITH_PERMANENT_DEGRADATION
    end

    return GetHashKey(weaponName)
end

GetWeaponObjectTipText = function(weaponObject)
    local degradation = Round(_GetWeaponDegradation(weaponObject), 6)
    local permDegradation = _GetWeaponPermanentDegradation(weaponObject)

    if degradation == 0.0 then
        return GetLabelTextByHash(1803343570)
    elseif permDegradation > 0.0 and (degradation == permDegradation) then
        return GetLabelTextByHash(-1933427003)
    end

    return GetLabelTextByHash(-54957657)
end

NormalizeFloat = function(float, min, Max)
	if (float > Max) then
		return Max
	elseif (float < min) then
		return min
    end

	return float
end

Round = function (number, decimals)
    return tonumber(string.format('%.' .. decimals .. 'f', number))
end

--[[ Natives declaration ]]--
_GetWeaponPermanentDegradation = function(weaponObject)
    return 0.0
end

_GetWeaponDegradation = function(weaponObject)
    return Citizen.InvokeNative(0x0D78E1097F89E637, weaponObject, Citizen.ResultAsFloat())
end

_GetWeaponDamage = function(weaponObject)
    return Citizen.InvokeNative(0x904103D5D2333977, weaponObject, Citizen.ResultAsFloat())
end

_GetWeaponDirt = function(weaponObject)
    return Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponObject, Citizen.ResultAsFloat())
end

_GetWeaponSoot = function(weaponObject)
    return Citizen.InvokeNative(0x4BF66F8878F67663, weaponObject, Citizen.ResultAsFloat())
end

_GetWeaponName = function(weaponHash)
    return Citizen.InvokeNative(0x89CF5FF3D363311E, weaponHash, Citizen.ResultAsString())
end

_IsWeaponAGun = function(...)
    return Citizen.InvokeNative(0x705BE297EEBDB95D, ...)
end

_IsUiappRunningByHash = function(appNameHash)
    return Citizen.InvokeNative(0x4E511D093A86AD49, appNameHash)
end

--[[ Integrations ]]--
if Config.UseIntegration == 'redemrp' then
    local HasInventoryLoaded = false
    local CurrentWeapons = {}
    local LastWeaponHash = nil
    local LastWeaponProps = nil
    local CurrentWeaponsCustom = {}

    local RefreshLoadoutStateFromCache = function(ignoreWeapon)
        local playerPed = PlayerPedId()

        for weaponHash, weaponMeta in pairs(CurrentWeapons) do
            if not ignoreWeapon or (weaponHash ~= ignoreWeapon) then
                if HasPedGotWeapon(playerPed, weaponHash) then
                    if GetValidStateNameHashForWeapon(weaponHash) then
                        local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                        if DoesEntityExist(weaponObject) then
                            local degradation = (weaponMeta.degradation or 0.0) + 0.0
                            local damage = (weaponMeta.damage or 0.0) + 0.0
                            local dirt = (weaponMeta.dirt or 0.0) + 0.0
                            local soot = (weaponMeta.soot or 0.0) + 0.0

                            ApplyWeaponObjectProps(weaponObject, degradation, damage, dirt, soot)
                        end
                    end
                end
            end
        end
    end

    Citizen.CreateThread(function ()
        local lastSyncTime = GetGameTimer()

        while true do
            local playerPed = PlayerPedId()
            local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed, true, 0, false)

            if LastWeaponHash and LastWeaponHash ~= weaponHash then
                local weaponMeta = CurrentWeapons[LastWeaponHash]

                if weaponMeta then
                    TriggerServerEvent('redm_weapon_maintenance:redemrp:updateWeaponProps', _GetWeaponName(LastWeaponHash), weaponMeta, LastWeaponProps)

                    printd('[RedEM:RP] Saved weapon props %s:\nnewPermDegradation: %s\nnewDegradation: %s\nnewDamage: %s\nnewDirt: %s\nnewSoot: %s\nnewIsJammed: %s', _GetWeaponName(LastWeaponHash),
                        LastWeaponProps.permDegradation, LastWeaponProps.degradation, LastWeaponProps.damage, LastWeaponProps.dirt, LastWeaponProps.soot, LastWeaponProps.isJammed)
                end

                lastSyncTime = GetGameTimer()
                LastWeaponHash, lastWeaponProps = nil, nil
            end

            if hasWeapon and GetValidStateNameHashForWeapon(weaponHash) then
                local weaponMeta = CurrentWeapons[weaponHash]

                if weaponMeta then
                    local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                    if DoesEntityExist(weaponObject) then
                        local newPermDegradation = Round(_GetWeaponPermanentDegradation(weaponObject), 6)
                        local newDegradation = Round(_GetWeaponDegradation(weaponObject), 6)
                        local newDamage = Round(_GetWeaponDamage(weaponObject), 6)
                        local newDirt = Round(_GetWeaponDirt(weaponObject), 6)
                        local newSoot = Round(_GetWeaponSoot(weaponObject), 6)
                        local newIsJammed = GetWeaponIsJammed(weaponObject)

                        if (weaponMeta.permDegradation ~= newPermDegradation) or (weaponMeta.degradation ~= newDegradation) or (weaponMeta.damage ~= newDamage) or (weaponMeta.dirt ~= newDirt) or (weaponMeta.soot ~= newSoot) or (weaponMeta.isJammed ~= newIsJammed) then
                            LastWeaponHash = weaponHash
                            LastWeaponProps = {
                                permDegradation = newPermDegradation,
                                degradation = newDegradation,
                                damage = newDamage,
                                dirt = newDirt,
                                soot = newSoot,
                                isJammed = newIsJammed
                            }

                            if GetGameTimer()-lastSyncTime > Config.StatsSyncInterval then
                                lastSyncTime = GetGameTimer()

                                TriggerServerEvent('redm_weapon_maintenance:redemrp:updateWeaponProps', _GetWeaponName(weaponHash), weaponMeta, {
                                    permDegradation = newPermDegradation,
                                    degradation = newDegradation,
                                    damage = newDamage,
                                    dirt = newDirt,
                                    soot = newSoot,
                                    isJammed = newIsJammed
                                })

                                printd('[RedEM:RP][BG] Saved weapon props %s:\nnewPermDegradation: %s\nnewDegradation: %s\nnewDamage: %s\nnewDirt: %s\nnewSoot: %s\nnewIsJammed: %s', _GetWeaponName(LastWeaponHash), newPermDegradation, newDegradation, newDamage, newDirt, newSoot, newIsJammed)
                            end
                        end
                    end
                end
            end

            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function ()
        while true do
            local playerPed = PlayerPedId()
            local _, currWeaponHash = GetCurrentPedWeapon(playerPed, true, 0, false)
            local weaponsToUpdate = {}

            for attachPoint=0, 29 do
                local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed, true, attachPoint, false)

                if hasWeapon and currWeaponHash ~= weaponHash and GetValidStateNameHashForWeapon(weaponHash) then
                    local weaponMeta = CurrentWeapons[weaponHash]

                    if weaponMeta then
                        local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                        if DoesEntityExist(weaponObject) then
                            local newPermDegradation = Round(_GetWeaponPermanentDegradation(weaponObject), 6)
                            local newDegradation = Round(_GetWeaponDegradation(weaponObject), 6)
                            local newDamage = Round(_GetWeaponDamage(weaponObject), 6)
                            local newDirt = Round(_GetWeaponDirt(weaponObject), 6)
                            local newSoot = Round(_GetWeaponSoot(weaponObject), 6)
                            local newIsJammed = GetWeaponIsJammed(weaponObject)

                            if (weaponMeta.permDegradation ~= newPermDegradation) or (weaponMeta.degradation ~= newDegradation) or (weaponMeta.damage ~= newDamage) or (weaponMeta.dirt ~= newDirt) or (weaponMeta.soot ~= newSoot) or (weaponMeta.isJammed ~= newIsJammed) then
                                table.insert(weaponsToUpdate, {
                                    meta = weaponMeta,
                                    name = _GetWeaponName(weaponHash),

                                    permDegradation = newPermDegradation,
                                    degradation = newDegradation,
                                    damage = newDamage,
                                    dirt = newDirt,
                                    soot = newSoot,
                                    isJammed = newIsJammed
                                })
                            end
                        end
                    end
                end
            end

            if #weaponsToUpdate > 0 then
                TriggerServerEvent('redm_weapon_maintenance:redemrp:updateMultiWeaponProps', weaponsToUpdate)
            end

            Citizen.Wait(Config.StatsSyncInterval)
        end
    end)

    RegisterNetEvent('redemrp_inventory:UseWeapon', function(weaponHash, ammoAmount, meta)
        Citizen.Wait(500)

        local playerPed = PlayerPedId()
        weaponHash = tonumber(weaponHash)

        if IsWeaponValid(weaponHash) then
            if HasPedGotWeapon(playerPed, weaponHash) then
                if GetValidStateNameHashForWeapon(weaponHash) then
                    CurrentWeapons[weaponHash] = meta
                    CurrentWeaponsCustom[weaponHash] = {}

                    local permDegradation = (meta.permDegradation or 0.0) + 0.0
                    local degradation = (meta.degradation or 0.0) + 0.0
                    if Config.EnablePermanentDegradation and (degradation < permDegradation) then
                        degradation = permDegradation

                        printw('[RedEM:RP] Weapon %s degradation is lower than permanent degradation value, synced with permanent degradation (%s) value.', _GetWeaponName(weaponHash), permDegradation)
                    end

                    CurrentWeaponsCustom[weaponHash]['permDegradation'] = permDegradation
                    CurrentWeaponsCustom[weaponHash]['isJammed'] = meta.isJammed

                    local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)
                    local timestamp = GetGameTimer()
                    while not DoesEntityExist(weaponObject) do
                        if GetGameTimer()-timestamp > Config.PropsLoadTimeout then
                            return printe('[RedEM:RP] Failed to load weapon props (%s).', weaponHash)
                        end

                        weaponObject = GetObjectIndexOfPedWeapon(PlayerPedId(), weaponHash)

                        Citizen.Wait(100)
                    end

                    local damage = (meta.damage or 0.0) + 0.0
                    local dirt = (meta.dirt or 0.0) + 0.0
                    local soot = (meta.soot or 0.0) + 0.0
                    ApplyWeaponObjectProps(weaponObject, degradation, damage, dirt, soot)

                    printd('[RedEM:RP] Applied props to weapon %s:\npermDegradation: %s\ndegradation: %s\ndamage: %s\ndirt: %s\nsoot: %s\nisJammed: %s', _GetWeaponName(weaponHash), permDegradation, degradation, damage, dirt, soot, meta.isJammed)
                end
            end
        end

        RefreshLoadoutStateFromCache(weaponHash)
    end)

    AddEventHandler('redm_weapon_maintenance:forceSaveWeaponProps', function (weaponHash, isCleaned)
        local weaponMeta = CurrentWeapons[weaponHash]

        if weaponMeta then
            local weaponObject = GetObjectIndexOfPedWeapon(PlayerPedId(), weaponHash)

            if DoesEntityExist(weaponObject) then
                local newPermDegradation = Round(_GetWeaponPermanentDegradation(weaponObject), 6)
                local newDegradation = Round(_GetWeaponDegradation(weaponObject), 6)
                local newDamage = Round(_GetWeaponDamage(weaponObject), 6)
                local newDirt = Round(_GetWeaponDirt(weaponObject), 6)
                local newSoot = Round(_GetWeaponSoot(weaponObject), 6)
                local newIsJammed = GetWeaponIsJammed(weaponObject)

                if newIsJammed and isCleaned then
                    if Config.MalfunctionEnablePermanentJamming then
                        if not (newPermDegradation >= Config.MalfunctionPermJamMinPermDegradation) then
                            newIsJammed = false

                            printd('[RedEM:RP] Unjammed weapon %s.', _GetWeaponName(weaponHash))
                        end
                    else
                        newIsJammed = false

                        printd('[RedEM:RP] Unjammed weapon %s.', _GetWeaponName(weaponHash))
                    end

                    if Config.EnableWeaponMalfunctions then
                        SetWeaponIsJammed(weaponObject, newIsJammed)
                    end
                end

                if (weaponMeta.permDegradation ~= newPermDegradation) or (weaponMeta.degradation ~= newDegradation) or (weaponMeta.damage ~= newDamage) or (weaponMeta.dirt ~= newDirt) or (weaponMeta.soot ~= newSoot) or (weaponMeta.isJammed ~= newIsJammed) then
                    TriggerServerEvent('redm_weapon_maintenance:redemrp:updateWeaponProps', _GetWeaponName(weaponHash), weaponMeta, {
                        permDegradation = newPermDegradation,
                        degradation = newDegradation,
                        damage = newDamage,
                        dirt = newDirt,
                        soot = newSoot,
                        isJammed = newIsJammed
                    })

                    weaponMeta.permDegradation = newPermDegradation
                    weaponMeta.degradation = newDegradation
                    weaponMeta.damage = newDamage
                    weaponMeta.dirt = newDirt
                    weaponMeta.soot = newSoot
                    weaponMeta.isJammed = newIsJammed

                    if LastWeaponHash == weaponHash then
                        LastWeaponProps = {
                            permDegradation = newPermDegradation,
                            degradation = newDegradation,
                            damage = newDamage,
                            dirt = newDirt,
                            soot = newSoot,
                            isJammed = newIsJammed
                        }
                    end

                    printd('[RedEM:RP] Force saved weapon props %s:\nnewPermDegradation: %s\nnewDegradation: %s\nnewDamage: %s\nnewDirt: %s\nnewSoot: %s\nnewIsJammed: %s', _GetWeaponName(weaponHash), newPermDegradation, newDegradation, newDamage, newDirt, newSoot, newIsJammed)
                end
            end
        end
    end)

    RegisterNetEvent('redemrp_inventory:SendItems', function (items, otherItems, weight, isOther)
        if isOther then
            return
        end

        local playerPed = PlayerPedId()
        local gunOilFound = false

        for _, item in ipairs(items) do
            if item.type == 'item_weapon' then
                local weaponHash = tonumber(item.weaponHash)

                if CurrentWeapons[weaponHash] then
                    CurrentWeapons[weaponHash] = item.meta
                end
            elseif item.name == Config.GunOilItemName and Config.EnableGunOilCheck then
                HasGunOil = (item.amount > 0)
                gunOilFound = true
            end
        end

        if not gunOilFound and Config.EnableGunOilCheck then
            HasGunOil = false
        end
    end)

    RegisterNetEvent('redemrp_inventory:removeWeapon', function(weaponHash)
        weaponHash = tonumber(weaponHash)

        if CurrentWeapons[weaponHash] then
            CurrentWeapons[weaponHash] = nil
            CurrentWeaponsCustom[weaponHash] = nil
        end
    end)

    if Config.EnableWeaponMalfunctions then
        printd('Malfunctions system enabled.')

        if Config.MalfunctionEnableJammedSound then
            while not (RequestScriptAudioBank('Ledger') == 1) do
                Citizen.Wait(0)
            end

            printd('Malfunctions sound effect loaded.')

            AddEventHandler('onResourceStop', function (rsc)
                if GetCurrentResourceName() == rsc then
                    ReleaseNamedScriptAudioBank('Ledger')
                end
            end)
        end

        Citizen.CreateThread(function ()
            while true do
                local playerPed = PlayerPedId()
                local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed, true, 0, false)

                if hasWeapon and _IsWeaponAGun(weaponHash) then
                    local weaponMeta = CurrentWeapons[weaponHash]

                    if weaponMeta then
                        local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                        if DoesEntityExist(weaponObject) then
                            if GetWeaponIsJammed(weaponObject) then
                                if IsDisabledControlJustPressed(0, `INPUT_ATTACK`) then
                                    if Config.MalfunctionNotificationEnabled then
                                        if Config.MalfunctionEnablePermanentJamming then
                                            local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                                            if DoesEntityExist(weaponObject) and (_GetWeaponPermanentDegradation(weaponObject) >= Config.MalfunctionPermJamMinPermDegradation) then
                                                exports[GetCurrentResourceName()]:UiFeedPostHelpText(Config.MalfunctionPermJamNotification, Config.MalfunctionNotificationDuration)
                                            else
                                                exports[GetCurrentResourceName()]:UiFeedPostHelpText(Config.MalfunctionNotification, Config.MalfunctionNotificationDuration)
                                            end
                                        else
                                            exports[GetCurrentResourceName()]:UiFeedPostHelpText(Config.MalfunctionNotification, Config.MalfunctionNotificationDuration)
                                        end
                                    end

                                    if Config.MalfunctionEnableJammedSound then
                                        PlaySoundFrontend('UNAFFORDABLE', 'Ledger_Sounds', true, 0)
                                    end
                                end

                                DisablePlayerFiring(PlayerId(), true)
                                DisableControlAction(0, `INPUT_ATTACK`, false)
                                DisableControlAction(0, `INPUT_HORSE_ATTACK`, false)
                                DisableControlAction(0, `INPUT_VEH_PASSENGER_ATTACK`, false)
                                DisableControlAction(0, `INPUT_VEH_CAR_ATTACK`, false)
                                DisableControlAction(0, `INPUT_VEH_BOAT_ATTACK`, false)
                                DisableControlAction(0, `INPUT_VEH_DRAFT_ATTACK`, false)
                                DisableControlAction(0, `INPUT_VEH_ATTACK`, false)
                            else
                                local degradation = _GetWeaponDegradation(weaponObject)

                                if degradation > Config.MalfunctionMinDegradation then
                                    if IsPedShooting(playerPed) then
                                        local malfunctionChance = (degradation * 100) * Config.MalfunctionChanceMultiplier

                                        if math.random(1, 100) < malfunctionChance then
                                            Citizen.InvokeNative(0x5230D3F6EE56CFE6, playerPed, 0)
                                            SetWeaponIsJammed(weaponObject, true)

                                            TriggerEvent('redm_weapon_maintenance:forceSaveWeaponProps', weaponHash)

                                            printd('Weapon %s got jammed:\ndegradation: %s\nmalfunctionChance: %s', _GetWeaponName(weaponHash), degradation, malfunctionChance)
                                        end
                                    end
                                end

                                if Config.MalfunctionEnablePermanentJamming then
                                    local permDegradation = _GetWeaponPermanentDegradation(weaponObject)

                                    if permDegradation >= Config.MalfunctionPermJamMinPermDegradation then
                                        Citizen.InvokeNative(0x5230D3F6EE56CFE6, playerPed, 0)
                                        SetWeaponIsJammed(weaponObject, true)

                                        TriggerEvent('redm_weapon_maintenance:forceSaveWeaponProps', weaponHash)

                                        printd('Weapon %s got jammed by permanent degradation:\nPermDegradation: %s\ndegradation: %s', _GetWeaponName(weaponHash), permDegradation, degradation)
                                    end
                                end
                            end
                        end
                    end
                else
                    Citizen.Wait(250)
                end

                Citizen.Wait(0)
            end
        end)
    end

    GetWeaponIsJammed = function(weaponObject)
        local playerPed = PlayerPedId()

        for weaponHash in pairs(CurrentWeapons) do
            local weaponObj = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

            if DoesEntityExist(weaponObj) and (weaponObj == weaponObject) then
                if CurrentWeaponsCustom[weaponHash] then
                    return CurrentWeaponsCustom[weaponHash].isJammed
                end
            end
        end

        return false
    end

    SetWeaponIsJammed = function(weaponObject, isJammed)
        local playerPed = PlayerPedId()

        for weaponHash in pairs(CurrentWeapons) do
            local weaponObj = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

            if DoesEntityExist(weaponObj) and (weaponObj == weaponObject) then
                if CurrentWeaponsCustom[weaponHash] then
                    CurrentWeaponsCustom[weaponHash].isJammed = isJammed
                end
            end
        end
    end

    if Config.EnablePermanentDegradation then
        printd('Permanent degradation system enabled.')

        Citizen.CreateThread(function ()
            local lastReminderTimestamp = 0

            while true do
                local playerPed = PlayerPedId()
                local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed, true, 0, false)

                if hasWeapon and _IsWeaponAGun(weaponHash) then
                    local weaponMeta = CurrentWeapons[weaponHash]

                    if weaponMeta then
                        local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                        if DoesEntityExist(weaponObject) then
                            local degradation = _GetWeaponDegradation(weaponObject)

                            if degradation > Config.PermDegMinDegradation then
                                if IsPedShooting(playerPed) then
                                    local lastPermDegradation = (weaponMeta.permDegradation or 0.0) + 0.0
                                    local newPermDegradation = Round(lastPermDegradation + (degradation * (Config.PermDegMultiplier / 1000)), 6)

                                    if Config.PermDegReminderEnabled and (degradation > Config.PermDegReminderMinDegradation) then
                                        if (GetGameTimer() - lastReminderTimestamp) > Config.PermDegReminderMinInterval then
                                            exports[GetCurrentResourceName()]:UiFeedPostHelpText(Config.PermDegReminderNotification, Config.PermDegReminderDuration)

                                            lastReminderTimestamp = GetGameTimer()
                                        end
                                    end

                                    if newPermDegradation >= 1.0 then
                                        _SetWeaponPermanentDegradation(weaponObject, 1.0)

                                        TriggerEvent('redm_weapon_maintenance:forceSaveWeaponProps', weaponHash)
                                        TriggerServerEvent('redm_weapon_maintenance:weaponBroke', weaponHash, weaponMeta)
                                        TriggerEvent('redm_weapon_maintenance:weaponBroke', weaponHash, weaponMeta)

                                        printd('Weapon %s reached 1.0 value of permanent degradation.', _GetWeaponName(weaponHash))
                                    else
                                        _SetWeaponPermanentDegradation(weaponObject, newPermDegradation)
                                    end
                                end
                            end
                        end
                    end
                else
                    Citizen.Wait(250)
                end

                Citizen.Wait(0)
            end
        end)

        _GetWeaponPermanentDegradation = function(weaponObject)
            local playerPed = PlayerPedId()

            for weaponHash in pairs(CurrentWeapons) do
                local weaponObj = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                if DoesEntityExist(weaponObj) and (weaponObj == weaponObject) then
                    if CurrentWeaponsCustom[weaponHash] then
                        return CurrentWeaponsCustom[weaponHash].permDegradation
                    end
                end
            end

            return 0.0
        end

        _SetWeaponPermanentDegradation = function(weaponObject, value)
            local playerPed = PlayerPedId()

            for weaponHash in pairs(CurrentWeapons) do
                local weaponObj = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                if DoesEntityExist(weaponObj) and (weaponObj == weaponObject) then
                    if CurrentWeaponsCustom[weaponHash] then
                        CurrentWeaponsCustom[weaponHash].permDegradation = value
                    end
                end
            end
        end

        printd('Patched _GetWeaponPermanentDegradation().')
    end
elseif Config.UseIntegration == 'vorp' then
    local CurrentWeapons = {}
    local LastWeaponHash = nil
    local LastWeaponProps = nil

    Citizen.CreateThread(function ()
        local lastSyncTime = GetGameTimer()

        while true do
            local playerPed = PlayerPedId()
            local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed, true, 0, false)

            if LastWeaponHash and LastWeaponHash ~= weaponHash then
                local weaponData = CurrentWeapons[LastWeaponHash]

                if weaponData then
                    weaponData.permDegradation = LastWeaponProps.permDegradation
                    weaponData.degradation = LastWeaponProps.degradation
                    weaponData.damage = LastWeaponProps.damage
                    weaponData.dirt = LastWeaponProps.dirt
                    weaponData.soot = LastWeaponProps.soot
                    weaponData.isJammed = LastWeaponProps.isJammed

                    TriggerServerEvent('redm_weapon_maintenance:vorp:updateWeaponProps', _GetWeaponName(LastWeaponHash), weaponData.id, LastWeaponProps)

                    printd('[VORP] Saved weapon props %s:\nnewPermDegradation: %s\nnewDegradation: %s\nnewDamage: %s\nnewDirt: %s\nnewSoot: %s\nnewIsJammed: %s', _GetWeaponName(LastWeaponHash),
                        LastWeaponProps.permDegradation, LastWeaponProps.degradation, LastWeaponProps.damage, LastWeaponProps.dirt, LastWeaponProps.soot, LastWeaponProps.isJammed)
                end

                lastSyncTime = GetGameTimer()
                LastWeaponHash, LastWeaponProps = nil, nil
            end

            if hasWeapon and GetValidStateNameHashForWeapon(weaponHash) then
                local weaponData = CurrentWeapons[weaponHash]

                if weaponData then
                    local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                    if DoesEntityExist(weaponObject) then
                        local newPermDegradation = Round(_GetWeaponPermanentDegradation(weaponObject), 6)
                        local newDegradation = Round(_GetWeaponDegradation(weaponObject), 6)
                        local newDamage = Round(_GetWeaponDamage(weaponObject), 6)
                        local newDirt = Round(_GetWeaponDirt(weaponObject), 6)
                        local newSoot = Round(_GetWeaponSoot(weaponObject), 6)

                        if (weaponData.permDegradation ~= newPermDegradation) or (weaponData.degradation ~= newDegradation) or (weaponData.damage ~= newDamage) or (weaponData.dirt ~= newDirt) or (weaponData.soot ~= newSoot) then
                            LastWeaponHash = weaponHash
                            LastWeaponProps = {
                                permDegradation = newPermDegradation,
                                degradation = newDegradation,
                                damage = newDamage,
                                dirt = newDirt,
                                soot = newSoot,
                                isJammed = weaponData.isJammed
                            }

                            if GetGameTimer()-lastSyncTime > Config.StatsSyncInterval then
                                lastSyncTime = GetGameTimer()
                                weaponData.permDegradation = newPermDegradation
                                weaponData.degradation = newDegradation
                                weaponData.damage = newDamage
                                weaponData.dirt = newDirt
                                weaponData.soot = newSoot

                                TriggerServerEvent('redm_weapon_maintenance:vorp:updateWeaponProps', _GetWeaponName(weaponHash), weaponData.id, {
                                    permDegradation = newPermDegradation,
                                    degradation = newDegradation,
                                    damage = newDamage,
                                    dirt = newDirt,
                                    soot = newSoot,
                                    isJammed = weaponData.isJammed
                                })

                                printd('[VORP][BG] Saved weapon props %s:\nnewPermDegradation: %s\nnewDegradation: %s\nnewDamage: %s\nnewDirt: %s\nnewSoot: %s\nnewIsJammed: %s', _GetWeaponName(weaponHash), newPermDegradation, newDegradation, newDamage, newDirt, newSoot, weaponData.isJammed)
                            end
                        end
                    end
                end
            end

            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function ()
        while true do
            local playerPed = PlayerPedId()
            local _, currWeaponHash = GetCurrentPedWeapon(playerPed, true, 0, false)
            local weaponsToUpdate = {}

            for attachPoint=0, 29 do
                local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed, true, attachPoint, false)

                if hasWeapon and currWeaponHash ~= weaponHash and GetValidStateNameHashForWeapon(weaponHash) then
                    local weaponData = CurrentWeapons[weaponHash]

                    if weaponData then
                        local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                        if DoesEntityExist(weaponObject) then
                            local newPermDegradation = Round(_GetWeaponPermanentDegradation(weaponObject), 6)
                            local newDegradation = Round(_GetWeaponDegradation(weaponObject), 6)
                            local newDamage = Round(_GetWeaponDamage(weaponObject), 6)
                            local newDirt = Round(_GetWeaponDirt(weaponObject), 6)
                            local newSoot = Round(_GetWeaponSoot(weaponObject), 6)

                            if (weaponData.permDegradation ~= newPermDegradation) or (weaponData.degradation ~= newDegradation) or (weaponData.damage ~= newDamage) or (weaponData.dirt ~= newDirt) or (weaponData.soot ~= newSoot) then
                                weaponData.permDegradation = newPermDegradation
                                weaponData.degradation = newDegradation
                                weaponData.damage = newDamage
                                weaponData.dirt = newDirt
                                weaponData.soot = newSoot

                                table.insert(weaponsToUpdate, {
                                    id = weaponData.id,
                                    name = _GetWeaponName(weaponHash),

                                    permDegradation = newPermDegradation,
                                    degradation = newDegradation,
                                    damage = newDamage,
                                    dirt = newDirt,
                                    soot = newSoot,
                                    isJammed = weaponData.isJammed
                                })
                            end
                        end
                    end
                end
            end

            if #weaponsToUpdate > 0 then
                TriggerServerEvent('redm_weapon_maintenance:vorp:updateMultiWeaponProps', weaponsToUpdate)
            end

            Citizen.Wait(Config.StatsSyncInterval)
        end
    end)

    RegisterNetEvent('redm_weapon_maintenance:vorp:useWeapon', function(weaponId, weaponHash, weaponProps)
        Citizen.Wait(500)

        local playerPed = PlayerPedId()
        weaponHash = tonumber(weaponHash)

        if IsWeaponValid(weaponHash) then
            if HasPedGotWeapon(playerPed, weaponHash) then
                if GetValidStateNameHashForWeapon(weaponHash) then
                    local permDegradation = (weaponProps.permDegradation or 0.0) + 0.0
                    local degradation = (weaponProps.degradation or 0.0) + 0.0
                    if Config.EnablePermanentDegradation and (degradation < permDegradation) then
                        degradation = permDegradation

                        printw('[VORP] Weapon %s degradation is lower than permanent degradation value, synced with permanent degradation (%s) value.', _GetWeaponName(weaponHash), permDegradation)
                    end

                    local damage = (weaponProps.damage or 0.0) + 0.0
                    local dirt = (weaponProps.dirt or 0.0) + 0.0
                    local soot = (weaponProps.soot or 0.0) + 0.0

                    CurrentWeapons[weaponHash] = {
                        id = weaponId,
                        permDegradation = permDegradation,
                        degradation = degradation,
                        damage = damage,
                        dirt = dirt,
                        soot = soot,
                        isJammed = weaponProps.isJammed
                    }

                    local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)
                    local timestamp = GetGameTimer()
                    while not DoesEntityExist(weaponObject) do
                        if GetGameTimer()-timestamp > Config.PropsLoadTimeout then
                            return printe('[VORP] Failed to load weapon props (%s).', weaponHash)
                        end

                        weaponObject = GetObjectIndexOfPedWeapon(PlayerPedId(), weaponHash)

                        Citizen.Wait(100)
                    end

                    ApplyWeaponObjectProps(weaponObject, degradation, damage, dirt, soot)

                    printd('[VORP] Applied props to weapon %s:\npermDegradation: %s\ndegradation: %s\ndamage: %s\ndirt: %s\nsoot: %s\nisJammed: %s', _GetWeaponName(weaponHash), permDegradation, degradation, damage, dirt, soot, weaponProps.isJammed)
                end
            end
        end
    end)

    AddEventHandler('redm_weapon_maintenance:forceSaveWeaponProps', function (weaponHash, isCleaned)
        local weaponData = CurrentWeapons[weaponHash]

        if weaponData then
            local weaponObject = GetObjectIndexOfPedWeapon(PlayerPedId(), weaponHash)

            if DoesEntityExist(weaponObject) then
                local newPermDegradation = Round(_GetWeaponPermanentDegradation(weaponObject), 6)
                local newDegradation = Round(_GetWeaponDegradation(weaponObject), 6)
                local newDamage = Round(_GetWeaponDamage(weaponObject), 6)
                local newDirt = Round(_GetWeaponDirt(weaponObject), 6)
                local newSoot = Round(_GetWeaponSoot(weaponObject), 6)
                local newIsJammed = weaponData.isJammed

                if newIsJammed and isCleaned then
                    if Config.MalfunctionEnablePermanentJamming then
                        if not (newPermDegradation >= Config.MalfunctionPermJamMinPermDegradation) then
                            newIsJammed = false

                            printd('[VORP] Unjammed weapon %s.', _GetWeaponName(weaponHash))
                        end
                    else
                        newIsJammed = false

                        printd('[VORP] Unjammed weapon %s.', _GetWeaponName(weaponHash))
                    end
                end

                if (weaponData.permDegradation ~= newPermDegradation) or (weaponData.degradation ~= newDegradation) or (weaponData.damage ~= newDamage) or (weaponData.dirt ~= newDirt) or (weaponData.soot ~= newSoot) or (weaponData.isJammed ~= newIsJammed) then
                    weaponData.permDegradation = newPermDegradation
                    weaponData.degradation = newDegradation
                    weaponData.damage = newDamage
                    weaponData.dirt = newDirt
                    weaponData.soot = newSoot
                    weaponData.isJammed = newIsJammed

                    if LastWeaponHash == weaponHash then
                        LastWeaponProps = {
                            permDegradation = newPermDegradation,
                            degradation = newDegradation,
                            damage = newDamage,
                            dirt = newDirt,
                            soot = newSoot,
                            isJammed = newIsJammed
                        }
                    end

                    TriggerServerEvent('redm_weapon_maintenance:vorp:updateWeaponProps', _GetWeaponName(weaponHash), weaponData.id, {
                        permDegradation = newPermDegradation,
                        degradation = newDegradation,
                        damage = newDamage,
                        dirt = newDirt,
                        soot = newSoot,
                        isJammed = newIsJammed
                    })

                    printd('[VORP] Force saved weapon props %s:\nnewPermDegradation: %s\nnewDegradation: %s\nnewDamage: %s\nnewDirt: %s\nnewSoot: %s\nnewIsJammed: %s', _GetWeaponName(weaponHash), newPermDegradation, newDegradation, newDamage, newDirt, newSoot, newIsJammed)
                end
            end
        end
    end)

    if Config.EnableGunOilCheck then
        local GunOilId, GunOilCount = nil, 0

        RegisterNetEvent('redm_weapon_maintenance:vorp:updateGunOil', function (hasGunOil)
            if HasGunOil ~= hasGunOil then
                HasGunOil = hasGunOil

                N_0xcb9401f918cb0f75(PlayerPedId(), 'GENERIC_WEAPON_CLEAN_PROMPT_AVAILABLE', HasGunOil, -1)

                printd('[VORP] redm_weapon_maintenance:vorp:updateGunOil event recieved:\nhasGunOil: %s', HasGunOil)
            end
        end)

        RegisterNetEvent('vorpInventory:giveInventory', function(inventory)
            inventory = json.decode(inventory)

            if inventory then
                for _, data in ipairs(inventory) do
                    if data.item == Config.GunOilItemName then
                        GunOilId, GunOilCount = data.id, data.amount
                        HasGunOil = (data.amount > 0)

                        break
                    end
                end

                if HasGunOil then
                    printd('[VORP] vorpInventory:giveInventory event recieved:\ngunOilId: %s\ngunOilCount: %s\nhasGunOil: %s', GunOilId, GunOilCount, HasGunOil)
                end
            end
        end)

        RegisterNetEvent('vorpCoreClient:addItem', function (item)
            if item.name == Config.GunOilItemName then
                if item.id ~= GunOilId then
                    GunOilId = item.id

                    printd('[VORP] vorpCoreClient:addItem event recieved, new gunOil item id: %s', item.id)
                end

                GunOilCount = item.count
                HasGunOil = (item.count > 0)

                printd('[VORP] vorpCoreClient:addItem event recieved, new gunOil count: %s', item.count)
            end
        end)

        RegisterNetEvent('vorpInventory:receiveItem', function(name, id, amount)
            if name == Config.GunOilItemName then
                if id ~= GunOilId then
                    GunOilId = id

                    printd('[VORP] vorpInventory:receiveItem event recieved, new gunOil item id: %s', id)
                end

                GunOilCount = GunOilCount + amount
                HasGunOil = (GunOilCount > 0)

                printd('[VORP] vorpInventory:receiveItem event recieved, new gunOil count: %s', GunOilCount)
            end
        end)

        RegisterNetEvent('vorpCoreClient:subItem', function (id, newCount)
            if not GunOilId then
                return
            end

            if id == GunOilId then
                GunOilCount = newCount
                HasGunOil = (newCount > 0)

                printd('[VORP] vorpCoreClient:subItem event recieved, new gunOil count: %s', newCount)
            end
        end)

        RegisterNetEvent('vorpInventory:removeItem', function(name, id, count)
            if not GunOilId then
                return
            end

            if id == GunOilId then
                GunOilCount = GunOilCount - count
                if GunOilCount < 0 then
                    GunOilCount = 0
                end

                HasGunOil = (GunOilCount > 0)

                printd('[VORP] vorpInventory:removeItem event recieved, new gunOil count: %s', GunOilCount)
            end
        end)

        RegisterNetEvent('redm_weapon_maintenance:vorp:dropItem', function(id, count)
            if not GunOilId then
                return
            end

            if id == GunOilId then
                GunOilCount = GunOilCount - count
                if GunOilCount < 0 then
                    GunOilCount = 0
                end

                HasGunOil = (GunOilCount > 0)

                printd('[VORP] redm_weapon_maintenance:vorp:dropItem event recieved, new gunOil count: %s', GunOilCount)
            end
        end)
    end

    if Config.EnableWeaponMalfunctions then
        printd('Malfunctions system enabled.')

        if Config.MalfunctionEnableJammedSound then
            while not (RequestScriptAudioBank('Ledger') == 1) do
                Citizen.Wait(0)
            end

            printd('Malfunctions sound effect loaded.')

            AddEventHandler('onResourceStop', function (rsc)
                if GetCurrentResourceName() == rsc then
                    ReleaseNamedScriptAudioBank('Ledger')
                end
            end)
        end

        Citizen.CreateThread(function ()
            while true do
                local playerPed = PlayerPedId()
                local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed, true, 0, false)

                if hasWeapon and _IsWeaponAGun(weaponHash) then
                    local weaponData = CurrentWeapons[weaponHash]

                    if weaponData then
                        if weaponData.isJammed then
                            if IsDisabledControlJustPressed(0, `INPUT_ATTACK`) then
                                if Config.MalfunctionNotificationEnabled then
                                    if Config.MalfunctionEnablePermanentJamming then
                                        local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                                        if DoesEntityExist(weaponObject) and (_GetWeaponPermanentDegradation(weaponObject) >= Config.MalfunctionPermJamMinPermDegradation) then
                                            exports[GetCurrentResourceName()]:UiFeedPostHelpText(Config.MalfunctionPermJamNotification, Config.MalfunctionNotificationDuration)
                                        else
                                            exports[GetCurrentResourceName()]:UiFeedPostHelpText(Config.MalfunctionNotification, Config.MalfunctionNotificationDuration)
                                        end
                                    else
                                        exports[GetCurrentResourceName()]:UiFeedPostHelpText(Config.MalfunctionNotification, Config.MalfunctionNotificationDuration)
                                    end
                                end

                                if Config.MalfunctionEnableJammedSound then
                                    PlaySoundFrontend('UNAFFORDABLE', 'Ledger_Sounds', true, 0)
                                end
                            end

                            DisablePlayerFiring(PlayerId(), true)
                            DisableControlAction(0, `INPUT_ATTACK`, false)
                            DisableControlAction(0, `INPUT_HORSE_ATTACK`, false)
                            DisableControlAction(0, `INPUT_VEH_PASSENGER_ATTACK`, false)
                            DisableControlAction(0, `INPUT_VEH_CAR_ATTACK`, false)
                            DisableControlAction(0, `INPUT_VEH_BOAT_ATTACK`, false)
                            DisableControlAction(0, `INPUT_VEH_DRAFT_ATTACK`, false)
                            DisableControlAction(0, `INPUT_VEH_ATTACK`, false)
                        else
                            local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                            if DoesEntityExist(weaponObject) then
                                local degradation = _GetWeaponDegradation(weaponObject)

                                if degradation > Config.MalfunctionMinDegradation then
                                    if IsPedShooting(playerPed) then
                                        local malfunctionChance = (degradation * 100) * Config.MalfunctionChanceMultiplier

                                        if math.random(1, 100) < malfunctionChance then
                                            Citizen.InvokeNative(0x5230D3F6EE56CFE6, playerPed, 0)
                                            weaponData.isJammed = true

                                            TriggerEvent('redm_weapon_maintenance:forceSaveWeaponProps', weaponHash)

                                            printd('Weapon %s got jammed:\ndegradation: %s\nmalfunctionChance: %s', _GetWeaponName(weaponHash), degradation, malfunctionChance)
                                        end
                                    end
                                end

                                if Config.MalfunctionEnablePermanentJamming then
                                    local permDegradation = _GetWeaponPermanentDegradation(weaponObject)

                                    if permDegradation >= Config.MalfunctionPermJamMinPermDegradation then
                                        Citizen.InvokeNative(0x5230D3F6EE56CFE6, playerPed, 0)
                                        weaponData.isJammed = true

                                        TriggerEvent('redm_weapon_maintenance:forceSaveWeaponProps', weaponHash)

                                        printd('Weapon %s got jammed by permanent degradation:\ndegradation: %s\nmalfunctionChance: %s', _GetWeaponName(weaponHash), degradation, malfunctionChance)
                                    end
                                end
                            end
                        end
                    end
                else
                    Citizen.Wait(250)
                end

                Citizen.Wait(0)
            end
        end)
    end

    if Config.EnablePermanentDegradation then
        printd('Permanent degradation system enabled.')

        Citizen.CreateThread(function ()
            local lastReminderTimestamp = 0

            while true do
                local playerPed = PlayerPedId()
                local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed, true, 0, false)

                if hasWeapon and _IsWeaponAGun(weaponHash) then
                    local weaponData = CurrentWeapons[weaponHash]

                    if weaponData then
                        local weaponObject = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                        if DoesEntityExist(weaponObject) then
                            local degradation = _GetWeaponDegradation(weaponObject)

                            if degradation > Config.PermDegMinDegradation then
                                if IsPedShooting(playerPed) then
                                    local newPermDegradation = Round(weaponData.permDegradation + (degradation * (Config.PermDegMultiplier / 1000)), 6)

                                    if Config.PermDegReminderEnabled and (degradation > Config.PermDegReminderMinDegradation) then
                                        if (GetGameTimer() - lastReminderTimestamp) > Config.PermDegReminderMinInterval then
                                            exports[GetCurrentResourceName()]:UiFeedPostHelpText(Config.PermDegReminderNotification, Config.PermDegReminderDuration)

                                            lastReminderTimestamp = GetGameTimer()
                                        end
                                    end

                                    if newPermDegradation >= 1.0 then
                                        weaponData.permDegradation = 1.0

                                        TriggerEvent('redm_weapon_maintenance:forceSaveWeaponProps', weaponHash)
                                        TriggerServerEvent('redm_weapon_maintenance:weaponBroke', weaponHash, weaponData)
                                        TriggerEvent('redm_weapon_maintenance:weaponBroke', weaponHash, weaponData)

                                        printd('Weapon %s reached 1.0 of permanent degradation.', _GetWeaponName(weaponHash))
                                    else
                                        weaponData.permDegradation = newPermDegradation
                                    end
                                end
                            end
                        end
                    end
                else
                    Citizen.Wait(250)
                end

                Citizen.Wait(0)
            end
        end)

        _GetWeaponPermanentDegradation = function(weaponObject)
            local playerPed = PlayerPedId()

            for weaponHash, weaponData in pairs(CurrentWeapons) do
                local weaponObj = GetObjectIndexOfPedWeapon(playerPed, weaponHash)

                if DoesEntityExist(weaponObj) and (weaponObj == weaponObject) then
                    return weaponData.permDegradation
                end
            end

            return 0.0
        end

        printd('Patched _GetWeaponPermanentDegradation().')
    end
end