--TriggerEvent('syn:exp', Horse , Number to increase horse exp)       
local oncooldown = false 

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
        if oncooldown then
            Wait(300000)
            oncooldown = false 
        end
    end
end)

RegisterNetEvent("syn_horseitems:useitem")
AddEventHandler("syn_horseitems:useitem", function(item)
    local info = Config.horsefood[item]
    local Ped = PlayerPedId()
    local onhorse = IsPedOnMount(Ped)
    local horse
    local lasthorse = Citizen.InvokeNative(0x4C8B59171957BCF7, Ped)
    local pCoords = GetEntityCoords(Ped)
    local cCoords = GetEntityCoords(lasthorse)
    local dist = GetDistanceBetweenCoords(pCoords, cCoords)

    if onhorse then
        horse = GetMount(Ped)
    elseif dist < 2.0 then
        horse = lasthorse
    end
    if info.typeof == "food" then 
        TaskAnimalInteraction(Ped, horse, -224471938, GetHashKey("s_horsnack_haycube01x"), 0)
    elseif info.typeof == "brush" then 
        TaskAnimalInteraction(Ped, horse, 554992710, GetHashKey("P_BRUSHHORSE02X"), 0)
        Wait(1000)
        Citizen.InvokeNative(0x6585D955A68452A5, horse) 
        Citizen.InvokeNative(0xB5485E4907B53019, horse) 
    elseif info.typeof == "stim" then 
        TaskAnimalInteraction(Ped, horse, -1355254781, GetHashKey("p_cs_syringe01x"), 0)
    end
    Citizen.Wait(3500)
    local valueHealth = Citizen.InvokeNative(0x36731AC041289BB1, horse, 0)
    local valueStamina = Citizen.InvokeNative(0x36731AC041289BB1, horse, 1)
    if not tonumber(valueHealth) then valueHealth = 0 end
    if not tonumber(valueStamina) then valueStamina = 0 end
    Citizen.InvokeNative(0xD4EE21B7CC7FD350, true) 
    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)    
    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, valueHealth + info.healthadd)
    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, valueStamina + info.staminaadd)
    if info.buffhealth ~= 0.0 then 
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, horse, 0, info.buffhealth)
    end
    if info.buffstamina ~= 0.0 then 
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, horse, 1, info.buffstamina)
    end
    if not oncooldown then 
        oncooldown = true 
        TriggerEvent('syn:exp', horse, info.expadd)
    end
end)