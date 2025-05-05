local isTalking = false
local isMuted = false
local vRange = 8.0
local show = false
local switchRange = false
local timer = 0
local ground = {}

function doUpdate()
	SendNUIMessage({
		show = show,  -- Disable hud if settings menu is active
		talking = isTalking,
		muted = isMuted,
		range = vRange
	})
end



RegisterNetEvent("syn_displayrange2")
AddEventHandler("syn_displayrange2", function(t)
	show = not t
	SendNUIMessage({
		show = show,  -- Disable hud if settings menu is active
		talking = isTalking,
		muted = isMuted,
		range = vRange
	})
end)


RegisterNetEvent("syn_talking")
AddEventHandler("syn_talking", function(t)
	isTalking = t
	doUpdate()
end)

--[[ RegisterNetEvent("SaltyChat_MicStateChanged")
AddEventHandler("SaltyChat_MicStateChanged", function(t)
	isMuted = t
	doUpdate()
end) ]]

RegisterNetEvent("syn_talking:getGround")
AddEventHandler("syn_talking:getGround", function(coords)
	local buffer
	buffer, ground = GetGroundZAndNormalFor_3dCoord(coords.x, coords.y, coords.z + 5 )
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if switchRange == true then
			if timer < 2000 then
				TriggerEvent('syn_talking:getGround', coords)
				Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, coords.x, coords.y, ground, 0, 0, 0, 0, 0, 0, vRange, vRange, 1.0, 100, 0, 0, 100, 0, 0, 1, 0, 0, 0, 0)
				timer = timer + 10
			else
				timer = 0
				switchRange = false
			end
		end
    end
end)

RegisterNetEvent("syn_changerange")
AddEventHandler("syn_changerange", function(t)
	switchRange = true
	timer = 0
	if t == 1 then
		vRange = 3.0
	elseif t == 2 then
		vRange = 8.0
	elseif t == 3 then
		vRange = 15.0
	elseif t == 4 then
		vRange = 32.0
	end
	print("Your Voice Range Is: "..vRange)
	doUpdate()
end)


