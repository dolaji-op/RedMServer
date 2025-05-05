fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'




shared_scripts {
	'config.lua',
}

client_script {
	'client/dataview.lua',
	'client/natives.lua',
	'client/functions.lua',
	'client/client.lua',
}

server_script {
	'server/main.lua',
}



lua54 'yes'