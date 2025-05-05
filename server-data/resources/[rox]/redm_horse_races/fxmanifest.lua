
fx_version 'cerulean'
game 'rdr3'
lua54 'yes'



rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
    'config.lua',
    'shared/utils.lua'
}

server_scripts {
    'server/main.lua',
    'server/commands.lua'
}

client_scripts {
    'client/structs.js',
    'client/utils.lua',
    'client/main.lua'
}

escrow_ignore {
  	'config.lua',
    'shared/utils.lua',
    'server/main.lua',
    'server/commands.lua',
    'client/utils.lua',
    'client/main.lua'
}
dependency '/assetpacks'