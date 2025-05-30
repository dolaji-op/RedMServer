fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'


client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

shared_scripts {
    'config.lua',
    'locale.lua',
    'languages/*.lua'
}

ui_page {
    "ui/dist/index.html"
}

files {
    "ui/dist/index.html",
    "ui/dist/js/*.*",
    "ui/dist/css/*.*",
    "ui/dist/fonts/*.*",
    "ui/dist/img/*.*",
    "ui/dist/style.css"
}

version '1.0.1'