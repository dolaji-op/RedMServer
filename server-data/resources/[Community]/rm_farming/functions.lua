function drawtext(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then 
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10);
    DisplayText(str, x, y)
end
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
    	SetTextScale(0.30, 0.30)
  		SetTextFontForCurrentCommand(1)
    	SetTextColor(255, 255, 255, 215)
    	SetTextCentre(1)
    	DisplayText(str,_x,_y)
    	local factor = (string.len(text)) / 225
    	DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
    end
end

function contains(table, element)
    for k, v in pairs(table) do
        if v == element then
            return true
        end
    end
return false
end

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
                playerid = GetPlayerServerId(players[i])
                tgt1 = GetPlayerPed(players[i])
            end
        end
    end
    return closestPlayer, closestDistance,  playerid, tgt1
end

function plantexist(plant, allfarms)
    local string = plant.id
    for l,m in pairs(allfarms) do 
        for x,y in pairs(m) do 
            for g,h in pairs(y) do 
                string2 = h.render
                if string == string2 then 
                    return true 
                end
            end
        end
    end
    return false 
end



function keysx(table)
    local keys = 0
    for k,v in pairs(table) do
       keys = keys + 1
    end
    return keys
end



function istownbanned(town)
    for k,v in pairs(Config.towns) do
		if town == GetHashKey(v) then
			return true
		end
	end
	return false
end

function totalcount(table)
    local totalcount = 0 
    for k,v in pairs(table) do 
      for x,y in pairs(v) do 
        totalcount = totalcount + 1
      end
    end
    return totalcount
end

function tooclose(allfarms,coords)
    local tooclose = {}
    for k,v in pairs(allfarms) do 
        for x,y in pairs(v) do 
            for g,h in pairs(y) do 
                local dist = GetDistanceBetweenCoords(coords,h.coords.x,h.coords.y,h.coords.z , true)
                if dist < Config.plantspace then
                    table.insert( tooclose, "false" )
                end
            end
        end
    end
    if contains(tooclose, "false") then 
        return true 
    else
        return false 
    end
end

function anim(dict,name, time, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), dict, name, 1.0, 1.0, time, flag, 0, true, 0, false, 0, false)  
end

function containswagon(table, element)
    for k, v in pairs(table) do
        if k == element then
            return true,v
        end
    end
return false,0
end
