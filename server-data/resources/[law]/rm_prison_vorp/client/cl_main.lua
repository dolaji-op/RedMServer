local current_prison = 0 -- (1,2 = Valentine) / (3 = Rhodes) / (4,5,6,7 = Saint Denis) / (8,9 = Strawberry) / (10,11 = Blackwater) / (0 = Not in Jail)
local prison_time = nil
local tptojail = false

MenuData = {}
TriggerEvent('redemrp_menu_base:getData',function(call)
    MenuData = call
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Wait(3000)

	TriggerServerEvent("rm_prison:check_prison_time")
end)

RegisterNetEvent("rm_prison:FirstLoad_2")
AddEventHandler("rm_prison:FirstLoad_2", function(current_prison_new, prison_time_new)
	prison_time = prison_time_new
	current_prison = current_prison_new
	
	if Config.AddThirstAndHunger then
		TriggerEvent("vorpmetabolism:changeValue", "Hunger", Config.AddHunger)
		TriggerEvent("vorpmetabolism:changeValue", "Thirst", Config.AddThrist)
	end
end)

RegisterNetEvent("rm_prison:update_unjail")
AddEventHandler("rm_prison:update_unjail", function()
	prison_time = 0
end)

Citizen.CreateThread(function()
	local SLEEPTIME = 2000
    while true do
	
		if current_prison == 0 then
			SLEEPTIME = 2000
			tptojail = false
	
		elseif current_prison == 1 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_1) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 1)
					SetEntityCoords(ped, Config.ExitFromJail_VAL.x, Config.ExitFromJail_VAL.y, Config.ExitFromJail_VAL.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
		
		elseif current_prison == 2 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_2) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 2)
					SetEntityCoords(ped, Config.ExitFromJail_VAL.x, Config.ExitFromJail_VAL.y, Config.ExitFromJail_VAL.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
		
		elseif current_prison == 3 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_3) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 3)
					SetEntityCoords(ped, Config.ExitFromJail_RH.x, Config.ExitFromJail_RH.y, Config.ExitFromJail_RH.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
			
		elseif current_prison == 4 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_4) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 4)
					SetEntityCoords(ped, Config.ExitFromJail_SD.x, Config.ExitFromJail_SD.y, Config.ExitFromJail_SD.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
			
		elseif current_prison == 5 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_5) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 5)
					SetEntityCoords(ped, Config.ExitFromJail_SD.x, Config.ExitFromJail_SD.y, Config.ExitFromJail_SD.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
			
		elseif current_prison == 6 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_6) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 6)
					SetEntityCoords(ped, Config.ExitFromJail_SD.x, Config.ExitFromJail_SD.y, Config.ExitFromJail_SD.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
			
		elseif current_prison == 7 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_7) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 7)
					SetEntityCoords(ped, Config.ExitFromJail_SD.x, Config.ExitFromJail_SD.y, Config.ExitFromJail_SD.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
			
		elseif current_prison == 8 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_8) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 8)
					SetEntityCoords(ped, Config.ExitFromJail_STR.x, Config.ExitFromJail_STR.y, Config.ExitFromJail_STR.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
			
		elseif current_prison == 9 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_9) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 9)
					SetEntityCoords(ped, Config.ExitFromJail_STR.x, Config.ExitFromJail_STR.y, Config.ExitFromJail_STR.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
			
		elseif current_prison == 10 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_10) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 10)
					SetEntityCoords(ped, Config.ExitFromJail_BW.x, Config.ExitFromJail_BW.y, Config.ExitFromJail_BW.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
			
		elseif current_prison == 11 then
			SLEEPTIME = 1000
			
			local ped = PlayerPedId()
			local player_coords = GetEntityCoords(ped, true)
			
			for k,v in pairs(Config.Jail_11) do
				if not tptojail then
					SetEntityCoords(ped, v.x, v.y, v.z)
					tptojail = true
				end
				if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxPrisonDistance then
					SetEntityCoords(ped, v.x, v.y, v.z)
				end
			end
			
            if prison_time ~= nil then
                if prison_time <= 0 then
                    local ped_server_id = GetPlayerServerId(PlayerId())

                    TriggerServerEvent("rm_prison:unjail", ped_server_id, 11)
					SetEntityCoords(ped, Config.ExitFromJail_BW.x, Config.ExitFromJail_BW.y, Config.ExitFromJail_BW.z)
					current_prison = 0
					prison_time = nil
					tptojail = false
                else
                    prison_time = prison_time - 1
                end
            end
			
		end
	
		Citizen.Wait(SLEEPTIME)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) -- Update Database Every 1 minute if in prison.
		
		if current_prison ~= 0 then
			TriggerServerEvent("rm_prison:update_prison_time")
		end
	end
end)

