if Config.UseIntegration == 'redemrp' then
    local data = {}
    TriggerEvent('redemrp_inventory:getData',function(call)
        data = call
    end)

    RegisterNetEvent('redm_weapon_maintenance:redemrp:updateMultiWeaponProps', function (weaponToUpdate)
        local _source = source

        for _, weaponData in ipairs(weaponToUpdate) do
            local ItemData = data.getItem(_source, weaponData.name, weaponData.meta)

            if ItemData and ItemData.ItemAmount > 0 then
                local newMeta = {}
                for fieldName, fieldValue in pairs(ItemData.ItemMeta) do
                    newMeta[fieldName] = fieldValue
                end

                newMeta['permDegradation'] = NormalizeFloat(weaponData.permDegradation)
                newMeta['degradation'] = NormalizeFloat(weaponData.degradation)
                newMeta['damage'] = NormalizeFloat(weaponData.damage)
                newMeta['dirt'] = NormalizeFloat(weaponData.dirt)
                newMeta['soot'] = NormalizeFloat(weaponData.soot)
                newMeta['isJammed'] = weaponData.isJammed
                ItemData.ChangeMeta(newMeta)
            end
        end
    end)

    RegisterNetEvent('redm_weapon_maintenance:redemrp:updateWeaponProps', function (weaponName, weaponMeta, weaponProps)
        local _source = source
        local ItemData = data.getItem(_source, weaponName, weaponMeta)

        if ItemData and ItemData.ItemAmount > 0 then
            local newMeta = {}
            for fieldName, fieldValue in pairs(ItemData.ItemMeta) do
                newMeta[fieldName] = fieldValue
            end

            newMeta['permDegradation'] = NormalizeFloat(weaponProps.permDegradation)
            newMeta['degradation'] = NormalizeFloat(weaponProps.degradation)
            newMeta['damage'] = NormalizeFloat(weaponProps.damage)
            newMeta['dirt'] = NormalizeFloat(weaponProps.dirt)
            newMeta['soot'] = NormalizeFloat(weaponProps.soot)
            newMeta['isJammed'] = weaponProps.isJammed
            ItemData.ChangeMeta(newMeta)
        end
    end)

    if Config.EnableGunOilCheck then
        RegisterNetEvent('redm_weapon_maintenance:redemrp:removeGunOil', function ()
            local _source = source
            local ItemData = data.getItem(_source, Config.GunOilItemName)

            if ItemData and ItemData.ItemAmount > 0 then
                ItemData.RemoveItem(1)
            end
        end)
    end
