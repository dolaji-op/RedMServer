Config = {}

Config.JobName = { -- Job Names for prison access.
	'sheriff',
	'police',
	'marshal',
}

Config.JailMenuCommand = 'jail' -- Open Prison Menu Command

-- Only use if u have https://github.com/VORPCORE/VORP-Metabolism plugin
Config.AddThirstAndHunger = true -- If This is enabled it will add Thrist and Hunger for the jailed player, this can prevent him from dying in jail if he has no Bread or Water item...
Config.AddThrist = 500 -- +500 Thrist if jailed. (Will be added just once he is jailed)
Config.AddHunger = 500 -- +500 Hunger if jailed. (Will be added just once he is jailed)

Config.ShowCellNumber3D = true -- If u want the cell number on doors 3D Text
Config.Coords3D = { -- 3D Text Coords for Cell Numbers
    [1] =  {
        ["Text"] = "Cell 1",
        ["Coords"] = { x = -272.23, y = 810.1, z = 119.39, r = 3.0 }, -- Valentine Cell 1
    },
    [2] =  {
        ["Text"] = "Cell 2",
        ["Coords"] = { x = -273.3, y = 808.12, z = 119.39, r = 3.0 }, -- Valentine Cell 2
    },
    [3] =  {
        ["Text"] = "Cell 1",
        ["Coords"] = { x = 1357.44, y = -1301.78, z = 77.71, r = 3.0 }, -- RHODES Cell 1
    },
    [4] =  {
        ["Text"] = "Cell 1",
        ["Coords"] = { x = 2502.42, y = -1307.85, z = 48.95, r = 3.0 }, -- SAINT DENIS Cell 1
    },
    [5] =  {
        ["Text"] = "Cell 2",
        ["Coords"] = { x = 2503.63, y = -1309.87, z = 48.95, r = 3.0 }, -- SAINT DENIS Cell 2
    },
    [6] =  {
        ["Text"] = "Cell 3",
        ["Coords"] = { x = 2499.75, y = -1309.87, z = 48.95, r = 3.0 }, -- SAINT DENIS Cell 3
    },
    [7] =  {
        ["Text"] = "Cell 4",
        ["Coords"] = { x = 2498.5, y = -1307.85, z = 48.95, r = 3.0 }, -- SAINT DENIS Cell 4
    },
    [8] =  {
        ["Text"] = "Cell 1",
        ["Coords"] = { x = -1814.58, y = -353.71, z = 161.43, r = 3.0 }, -- STRAWBERRY Cell 1
    },
    [9] =  {
        ["Text"] = "Cell 2",
        ["Coords"] = { x = -1811.40, y = -352.19, z = 161.39, r = 3.0 }, -- STRAWBERRY Cell 2
    },
    [10] =  {
        ["Text"] = "Cell 1",
        ["Coords"] = { x = -765.75, y = -1263.47, z = 44.3, r = 3.0 }, -- BLACKWATER Cell 1
    },
    [11] =  {
        ["Text"] = "Cell 2",
        ["Coords"] = { x = -763.53, y = -1263.71, z = 44.3, r = 3.0 }, -- BLACKWATER Cell 2
    },
}




Config.MaxPrisonDistance = 15 -- When a player is trying to glitch out from prison after the distance, he will be teleported back.

Config.Jail_1 = {
    { x = -273.47, y = 811.47, z = 118.32 } -- Valentine Cell 1
}

Config.Jail_2 = {
    { x = -271.73, y = 807.21, z = 118.32 } -- Valentine Cell 2
}

Config.Jail_3 = {
    { x = 1355.51, y = -1303.18, z = 76.70 } -- RHODES Cell 1
}

Config.Jail_4 = {
    { x = 2504.36, y = -1306.90, z = 47.90 } -- SAINT DENIS Cell 1
}

Config.Jail_5 = {
    { x = 2501.88, y = -1310.83, z = 47.90 } -- SAINT DENIS Cell 2
}

Config.Jail_6 = {
    { x = 2497.93, y = -1310.83, z = 47.90 } -- SAINT DENIS Cell 3
}

Config.Jail_7 = {
    { x = 2500.15, y = -1306.88, z = 47.90 } -- SAINT DENIS Cell 4
}

Config.Jail_8 = {
    { x = -1812.66, y = -355.53, z = 160.39 } -- STRAWBERRY Cell 1
}

Config.Jail_9 = {
    { x = -1809.86, y = -351.83, z = 160.39 } -- STRAWBERRY Cell 2
}

Config.Jail_10 = {
    { x = -766.54, y = -1262.65, z = 42.97 } -- BLACKWATER Cell 1
}

Config.Jail_11 = {
    { x = -762.61, y = -1264.26, z = 42.97 } -- BLACKWATER Cell 1
}

Config.ExitFromJail_VAL = { ["x"] = -277.02, ["y"] = 815.20, ["z"] = 118.17 } -- Valentine Exit Coords

Config.ExitFromJail_RH = { ["x"] = 1357.25, ["y"] = -1297.37, ["z"] = 75.79 } -- RHODES Exit Coords

Config.ExitFromJail_SD = { ["x"] = 2513.63, ["y"] = -1308.56, ["z"] = 47.91 } -- SAINT DENIS Exit Coords

Config.ExitFromJail_STR = { ["x"] = -1813.29, ["y"] = -343.49, ["z"] = 163.62 } -- STRAWBERRY Exit Coords

Config.ExitFromJail_BW = { ["x"] = -770.48, ["y"] = -1267.43, ["z"] = 42.52 } -- BLACKWATER Exit Coords