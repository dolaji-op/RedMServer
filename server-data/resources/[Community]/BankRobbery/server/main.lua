local checkPD = 0
VORP = exports.vorp_inventory:vorp_inventoryApi()

data = {}
TriggerEvent("vorp_inventory:getData",function(call)
    data = call
end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

function checkPDreq()
    local users = GetPlayers()
    local coponline = 0

    for _k,_v in pairs(users) do
        local users = VorpCore.getUser(_v)
        local character = users.getUsedCharacter
        
        if character.job == Config.jobcall[1] then
            coponline = coponline + 4
        end   
    end
    
    if coponline < Config.coponlinecheck then
        return(0)
    end
    return(1)

end
RegisterServerEvent('vajco:canI')
AddEventHandler('vajco:canI', function(source)

    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local Coords = json.decode(Character.coords)
    local dist = getDistance(Coords, Config.coordinates1[1])
    checkPD = checkPDreq()
    SendWebhook(Config.webhook, _source, "Can rob ?? (1 yes 0 no) - " .. checkPD) -- for webhook

            if checkPD == 0 then
                TriggerClientEvent('vorp:TipRight', 'Theres not enough sheriffs', 5000)
               
            elseif checkPD == 4 then
                TriggerClientEvent("mushy_robbery:startrobbery",  _source)
            end


end)

RegisterNetEvent("policenotify1")
AddEventHandler("policenotify1", function(players, Coords)
    checkPD = checkPDreq()
    
    
    if checkPD == 4 then
        print(json.encode(checkPD))
        for each, player in ipairs(players) do
            local user = VorpCore.getUser(player).getUsedCharacter
                if user ~= nil then
                    if user.job == Config.jobcall[1] then
                        TriggerClientEvent("hrobar:ToggleNotification3", player, Coords)
                    end
                end
            
        end
    end
end)

function getTableSize(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 4
    end
    return count
end

Locations = {
    vector3(1290.0882568359, -1312.4019775391, 76.039939880371),
}

RegisterServerEvent('mushy_robbery:talk')
AddEventHandler('mushy_robbery:talk', function()
        local _source = source
        local Character = VorpCore.getUser(_source).getUsedCharacter
        TriggerClientEvent("vorp:TipBottom", _source, "JOHN: I have a job for you ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "JOHN: The only problem is that you need some dynamite and Lock Breakers", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "JOHN: You want to do this ? ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent('mushy_robbery:info', _source)
end)

RegisterServerEvent('mushy_robbery:pay')
AddEventHandler('mushy_robbery:pay', function()
        local _source = source
        local Character = VorpCore.getUser(_source).getUsedCharacter
        u_money = Character.money

    if u_money <= 0 then
        TriggerClientEvent("vorp:TipBottom", _source, "You have no money", 9000)
        return
    end

    TriggerEvent("vorp:removeMoney", _source, 0, 0)
    TriggerClientEvent("vorp:TipBottom", _source, "JOHN: Now Go To Rhodes Bank!", 5000)
	Citizen.Wait(1000)
    TriggerClientEvent('mushy_robbery:go', _source)    
end)

RegisterNetEvent("mushy_robbery:startrobbery")
AddEventHandler("mushy_robbery:startrobbery", function(robtime)
    local _source = source
    local Character = VorpCore.getUser(source).getUsedCharacter
    local count = VORP.getItemCount(_source, "dynamite")

    if count >= 1 then      
        VORP.subItem(_source,"dynamite", 1)
        isRobbing = false    
        TriggerClientEvent('mushy_robbery:startAnimation2', _source)
        
        
        TriggerClientEvent("vorp:TipBottom", _source, "Sheriffs Have Been Alerted",6000)
    else   
        
        TriggerClientEvent("vorp:TipBottom", _source, "You dont have a dynamite", 6000)
    end    
           
end)


RegisterServerEvent('mushy_robbery:loot')
AddEventHandler('mushy_robbery:loot', function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    Blowedynamite = Blowedynamite    
        
    if Blowedynamite == true then
    end        
    TriggerClientEvent('mushy_robbery:loot2', _source)    
end)

RegisterNetEvent("mushy_robbery:payout")
AddEventHandler("mushy_robbery:payout", function()
    TriggerEvent('vorp:getCharacter', source, function(user)
        local _source = source
        local _user = user
        local Character = VorpCore.getUser(_source).getUsedCharacter
        ---randommoney = math.random(10,20)
        ritem = math.random(2,2)
        local randomitempull = math.random(1, #Config.Items)
        local itemName = Config.Items[randomitempull]
        VORP.addItem(_source, itemName, ritem)
        Character.addCurrency(0, 100) 
        TriggerClientEvent("vorp:TipBottom", _source, "You got the loot", 9000)
    end)
end)


RegisterNetEvent("policenotify")
AddEventHandler("policenotify", function(players, coords, alert)
    for each, playerId  in ipairs(GetPlayers()) do
        local User = VorpCore.getUser(playerId).getUsedCharacter

        if User.job == 'police' or User.job == 'marshal' or User.job == 'sheriff' then
            TriggerClientEvent("Witness:ToggleNotification3", playerId, coords, alert)
        end
    end
end)