local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()


RegisterServerEvent("rm_buy_farmanimal:check")
AddEventHandler("rm_buy_farmanimal:check", function()
    local _source = source
    local go = true
    if Config.MenuJob ~= false then 
        go = false
        local Character = VorpCore.getUser(_source).getUsedCharacter
        local job =  Character.job
        for i,v in pairs(Config.MenuJob) do 
            if v == job then 
                go = true 
                break
            end
        end 
    end
    if go then 
        TriggerClientEvent("rm_buy_farmanimal", _source)
    else
        TriggerClientEvent("vorp:TipBottom", _source, Config.Options.Messages.AnimalShop, Config.Options.Messages.NoJob, 'menu_textures', 'stamp_locked_rank', 3000)
    end
end)


RegisterServerEvent("rm_farmanimals:deleteped_s")
AddEventHandler("rm_farmanimals:deleteped_s", function(ent)
    TriggerClientEvent("rm_farmanimals:deleteped_c", -1, ent)
end)

RegisterServerEvent('rm_farmanimal:buyanimal')
AddEventHandler( 'rm_farmanimal:buyanimal', function ( name,model,preset,price )
    local _source   = source
    local _price = tonumber(price)
    local _model = tonumber(model)
    local _preset = tonumber(preset)
    local _name = tostring(name)

    local Character = VorpCore.getUser(_source).getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier

    local u_money =  Character.money
    if u_money < _price then
        TriggerClientEvent("vorp:TipBottom", _source, Config.Options.MenuTexts.Title.."\n"..Config.Options.Messages.NoMoney, 3000)
        return
    else
        local animalid = math.random(1,999999)
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['animalid'] = animalid, ['model'] = _model, ['preset'] = _preset, ['name'] = _name, ['xp'] = 0, ['price'] = _price}
        TriggerClientEvent("vorp:TipBottom", _source, Config.Options.MenuTexts.Title.."\n"..Config.Options.Messages.BoughtAnimal, 3000)
        Character.removeCurrency(0 , tonumber(_price))
        exports.ghmattimysql:execute("INSERT INTO farmanimals ( `identifier`, `charid`, `animalid`, `model`, `preset`, `name`, `xp`, `price`) VALUES ( @identifier, @charid, @animalid, @model, @preset, @name, @xp, @price)", Parameters, function(done)
        end)
    end
end)

RegisterServerEvent('rm_farmanimal:getFarmAnimals')
AddEventHandler('rm_farmanimal:getFarmAnimals', function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local identifier = Character.identifier
    local charid = Character.charIdentifier
    TriggerEvent('rm_farmanimal:getFarmAnimals_db',identifier, charid, function(call)
        if call then
            TriggerClientEvent('rm_farmanimal:putInTable', _source, call)
        end
    end)
end)


RegisterServerEvent('rm_farmanimal:getFarmAnimals_db')
AddEventHandler('rm_farmanimal:getFarmAnimals_db', function(identifier,charid,callback)
    local Callback = callback
    exports.ghmattimysql:execute('SELECT * FROM farmanimals WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = identifier, charid = charid}, function(animals)
        if animals[1] then
            Callback(animals)
        else
            Callback(false)
        end
    end)
end)

RegisterServerEvent('rm_farmanimal:SetAnimal')
AddEventHandler('rm_farmanimal:SetAnimal', function(model,name,preset,xp,price,animalid)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local identifier = Character.identifier
    local charid = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT * FROM farmanimals WHERE `identifier`=@identifier AND `charid`=@charid AND `animalid`=@animalid AND `model`=@model AND `name`=@name;', {identifier = identifier, charid = charid, animalid = animalid, model = model, name = name}, function(animals)
        if animals[1] then
            TriggerClientEvent('rm_farmanimal:spawnanimal', _source, model, name, preset, xp, price, animalid)
        end
    end)
end)


RegisterServerEvent('rm_farmanimal:DeleteAnimal')
AddEventHandler('rm_farmanimal:DeleteAnimal', function(model,name,preset,xp,price,animalid,killerid)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute('DELETE FROM farmanimals  WHERE `identifier`=@identifier AND `charid`=@charid AND`animalid`=@animalid AND `model`=@model AND `name`=@name;', {identifier = u_identifier, charid = u_charid,  animalid = animalid, model = model, name = name}, function(result)
    end)
end)

RegisterServerEvent('rm_farmanimal:SellAnimal')
AddEventHandler('rm_farmanimal:SellAnimal', function(id,model,name,preset,xp,price,animalid,odds)
    local _source = source
    local _price = tonumber(price)
    local odds1 = tonumber(odds)
    local _sum = _price * odds1
    local _animalid = tonumber(animalid)
    local _model = tonumber(model)
    local _name = tostring(name)

    local Character = VorpCore.getUser(_source).getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    local u_money = Character.money
    Character.addCurrency(0 , tonumber(_sum))

    exports.ghmattimysql:execute('DELETE FROM farmanimals  WHERE `identifier`=@identifier AND `charid`=@charid AND`animalid`=@animalid AND `model`=@model AND `name`=@name;', {identifier = u_identifier, charid = u_charid,  animalid = _animalid, model = _model, name = _name}, function(result)
    end)
    TriggerClientEvent("rm_farmanimal:soldanimal",_source, id)
end)

RegisterServerEvent("rm_farmanimal:finishedeating")
AddEventHandler("rm_farmanimal:finishedeating", function(data)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    local newxp = data.xp
    if newxp < 800 then
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid,  ['model'] = data.model, ['animalid'] = data.animalid}
        exports.ghmattimysql:execute(" UPDATE farmanimals SET xp ='"..newxp.."' WHERE identifier = @identifier AND charid = @charid AND model = @model AND animalid = @animalid", Parameters)
    end
end)