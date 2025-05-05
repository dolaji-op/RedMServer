
local prompts = GetRandomIntInRange(0, 0xffffff)
local prompts2 = GetRandomIntInRange(0, 0xffffff)
local prompts3 = GetRandomIntInRange(0, 0xffffff)
local pumpwater
local wagonwater
local fert
local water2plant
local fillwagon
local harvest
local trim
local allfarms = {}
local renderedplants = {}
local resp
local holdingcan = false 
local bucketprop
local onholdbucket = false
local clientwaterwagons = {}
local itemSet2  = CreateItemset(true)
local volumeArea = Citizen.InvokeNative(0xB3FB80A32BAE3065, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0) 
local closewagon
local blips = {}
local charid
local removeplant
local refresh = false
local render = {}
local ready
TriggerEvent("menuapi:getData",function(call)
    MenuData = call
end)
--[[ RegisterCommand("testan", function(source, args, rawCommand)
    
end, false) ]]

-- delete all rendered plants on script stop
AddEventHandler("onResourceStop",function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for k,v in pairs(renderedplants) do 
            SetEntityAsMissionEntity(v.plant)
            DeleteObject(v.plant)
        end
        DeleteObject(bucketprop)
        if IsItemsetValid(itemSet2) then
            Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet2)
        end
        for k,v in pairs(blips) do 
            RemoveBlip(v.blip)
        end
    end
end)

-- pull plant information from all players
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.requestupdatetime*60000)
        TriggerServerEvent("rm_farming:requestinfo")
    end
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(x)
    charid = x 
    TriggerServerEvent("rm_farming:requestinfo")
    ready = nil 
    while ready == nil do 
        Wait(100)
    end
    for k,v in pairs(allfarms) do 
        if k == charid then 
            for x,y in pairs(v) do 
                for g,h in pairs(y) do 
                    local blip = N_0x554d9d53f696d002(1664425300, h.coords.x, h.coords.y, h.coords.z)
                    SetBlipSprite(blip, Config.blip, 1)
                    SetBlipScale(blip, 0.1)
                    Citizen.InvokeNative(0x9CB1A1623062F402, blip, h.type)
                    table.insert(blips, {blip=blip,id = h.render})
                end
            end
        end
    end
