Config = {}
Config.Debug = false
Config.EnablePrompt = true

Config.Keys = {
	enter = "INPUT_FRONTEND_RB",
}

Config.Price = 30

Config.Locations = {
	{
		pedCoords = vector4(2781.9165039062, -1522.8715820312, 45.820667266846, 31.38),
		pedModel = `s_m_m_sdticketseller_01`, --model of the tailor ped
		blip = true, --if the blip is displayed for this store
		distancePrompt = 2.0, --distance to display the prompt
		needInstance = true,
		name = "guarma",

	},

	{
		pedCoords = vector4(1276.0483398438, -6855.23046875, 43.319633483887, 0.0),
		pedModel = `u_m_m_sdtrapper_01`, --model of the tailor ped
		distancePrompt = 2.0, --distance to display the prompt
		needInstance = true,
		name = "hanover",

	},
}
