fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"
author 'VORP @blue'
lua54 'yes'

file 'wepcomps.json'

client_script {
  'client/warmenu.lua',
  'client/client.lua'
}
server_script {
  'server/server.lua'
}
shared_scripts {
  'config/shops.lua',
  'config/weapons.lua',
  'config/language.lua',
  'config/ammo.lua',
  'config/config.lua'
}

--dont touch
version '2.1'
vorp_checker 'no'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_weaponsv2'
