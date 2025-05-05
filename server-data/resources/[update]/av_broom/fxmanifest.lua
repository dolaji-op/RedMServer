fx_version "cerulean"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}
lua54 "yes"


client_scripts {
    'config.lua',
    'client.lua',
    'not.js'
}
files {'not.js'}

server_scripts {
    'config.lua',
    'server.lua',
    '@mysql-async/lib/MySQL.lua',
}
