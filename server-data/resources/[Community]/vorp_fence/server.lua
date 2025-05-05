local VorpCore = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()


RegisterServerEvent('fence:vender')
AddEventHandler( 'fence:vender', function ( args )
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local _price = args['Price']
    local _model = args['Tipo']
	local _mens  = args['Mens']
	
	local inv_count = VorpInv.getItemCount(_source, _model)
	
    if inv_count < 1 then
        TriggerClientEvent( 'UI:NotificaVenta', _source, Config.NoInv )
        return
    end

	VorpInv.subItem(_source, _model, 1)
	Character.addCurrency(0, _price)
	
	TriggerClientEvent( 'UI:NotificaVenta', _source, Config.Selltext .. _mens )
	
end)

RegisterServerEvent('bar:comprar')
AddEventHandler( 'bar:comprar', function ( args )
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local _source   = source
    local _price = args['Price']
    local _model = args['Tipo']
    local _mens  = args['Mens']
    
    u_money = Character.money

    if u_money <= _price then
        TriggerClientEvent( 'UI:NotificaCompra', _source, Config.NoMoney )
        return
    end

    Character.removeCurrency(0, _price)
    
   
    VorpInv.addItem(_source, _model, 1)

    TriggerClientEvent( 'UI:NotificaCompra', _source, Config.Buytext .. _mens )
    
end)