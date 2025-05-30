local VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)
-- Prompts
local OpenPorts
local ClosePorts
local PortPrompt1 = GetRandomIntInRange(0, 0xffffff)
local PortPrompt2 = GetRandomIntInRange(0, 0xffffff)
-- Jobs
local PlayerJob
local JobName
local JobGrade
-- Menu
local InMenu = false
MenuData = {}

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

-- Start Portals
Citizen.CreateThread(function()
    PortOpen()
    PortClosed()

    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local sleep = true
        local dead = IsEntityDead(player)
        local hour = GetClockHours()

        if InMenu == false and not dead then
            for portId, portConfig in pairs(Config.ports) do
                if portConfig.portHours then
                    -- Using Port Hours - Port Closed
                    if hour >= portConfig.portClose or hour < portConfig.portOpen then
                        if Config.blipAllowedClosed then
                            if not Config.ports[portId].BlipHandle and portConfig.blipAllowed then
                                AddBlip(portId)
                            end
                        else
                            if Config.ports[portId].BlipHandle then
                                RemoveBlip(Config.ports[portId].BlipHandle)
                                Config.ports[portId].BlipHandle = nil
                            end
                        end
                        if Config.ports[portId].BlipHandle then
                            Citizen.InvokeNative(0x662D364ABF16DE2F, Config.ports[portId].BlipHandle, joaat(portConfig.blipColorClosed)) -- BlipAddModifier
                        end
                        if portConfig.NPC then
                            DeleteEntity(portConfig.NPC)
                            DeletePed(portConfig.NPC)
                            SetEntityAsNoLongerNeeded(portConfig.NPC)
                            portConfig.NPC = nil
                        end
                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsPort = vector3(portConfig.npc.x, portConfig.npc.y, portConfig.npc.z)
                        local distPort = #(coordsDist - coordsPort)

                        if (distPort <= portConfig.distPort) then
                            sleep = false
                            local portClosed = CreateVarString(10, 'LITERAL_STRING', portConfig.portName .. _U("closed"))
                            PromptSetActiveGroupThisFrame(PortPrompt2, portClosed)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, ClosePorts) then -- UiPromptHasStandardModeCompleted
                                Wait(100)
                                VORPcore.NotifyRightTip(portConfig.portName .. _U("hours") .. portConfig.portOpen .. _U("to") .. portConfig.portClose .. _U("hundred"), 4000)
                            end
                        end
                    elseif hour >= portConfig.portOpen then
                        -- Using Port Hours - Port Open
                        if not Config.ports[portId].BlipHandle and portConfig.blipAllowed then
                            AddBlip(portId)
                        end
                        if not portConfig.NPC and portConfig.npcAllowed then
                            SpawnNPC(portId)
                        end
                        if not next(portConfig.allowedJobs) then
                            if Config.ports[portId].BlipHandle then
                                Citizen.InvokeNative(0x662D364ABF16DE2F, Config.ports[portId].BlipHandle, joaat(portConfig.blipColorOpen)) -- BlipAddModifier
                            end
                            local coordsDist = vector3(coords.x, coords.y, coords.z)
                            local coordsPort = vector3(portConfig.npc.x, portConfig.npc.y, portConfig.npc.z)
                            local distPort = #(coordsDist - coordsPort)

                            if (distPort <= portConfig.distPort) then
                                sleep = false
                                local portOpened = CreateVarString(10, 'LITERAL_STRING', portConfig.promptName)
                                PromptSetActiveGroupThisFrame(PortPrompt1, portOpened)

                                if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenPorts) then -- UiPromptHasStandardModeCompleted
                                    PortalMenu(portId)
                                    DisplayRadar(false)
                                    TaskStandStill(player, -1)
                                end
                            end
                        else
                            -- Using Port Hours - Port Open - Job Locked
                            if Config.ports[portId].BlipHandle then
                                Citizen.InvokeNative(0x662D364ABF16DE2F, Config.ports[portId].BlipHandle, joaat(portConfig.blipColorJob)) -- BlipAddModifier
                            end
                            local coordsDist = vector3(coords.x, coords.y, coords.z)
                            local coordsPort = vector3(portConfig.npc.x, portConfig.npc.y, portConfig.npc.z)
                            local distPort = #(coordsDist - coordsPort)

                            if (distPort <= portConfig.distPort) then
                                sleep = false
                                local portOpened = CreateVarString(10, 'LITERAL_STRING', portConfig.promptName)
                                PromptSetActiveGroupThisFrame(PortPrompt1, portOpened)

                                if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenPorts) then -- UiPromptHasStandardModeCompleted
                                    TriggerServerEvent("oss_portals:getPlayerJob")
                                    Wait(200)
                                    if PlayerJob then
                                        if CheckJob(portConfig.allowedJobs, PlayerJob) then
                                            if tonumber(portConfig.jobGrade) <= tonumber(JobGrade) then
                                                PortalMenu(portId)
                                                DisplayRadar(false)
                                                TaskStandStill(player, -1)
                                            else
                                                VORPcore.NotifyRightTip(_U("needJob") .. JobName .. " " .. portConfig.jobGrade, 5000)
                                            end
                                        else
                                            VORPcore.NotifyRightTip(_U("needJob") .. JobName .. " " .. portConfig.jobGrade, 5000)
                                        end
                                    else
                                        VORPcore.NotifyRightTip(_U("needJob") .. JobName .. " " .. portConfig.jobGrade, 5000)
                                    end
                                end
                            end
                        end
                    end
                else
                    -- Not Using Port Hours - Port Always Open
                    if not Config.ports[portId].BlipHandle and portConfig.blipAllowed then
                        AddBlip(portId)
                    end
                    if not portConfig.NPC and portConfig.npcAllowed then
                        SpawnNPC(portId)
                    end
                    if not next(portConfig.allowedJobs) then
                        if Config.ports[portId].BlipHandle then
                            Citizen.InvokeNative(0x662D364ABF16DE2F, Config.ports[portId].BlipHandle, joaat(portConfig.blipColorOpen)) -- BlipAddModifier
                        end
                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsPort = vector3(portConfig.npc.x, portConfig.npc.y, portConfig.npc.z)
                        local distPort = #(coordsDist - coordsPort)

                        if (distPort <= portConfig.distPort) then
                            sleep = false
                            local portOpened = CreateVarString(10, 'LITERAL_STRING', portConfig.promptName)
                            PromptSetActiveGroupThisFrame(PortPrompt1, portOpened)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenPorts) then -- UiPromptHasStandardModeCompleted
                                PortalMenu(portId)
                                DisplayRadar(false)
                                TaskStandStill(player, -1)
                            end
                        end
                    else
                        -- Not Using Port Hours - Port Always Open - Job Locked
                        if Config.ports[portId].BlipHandle then
                            Citizen.InvokeNative(0x662D364ABF16DE2F, Config.ports[portId].BlipHandle, joaat(portConfig.blipColorJob)) -- BlipAddModifier
                        end
                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsPort = vector3(portConfig.npc.x, portConfig.npc.y, portConfig.npc.z)
                        local distPort = #(coordsDist - coordsPort)

                        if (distPort <= portConfig.distPort) then
                            sleep = false
                            local portOpened = CreateVarString(10, 'LITERAL_STRING', portConfig.promptName)
                            PromptSetActiveGroupThisFrame(PortPrompt1, portOpened)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenPorts) then -- UiPromptHasStandardModeCompleted
                                TriggerServerEvent("oss_portals:getPlayerJob")
                                Wait(200)
                                if PlayerJob then
                                    if CheckJob(portConfig.allowedJobs, PlayerJob) then
                                        if tonumber(portConfig.jobGrade) <= tonumber(JobGrade) then
                                            PortalMenu(portId)
                                            DisplayRadar(false)
                                            TaskStandStill(player, -1)
                                        else
                                            VORPcore.NotifyRightTip(_U("needJob") .. JobName .. " " .. portConfig.jobGrade, 5000)
                                        end
                                    else
                                        VORPcore.NotifyRightTip(_U("needJob") .. JobName .. " " .. portConfig.jobGrade, 5000)
                                    end
                                else
                                    VORPcore.NotifyRightTip(_U("needJob") .. JobName .. " " .. portConfig.jobGrade, 5000)
                                end
                            end
                        end
                    end
                end
            end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)

