fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"

client_script {
	'config.lua',
	'client.lua'

 }

server_script {
	'config.lua',
	'server.lua'

}

ui_page('html/index.html')

files({
	"html/script.js",
	"html/styles.css",
	"html/img/*.svg",
	"html/img/*.png",
	"html/index.html",
	
})

export 'StressaPlayer'