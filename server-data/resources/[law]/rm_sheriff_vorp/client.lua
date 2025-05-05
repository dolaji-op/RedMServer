-- Locals
local CreatedBlips = {}
local onDuty = false
local MenuActive = false
local paymenttimerstarted = false
local currentlocker = nil
local lockerenabled = false
local inv = {}

-- redemrp_menu_base / works on VORP CORE
MenuData = {}
TriggerEvent('redemrp_menu_base:getData',function(call)
    MenuData = call
end)

-- Create Map Blips
Citizen.CreateThread(function()
    for i, v in pairs(Config.MapBlips) do
        if v.blip_enabled == true then
            CreatedBlips[i]= N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
            SetBlipSprite(CreatedBlips[i], Config.MapBlipsSprites, 1)
            SetBlipScale(CreatedBlips[i], 0.1)
            Citizen.InvokeNative(0x9CB1A1623062F402, CreatedBlips[i], Config.MapBlipsNames)
        end
    end
end)

-- Markers to Open Sheriff Office Menu
Citizen.CreateThread(function()
	local alreadyEnteredZone = false
    while true do
		Citizen.Wait(0)
		local sleep = true
		local inZone = false
		local playercoords = GetEntityCoords(PlayerPedId())
		
		for i, v in pairs(Config.MapBlips) do
			local dist = GetDistanceBetweenCoords(playercoords, v.x, v.y, v.z, true)
			
			if 2.0 > dist then
				sleep = false
				inZone = true
				
				if not MenuActive then
					DrawText3D(v.x, v.y, v.z, Config.PressToOpen)
					
					if IsControlJustReleased(0, Config.KeyToOpenOfficeMenu) then
						MenuActive = true
						TriggerServerEvent("rm_sheriff_vorp:openofficemenu", v.locker_name, v.enable_locker)
					end
				end
			end
		end
		
		if Config.EnableWagons then
			for i, v in pairs(Config.WagonMenuMarkers) do
				local dist2 = GetDistanceBetweenCoords(playercoords, v.x, v.y, v.z, true)
				
				if 2.0 > dist2 then
					sleep = false
					inZone = true
					
					if not MenuActive then
						DrawText3D(v.x, v.y, v.z, Config.PressToOpenWagons)
						
						if IsControlJustReleased(0, Config.KeyToOpenWagonsMenu) then
							MenuActive = true
							TriggerServerEvent("rm_sheriff_vorp:openwagonsmenu", v.xs, v.ys, v.zs, v.zh)
						end
					end
				end
			end
		end
		
		if inZone and not alreadyEnteredZone then
			alreadyEnteredZone = true
		end

		if not inZone and alreadyEnteredZone then
			alreadyEnteredZone = false
			MenuActive = false
			currentlocker = nil
			lockerenabled = false
			MenuData.CloseAll()
		end
	
		if sleep then 
            Citizen.Wait(1000)
        end	
	end
end)

-- 3D Text for Office Menu Marker
function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())
	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(6)
	SetTextColor(255, 255, 255, 215)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	SetTextCentre(1)
	DisplayText(str,_x,_y)
end

-- Sheriff Mobile Menu
RegisterNetEvent('rm_sheriff_vorp:SheriffMobileMenu')
AddEventHandler('rm_sheriff_vorp:SheriffMobileMenu', function()
	SheriffMobileMenu()
end)

function SheriffMobileMenu()
	MenuData.CloseAll()
	
	local elements = {}
	
	if Config.EnableHandcuffsMenu then
		table.insert(elements, { label = Config.SheriffCuff, value = Config.SheriffCuff, desc = Config.SheriffCuffDesc })
	end
	if Config.EnableSearchMenu then
		table.insert(elements, { label = Config.SheriffMobileMenuSearch, value = Config.SheriffMobileMenuSearch, desc = Config.SheriffMobileMenuSearchDesc })
	end
	if Config.PrisonJailPlugin then
		table.insert(elements, { label = Config.JailMenu, value = Config.JailMenu, desc = Config.JailMenu })
	end
	if Config.EnableDestroyVehicleMenu then
		table.insert(elements, { label = Config.RemoveCurrentVehicle, value = Config.RemoveCurrentVehicle, desc = Config.RemoveCurrentVehicleDesc })
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffMobileMenu', {
		title    = Config.MenuDataMobile,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		if(data.current.value == Config.SheriffCuff) then
			TriggerServerEvent('bulgar_handcuffs:rm_sheriff_vorp_use')
		elseif(data.current.value == Config.SheriffMobileMenuSearch) then
			SheriffSearchMainMenu()
		elseif(data.current.value == Config.JailMenu) then
			TriggerEvent('bulgar_prison:open_jail_menu')
		elseif(data.current.value == Config.RemoveCurrentVehicle) then
			local cveh = GetVehiclePedIsIn(PlayerPedId(), false)
			SetEntityAsMissionEntity(cveh, true, true)
			DeleteVehicle(cveh)
		end
	end,
			
	function(data, menu)
		menu.close()
	end) 
