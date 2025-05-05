fx_version "adamant"

games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

author 'ss' 
description 'ss Prison'
version '1.1 VORP'



client_scripts {
   'config.lua',
   'client/cl_main.lua',
}

server_scripts {
   'config.lua',
   'server/sv_main.lua',
}
