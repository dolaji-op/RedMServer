fx_version "adamant"
games { "rdr3" }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'VORP edit by RobiZona#0001'
description 'Bank system VORP'

shared_scripts {
    'shared/language.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/services.lua',
    'server/server.lua',
}

dependencies {
	'vorp_core',
	'vorp_inventory'
}

--dont touch
version '1.6'
vorp_checker 'no'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_banking'
