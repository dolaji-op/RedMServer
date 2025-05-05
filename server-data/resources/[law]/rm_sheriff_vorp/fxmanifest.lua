fx_version "adamant"

games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

author 'ss' -- 
description 'ss Sheriff'
version '1.3 VORP'



ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/img/*.png',
	'html/script.js',
	'not.js'
}

client_scripts {
	'config.lua',
	'client.lua',
	'not.js',
	'handcuffs/cl_handcuffs.lua'
}

server_scripts {
	'config.lua',
	'server.lua',
	'not.js',
	'handcuffs/sv_handcuffs.lua'
}
