fx_version "adamant"
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


-- Client Scripts
client_scripts {
	'client/dataview.lua',
	'client/client.lua',
	'config.lua',
	'client/cloth_hash_names.lua',
}

shared_scripts {
	'config.lua',
	'shared/*.lua'
}

-- Server Scripts
server_scripts {
	'server/server.lua',
}

version '1.0'
vorp_checker 'no'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_barbershop_lua'
