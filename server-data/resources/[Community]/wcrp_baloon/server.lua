TriggerEvent("getCore", function(core)
    VORPcore = core
end)

VORPinv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent("PayBaloon")
AddEventHandler("PayBaloon", function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local money = Character.money
        if money >= 5 then
            Character.removeCurrency(0, 5)
            TriggerClientEvent("SpawnBalloon",_source)
            --print("money above 5")
        else
            TriggerClientEvent("vorp:TipRight", _source, "You don't have enough money", 3000)
            --print("not enough money")
        end
end)