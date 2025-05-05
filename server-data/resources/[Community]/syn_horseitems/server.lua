local VorpCore = {}
local VorpInv

local inventory = {}

if Config.vorp then
    TriggerEvent("getCore",function(core)
        VorpCore = core
    end)

    VorpInv = exports.vorp_inventory:vorp_inventoryApi()

    for k,v in pairs(Config.horsefood) do 
        VorpInv.RegisterUsableItem(k, function(data)
            if v.typeof ~= "brush" then 
                VorpInv.subItem(data.source, k, 1)
            end
            TriggerClientEvent("syn_horseitems:useitem", data.source,k)
        end)
    end
end