end

-- Sheriff Office Menu
RegisterNetEvent('rm_sheriff_vorp:SheriffOfficeMenu')
AddEventHandler('rm_sheriff_vorp:SheriffOfficeMenu', function(locker_name, allowlocker)
	currentlocker = locker_name
	lockerenabled = allowlocker
	SheriffOfficeMenu()
end)

function SheriffOfficeMenu()
	MenuData.CloseAll()
	
	local elements = {}
	
	table.insert(elements, { label = Config.OfficeMenuOnDuty, value = Config.OfficeMenuOnDuty, desc = Config.OfficeMenuOnDutyDesc })
	if Config.EnableArmory then
		table.insert(elements, { label = Config.ArmoryMenu, value = Config.ArmoryMenu, desc = Config.ArmoryMenuDesc })
	end
	if Config.EnableLocker then
		if lockerenabled then
			table.insert(elements, { label = Config.SheriffLocker, value = Config.SheriffLocker, desc = Config.SheriffLockerDesc })
		end
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffOfficeMenu', {
		title    = Config.MenuDataOffice,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		if(data.current.value == Config.OfficeMenuOnDuty) then
			Badges()
		elseif(data.current.value == Config.ArmoryMenu) then
			SheriffArmoryMenu()
		elseif(data.current.value == Config.SheriffLocker) then
			-- REDEM:RP FUNCTION
			MenuData.CloseAll()
		end
	end,
			
	function(data, menu)
		menu.close()
		MenuActive = false
		currentlocker = nil
		lockerenabled = false
	end)
end

-- Sheriff Armory Menu
RegisterNetEvent('rm_sheriff_vorp:SheriffArmoryMenu')
AddEventHandler('rm_sheriff_vorp:SheriffArmoryMenu', function()
	SheriffArmoryMenu()
end)

function SheriffArmoryMenu()
	MenuData.CloseAll()
	
	local elements = {}
	
	if Config.EnableArmoryWeapons then
		table.insert(elements,{label = Config.ArmoryWeaponsName, value = Config.ArmoryWeaponsName, desc = Config.ArmoryWeaponsName})
	end
	if Config.EnableArmoryAmmo then
		table.insert(elements,{label = Config.ArmoryAmmoName, value = Config.ArmoryAmmoName, desc = Config.ArmoryAmmoName})
	end
	if Config.EnableArmoryItems then
		table.insert(elements,{label = Config.ArmoryItemsName, value = Config.ArmoryItemsName, desc = Config.ArmoryItemsName})
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffArmoryMenu', {
		title    = Config.MenuDataArmory,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		if(data.current.value == Config.ArmoryWeaponsName) then
			SheriffArmoryWeaponsMenu()
		elseif(data.current.value == Config.ArmoryAmmoName) then
			SheriffArmoryAmmoMenu()
		elseif(data.current.value == Config.ArmoryItemsName) then
			SheriffArmoryItemsMenu()
		end
	end,
			
	function(data, menu)
		SheriffOfficeMenu()
	end)
end

function SheriffArmoryWeaponsMenu()
	MenuData.CloseAll()
	
	local elements = {}
	
	for i, v in pairs(Config.ArmoryWeapons) do
		table.insert(elements,{label = v.displayname.." <font color=green>$"..v.price.."</font>", value = v.weapon, desc = v.image})
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffArmoryWeaponsMenu', {
		title    = Config.MenuDataArmory,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		for i, v in pairs(Config.ArmoryWeapons) do
			if(data.current.value == v.weapon) then
				TriggerServerEvent('syn_weapons:buyweapon', v.weapon, v.price, v.displayname) -- VORP
			end
		end
	end,
			
	function(data, menu)
		SheriffArmoryMenu()
	end)
end

function SheriffArmoryAmmoMenu()
	MenuData.CloseAll()
	
	local elements = {}
	
	for i, v in pairs(Config.ArmoryAmmo) do
		table.insert(elements,{label = v.displayname.." <font color=green>$"..v.price.."</font>", value = 1, type = "slider", min = 1, max = 10, desc = v.image})
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffArmoryAmmoMenu', {
		title    = Config.MenuDataArmory,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		for i, v in pairs(Config.ArmoryAmmo) do
			if(data.current.desc == v.image) then
				TriggerServerEvent("syn_weapons:buyammo", v.ammo, v.price, data.current.value, v.displayname) -- VORP
			end
		end
	end,
			
	function(data, menu)
		SheriffArmoryMenu()
	end)
