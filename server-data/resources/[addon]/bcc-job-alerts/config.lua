Config = {}
Config.Alerts = {
    {
        name = 'police', --The name of the alert
        command = 'alertpolice', -- the command, this is what players will use with /
        message = "Crime Reported!", -- Message to show to theh police
        messageTime = 40000, -- Time the message will stay on screen (miliseconds)
        job = "police", -- Job the alert is for
        jobgrade = { 0, 1, 2, 3 }, -- What grades the alert will effect
        icon = "star", -- The icon the alert will use
        hash = -1043855483, -- The radius blip
        radius = 40.0, -- The size of the radius blip
        blipTime = 60000, -- How long the blip will stay for the job (miliseconds)
        blipDelay = 5000, -- Delay time before the job is notified (miliseconds)
        originText = "Hang tight, the Sheriffs has been notified", -- Text displayed to the user who enacted the command
        originTime = 40000 --The time the origintext displays (miliseconds)
    },
    {
        name = 'police', --The name of the alert
        command = 'alertpolice', -- the command, this is what players will use with /
        message = "Crime Reported!", -- Message to show to theh police
        messageTime = 40000, -- Time the message will stay on screen (miliseconds)
        job = "sheriff", -- Job the alert is for
        jobgrade = { 0, 1, 2, 3 }, -- What grades the alert will effect
        icon = "star", -- The icon the alert will use
        hash = -1043855483, -- The radius blip
        radius = 40.0, -- The size of the radius blip
        blipTime = 60000, -- How long the blip will stay for the job (miliseconds)
        blipDelay = 5000, -- Delay time before the job is notified (miliseconds)
        originText = "Hang tight, the Sheriffs has been notified", -- Text displayed to the user who enacted the command
        originTime = 40000 --The time the origintext displays (miliseconds)
    },
    {
        name = 'Medical Assistance', --The name of the alert
        command = 'calldoctor', -- the command, this is what players will use with /
        message = "Someone needs medical assistance!", -- Message to show to theh police
        messageTime = 40000, -- Time the message will stay on screen (miliseconds)
        job = "doctor", -- Job the alert is for
        jobgrade = { 0, 1, 2, 3 }, -- What grades the alert will effect
        icon = "star", -- The icon the alert will use
        hash = -1043855483, -- The radius blip
        radius = 40.0, -- The size of the radius blip
        blipTime = 60000, -- How long the blip will stay for the job (miliseconds)
        blipDelay = 5000, -- Delay time before the job is notified (miliseconds)
        originText = "Hang tight, the medics have been notified", -- Text displayed to the user who enacted the command
        originTime = 40000 --The time the origintext displays (miliseconds)
    }
}