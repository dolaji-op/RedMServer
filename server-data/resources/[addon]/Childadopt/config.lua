-- Based on Malik's and Blue's animal shelters and vorp animal shelter --


Config = {}

Config.Locale = "en"

Config.TriggerKeys = {
    OpenShop = 'E',
    CallPet = 'G'
}

Config.CallPetKey = false

Config.Shops = {
    {
        Name = 'Orphan',
        Ring = false,
        ActiveDistance = 5,
        Coords = {
            vector3(2506.34, -1161.57, 50.01)
        },
        Spawndog = vector4(2513.92, -1169.25, 50.16, 90.03),
        Blip = { sprite = 1183081869, x = 2505.57, y = -1161.81, z = 49.53}
    }
}

Config.PetAttributes = {
    FollowDistance = 5,
    Invincible = true,
    SpawnLimiter = 2 -- set to 0 if you do not want a spawn limiter
}

-- Pets availability will only be limited if the object exists in the pet config.
Config.Pets = {
   
    {
        Text = "$1000 - Adopt a Child (girl)",
        SubText = "",
        Desc = "Poor child lost her mother in the fires.",
        Param = {
            Price = 1000,
            Model = "CS_GERMANDAUGHTER",
            Level = 1
        }
    },
    {
        Text = "$1000 - Adopt a Child (boy)",
        SubText = "",
        Desc = "Poor child lost his parents.",
        Param = {
            Price = 1000,
            Model = "cs_germanson",
            Level = 1
        }
    },
    {
        Text = "$1000 - Adopt a Teen Child (boy)",
        SubText = "",
        Desc = "Poor child",
        Param = {
            Price = 1000,
            Model = "cs_mixedracekid",
            Level = 1
        }
    },
    {
        Text = "$1000 - Adopt a Street Child",
        SubText = "",
        Desc = "Poor child grew up in the streets.",
        Param = {
            Price = 1000,
            Model = "a_m_y_nbxstreetkids_01",
            Level = 1
        }
    }
}

Config.Keys = {["B"] = 0x4CC0E2FE, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9, ["J"] = 0xF3830D8E }

Config.NPCS = {
    { -- 
        coords = vector4(2507.66, -1166.58, 49.11, 335.27), 
        model = 'S_M_M_StrLumberjack_01', -- Npc model
        weapon = false, 
        outfit = false, 
        scenario = 'PROP_HUMAN_REPAIR_WAGON_WHEEL_ON_LARGE', 
        anim = { animDict = false, animName = '' }, 
        scale = false, -- 
    },
    { -- 
        coords = vector4(2509.65, -1156.85, 49.26, 186.57), 
        model = 'S_M_M_StrLumberjack_01', 
        weapon = false, 
        outfit = false, --
        scenario = 'PROP_HUMAN_REPAIR_WAGON_WHEEL_ON_LARGE', 
        anim = { animDict = false, animName = '' }, 
        scale = false, 
    },
    { -- 
        coords = vector4(2505.30, -1165.05, 48.22, 75.91), 
        model = 'cs_sd_streetkid_01', 
        weapon = false, 
        outfit = false, --
        scenario = 'PROP_HUMAN_SEAT_CRATE_CLEAN_BOOTS', 
        anim = { animDict = false, animName = '' }, 
        scale = false, 
    },
    { -- 
        coords = vector4(2506.54, -1161.49, 48.30, 108.46), 
        model = 'mes_finale2_females_01', 
        weapon = false, 
        outfit = 8, 
        scenario = 'PROP_HUMAN_SEAT_CHAIR_SEWING', 
        anim = { animDict = false, animName = '' }, 
        scale = false, -- 
    },
    { -- 
    coords = vector4(2506.63, -1162.49, 48.30, 108.46), 
    model = 'a_m_y_nbxstreetkids_01', 
    weapon = false, 
    outfit = 8, 
    scenario = 'PROP_HUMAN_SEAT_CHAIR_READ_NEWSPAPER_TRAIN', 
    anim = { animDict = false, animName = '' }, 
    scale = false, -- 
}
    
}