end

function SheriffArmoryItemsMenu()
	MenuData.CloseAll()
	
	local elements = {}
	
	for i, v in pairs(Config.ArmoryItems) do
		table.insert(elements,{label = v.displayname.." <font color=green>$"..v.price.."</font>", value = 1, type = "slider", min = 1, max = 10, desc = v.image})
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffArmoryItemsMenu', {
		title    = Config.MenuDataArmory,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		for i, v in pairs(Config.ArmoryItems) do
			if(data.current.desc == v.image) then
				TriggerServerEvent('rm_sheriff_vorp:getitemitem', v.item, v.price, data.current.value)
			end
		end
	end,
			
	function(data, menu)
		SheriffArmoryMenu()
	end)
end

-- Sheriff Wagons Menu
RegisterNetEvent('rm_sheriff_vorp:SheriffWagonsMenu')
AddEventHandler('rm_sheriff_vorp:SheriffWagonsMenu', function(xx, yy, zz, hh)
	SheriffWagonsMenu(xx, yy, zz, hh)
end)

function SheriffWagonsMenu(xx, yy, zz, hh)
	MenuData.CloseAll()
	
	local elements = {}
	
	for i, v in pairs(Config.WagonsList) do
		table.insert(elements,{label = v.displayname, value = v.model, desc = v.model})
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffWagonsMenu', {
		title    = Config.MenuDataWagons,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		for i, v in pairs(Config.WagonsList) do
			if(data.current.value == v.model) then
				spawnwagononcoords(xx, yy, zz, hh, data.current.value)
				MenuData.CloseAll()
			end
		end
	end,
			
	function(data, menu)
		menu.close()
		MenuActive = false
		currentlocker = nil
		lockerenabled = false
	end)
end

-- Spawn Wagon Function
function spawnwagononcoords(xx, yy, zz, hh, vehiculoo)
	Citizen.Wait(0)

	local vehiculo = GetHashKey(vehiculoo)
	RequestModel(vehiculo)

	while not HasModelLoaded(vehiculo) do
		Citizen.Wait(0)
	end

	spawncar = CreateVehicle(vehiculo, xx, yy, zz, hh, true, false)
	SetVehicleOnGroundProperly(spawncar)
	SetModelAsNoLongerNeeded(vehiculo)
end

-- Sheriff Search Main Menu
RegisterNetEvent("rm_sheriff_vorp:smainmenuopen")
AddEventHandler("rm_sheriff_vorp:smainmenuopen", function()
	SheriffSearchMainMenu()
end)

function SheriffSearchMainMenu()
	MenuData.CloseAll()
	
	local elements = {}
	
	table.insert(elements, { label = Config.SearchForMoney, value = Config.SearchForMoney, desc = Config.SearchForMoney })
	table.insert(elements, { label = Config.SearchForItems, value = Config.SearchForItems, desc = Config.SearchForItems })
	table.insert(elements, { label = Config.SearchForWeapons, value = Config.SearchForWeapons, desc = Config.SearchForWeapons })

	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffSearchMainMenu', {
		title    = Config.MenuDataMobile,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		if(data.current.value == Config.SearchForMoney) then
			local closestPlayer, closestDistance = GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				TriggerServerEvent("rm_sheriff_vorp:search_money", GetPlayerServerId(closestPlayer))
			else
				TriggerEvent('vorp:TipRight', Config.SheriffSearchTargetNotFount, 5000)
			end
		elseif(data.current.value == Config.SearchForItems) then
			local closestPlayer, closestDistance = GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				TriggerServerEvent("rm_sheriff_vorp:search_item", GetPlayerServerId(closestPlayer))
			else
				TriggerEvent('vorp:TipRight', Config.SheriffSearchTargetNotFount, 5000)
			end
		elseif(data.current.value == Config.SearchForWeapons) then
			local closestPlayer, closestDistance = GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				TriggerServerEvent("rm_sheriff_vorp:search_weapon", GetPlayerServerId(closestPlayer))
			else
				TriggerEvent('vorp:TipRight', Config.SheriffSearchTargetNotFount, 5000)
			end
		end
	end,
			
	function(data, menu)
		SheriffMobileMenu()
	end) 
end

