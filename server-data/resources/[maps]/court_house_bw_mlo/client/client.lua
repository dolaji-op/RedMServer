local prompts = GetRandomIntInRange(0, 0xffffff)
local prompts2 = GetRandomIntInRange(0, 0xffffff)
enterCourt = nil
leaveCourt = nil

RegisterNetEvent('Courthouse:client:enter', function()
    DoScreenFadeOut(1000)
    Wait(2000)

    SetEntityCoords(PlayerPedId(), -799.0004, -1209.282, -21.82159-0.9)
    SetEntityHeading(PlayerPedId(), 6.4066724)
    DoScreenFadeIn(1000)
end)


RegisterNetEvent('Courthouse:client:leave', function()
    DoScreenFadeOut(1000)
    Wait(2000)

    SetEntityCoords(PlayerPedId(), -798.5643, -1203.359, 44.193489-0.9)
    SetEntityHeading(PlayerPedId(), 188.2662)
    DoScreenFadeIn(1000)
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Enter In Courthouse"
    enterCourt = PromptRegisterBegin()
    PromptSetControlAction(enterCourt, 0xCEFD9220)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(enterCourt, str)
    PromptSetEnabled(enterCourt, 1)
    PromptSetVisible(enterCourt, 1)
    PromptSetStandardMode(enterCourt, 1)
    PromptSetHoldMode(enterCourt, 1)
    PromptSetGroup(enterCourt, prompts)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, enterCourt, true)
    PromptRegisterEnd(enterCourt)
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Leave Courthouse"
    leaveCourt = PromptRegisterBegin()
    PromptSetControlAction(leaveCourt, 0xCEFD9220)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(leaveCourt, str)
    PromptSetEnabled(leaveCourt, 1)
    PromptSetVisible(leaveCourt, 1)
    PromptSetStandardMode(leaveCourt, 1)
    PromptSetHoldMode(leaveCourt, 1)
    PromptSetGroup(leaveCourt, prompts2)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, leaveCourt, true)
    PromptRegisterEnd(leaveCourt)
end)


local enterPos = vector3(-798.5643,-1203.359, 43.193489)
local leavePos vector3(-799.0004,-1209.282, -22.82159)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local enterDist = Vdist(pos.x , pos.y, pos.z , -798.5643,-1203.359, 43.193489)
        local leaveDist = Vdist(pos.x, pos.y, pos.z , -799.0004,-1209.282, -22.82159)
        if enterDist < 2.0 then
            local label = CreateVarString(10, 'LITERAL_STRING', "Courthouse")
            PromptSetActiveGroupThisFrame(prompts, label)

            if Citizen.InvokeNative(0xC92AC953F0A982AE, enterCourt) then
                TriggerEvent("Courthouse:client:enter")
                Citizen.Wait(1000)
            end
        end

        if leaveDist < 2.0 then
            local label = CreateVarString(10, 'LITERAL_STRING', "Courthouse")
            PromptSetActiveGroupThisFrame(prompts2, label)

            if Citizen.InvokeNative(0xC92AC953F0A982AE, leaveCourt) then
                TriggerEvent("Courthouse:client:leave")
                Citizen.Wait(1000)
            end
        end
    end
end)

CreateThread(function()
    local blip = Citizen.InvokeNative(0x554D9D53F696D002, GetHashKey("BLIP_STYLE_CREATOR_DEFAULT"),vector3(-798.3491, -1204.753, 44.193405))
    Citizen.InvokeNative(0x662D364ABF16DE2F, blip, GetHashKey('BLIP_MODIFIER_SELECTED_UP_SCALE'))
    SetBlipSprite(blip, -1596758107, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Courthouse")
end)