Config = {}

Config.Options = {
    MinMoney = 5,
    MaxMoney = 30,
    WorkTimer = 60,--seconds
}

Config.Prompts = {
    Title = "Broom",
    StopPrompt = 0x5966D52A,
    StopName = "Stop",
    BroomPrompt = 0x39336A4F,
    BroomName = "Work",
}
Config.Towns = {
    `Tumbleweed`,
    `VANHORN`,
    `valentine`, 
    `Strawberry`, 
    `StDenis`, 
    `Emerald`, 
    `Rhodes`, 
    `Blackwater`,  
    `Armadillo`, 
}

Config.Messages = {
    Title = "Work - Broom",
    WrongArea = "You can work in towns only!",
    JobFinish = "You got your payment!",
    NoBroom = "You can not broom right now!",
}

--[[
    Items for redemrp_inventory 2.0
    ["broom"] =
    {
        label = "Broom",
        description = "Worktool",
        weight = 1.0,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 5,
        imgsrc = "items/broom.png",
        type = "item_standard",
    },
]]