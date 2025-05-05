local VorpCore
local VorpInv

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent("av_broom:deleteobj_s")
AddEventHandler("av_broom:deleteobj_s", function(ent)
    TriggerClientEvent("av_broom:deleteobj_c", -1, ent)
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)
    VorpInv.RegisterUsableItem("broom", function(data)
		TriggerClientEvent('av_broom:start', data.source)
        VorpInv.CloseInv(data.source)
    end)
end)

RegisterServerEvent("av_broom:reward")
AddEventHandler("av_broom:reward", function()
    local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter

    local money = math.random(Config.Options.MinMoney,Config.Options.MaxMoney)
    Character.addCurrency(0, money)

    local msg = Config.Messages.JobFinish.." $"..money..""
    TriggerClientEvent("Notification:left_broom", _source, Config.Messages.Title, msg, 'generic_textures', 'tick', 3000)
end)

