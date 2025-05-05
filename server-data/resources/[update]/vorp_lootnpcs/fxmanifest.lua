fx_version "cerulean"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"

exports {
    'DataViewNativeGetEventData2'
}

client_scripts {
    'client/client.lua',
    'client/client.js'
}

shared_script {
    'shared/translation.lua',
    'config.lua'
}

server_script {
    'server/server.lua'
}

dependencies {
    'vorp_core',
    'vorp_inventory'
}

author 'refactor by @outsider31000'
lua54 'yes'
version '1.3'