elseif Config.UseIntegration == 'vorp' then
    local VorpCore = {}
    TriggerEvent("getCore",function(core)
        VorpCore = core
    end)

    VorpInv = exports.vorp_inventory:vorp_inventoryApi()

    RegisterNetEvent('redm_weapon_maintenance:vorp:updateMultiWeaponProps', function (weaponToUpdate)
        local _source = source
        local User = VorpCore.getUser(_source)

        if User then
            local Character = User.getUsedCharacter

            if Character then
                local identifier = Character.identifier

                if identifier then
                    local updatedWeaponIds = {}

                    for _, weaponData in ipairs(weaponToUpdate) do
                        exports.ghmattimysql:execute('UPDATE loadout_props SET permDegradation = @permDegradation, degradation = @degradation, damage = @damage, dirt = @dirt, soot = @soot, isJammed = @isJammed WHERE id = @id' , {
                            ['id'] = weaponData.id,
                            ['permDegradation'] = NormalizeFloat(weaponData.permDegradation),
                            ['degradation'] = NormalizeFloat(weaponData.degradation),
                            ['damage'] = NormalizeFloat(weaponData.damage),
                            ['dirt'] = NormalizeFloat(weaponData.dirt),
                            ['soot'] = NormalizeFloat(weaponData.soot),
                            ['isJammed'] = BoolToInt(weaponData.isJammed)
                        })

                        table.insert(updatedWeaponIds, weaponData.id)
                    end

                    printd('[VORP] %s updated %i weapons (%s).', GetPlayerName(_source), #updatedWeaponIds, table.concat(updatedWeaponIds, ', '))
                end
            end
        end
    end)

    RegisterNetEvent('redm_weapon_maintenance:vorp:updateWeaponProps', function (weaponName, weaponId, weaponProps)
        local _source = source
        local User = VorpCore.getUser(_source)

        if User then
            local Character = User.getUsedCharacter

            if Character then
                local identifier = Character.identifier

                if identifier then
                    exports.ghmattimysql:execute('UPDATE loadout_props SET permDegradation = @permDegradation, degradation = @degradation, damage = @damage, dirt = @dirt, soot = @soot, isJammed = @isJammed WHERE id = @id' , {
                        ['id'] = weaponId,
                        ['permDegradation'] = NormalizeFloat(weaponProps.permDegradation),
                        ['degradation'] = NormalizeFloat(weaponProps.degradation),
                        ['damage'] = NormalizeFloat(weaponProps.damage),
                        ['dirt'] = NormalizeFloat(weaponProps.dirt),
                        ['soot'] = NormalizeFloat(weaponProps.soot),
                        ['isJammed'] = BoolToInt(weaponProps.isJammed)
                    })

                    printd('[VORP] %s updated weapon %i (permDegradation: %s, degradation: %s, damage: %s, dirt: %s, soot: %s, isJammed: %s).', GetPlayerName(_source), weaponId, weaponProps.permDegradation, weaponProps.degradation, weaponProps.damage, weaponProps.dirt, weaponProps.soot, weaponProps.isJammed)
                end
            end
        end
    end)

    RegisterNetEvent('syn_weapons:weaponused', function(data)
        local _source = source
        local id = data.id
        local hash = data.hash

        exports.ghmattimysql:execute('SELECT permDegradation, degradation, damage, dirt, soot, isJammed FROM loadout_props WHERE id = @id' , {['id'] = id}, function(result)
            result = result[1]

            if not result then
                result = { permDegradation = 0.0, degradation = 0.0, damage = 0.0, dirt = 0.0, soot = 0.0 }

                exports.ghmattimysql:execute('INSERT INTO loadout_props (id) VALUES (@id)' , {
                    ['id'] = id,
                }, function (done)
                    if not done then
                        return printe('[VORP] %s tried to create weapon (%s) entry in DB.', GetPlayerName(_source), id)
                    end

                    printd('[VORP] %s created weapon (%s) entry in DB.', GetPlayerName(_source), id)
                end)
            end

            TriggerClientEvent('redm_weapon_maintenance:vorp:useWeapon', _source, id, hash, {
                permDegradation = NormalizeFloat(result.permDegradation),
                degradation = NormalizeFloat(result.degradation),
                damage = NormalizeFloat(result.damage),
                dirt = NormalizeFloat(result.dirt),
                soot = NormalizeFloat(result.soot),
                isJammed = IntToBool(result.isJammed)
            })
        end)
    end)

    local transactions = {}
    local IsTransactionActive = function(weaponId)
        for index, data in ipairs(transactions) do
            if data.weaponId == weaponId then
                return true
            end
        end

        return false
    end

    local FindMatchingTransaction = function(weaponName, nextPropietary)
        for index, data in ipairs(transactions) do
            if data.weaponName == weaponName then
                if data.type == 'give' or data.type == 'pickup' then
                    if data.nextPropietary == nextPropietary then
                        return data.weaponId, index
                    end
                end

                return data.weaponId, index
            end
        end

        return nil
    end

    AddEventHandler('redm_weapon_maintenance:vorp:onGiveWeapon2', function (contExec, playerId, weaponId, targetPlayerId)
        if IsTransactionActive(weaponId) then
            return contExec()
        end

        TriggerEvent('redm_weapon_maintenance:vorp:getWeaponData', function (weaponData)
            local nextPropietary = GetPlayerIdentifierByType(targetPlayerId, 'steam', false)

            if nextPropietary then
                table.insert(transactions, {
                    type = 'give',
                    weaponId = weaponId,
                    weaponName = weaponData.name,
                    nextPropietary = nextPropietary
                })

                printd('[VORP] Created new transaction (type: %s, weaponId: %s, weaponName: %s, nextPropietary: %s).', 'give', weaponId, weaponData.name, nextPropietary)
            end

            contExec()
        end, weaponId)
    end)

    RegisterNetEvent('vorpinventory:onPickup', function (obj)
        local _source = source

        TriggerEvent('redm_weapon_maintenance:vorp:getItemPickUpsData', function (itemPickUp)
            if (not itemPickUp) or (itemPickUp.weaponid == 1) or (IsTransactionActive(itemPickUp.weaponid)) then
                return
            end

            TriggerEvent('redm_weapon_maintenance:vorp:getWeaponData', function (weaponData)
                local nextPropietary = GetPlayerIdentifierByType(_source, 'steam', false)

                if nextPropietary then
                    table.insert(transactions, {
                        type = 'pickup',
                        weaponId = itemPickUp.weaponid,
                        weaponName = weaponData.name,

                        nextPropietary = nextPropietary
                    })

                    printd('[VORP] Created new transaction (type: %s, weaponId: %s, weaponName: %s, nextPropietary: %s).', 'pickup', itemPickUp.weaponid, weaponData.name, nextPropietary)
                end
            end, itemPickUp.weaponid)
        end, obj)
    end)

    AddEventHandler('syn_weapons:registerWeapon', function (weaponId)
        local transaction_promise = promise.new()

        TriggerEvent('redm_weapon_maintenance:vorp:getWeaponData', function (weaponData)
            local oldWeaponId, index = FindMatchingTransaction(weaponData.name, weaponData.propietary)

            if oldWeaponId and index then
                exports.ghmattimysql:execute('UPDATE loadout_props SET id = @newId WHERE id = @id' , {
                    ['id'] = oldWeaponId,
                    ['newId'] = weaponId
                })

                table.remove(transactions, index)
                transaction_promise:resolve(1)

                return printd('[VORP] Restored weapon %i props using transaction.', weaponId, oldWeaponId)
            end

            transaction_promise:resolve(0)
        end, weaponId)

        if Config.EnableSynScriptsCompatibility then
            local restoredFromTransaction = (Citizen.Await(transaction_promise) == 1)

            exports.ghmattimysql:execute('SELECT comps FROM loadout WHERE id = @id' , {['id'] = weaponId}, function(result)
                result = result[1]
                if not result then
                    return
                end

                local newComps = {}

                local oldComps = json.decode(result.comps)
                if oldComps then
                    newComps = oldComps

                    if not restoredFromTransaction then
                        local oldWeaponId = oldComps['_ID']

                        if oldWeaponId and oldWeaponId ~= weaponId then
                            exports.ghmattimysql:execute('UPDATE loadout_props SET id = @newId WHERE id = @id' , {
                                ['id'] = oldWeaponId,
                                ['newId'] = weaponId
                            })

                            printd('[VORP] Restored weapon %i props using comps.', weaponId)
                        end
                    end
                end

                newComps['_ID'] = weaponId

                exports.ghmattimysql:execute("UPDATE loadout Set comps = @comps WHERE id = @id", { ['id'] = weaponId, ['comps'] = json.encode(newComps) })

                printd('[VORP] Updated weapon %i comps _ID field.', weaponId)
            end)
        end
    end)

    if Config.EnableGunOilCheck then
        Citizen.CreateThread(function ()
            if not VorpInv.getDBItem(nil, Config.GunOilItemName) then
                printe('[VORP] Gun oil item (%s) not found in database!', Config.GunOilItemName)
            end
        end)

        RegisterNetEvent('redm_weapon_maintenance:vorp:requestGunOil', function ()
            local _source = source
            local itemCount = VorpInv.getItemCount(_source, Config.GunOilItemName)

            TriggerClientEvent('redm_weapon_maintenance:vorp:updateGunOil', _source, (itemCount > 0))
        end)

        RegisterNetEvent('redm_weapon_maintenance:vorp:removeGunOil', function ()
            local _source = source
            local itemCount = VorpInv.getItemCount(_source, Config.GunOilItemName)

            if itemCount > 0 then
                VorpInv.subItem(_source, Config.GunOilItemName, 1)
            end
        end)
    end

    if Config.EnableSynScriptsCompatibility then
        RegisterCommand('rwm_initweaponsid', function (source)
            if not (source == 0) then
                return printe('[VORP] Command /rwm_initweaponsid must be used in the server console.')
            end

            exports.ghmattimysql:execute('SELECT id, comps FROM loadout' , {}, function(result)
                local initializedWeapons = 0

                for _, data in ipairs(result) do
                    local newComps = {}

                    local oldComps = json.decode(data.comps)
                    if oldComps then
                        newComps = oldComps
                    end

                    if not newComps['_ID'] then
                        newComps['_ID'] = data.id

                        exports.ghmattimysql:execute("UPDATE loadout Set comps = @comps WHERE id = @id", { ['id'] = data.id, ['comps'] = json.encode(newComps) })

                        initializedWeapons = initializedWeapons + 1
                    end
                end

                printd('[VORP] Initialized _ID field for %i weapons!', initializedWeapons)
            end)
        end)
    end
end

GetPlayerIdentifierByType = function(source, type, sub)
    local identifiers = GetPlayerIdentifiers(source)

    for i = 1, #identifiers do
        if identifiers[i]:match(type .. ':') then
            if sub then
                return identifiers[i]:sub(type:len() + 2, identifiers[i]:len())
            end

            return identifiers[i]
        end
    end

    return nil
end

NormalizeFloat = function(float)
    if float == 1.0 then
        float = 1
    elseif float == 0.0 then
        float = 0
    end

    return float
end

IntToBool = function(value)
    return (value == 1 and true) or (value == 0 and false)
end

BoolToInt = function(value)
    return (value == true and 1) or (value == false and 0)
end