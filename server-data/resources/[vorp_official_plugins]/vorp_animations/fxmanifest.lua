fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'
author 'Bytesizd'

client_scripts {
    'client/client.lua'

}

shared_scripts {
    'config.lua'
}

files {
    'ui/*',
    'ui/assets/*',
    'ui/assets/fonts/*'
}

ui_page 'ui/index.html'

export "initiate"

--dont touch
version '1.0'
-- vorp_checker 'no'
-- vorp_name '^4Resource version Check^3'
-- vorp_github 'https://github.com/VORPCORE/vorp_animations'
