Config = {}

---------------- Main Setup ------------------------
Config.RobberyCommand = 'robbery' --command to enter to enable robberies
Config.RobberyCooldown = 30000 --This is the cooldown in ms for each robbery meaning once a place is robbed you have to wait this long to rob it again

--These are jobs that will not be able to do robberies
Config.NoRobberyJobs = { --add as many as you want just copy paste a table
    {jobname = 'police'},
    {jobname = 'sheriff'},
}

Config.PoliceAlert = {
    enabled = true,
    Job = 'police',
    AlertMssg = 'Robbery In Progress!',
    ShowMssgTime = 30000,
    BlipTime = 60000
}

--Lockpicking setup
Config.LockPick = {
    MaxAttemptsPerLock = 3,
    lockpickitem = 'lockpick',
    difficulty = 10,
    hintdelay = 500,
    pins = { -- hardcoded pins, if randomPins set to true, then this will be ignored.
        {
            deg = 25 -- 0-360 degrees
        },
        {
            deg = 0 -- 0-360 degrees
        },
        {
            deg = 300 -- 0-360 degrees
        }
    },
    randomPins = true --If random is set to True, then pins above will be ignored.
}

-- Main robbery setup
Config.Robberies = {
    {
        Id = 1, --this has to be unique to each robbery
        StartingCoords = {x = -322.36, y = 804.46, z = 117.88}, --coords you have to be near to start the robbery
        EnemyNpcs = true, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 30000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
            {
                LootCoordinates = {x = -325.31, y = 797.8, z = 117.88}, --coordinates of the loot box
                CashReward = 150, --amount of cash to reward set 0 for none
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --name of the item in the database
                        count = 1, --the amount of the item to give
                    },
                    {
                        name = 'water',
                        count = 2,
                    },
                },
            },
            {
                LootCoordinates = {x = -321.22, y = 805.86, z = 117.88}, --coordinates of the loot box
                CashReward = 1000, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },
        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -328.78, y = 804.74, z = 117.89}, --coords the peds will spawn at
            {x = -327.43, y = 803.71, z = 118.36},
            {x = -320.16, y = 795.24, z = 117.89},
        },
    },
    {
        Id = 2, --this has to be unique to each robbery
        StartingCoords = {x = -307.49, y = 778.03, z = 118.7}, --coords you have to be near to start the robbery
        EnemyNpcs = false, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 60000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
            {
                LootCoordinates = {x = -301.89, y = 772.2, z = 118.7}, --coordinates of the loot box
                CashReward = 10, --amount of cash to reward set 0 for none
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --name of the item in db
                        count = 1, --amount to give
                    },
                },
            },
        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -325.04, y = 797.18, z = 117.88}, --coords the ped will spawn
            {x = -320.61, y = 803.24, z = 117.88},
            {x = -310.99, y = 777.9, z = 118.72},
            {x = -302.85, y = 774.35, z = 118.7},
        },
    },
    {
        Id = 4, --this has to be unique to each robbery   --- valentine store robbery
        StartingCoords = {x = 2641.23, y = -1285.87, z = 52.25}, --coords you have to be near to start the robbery
        EnemyNpcs = true, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 30000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
            {
                LootCoordinates = {x = 2640.94, y = -1301.95, z = 52.25}, --coordinates of the loot box 
                CashReward = 0, --amount of cash to reward set 0 for none
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'diamond', --name of the item in the database
                        count = 1, --the amount of the item to give
                    },
                    {
                        name = 'goldnugget',
                        count = 2,
                    },
                },
            },
            {
                LootCoordinates = {x = 2643.02, y = -1305.54, z = 52.25}, --coordinates of the loot box
                CashReward = 1000, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'goldnugget', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },
            {
                LootCoordinates = {x = 2645.36, y = -1305.57, z = 52.25}, --coordinates of the loot box
                CashReward = 1000, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'goldnugget', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },
        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
        {x = 2637.83, y = -1298.88, z = 52.25}, --coords the peds will spawn at
        {x = 2637.64, y = -1300.74, z = 51.88},
        {x = 2635.2, y = -1285.28, z = 52.28},
        {x = 2648.84, y = -1281.62, z = 52.28},
        {x = 2650.32, y = -1284.02, z = 52.28},
        {x = 2647.71, y = -1283.44, z = 52.25},

        },
    },
}

------------------- Translate Here -----------------------
Config.Language = {
    RobberyStart = 'Robbery Started!',
    OnCooldown = 'This has been robbed recently!',
    LootMarked = 'Begin Looting!',
    HoldOutBeforeLooting = 'Wait',
    HoldOutBeforeLooting2 = 'Minutes Before Looting',
    RobberyFail = 'Robbery Failed!',
    Rob = 'LockPick',
    Robbery = 'LockBox',
    PickFailed = 'Lockpicking Failed Lock Broken',
    RobberyEnable = 'Robberies enabled shoot a gun, at a valid location to start a robbery!',
    RobberyDisable = 'Robberies Disabled',
    WrongJob = 'You can not start robberies due to your job!',
    YouGotPay = 'you got something !',
}