-- Portal Menu to Choose Destination
function PortalMenu(portId)
    MenuData.CloseAll()
    InMenu = true
    local elements = {}

    for outlet, outletConfig in pairs(Config.ports[portId].outlets) do
        elements[#elements + 1] = {
            label = outletConfig.label,
            value = outlet,
            desc = _U("price") .. outletConfig.buyPrice .. " " .. outletConfig.currencyType,
            info = outletConfig,
        }
    end
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
    {
        title = Config.ports[portId].portName,
        subtext = _U("subMenu"),
        align = "top-left",
        elements = elements,
        lastmenu = '',
    },
    function(data, menu)
        if data.current == "backup" then
            _G[data.trigger](portId)
        end
        if data.current.value then
            local outletData = data.current.info
            TriggerServerEvent('oss_portals:BuyPassage', outletData, portId)

            menu.close()
            InMenu = false
            ClearPedTasksImmediately(PlayerPedId())
            DisplayRadar(true)
        end
    end,
    function(data, menu)
        menu.close()
        InMenu = false
        ClearPedTasksImmediately(PlayerPedId())
        DisplayRadar(true)
    end)
end

-- Send Player to Destination
RegisterNetEvent("oss_portals:SendPlayer")
AddEventHandler("oss_portals:SendPlayer", function(location)
    local player = PlayerPedId()
    local destination = location
    local portConfig = Config.ports[destination]
    DoScreenFadeOut(1000)
    Wait(1000)
    Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, _U('traveling') .. portConfig.portName, '', '') -- DisplayLoadingScreens
    Wait(Config.travelTime)
    Citizen.InvokeNative(0x203BEFFDBE12E96A, player, portConfig.player.x, portConfig.player.y, portConfig.player.z, portConfig.player.h) -- SetEntityCoordsAndHeading
    ShutdownLoadingScreen()
    DoScreenFadeIn(1000)
    Wait(1000)
    SetCinematicModeActive(false)