-- Sheriff Search Money Menu
RegisterNetEvent("rm_sheriff_vorp:inspectPlayerClient")
AddEventHandler("rm_sheriff_vorp:inspectPlayerClient", function(name, inv)
    local _name = name
    local _inv = inv

	SheriffSearchMoneyMenu(_name, _inv)
end)

function SheriffSearchMoneyMenu(smname, sminv)
	MenuData.CloseAll()
	
	local elements = {}
	
	for k,v in pairs(sminv) do
		table.insert(elements, { label = "".. v["Name"] .. " (" .. tostring(v["Quantity"]) .. " $)", value = 'takemoney', desc = "<img src='nui://rm_sheriff_vorp/html/img/money.png'>" })
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffSearchMoneyMenu', {
		title    = Config.MenuDataMobile,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		if(data.current.value == 'takemoney') then
			local closestPlayer, closestDistance = GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				MenuData.CloseAll()
				TriggerEvent("vorpinputs:getInput", Config.TakeMoney, Config.TakeMoneyQuantity, function(cb)
					local qt = tonumber(cb)
					if qt ~= nil then
						TriggerServerEvent("rm_sheriff_vorp:steal_money", GetPlayerServerId(closestPlayer), qt)
					end
				end)
			else
				TriggerEvent('vorp:TipRight', Config.SheriffSearchTargetNotFount, 5000)
			end
		end
	end,
			
	function(data, menu)
		SheriffSearchMainMenu()
	end)
end

-- Sheriff Search Items Menu
RegisterNetEvent("rm_sheriff_vorp:inspectPlayerClient2")
AddEventHandler("rm_sheriff_vorp:inspectPlayerClient2", function(name, inv)
    local _name = name
    local _inv = inv

	SheriffSearchItemsMenu(_name, _inv)
end)

function SheriffSearchItemsMenu(smname, sminv)
	MenuData.CloseAll()
	
	local elements = {}
	
	for k,v in pairs(sminv) do
		table.insert(elements, { label = "".. v["Name"] .. " (x" .. tostring(v["Quantity"]) .. ")", value = "".. v["Name"] .. " (x" .. tostring(v["Quantity"]) .. ")", desc = "<img src='nui://vorp_inventory/html/img/items/"..v["Id"]..".png'>" })
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffSearchItemsMenu', {
		title    = Config.MenuDataMobile,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		for k,v in pairs(sminv) do
			if(data.current.value == "".. v["Name"] .. " (x" .. tostring(v["Quantity"]) .. ")") then
				local closestPlayer, closestDistance = GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 1.0 then
					MenuData.CloseAll()
					TriggerEvent("vorpinputs:getInput", Config.TakeItem, Config.TakeItemQuantity, function(cb)
						local qt = tonumber(cb)
						if qt ~= nil then
							TriggerServerEvent("rm_sheriff_vorp:steal_items", v["Id"], GetPlayerServerId(closestPlayer), qt)
						end
					end)
				else
					TriggerEvent('vorp:TipRight', Config.SheriffSearchTargetNotFount, 5000)
				end
			end
		end
	end,
			
	function(data, menu)
		SheriffSearchMainMenu()
	end)
end

-- Sheriff Search Weapons Menu
RegisterNetEvent("rm_sheriff_vorp:inspectPlayerClient3")
AddEventHandler("rm_sheriff_vorp:inspectPlayerClient3", function(name, inv)
    local _name = name
    local _inv = inv

	SheriffSearchWeaponsMenu(_name, _inv)
end)

function SheriffSearchWeaponsMenu(smname, sminv)
	MenuData.CloseAll()
	
	local elements = {}
	
	for k,v in pairs(sminv) do
		table.insert(elements, { label = "".. v["Name"] .. " (x" .. tostring(v["Quantity"]) .. ")", value = "".. v["Name"] .. " (x" .. tostring(v["Quantity"]) .. ")", desc = "<img src='nui://rm_sheriff_vorp/html/img/"..v["Realname"]..".png'>" })
	end
	
	MenuData.Open('default', GetCurrentResourceName(), 'SheriffSearchWeaponsMenu', {
		title    = Config.MenuDataMobile,
		subtext    = '',
		align    = 'top-right',
		elements = elements,
	},

	function(data, menu)
		for k,v in pairs(sminv) do
			if(data.current.value == "".. v["Name"] .. " (x" .. tostring(v["Quantity"]) .. ")") then
				local closestPlayer, closestDistance = GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 1.0 then
					MenuData.CloseAll()
					TriggerEvent("vorpinputs:getInput", Config.TakeItem, Config.TakeItemQuantity, function(cb)
						local qt = tonumber(cb)
						if qt ~= nil then
							TriggerServerEvent("rm_sheriff_vorp:steal_weapon", v["Id"], GetPlayerServerId(closestPlayer), qt)
						end
					end)
				else
					TriggerEvent('vorp:TipRight', Config.SheriffSearchTargetNotFount, 5000)
				end
			end
		end
	end,
			
	function(data, menu)
		SheriffSearchMainMenu()
	end)
