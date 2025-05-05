Config = {}


Config.defaultlang = "en_lang" -- Set Language (Current Languages: "en_lang" English, "de_lang" German, "ro_lang" Romanian)

-----------------------------------------------------------------------------------
---------------------------------ID Settings----------------------------------
-----------------------------------------------------------------------------------

Config.AusweisBlips = true
Config.CreateNPC = true
Config.Show3dText = true
Config.AusweisLocations = {

    {
        coords = vector3(-183.36, 630.16, 114.09),   --- Also the Location of Blip and Npc (Valentine)
        NpcHeading = 114.86,
    },

}

Config.AusweisPreis = 15
Config.AusweisVerlorenPreis = 20
Config.ChangeFotoPreis = 10

Config.JobLockHunting = false
Config.Command = 'createhuntingid' -- Command TO Popup HunterLicense Menü
Config.Jobs =  {
    {JobName = 'hunter'},
}
Config.HuntingLicensePrice = 10
Config.HuntingLicenseVerlorenPrice = 30
Config.HuntingIdPicture = 'https://i.postimg.cc/KvJYFgW5/jagt.png' -- <-- Picture of Directlink from  https://postimg.cc Readme for Picture Info
