if Config.UseHandcuffsFunctions then --------------------------------------------------------------------

VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

Inventory = exports.vorp_inventory:vorp_inventoryApi()

data = {}

TriggerEvent("vorp_inventory:getData",function(call)
    data = call
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)

	Inventory.RegisterUsableItem(Config.HandcuffsItemName, function(data)
		TriggerClientEvent("bulgar_handcuffs:handcuff_use", data.source) 
	end)	
end)

RegisterServerEvent('bulgar_handcuffs:rm_sheriff_vorp_use')
AddEventHandler('bulgar_handcuffs:rm_sheriff_vorp_use', function()
	local _source = source
	local cnt = Inventory.getItemCount(_source, Config.HandcuffsItemName)
	
	if cnt >= 1 then
		TriggerClientEvent("bulgar_handcuffs:handcuff_use", _source)
	else
		TriggerClientEvent("rm_sheriff_vorp:not", _source, Config.NotificationTitle, Config.NoHandcuffNot, 'generic_textures', 'star', 5000)
	end	
end)

RegisterServerEvent('bulgar_handcuffs:handcuff_use_sv')
AddEventHandler('bulgar_handcuffs:handcuff_use_sv', function(target)
	local _source = source
	local _target = target
	
	TriggerClientEvent('bulgar_handcuffs:handcuff', _target)
end)

end --------------------------------------------------------------------