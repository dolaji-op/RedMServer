IsAnyIntegrationEnabled = function()
    return not (Config.UseIntegration == nil or Config.UseIntegration == false)
end

printd = function(str, ...)
    if not Config.Debug then
        return
    end

    print('\n[DEBUG] ' .. str:format(...))
end

printw = function(str, ...)
    print('\n[WARN] ' .. str:format(...))
end

printe = function(str, ...)
    print('\n[ERROR] ' .. str:format(...))
end

if Config.UseIntegration == 'redemrp' then
    printw('Resource started with RedEM:RP framework integration.')
elseif Config.UseIntegration == 'vorp' then
    printw('Resource started with VORP framework integration.')

    if Config.EnableSynScriptsCompatibility then
        printw('Syn scripts compatibility is enabled.')
    end
end

if not IsAnyIntegrationEnabled() and Config.EnableGunOilCheck then
    printw('Gun oil item requirement is only available in RedEM:RP or VORP integration.')
end

if not IsAnyIntegrationEnabled() and Config.EnableWeaponMalfunctions then
    printw('Weapon malfunctions is only available in RedEM:RP or VORP integration.')
end

if not (Config.UseIntegration == 'vorp') and Config.EnableSynScriptsCompatibility then
    printw('Syn scripts compatibility is only available in VORP integration.')
end