Citizen.CreateThread(function()
	local SLEEPTIME = 2000

    while true do
        if current_prison ~= 0 then
			if prison_time ~= nil then
				SLEEPTIME = 0
				DrawTxt('Prison time: '..prison_time..' left.', 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
			end
		else
			SLEEPTIME = 2000
        end
        Citizen.Wait(SLEEPTIME)
    end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

Citizen.CreateThread(function()
	local SLEEPTIME = 2000
	while true do
		if Config.ShowCellNumber3D then
			for k,v in pairs(Config.Coords3D) do
				isnearcoords = IsPlayerNearCoords(Config.Coords3D[k]["Coords"].x, Config.Coords3D[k]["Coords"].y, Config.Coords3D[k]["Coords"].z, Config.Coords3D[k]["Coords"].r)
				if isnearcoords then
					SLEEPTIME = 5
					DrawText3D(Config.Coords3D[k]["Coords"].x, Config.Coords3D[k]["Coords"].y, Config.Coords3D[k]["Coords"].z+0.5, Config.Coords3D[k]["Text"])
				end
			end
		end
		Citizen.Wait(SLEEPTIME)
	end
end)

function IsPlayerNearCoords(x, y, z, radius)
	local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
	local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)
	if distance < radius then
		return true
	end
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

-- Prison Menu
RegisterNetEvent("rm_prison:open_jail_menu")
AddEventHandler("rm_prison:open_jail_menu", function()
	openjailmenu()
end)

function openjailmenu()
	MenuData.CloseAll()
	
	local elements = {
		{label = "Valentine Jail Cell 1", value = "vjail1" , desc =  "Valentine Jail Cell 1" },
		{label = "Valentine Jail Cell 2", value = "vjail2" , desc =  "Valentine Jail Cell 2" },
		{label = "", value = "" , desc =  "" }, -- Space
		{label = "Rhodes Jail Cell 1", value = "rjail1" , desc =  "Rhodes Jail Cell 1" },
		{label = "", value = "" , desc =  "" }, -- Space
		{label = "Saint Denis Jail Cell 1", value = "sdjail1" , desc =  "Saint Denis Jail Cell 1" },
		{label = "Saint Denis Jail Cell 2", value = "sdjail2" , desc =  "Saint Denis Jail Cell 2" },
		{label = "Saint Denis Jail Cell 3", value = "sdjail3" , desc =  "Saint Denis Jail Cell 3" },
		{label = "Saint Denis Jail Cell 4", value = "sdjail4" , desc =  "Saint Denis Jail Cell 4" },
		{label = "", value = "" , desc =  "" }, -- Space
		{label = "Strawberry Jail Cell 1", value = "strjail1" , desc =  "Strawberry Jail Cell 1" },
		{label = "Strawberry Jail Cell 2", value = "strjail2" , desc =  "Strawberry Jail Cell 2" },
		{label = "", value = "" , desc =  "" }, -- Space
		{label = "Blackwater Jail Cell 1", value = "bljail1" , desc =  "Blackwater Jail Cell 1" },
		{label = "Blackwater Jail Cell 2", value = "bljail2" , desc =  "Blackwater Jail Cell 2" },
		{label = "", value = "" , desc =  "" }, -- Space
		{label = "Release from Jail", value = "rfromjail" , desc =  "Release from Jail" },
	}

	MenuData.Open('default', GetCurrentResourceName(), 'PrisonMenu', {
		title    = 'Prison Menu',
		subtext    = 'Prison Menu',
		align    = 'right',
		elements = elements,
	},
	
	function(data, menu)
		if(data.current.value == 'vjail1') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 1, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'vjail2') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 2, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'rjail1') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 3, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'sdjail1') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 4, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'sdjail2') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 5, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'sdjail3') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 6, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'sdjail4') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 7, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'strjail1') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 8, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'strjail2') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 9, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'bljail1') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 10, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'bljail2') then
			MenuData.CloseAll()
			
			local tid = nil
			local tim = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerEvent("bulgar_inputs:getInput", "Confirm", "Time in Minutes", function(cb2)
							tim = tonumber(cb2)

							if tim ~= nil then
								if tim >= 0 then
									TriggerServerEvent("rm_prison:put_in_jail", tid, 11, tim)
								end
							end
						end)
					end
				end
			end)
		elseif(data.current.value == 'rfromjail') then
			MenuData.CloseAll()
			
			local tid = nil

			TriggerEvent("bulgar_inputs:getInput", "Confirm", "Target ID", function(cb)
				tid = tonumber(cb)

				if tid ~= nil then
					if tid >= 0 then
						TriggerServerEvent("rm_prison:unjail", tid, 0)
					end
				end
			end)
		end
	end,
			
	function(data, menu)
		menu.close()
	end)
end