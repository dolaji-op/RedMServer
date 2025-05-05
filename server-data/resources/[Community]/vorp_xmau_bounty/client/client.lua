local starting = false
local already = false
local count = {}
local createdped = {}
local pressing = false
local gpsx = 0.0
local gpsy = 0.0
local gpsz = 0.0

local gpsx2 = 0.0
local gpsy2 = 0.0
local gpsz2 = 0.0
local canpass = false

function missionstart()


	local randomNCoords = math.random(23)
	local chossenCoords = {}


	if randomNCoords == 1 then
		chossenCoords = Config.Coordenates.coords
	elseif randomNCoords == 2 then
		chossenCoords = Config.Coordenates.coords2
	elseif randomNCoords == 3 then
		chossenCoords = Config.Coordenates.coords3
	elseif randomNCoords == 4 then
		chossenCoords = Config.Coordenates.coords4
	elseif randomNCoords == 5 then
		chossenCoords = Config.Coordenates.coords5
	elseif randomNCoords == 6 then
		chossenCoords = Config.Coordenates.coords6
	elseif randomNCoords == 7 then
		chossenCoords = Config.Coordenates.coords7
	elseif randomNCoords == 8 then
		chossenCoords = Config.Coordenates.coords8
	elseif randomNCoords == 9 then
		chossenCoords = Config.Coordenates.coords9
	elseif randomNCoords == 10 then
		chossenCoords = Config.Coordenates.coords10
	elseif randomNCoords == 11 then
		chossenCoords = Config.Coordenates.coords11
	elseif randomNCoords == 12 then
		chossenCoords = Config.Coordenates.coords12
	elseif randomNCoords == 13 then
		chossenCoords = Config.Coordenates.coords13
	elseif randomNCoords == 14 then
		chossenCoords = Config.Coordenates.coords14
	elseif randomNCoords == 15 then
		chossenCoords = Config.Coordenates.coords15
	elseif randomNCoords == 16 then
		chossenCoords = Config.Coordenates.coords16
	elseif randomNCoords == 17 then
		chossenCoords = Config.Coordenates.coords17
	elseif randomNCoords == 18 then
		chossenCoords = Config.Coordenates.coords18
	elseif randomNCoords == 19 then
		chossenCoords = Config.Coordenates.coords19
	elseif randomNCoords == 20 then
		chossenCoords = Config.Coordenates.coords20
	elseif randomNCoords == 21 then
		chossenCoords = Config.Coordenates.coords21
			elseif randomNCoords == 22 then
		chossenCoords = Config.Coordenates.coords22
			elseif randomNCoords == 23 then
		chossenCoords = Config.Coordenates.coords23
	end

			  
	for k,item in pairs(chossenCoords) do
		
	--Take a random model
		local modelNumeroRandom = math.random(15)
		local modelRandom = Config.models[modelNumeroRandom].hash
		local _hash = GetHashKey(modelRandom)
		RequestModel(_hash)
		if not HasModelLoaded(_hash) then 
			RequestModel(_hash) 
		end
	
		while not HasModelLoaded(_hash) do 
			Citizen.Wait(1) 
		end
		
		--print(modelNumeroRandom)

	--Take a random weapon
		local randomNumeroArma = math.random(22)
		local arma = Config.weapons[randomNumeroArma].hash
		--print(randomNumeroArma)

		createdped[k] = CreatePed(_hash, item.x, item.y, item.z, true, true, true, true)
		Citizen.InvokeNative(0x283978A15512B2FE, createdped[k], true)
		Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, createdped[k])
		gpsx = item.x
		gpsy = item.y
		gpsz = item.z
	--Give weapons to ped and equip them
		GiveWeaponToPed_2(createdped[k], arma, 10, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
		SetCurrentPedWeapon(createdped[k], arma, true)
	--Ped becomes agressive to the player
		TaskCombatPed(createdped[k],PlayerPedId())
		count[k] = createdped[k]
		--print(count[k])
	end
	StartGpsMultiRoute(6, true, true)
        
    -- Add the points
    AddPointToGpsMultiRoute(gpsx, gpsy, gpsz)
    AddPointToGpsMultiRoute(gpsx, gpsy, gpsz)

    -- Set the route to render
	SetGpsMultiRouteRender(true)

	starting = true
	Wait(1000)
	Citizen.CreateThread(function()
		local x = #chossenCoords
		local pl = Citizen.InvokeNative(0x217E9DC48139933D)
		while starting == true do
			Citizen.Wait(0)
			for k,v in pairs(createdped) do
				if IsEntityDead(v) then
					if count[k] ~= nil then
						x = x - 1
						count[k] = nil
						if x == 0 then
							TriggerEvent("vorp:TipBottom", Config.ObjectivesKilledMessage, 4000)
							TriggerServerEvent('vorp_bountyhunting:AddSomeMoney', 4000)
							Wait(4000)
							--TriggerEvent("vorp:TipBottom", 'You got paid for the Bounty', 4000)
							stopmission()
						end
					end
				end
				if IsPlayerDead(pl) then
					TriggerEvent("vorp:TipBottom", Config.DeadMessage, 4000)
					stopmission()
				end
			end
		end
	end)
end

function stopmission()
	Wait(5000)
	pressing = false
	starting = false
	already = false
	SetGpsMultiRouteRender(false)
	--[[ for k,v in pairs(createdped) do
		DeletePed(v)
		Wait(500)
	end ]]
	table.remove{createdped}
	table.remove{count}
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function startdialog()
	Citizen.CreateThread(function()
	  local timetocheck = 600
		while timetocheck >= 0  do
			Citizen.Wait(0)
			DrawTxt(Config.KillingMessage, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			timetocheck = timetocheck - 1
		end
	end)
end

RegisterNetEvent('bounty:findcard')
AddEventHandler('bounty:findcard', function()
	canpass = true
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		for k,v in pairs(Config.Locations) do
			local distance = GetDistanceBetweenCoords(coords, v['x'], v['y'], v['z'], true)
			if distance < 1.0 then
			DrawTxt(Config.HuntingMessage, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
				if IsControlJustPressed(2, 0xC7B5340A) and not pressing then
					TriggerServerEvent("bounty:checkcard")
					Wait(600)
					if canpass then 
						stopmission()
						pressing = true
						missionstart()
						startdialog()
						already = true
					else
						TriggerEvent("vorp:TipBottom", "You Dont Have a Bounty Hunting License.", 10000)
					end
				end
			end
		end
	end
end)
