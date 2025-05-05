if Config.UseHandcuffsFunctions then --------------------------------------------------------------------

local isHandcuffed = false

MenuData = {}
TriggerEvent('redemrp_menu_base:getData',function(call)
	MenuData = call
end)

RegisterNetEvent("bulgar_handcuffs:handcuff_use")
AddEventHandler("bulgar_handcuffs:handcuff_use",function()
	local closestPlayer, closestDistance = GetClosestPlayer()

	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('bulgar_handcuffs:handcuff_use_sv', GetPlayerServerId(closestPlayer))
	end
end)

RegisterNetEvent("bulgar_handcuffs:handcuff")
AddEventHandler("bulgar_handcuffs:handcuff",function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()
	
	Citizen.CreateThread(function()
		if isHandcuffed then
			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
			SetPedCanPlayGestureAnims(playerPed, false)
			print("Handcuffed")
			print(isHandcuffed)
		elseif not isHandcuffed then
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			print("Uncuffed")
			print(isHandcuffed)
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			SetEnableHandcuffs(playerPed, true) -- FORCE HANDCUFF
			DisableControlAction(0, 0xB2F377E8, true) -- Attack
			DisableControlAction(0, 0xC1989F95, true) -- Attack 2
			DisableControlAction(0, 0x07CE1E61, true) -- Melee Attack 1
			DisableControlAction(0, 0xF84FA74F, true) -- MOUSE2
			DisableControlAction(0, 0xCEE12B50, true) -- MOUSE3
			DisableControlAction(0, 0x8FFC75D6, true) -- Shift
			DisableControlAction(0, 0xD9D0E1C0, true) -- SPACE
			DisableControlAction(0, 0xF3830D8E, true) -- J
			DisableControlAction(0, 0x80F28E95, true) -- L
			DisableControlAction(0, 0xDB096B85, true) -- CTRL
			DisableControlAction(0, 0xE30CD707, true) -- R
			DisableControlAction(0, 0x4CC0E2FE, true) -- B
			DisableControlAction(0, 0x295175BF, true) -- Disable break
			DisableControlAction(0, 0x6E9734E8, true) -- Disable suicide
			DisableControlAction(0, 0xD8F73058, true) -- Disable aiminair
			DisableControlAction(0, 0xDE794E3E, true) -- Cover
			DisableControlAction(0, 0x06052D11, true) -- Cover
			DisableControlAction(0, 0x5966D52A, true) -- Cover
			DisableControlAction(0, 0xCEFD9220, true) -- Cover
			DisableControlAction(0, 0xC75C27B0, true) -- Cover
			DisableControlAction(0, 0x41AC83D1, true) -- Cover
			DisableControlAction(0, 0xADEAF48C, true) -- Cover
			DisableControlAction(0, 0x9D2AEA88, true) -- Cover
			DisableControlAction(0, 0xE474F150, true) -- Cover
		else
			Citizen.Wait(500)
		end
	end
end)

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

	for i = 1, #players, 1 do
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

end --------------------------------------------------------------------