end)

 -- request the farming information from the server side 
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    TriggerServerEvent("rm_farming:requestinfo")
    
    local str = language.fillwagon
	fillwagon = PromptRegisterBegin()
	PromptSetControlAction(fillwagon, Config.keys["G"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(fillwagon, str)
	PromptSetEnabled(fillwagon, 1)
	PromptSetStandardMode(fillwagon,1)
	PromptSetGroup(fillwagon, prompts3)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,fillwagon,true)
	PromptRegisterEnd(fillwagon)

    local str = language.wagonwater
	wagonwater = PromptRegisterBegin()
	PromptSetControlAction(wagonwater, Config.keys["ENTER"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(wagonwater, str)
	PromptSetEnabled(wagonwater, 1)
	PromptSetStandardMode(wagonwater,1)
	PromptSetGroup(wagonwater, prompts3)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,wagonwater,true)
	PromptRegisterEnd(wagonwater)

    local str = language.pump
	pumpwater = PromptRegisterBegin()
	PromptSetControlAction(pumpwater, Config.keys["G"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(pumpwater, str)
	PromptSetEnabled(pumpwater, 1)
    PromptSetVisible(pumpwater, 1)
	PromptSetStandardMode(pumpwater,1)
	PromptSetGroup(pumpwater, prompts2)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,pumpwater,true)
	PromptRegisterEnd(pumpwater)

    local str = language.trim
	trim = PromptRegisterBegin()
	PromptSetControlAction(trim, Config.keys["SHIFT"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(trim, str)
	PromptSetEnabled(trim, 1)
	PromptSetStandardMode(trim,1)
	PromptSetGroup(trim, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,trim,true)
	PromptRegisterEnd(trim)


    local str = language.fert
	fert = PromptRegisterBegin()
	PromptSetControlAction(fert, Config.keys["E"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(fert, str)
	PromptSetEnabled(fert, 1)
	PromptSetStandardMode(fert,1)
	PromptSetGroup(fert, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,fert,true)
	PromptRegisterEnd(fert)

    local str = language.water2plant
	water2plant = PromptRegisterBegin()
	PromptSetControlAction(water2plant, Config.keys["G"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(water2plant, str)
	PromptSetEnabled(water2plant, 1)
	PromptSetStandardMode(water2plant,1)
	PromptSetGroup(water2plant, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,water2plant,true)
	PromptRegisterEnd(water2plant)

    local str = language.harvest
	harvest = PromptRegisterBegin()
	PromptSetControlAction(harvest, Config.keys["B"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(harvest, str)
	PromptSetEnabled(harvest, 1)
	PromptSetStandardMode(harvest,1)
	PromptSetGroup(harvest, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,harvest,true)
	PromptRegisterEnd(harvest)

    local str = language.remove
	removeplant = PromptRegisterBegin()
	PromptSetControlAction(removeplant, Config.keys["BACKSPACE"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(removeplant, str)
	PromptSetEnabled(removeplant, 1)
    PromptSetVisible(removeplant, 1)
	PromptSetStandardMode(removeplant,1)
	PromptSetGroup(removeplant, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,removeplant,true)
	PromptRegisterEnd(removeplant)
    
   

end)

-- recieve all farm information
RegisterNetEvent('rm_farming:recinfo')
AddEventHandler('rm_farming:recinfo', function(x,y)
    allfarms = x 
    ready = y 
end)



--rec wagon info
RegisterNetEvent('rm_farming:recinfowagons')
AddEventHandler('rm_farming:recinfowagons', function(x)
    clientwaterwagons = x 
end)


-- on watercan item use
RegisterNetEvent('rm_farming:wateringcan')
AddEventHandler('rm_farming:wateringcan', function()
    TriggerEvent("vorp_inventory:CloseInv")
    bucket()
end)

-- command to remove bucket from hand 
RegisterCommand(Config.removebucketcommand, function(source, args, rawCommand)
    DeleteObject(bucketprop)
    ClearPedTasks(PlayerPedId())  
    holdingcan = false 
end, false) 

-- check if player in water and fill up bucket
RegisterNetEvent('rm_farming:usebucketinwater')
AddEventHandler('rm_farming:usebucketinwater', function()
    TriggerEvent("vorp_inventory:CloseInv")
    local coords = GetEntityCoords(PlayerPedId())
	local Water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)
	if Water == 231313522 or 2005774838 or -1287619521 or -196675805 or -1308233316 or 1755369577 or -2040708515 or -557290573 or -247856387 or 370072007 or -1504425495 or -1369817450 or -1356490953 or -1781130443 or -1300497193 or -1276586360 or -1410384421 or 650214731 or 592454541 or -804804953 or 1245451421 or -218679770 or -1817904483 or -811730579 or -1229593481 or -105598602 then
		if IsEntityInWater(PlayerPedId()) then
            DeleteObject(bucketprop)
	        FreezeEntityPosition(PlayerPedId(), true)
            anim("amb_work@world_human_bucket_fill@female_a@stand_exit_withprop","exit_front", -1, 1)
            Citizen.Wait(100)
            bucketprop = CreateObject("p_bucket03x", coords.x, coords.y, coords.z, true, true, false)
            AttachEntityToEntity(bucketprop, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger43"), 0.01, 0.0, 0.0, 174.0, -32.0, 187.0, false, false, true, false, 0, true, false, false)
            Citizen.Wait(1300)
            DeleteObject(bucketprop)
            ClearPedTasks(PlayerPedId())  
            FreezeEntityPosition(PlayerPedId(), false)   
            TriggerServerEvent("rm_farming:watefromriver")  
        else
            TriggerServerEvent("rm_farming:termbucket")  
        end
    else
        TriggerServerEvent("rm_farming:termbucket")  
    end
end)
-- function for attaching watercan 
function bucket()
    DeleteObject(bucketprop)
	FreezeEntityPosition(PlayerPedId(), true)
	local pos = GetEntityCoords(PlayerPedId(), true)
	ClearPedTasks(PlayerPedId())
	holdingcan = true
	Citizen.Wait(50)
	anim("amb_camp@world_camp_jack_es@bucket_pickup@empty@male_a@base","base", -1, 25)
	bucketprop = CreateObject("p_bucketcampmil01x", pos.x, pos.y, pos.z, true, true, false)
	AttachEntityToEntity(bucketprop, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), -0.03, 0.02, -0.02, 0.0, 0.0, -94.0, false, false, true, false, 0, true, false, false)
	FreezeEntityPosition(PlayerPedId(), false)
end
--animation for trimming 
function trimanim()
    anim("mech_pickup@plant@gold_currant", "exit", 2500, 1)
end
-- harvest animation
function harvestanim()
    anim("mech_pickup@plant@berries", "base", 2500, 1)
end

function removeplantanim()
    FreezeEntityPosition(PlayerPedId(), true)
    anim("amb_camp@world_camp_fire@stomp@male_a@wip_base", "wip_base", -1, 1)
    Citizen.Wait(10000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
end
-- fert animation
function fertanim()
    anim("mech_pickup@plant@orchid_plant", "base", 2500, 1)
end

-- planting animation
function plantanim()
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), true)
    local coords = GetEntityCoords(PlayerPedId())
    anim("amb_work@world_human_farmer_rake@male_a@idle_a","idle_a", -1, 1)
    Citizen.Wait(700)
    local rake = CreateObject("p_rake02x", coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(rake, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.0, 0.0, 0.19, 0.0, 0.0, 0.0, false, false, true, false, 0, true, false, false)
    Citizen.Wait(15000)
    DeleteEntity(rake)
    ClearPedTasks(PlayerPedId())
    anim("amb_work@world_human_feed_chickens@female_a@base","base", -1, 1)
    Citizen.Wait(700)
    local bag = CreateObject("p_feedbag01bx", coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(bag, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_L_Hand"), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 0, true, false, false)
    Citizen.Wait(15000)
    DeleteEntity(bag)
    ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
end
-- animation for watering plants
function wateranim()
	FreezeEntityPosition(PlayerPedId(), true)
	ClearPedTasks(PlayerPedId())
    DeleteObject(bucketprop)
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_PLAYER_CHORES_BUCKET_POUR_HIGH"), 7000, true, false, false, false)
    Wait(6000)
	holdingcan = false
	Citizen.Wait(50)
	FreezeEntityPosition(PlayerPedId(), false)
    Citizen.InvokeNative(0xFCCC886EDE3C63EC,PlayerPedId(),false,true)
end

--trigger animations if successful at tasks
RegisterNetEvent('rm_farming:animationtrigger')
AddEventHandler('rm_farming:animationtrigger', function(type)
    if type == "trim" then 
        trimanim()
    elseif type == "fert" then 
        fertanim()
    end
end)

-- checks if client is in a town and declines the servers request to register plant if the player is. 
RegisterNetEvent('rm_farming:createblip')
AddEventHandler('rm_farming:createblip', function(type,coords,idnumber)
    local blip = N_0x554d9d53f696d002(1664425300, coords.x, coords.y, coords.z)
    SetBlipSprite(blip, Config.blip, 1)
    SetBlipScale(blip, 0.1)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, type)
    table.insert(blips, {blip=blip,id = idnumber})
end)

RegisterNetEvent('rm_farming:usedseed')
AddEventHandler('rm_farming:usedseed', function(type)
    TriggerEvent("vorp_inventory:CloseInv")
    local coords = GetEntityCoords(PlayerPedId())
    local town = Citizen.InvokeNative(0x43AD8FC02B429D33, coords, 1)
    if not istownbanned(town) then
        if not tooclose(allfarms,coords) then
            if not IsEntityInWater(PlayerPedId()) then  
                if Config.minigame then
                    local diff = Config.seeds[type].difficulty
                    local minigame = exports["syn_minigame"]:taskBar(diff,7)
                    if minigame == 100 then 
                        plantanim()
                        TriggerServerEvent("rm_farming:approvefarming",type,coords)
                    else
                        if Config.ragdollonfail then 
                            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                        end
                        TriggerEvent("vorp:TipBottom", language.failedd, 6000)
                    end
                else
                    plantanim()
                    TriggerServerEvent("rm_farming:approvefarming",type,coords)
                end
            else
                TriggerEvent("vorp:TipBottom", language.inwater, 6000)
            end
        else
            TriggerEvent("vorp:TipBottom", language.closeplant, 6000) 
        end
    else
        TriggerEvent("vorp:TipBottom", language.closetown, 6000)
    end
    TriggerServerEvent("rm_farming:cleartofarm")
end)

-- remove plant 
RegisterNetEvent('rm_farming:removeplant')
AddEventHandler('rm_farming:removeplant', function(k,x,g)
    render[allfarms[k][x][g].render] = nil 
    for b,n in pairs(renderedplants) do 
        if allfarms[k][x][g].render == n.id then 
            SetEntityAsMissionEntity(n.plant)
            DeleteObject(n.plant)
            for f,q in pairs(blips) do 
                if allfarms[k][x][g].render == q.id then 
                    RemoveBlip(q.blip)
                    table.remove(blips,f)
                end
            end
        end
    end
end)
-- find and render plants close to the player 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playercoords = GetEntityCoords(PlayerPedId())
        local plant = {}
        for k,v in pairs(allfarms) do 
            for x,y in pairs(v) do 
                for g,h in pairs(y) do 
                    local dist = GetDistanceBetweenCoords(playercoords,h.coords.x,h.coords.y,h.coords.z, true)
                    if Config.render > dist then 
                        renderobj(h.render,h.type,h.coords)
                    else
                        derenderobj(h.render)
                    end 
                end
            end
        end
        for k,v in pairs(renderedplants) do 
            if not plantexist(v, allfarms) then 
                render[v.id] = nil 
                SetEntityAsMissionEntity(v.plant)
                DeleteObject(v.plant)
                table.remove(renderedplants,k)
            end
        end

        
        Citizen.Wait(500)
    end
end)
-- logic to render objects if not rendered
function renderobj(id,typex,coords)
    if render[id] == nil then 
        render[id] = false 
    end
    if render[id] == false then
        render[id] = true 
        local prop = Config.seeds[typex].prop
        local offset = Config.seeds[typex].offset
        local plant = CreateObject(GetHashKey(prop), coords.x, coords.y, coords.z , false, false, true)
        SetEntityAsMissionEntity(plant)
        PlaceObjectOnGroundProperly(plant)
        if offset ~= 0.0 then -- some plants are still floating even after ground placement
            local coords2 = GetEntityCoords(plant) 
            SetEntityCoords(plant,coords2.x, coords2.y, coords2.z - offset)
        end
        FreezeEntityPosition( plant, true)
        table.insert(renderedplants, {id =id, plant = plant,type = typex})
    end
end
-- logic to delete objects if rendered
function derenderobj(id)
    if render[id] == nil then 
        render[id] = false 
    end
    if render[id] == true then 
        render[id] = false
        for b,q in pairs(renderedplants) do 
            if id == q.id then 
                SetEntityAsMissionEntity(q.plant)
                DeleteObject(q.plant)
                table.remove(renderedplants,b)
            end
        end
    end
end

-- recieve fert feedback 
RegisterNetEvent('rm_farming:recst')
AddEventHandler('rm_farming:recst', function()
    resp = "done"
end)
-- pump bucket animation
RegisterNetEvent('rm_farming:pumpbucket')
AddEventHandler('rm_farming:pumpbucket', function(waterpumpcoords)
    local DataStruct = DataView.ArrayBuffer(256 * 4) 
    local is_data_exists = Citizen.InvokeNative(0x345EC3B7EBDE1CB5, GetEntityCoords(PlayerPedId()), 3.0, DataStruct:Buffer(), 10)
    for i = 1, 10, 1 do
		local scenario = DataStruct:GetInt32(8 * i)
		if scenario ~= 0 then
			if GetHashKey("PROP_HUMAN_PUMP_WATER") == Citizen.InvokeNative(0xA92450B5AE687AAF,scenario) or GetHashKey("PROP_HUMAN_PUMP_WATER_BUCKET") == Citizen.InvokeNative(0xA92450B5AE687AAF,scenario) then 
                ClearPedTasksImmediately(PlayerPedId())
                Citizen.InvokeNative(0xFCCC886EDE3C63EC,PlayerPedId(),false,true)
                TaskUseScenarioPoint(PlayerPedId(), scenario ,  "" , -1.0, true, false, 0, false, -1.0, true)
                Wait(10000)
			end
		end
	end
    ClearPedTasks(PlayerPedId())
    onholdbucket = false
end)


RegisterNetEvent('rm_farming:clearonholdbucket')
AddEventHandler('rm_farming:clearonholdbucket', function()
    onholdbucket = false
end)

-- close to plant / close to pump loop/buttons/logic
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playercoords = GetEntityCoords(PlayerPedId())
        local plant = {}
        local sleep = true 
        local waterpump = GetClosestObjectOfType(playercoords, 1.0, -40350080, false, false, false)
        local waterpumpcoords = GetEntityCoords(waterpump)
        local pumpdist = GetDistanceBetweenCoords(playercoords,waterpumpcoords, true)
        if 1.5 > pumpdist and not onholdbucket then 
            sleep = false
            local label  = CreateVarString(10, 'LITERAL_STRING', language.waterpump)
            PromptSetActiveGroupThisFrame(prompts2, label)
            if Citizen.InvokeNative(0xC92AC953F0A982AE,pumpwater) then
                TriggerServerEvent("rm_farming:checkbucket",waterpumpcoords)
                onholdbucket = true
            end
        end
        for k,v in pairs(allfarms) do 
            for x,y in pairs(v) do 
                for g,h in pairs(y) do 
                    local dist = GetDistanceBetweenCoords(playercoords,h.coords.x,h.coords.y,h.coords.z, true)
                    if 3 > dist then 
                        sleep = false
                        local timetowater = Config.seeds[h.type].timetowater 
                        local totaltimer = Config.seeds[h.type].totaltime 
                        local difficulty = Config.seeds[h.type].difficulty 
                        local string
                        if h.timer > 0 then
                            if h.watered and h.fert and h.trem then
                                string = "~u~"..tostring(h.timer)
                            elseif h.watered then
                                string = "~pa~"..tostring(h.timer)
                            elseif not h.watered and timetowater == h.timer then 
                                string = "~e~"..tostring(h.timer)
                            else
                                string = tostring(h.timer)
                            end
                        else
                            string = "~t6~"..language.grown
                        end
                        DrawText3D(h.coords.x, h.coords.y,h.coords.z, string)
                        if 1 > dist then 
                            if not Config.onlyowner or charid == k then 
                                local label  = CreateVarString(10, 'LITERAL_STRING', h.type)
                                PromptSetActiveGroupThisFrame(prompts, label)
                                if Citizen.InvokeNative(0xC92AC953F0A982AE,removeplant) then
                                    removeplantanim()
                                    TriggerServerEvent("rm_farming:interact","remove",h.type,h.render) 
                                    resp = nil 
                                    while resp == nil do 
                                        Wait(1000)
                                    end
                                end
                                if h.timer == 0 then 
                                    if Config.drawtext then 
                                        drawtext(language.pressgtoharvest, 0.15, 0.8, 0.3, 0.3, true, 255, 255, 255, 255, true, 10000)
                                        if IsDisabledControlJustReleased(0,Config.keys["G"]) then
                                            if Config.minigame then 
                                                local diff = h.difficulty
                                                local minigame = exports["syn_minigame"]:taskBar(diff,7)
                                                if minigame == 100 then
                                                    harvestanim()
                                                    TriggerServerEvent("rm_farming:interact","harvest",h.type,h.render) 
                                                    resp = nil 
                                                    while resp == nil do 
                                                        Wait(1000)
                                                    end
                                                else
                                                    if Config.ragdollonfail then 
                                                        SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                                                    end
                                                    TriggerServerEvent("rm_farming:interact","dmg",h.type,h.render) 
                                                    Wait(1000)
                                                end
                                            else
                                                harvestanim()
                                                TriggerServerEvent("rm_farming:interact","harvest",h.type,h.render) 
                                                resp = nil 
                                                while resp == nil do 
                                                    Wait(1000)
                                                end
                                            end
                                        end
                                    else
                                        PromptSetVisible(harvest, 1)
                                        if Citizen.InvokeNative(0xC92AC953F0A982AE,harvest) then
                                            if Config.minigame then 
                                                local diff = h.difficulty
                                                local minigame = exports["syn_minigame"]:taskBar(diff,7)
                                                if minigame == 100 then
                                                    harvestanim()
                                                    TriggerServerEvent("rm_farming:interact","harvest",h.type,h.render) 
                                                    resp = nil 
                                                    while resp == nil do 
                                                        Wait(1000)
                                                    end
                                                else
                                                    if Config.ragdollonfail then 
                                                        SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                                                    end
                                                    TriggerServerEvent("rm_farming:interact","dmg",h.type,h.render) 
                                                    Wait(1000)
                                                end
                                            else
                                                harvestanim()
                                                TriggerServerEvent("rm_farming:interact","harvest",h.type,h.render) 
                                                resp = nil 
                                                while resp == nil do 
                                                    Wait(1000)
                                                end
                                            end
                                        end
                                    end
                                else
                                    PromptSetVisible(harvest, 0)
                                end
                                if not h.watered and not h.trem and not holdingcan then 
                                    PromptSetVisible(trim, 1)
                                    if Citizen.InvokeNative(0xC92AC953F0A982AE,trim) then
                                        if Config.minigame then 
                                            local diff = h.difficulty
                                            local minigame = exports["syn_minigame"]:taskBar(diff,7)
                                            if minigame == 100 then
                                                TriggerServerEvent("rm_farming:interact","trim",h.type,h.render) 
                                                resp = nil 
                                                while resp == nil do 
                                                    Wait(1000)
                                                end
                                            else
                                                if Config.ragdollonfail then 
                                                    SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                                                end
                                                TriggerServerEvent("rm_farming:interact","dmg",h.type,h.render) 
                                                Wait(1000)
                                            end
                                        else
                                            TriggerServerEvent("rm_farming:interact","trim",h.type,h.render) 
                                            resp = nil 
                                            while resp == nil do 
                                                Wait(1000)
                                            end
                                        end
                                    end
                                else
                                    PromptSetVisible(trim, 0)
                                end
                                if not h.fert and not h.watered and timetowater ~= h.timer and not holdingcan then 
                                    PromptSetVisible(fert, 1)
                                    if Citizen.InvokeNative(0xC92AC953F0A982AE,fert) then
                                        if Config.minigame then
                                            local diff = h.difficulty
                                            local minigame = exports["syn_minigame"]:taskBar(diff,7)
                                            if minigame == 100 then
                                                TriggerServerEvent("rm_farming:interact","fert",h.type,h.render) 
                                                resp = nil 
                                                while resp == nil do 
                                                    Wait(1000)
                                                end
                                            else
                                                if Config.ragdollonfail then 
                                                    SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                                                end
                                                TriggerServerEvent("rm_farming:interact","dmg",h.type,h.render) 
                                                Wait(1000)
                                            end
                                        else
                                            TriggerServerEvent("rm_farming:interact","fert",h.type,h.render) 
                                            resp = nil 
                                            while resp == nil do 
                                                Wait(1000)
                                            end
                                        end
                                    end
                                else
                                    PromptSetVisible(fert, 0)
                                end
                                if holdingcan and not h.watered and timetowater ==  h.timer then
                                    PromptSetVisible(water2plant, 1)
                                    if Citizen.InvokeNative(0xC92AC953F0A982AE,water2plant) then
                                        if Config.minigame then
                                            local diff = h.difficulty
                                            local minigame = exports["syn_minigame"]:taskBar(diff,7)
                                            if minigame == 100 then
                                                wateranim()
                                                TriggerServerEvent("rm_farming:interact","water",h.type,h.render) 
                                                resp = nil 
                                                while resp == nil do 
                                                    Wait(1000)
                                                end
                                            else
                                                DeleteObject(bucketprop)
                                                holdingcan = false
                                                if Config.ragdollonfail then 
                                                    SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                                                end
                                                TriggerServerEvent("rm_farming:interact","dmg",h.type,h.render) 
                                                Wait(1000)
                                            end
                                        else
                                            wateranim()
                                            TriggerServerEvent("rm_farming:interact","water",h.type,h.render) 
                                            resp = nil 
                                            while resp == nil do 
                                                Wait(1000)
                                            end
                                        end
                                    end
                                else
                                    PromptSetVisible(water2plant, 0)
                                end
                            end
                        end
                    end 
                end
            end
        end
        if sleep then 
            Citizen.Wait(500)
        end
    end
end)





-- find closest vehicle
function GetClosestveh(coords, range)
    local vehiclesToDraw = {}
    if volumeArea then 
        Citizen.InvokeNative(0x541B8576615C33DE, volumeArea, coords.x, coords.y, coords.z) 
        local itemsFound = Citizen.InvokeNative(0x886171A12F400B89, volumeArea, itemSet2, 2) 
        if itemsFound then
            n = 0
            while n < itemsFound do
                vehiclesToDraw[(GetIndexedItemInItemset(n, itemSet2))] = true
                n = n + 1
            end
        end
        Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet2)
        for k,v in pairs(vehiclesToDraw) do 
            Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet2)
            return k
        end
        
    end
    if IsItemsetValid(itemSet2) then
        Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet2)
    end
end

-- loop to find closest wagon 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local coords = GetEntityCoords(PlayerPedId())
        closewagon = GetClosestveh(coords,10)
        if closewagon == nil then 
            Wait(1000)
        end
    end
end)

-- filling up and using wagon to get water
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if closewagon ~= nil then 
            local model = GetEntityModel(closewagon)
            for k,v in pairs(Config.waterwagons) do 
                if GetHashKey(k) == model then 
                    local network = NetworkGetNetworkIdFromEntity(closewagon)
                    local exists,space = containswagon(clientwaterwagons, network)
                    local coords = GetEntityCoords(closewagon)
                    local Water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)
                    if not IsPedInVehicle(PlayerPedId(),closewagon) then 
                        if exists then 
                            DrawText3D(coords.x, coords.y,coords.z,"~pa~"..tostring(clientwaterwagons[network]))
                            local label  = CreateVarString(10, 'LITERAL_STRING', language.Wagon)
                            PromptSetActiveGroupThisFrame(prompts3, label)
                            PromptSetVisible(wagonwater, 1)
                            if Citizen.InvokeNative(0xC92AC953F0A982AE,wagonwater) then
                                ClearPedTasks(PlayerPedId())
                                anim("amb_work@prop_human_pump_water@female_b@idle_a", "idle_a", -1, 1)
                                Citizen.Wait(5000)
                                ClearPedTasks(PlayerPedId())
                                bucket()
                                TriggerServerEvent("rm_farming:waterfromwagon",network)
                                resp = nil 
                                while resp == nil do 
                                    Wait(1000)
                                end
                            end
                        else
                            PromptSetVisible(wagonwater, 0)
                        end
                        if ( holdingcan or (Water == 231313522 or 2005774838 or -1287619521 or -196675805 or -1308233316 or 1755369577 or -2040708515 or -557290573 or -247856387 or 370072007 or -1504425495 or -1369817450 or -1356490953 or -1781130443 or -1300497193 or -1276586360 or -1410384421 or 650214731 or 592454541 or -804804953 or 1245451421 or -218679770 or -1817904483 or -811730579 or -1229593481 or -105598602) and IsEntityInWater(closewagon)) then
                            local label  = CreateVarString(10, 'LITERAL_STRING', language.Wagon)
                            PromptSetActiveGroupThisFrame(prompts3, label)
                            if exists then 
                                if clientwaterwagons[network] == nil then
                                    PromptSetVisible(fillwagon, 1)
                                elseif Config.waterwagons[k] > clientwaterwagons[network] then 
                                    PromptSetVisible(fillwagon, 1)
                                else
                                    PromptSetVisible(fillwagon, 0)
                                end
                            else
                                PromptSetVisible(fillwagon, 1)
                            end
                            if Citizen.InvokeNative(0xC92AC953F0A982AE,fillwagon) then
                                if holdingcan then 
                                    holdingcan = false
                                    DeleteObject(bucketprop)
                                end
                                ClearPedTasks(PlayerPedId())
                                anim("amb_work@prop_human_pump_water@female_b@idle_a", "idle_a", -1, 1)
                                Citizen.Wait(5000)
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent("rm_farming:sendwagonfillrequest",k,network,space)
                                resp = nil 
                                while resp == nil do 
                                    Wait(1000)
                                end
                            end
                        elseif not IsEntityInWater(closewagon) and not holdingcan then 
                            PromptSetVisible(fillwagon, 0)
                        end
                    else
                        Wait(1000)
                    end
                end
            end
        else
            Wait(1000)
        end
    end
end)