end)

-- Menu Prompts
function PortOpen()
    local str = _U("portPrompt")
    OpenPorts = PromptRegisterBegin()
    PromptSetControlAction(OpenPorts, Config.portKey)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(OpenPorts, str)
    PromptSetEnabled(OpenPorts, 1)
    PromptSetVisible(OpenPorts, 1)
    PromptSetStandardMode(OpenPorts, 1)
    PromptSetGroup(OpenPorts, PortPrompt1)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, OpenPorts, true)
    PromptRegisterEnd(OpenPorts)
end

function PortClosed()
    local str = _U("portPrompt")
    ClosePorts = PromptRegisterBegin()
    PromptSetControlAction(ClosePorts, Config.portKey)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(ClosePorts, str)
    PromptSetEnabled(ClosePorts, 1)
    PromptSetVisible(ClosePorts, 1)
    PromptSetStandardMode(ClosePorts, 1)
    PromptSetGroup(ClosePorts, PortPrompt2)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, ClosePorts, true)
    PromptRegisterEnd(ClosePorts)
end

-- Blips
function AddBlip(portId)
    local portConfig = Config.ports[portId]
    if portConfig.blipAllowed then
        portConfig.BlipHandle = N_0x554d9d53f696d002(1664425300, portConfig.npc.x, portConfig.npc.y, portConfig.npc.z) -- BlipAddForCoords
        SetBlipSprite(portConfig.BlipHandle, portConfig.blipSprite, 1)
        SetBlipScale(portConfig.BlipHandle, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, portConfig.BlipHandle, portConfig.blipName) -- SetBlipNameFromPlayerString
    end
end

-- NPCs
function SpawnNPC(portId)
    local portConfig = Config.ports[portId]
    LoadModel(portConfig.npcModel)
    local npc = CreatePed(portConfig.npcModel, portConfig.npc.x, portConfig.npc.y, portConfig.npc.z, portConfig.npc.h, false, true, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
    SetEntityCanBeDamaged(npc, false)
    SetEntityInvincible(npc, true)
    Wait(500)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    Config.ports[portId].NPC = npc
end

function LoadModel(npcModel)
    local model = joaat(npcModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(100)
    end
end

-- Check if Player has Job
function CheckJob(allowedJob, playerJob)
    for _, jobAllowed in pairs(allowedJob) do
        JobName = jobAllowed
        if JobName == playerJob then
            return true
        end
    end
    return false
end

RegisterNetEvent("oss_portals:sendPlayerJob")
AddEventHandler("oss_portals:sendPlayerJob", function(Job, grade)
    PlayerJob = Job
    JobGrade = grade
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    if InMenu == true then
        ClearPedTasksImmediately(PlayerPedId())
        PromptDelete(OpenPorts)
        PromptDelete(ClosePorts)
        MenuData.CloseAll()
    end

    for _, portConfig in pairs(Config.ports) do
        if portConfig.BlipHandle then
            RemoveBlip(portConfig.BlipHandle)
        end
        if portConfig.NPC then
            DeleteEntity(portConfig.NPC)
            DeletePed(portConfig.NPC)
            SetEntityAsNoLongerNeeded(portConfig.NPC)
        end
    end
end)