end

-- Sheriff Badges / Duty
function Badges()
	if onDuty == false then 
		onDuty = true
		if Config.DisplayOnDutyHud then
			SendNUIMessage({
				type = "logo",
				display = true
			})
		end
		if IsPedMale(PlayerPedId()) then
			Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), Config.MaleBadge, false, true, true)
		else
			Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), Config.FemaleBadge, false, true, true)
		end
		Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
		Citizen.InvokeNative(0xAAB86462966168CE, PlayerPedId(), 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
		SetPedConfigFlag(PlayerPedId(), 192, true)
		TriggerEvent("rm_sheriff_vorp:not", Config.NotificationTitle, Config.DutyStart, 'generic_textures', 'star', 5000)
	elseif onDuty == true then
		onDuty = false
		if Config.DisplayOnDutyHud then
			SendNUIMessage({
				type = "logo",
				display = false
			})
		end
		Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F7F3587, 0)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
		SetPedConfigFlag(PlayerPedId(), 192, false)
		TriggerEvent("rm_sheriff_vorp:not", Config.NotificationTitle, Config.DutyStop, 'generic_textures', 'star', 5000)
	end
end

-- Payment Timer
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(500)
		if Config.EnablePaymentForSheriff then
			if onDuty == true then
				if not paymenttimerstarted then
					paymenttimerstarted = true
					Citizen.Wait(Config.PaymentTimer)
					if onDuty == true then
						TriggerServerEvent("rm_sheriff_vorp:paysheriff")
					end
					paymenttimerstarted = false
				end
			end
		else
			Citizen.Wait(10000)
		end
    end
end)

-- Armory Notification
RegisterNetEvent('rm_sheriff_vorp:not_payment_armory')
AddEventHandler('rm_sheriff_vorp:not_payment_armory', function(ajtem, amolt, prajs, cani)
	if cani then
		TriggerEvent('vorp:TipRight', Config.YouBought..''..ajtem..' x'..amolt..''..Config.ThePriceWas..''..prajs, 5000)
	else
		TriggerEvent('vorp:TipRight', Config.YouCantBuy..''..ajtem..' x'..amolt..''..Config.ThePriceIs..''..prajs, 5000)	
	end
end)

-- Not Sheriff Notification
RegisterNetEvent('rm_sheriff_vorp:failed_not_sheriff')
AddEventHandler('rm_sheriff_vorp:failed_not_sheriff', function()
	TriggerEvent("rm_sheriff_vorp:not", Config.NotificationTitleFailed, Config.NotSheriff, 'menu_textures', 'cross', 5000)
end)

-- Payment Notification
RegisterNetEvent('rm_sheriff_vorp:not_payment')
AddEventHandler('rm_sheriff_vorp:not_payment', function()
	TriggerEvent("rm_sheriff_vorp:not", Config.NotificationTitle, Config.PaymentNotification.." $"..Config.PaymentMoney, 'inventory_items', 'money_moneyclip', 5000)
end)

-- Notifications
RegisterNetEvent('rm_sheriff_vorp:not')
AddEventHandler('rm_sheriff_vorp:not', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(5)
        end
    end
    if txtr ~= nil then
        exports.rm_sheriff_vorp.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.rm_sheriff_vorp.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
end)

-- GetClosestPlayer Function
function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

-- Just in case...
RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	SendNUIMessage({
		type = "logo",
		display = false
	})
end)

-- onClientMapStart
AddEventHandler('onClientResourceStart', function(resource)
	SendNUIMessage({
		type = "logo",
		display = false
	})
	
	Wait(3000) -- Make Sure...

	SendNUIMessage({
		type = "logo",
		display = false
	})
end)

-- onResourceStop
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	
	-- Remove Badges
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F7F3587, 0)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
	
	-- Disable Duty
	onDuty = false
	
	-- Remove Logo
	SendNUIMessage({
		type = "logo",
		display = false
	})
	
	-- Disable Menu
	MenuActive = false
	
	-- Disable Lockers
	currentlocker = nil
	lockerenabled = false
	
	-- Disable Payment Timer
	paymenttimerstarted = false

	-- Remove Blips
    for i, v in pairs(CreatedBlips) do
        RemoveBlip(v)
    end
    CreatedBlips = {}
end)