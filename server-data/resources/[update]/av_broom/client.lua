local brooming = false
local broomObject = nil
local broomout = false
local BroomPrompt
local BroomEndPrompt
local BroomGroup = GetRandomIntInRange(0, 0xffffff)

function CreateBroom()
    if broomObject ~= nil then
        --TriggerServerEvent("av_broom:deleteobj_s", ObjToNet(broomObject))
        DeleteObject(broomObject)
        SetEntityAsNoLongerNeeded(broomObject)
        broomObject = nil
    end
    local pedp = PlayerPedId()
    local pc = GetEntityCoords(pedp)
    local broommodel = `p_broom01x`
    RequestModel(broommodel)
    while not HasModelLoaded(broommodel) do
        Wait(10)
    end
    broomObject = CreateObject(broommodel, pc.x,pc.y,pc.z, true, true, true)
    SetModelAsNoLongerNeeded(broommodel)
    if IsPedMale(pedp) then
        AttachEntityToEntity(broomObject, pedp, 311, 0.01, -0.18, 0.84, -10.0, 180.0, 0.0, false, false, true, false, 0, true, false, false)
    else
        AttachEntityToEntity(broomObject, pedp, 371, 0.01, -0.18, 0.84, -10.0, 180.0, 0.0, false, false, true, false, 0, true, false, false)
    end
end

function DeleteBroom()
    if broomObject ~= nil then
        --TriggerServerEvent("av_broom:deleteobj_s", ObjToNet(broomObject))
        DeleteObject(broomObject)
        SetEntityAsNoLongerNeeded(broomObject)
        broomObject = nil
    end
end

function InTown()
    local coordsped = GetEntityCoords(PlayerPedId())
    local town_name = Citizen.InvokeNative(0x43AD8FC02B429D33,coordsped.x,coordsped.y,coordsped.z,1)
    if town_name ~= false then
        for i,v in pairs(Config.Towns) do
            if v == town_name then
                return true
            end
        end
        return false
    end
    return false
end

function Broom()
    if brooming == false then
        local hasw, playerw = GetCurrentPedWeapon(PlayerPedId(), 1)
        if playerw == -1569615261 then
            if InTown() then
                local playerp = PlayerPedId()
                brooming = true
                DeleteBroom()
                local coordsb = GetEntityCoords(playerp)
                local phead = GetEntityHeading(playerp)
                Citizen.Wait(500)
                TaskStartScenarioAtPosition(playerp, `WORLD_HUMAN_BROOM_WORKING`, coordsb.x, coordsb.y,coordsb.z-1, phead, -1, true, true)
                local timer = Config.Options.WorkTimer * 1000
                Citizen.Wait(timer)
                TriggerServerEvent("av_broom:reward")
                ClearPedTasksImmediately(playerp)
                CreateBroom()
                brooming = false
            end
        end
    end
end

function EndBroom()
    if brooming == false then
        if broomObject ~= nil then
            broomout = false
            brooming = false
            --TriggerServerEvent("av_broom:deleteobj_s", ObjToNet(broomObject))
            DeleteObject(broomObject)
            SetEntityAsNoLongerNeeded(broomObject)
            broomObject = nil
            return
        end
        broomout = false
        brooming = false
    end
end

function SetupBroomPrompt()
        local str = Config.Prompts.BroomName
        BroomPrompt = PromptRegisterBegin()
        PromptSetControlAction(BroomPrompt, Config.Prompts.BroomPrompt)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(BroomPrompt, str)
        PromptSetEnabled(BroomPrompt, 1)
        PromptSetVisible(BroomPrompt, 1)
		PromptSetStandardMode(BroomPrompt,1)
		PromptSetGroup(BroomPrompt, BroomGroup)
		Citizen.InvokeNative(0xC5F428EE08FA7F2C,BroomPrompt,true)
		PromptRegisterEnd(BroomPrompt)

        local str = Config.Prompts.StopName
        BroomEndPrompt = PromptRegisterBegin()
        PromptSetControlAction(BroomEndPrompt, Config.Prompts.StopPrompt) 
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(BroomEndPrompt, str)
        PromptSetEnabled(BroomEndPrompt, 1)
        PromptSetVisible(BroomEndPrompt, 1)
		PromptSetStandardMode(BroomEndPrompt,1)
		PromptSetGroup(BroomEndPrompt, BroomGroup)
		Citizen.InvokeNative(0xC5F428EE08FA7F2C,BroomEndPrompt,true)
		PromptRegisterEnd(BroomEndPrompt)
end

Citizen.CreateThread(function() --
    SetupBroomPrompt()
	while true do
		local t = 4
		if broomout == true then
            local label  = CreateVarString(10, 'LITERAL_STRING', Config.Prompts.Title)
            PromptSetActiveGroupThisFrame(BroomGroup, label)
            DisableControlAction(0, 0xAC4BD4F1, true) -- TAB 
            DisableControlAction(0, 0x4CC0E2FE, true) -- B 
            DisableControlAction(0, 0xCEFD9220, true) -- Mount
            if Citizen.InvokeNative(0xC92AC953F0A982AE,BroomPrompt) then
				Broom()
                Citizen.Wait(500)
            end
			if Citizen.InvokeNative(0xC92AC953F0A982AE,BroomEndPrompt) then
                if broomout == true then
                    EndBroom()
                    Citizen.Wait(500)
                end
            end
            if IsPedSwimming(PlayerPedId()) or IsPedClimbing(PlayerPedId()) or IsPedFalling(PlayerPedId()) or IsPedDeadOrDying(PlayerPedId()) then
                EndBroom()
            end
        else
            t = 1000
        end
        Citizen.Wait(t)
    end
end)

RegisterNetEvent('av_broom:start')
AddEventHandler('av_broom:start', function()
    local playerp = PlayerPedId()
    if not  IsPedDeadOrDying(playerp) and broomout == false then
        if GetMount(playerp) == 0 and not IsPedSwimming(playerp) and not IsPedClimbing(playerp) and not IsPedFalling(playerp) then
            broomout = true
            CreateBroom()
        else
            TriggerEvent("Notification:left_broom", Config.Messages.Title, Config.Messages.NoBroom, 'menu_textures', 'stamp_locked_rank', 3000)
        end
    end
end)

RegisterNetEvent("av_broom:deleteobj_c")
AddEventHandler("av_broom:deleteobj_c", function(obj)
    local _obj = NetToObj(obj)
    if DoesEntityExist(_obj) then
        DeleteObject(_obj)
        SetObjectAsNoLongerNeeded(_obj)
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    if broomObject then
        --TriggerServerEvent("av_broom:deleteobj_s", ObjToNet(broomObject))
        DeleteObject(broomObject)
        SetEntityAsNoLongerNeeded(broomObject)
	end
    brooming = false
    broomObject = nil
    broomout = false
end)

--Basic Notification
RegisterNetEvent('Notification:left_broom')
AddEventHandler('Notification:left_broom', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(5)
        end
    end
    if txtr ~= nil then
        exports.av_broom.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.av_broom.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
end)