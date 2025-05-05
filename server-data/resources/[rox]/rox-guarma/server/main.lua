

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


RegisterNetEvent('DBFW:Server:BuyTicket')
AddEventHandler('DBFW:Server:BuyTicket', function(name)
    local src = source

    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local _ticket = Config.Price
    Character.removeCurrency(0, _ticket)
    TriggerClientEvent('DBFW:Client:SailBoat', src, name)
    TriggerClientEvent("vorp:NotifyLeft", src, "Boat Ticket", 'You purchased boat ticket', 'generic_textures', 'tick', 5000)
end)

