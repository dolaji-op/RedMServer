fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'

client_scripts {
	'client/client.lua',
	'client/dataview.lua'
}

server_scripts {
	'server/server.lua'
}

shared_scripts {
	'config.lua',
	'locale.lua',
	'languages/*.lua'
}

version '1.0.3'