fx_version "adamant"
game "rdr3"

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

dependency 'objectloader'

files {
	'Deleting_taxidermist_objects.xml',
	'Taxidermist_museum.xml'
}

objectloader_maps {
	'Deleting_taxidermist_objects.xml',
	'Taxidermist_museum.xml'
}

client_script {
	'interiors.lua',
  }