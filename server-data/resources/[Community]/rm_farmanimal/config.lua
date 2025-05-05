Config = {}


Config.ssDog = true

Config.MenuJob = false-- {"farmer","unemployed", "animal_keeper"} --for no job: Config.MenuJob = false

Config.AnimalLevel = {
    [1] = {
        ["Scale"] = 0.5,
        ["MoneyOdds"] = 0.1,
    },
    [2] = {
        ["Scale"] = 0.55,
        ["MoneyOdds"] = 0.2,
    },
    [3] = {
        ["Scale"] = 0.6,
        ["MoneyOdds"] = 0.3,
    },
    [4] = {
        ["Scale"] = 0.65,
        ["MoneyOdds"] = 0.4,
    },
    [5] = {
        ["Scale"] = 0.7,
        ["MoneyOdds"] = 0.5,
    },
    [6] = {
        ["Scale"] = 0.75,
        ["MoneyOdds"] = 0.6,
    },
    [7] = {
        ["Scale"] = 0.8,
        ["MoneyOdds"] = 0.7,
    },
    [8] = {
        ["Scale"] = 0.85,
        ["MoneyOdds"] = 0.8,
    },
    [9] = {
        ["Scale"] = 0.9,
        ["MoneyOdds"] = 0.9,
    },
    [10] = {
        ["Scale"] = 0.95,
        ["MoneyOdds"] = 1.1,
    },
    [11] = {
        ["Scale"] = 1.0,
        ["MoneyOdds"] = 1.3,
    },
    [12] = {
        ["Scale"] = 1.05,
        ["MoneyOdds"] = 1.5,
    },
    [13] = {
        ["Scale"] = 1.15,
        ["MoneyOdds"] = 1.7,
    },
    [14] = {
        ["Scale"] = 1.2,
        ["MoneyOdds"] = 2.0,
    },
    [15] = {
        ["Scale"] = 1.25,
        ["MoneyOdds"] = 2.2,
    },
}

Config.Options = {
    ["ControlKey"] = 0x760A9C6F, -- [U] for shop
    ["MaxAnimals"] = 10,
    ["AnimalControls"] = {
        ["Graze"] = {'eat grass',0x05CA7C52},
        ["Follow"] = {"Follow",0xA65EBAB4},
        ["Home"] = {'Farm house',0x6319DB71},
        ["Herd"] = {'Herd animal',0xDEB34313},
    },
    ["BlipEnable"] = true,
    ["ShopBlipName"] = "Animal Shop",
    ["ShopBlipSprite"] =  423351566,
    ["ButcherySprite"] = 218395012,
    ["GrazeTime"] = 20, --seconds for grazing function. Animal gets xp after finishing grazeing
    ["GrazeXP"] = 5,
    ["GrazeXPs"] = {
        ["Bull"] = 1,
        ["Ox"] = 1,
        ["Chicken"] = 20,
        ["Cow"] = 1,
        ["Goat"] = 10,
        ["Sheep"] = 10,
        ["Pig"] = 10,
        ["Rooster"] = 20,
        ["Turkey"] = 10,
        ["Rabbit"] = 15,
    },
    ["Messages"] = {
        ["AnimalSpawned"] = "Your Farm animal has already spawned!",
        ["AnimalHere"] = "Your Farm animal spawned. ",
        ["AnimalGrazing"] = "Your animal is grazing already!",
        ["AnimalBusy"] = "Your animal is not listen to you!",
        ["GrazeError"] = " farm Animals cant Heard in towns and cities!",
        ["AnimalHome"] = "You sent your farm animal back to home!",
        ["AnimalSold"] = "You sold an farm animal!",
        ["NoAnimal"] = "There is no farm animal near the Butchery!",
        ["BoughtAnimal"] = "You bought an farm animal!",
        ["NoMoney"] = "You dont have money!",
        ["AnimalShop"] = "Farm Animal Shop",
        ["NoJob"] = "You dont have the reqiured job!",
        ["ssDogs"] = {
            ["GuardSuccess"] = "Your farm animal finished Grow  and started again, because of your skilled dog!",
            ["FinishedGraze"] = "Your farm animal now Growing, and started wandering!",
            ["GuardFail"] = "Your farm animal finished grazing.~n~You dog is not skilled to guard it, animal is wandering.",
        },
    },
    ["MenuTexts"] = {
        ["Butchery"] = "Butchery",
        ["SellSubText"] = "Sell Animals",
        ["SellBtn"] = "Sell",
        ["Title"] = "Farm Animals",
        ["SubText"] = "Options",
        ["OwnedAnimals"] = "Your Farm Animals",
        ["OwnedDesc"] = "Your Animals",
        ["Chickens"] = "Chickens",
        ["Roosters"] = "Roosters",
        ["Turkeys"] = "Turkeys",
        ["Rabbits"] = "Rabbits",
        ["Goats"] = "Goats",
        ["Pigs"] = "Pigs",
        ["Sheeps"] = "Sheeps",
        ["Cows"] = "Cows",
        ["Bulls"] = "Bulls",
    },
    ["MenuOptions"] = {
        ["ChooseAnimal"] = "Take Farm animal with you",
        ["ChooseAnimalSub"] = "Choose your farm animal",
        ["DeleteAnimal"] = "Free Animal",
        ["DeleteAnimalSub"] = "flee your animal",
        ["Chickens"] = {
            [1] = "Leghorn Chicken",
            [2] = "Dominique Chicken",
            [3] = "Java Chicken",
        },
        ["Roosters"] = {
            [1] = "Dominique Rooster",
            [2] = "Java Rooster",
        },
        ["Turkeys"] = {
            [1] = "Turkey",
        },
        ["Rabbits"] = {
            [1] = "Grey Rabbit",
            [2] = "Rabbit",
            [3] = "White Rabbit",
        },
        ["Goats"] = {
            [1] = "White  Goat",
            [2] = "Black  Goat",
        },
        ["Pigs"] = {
            [1] = "China Pig",
            [2] = "Berkshire Pig",
            [3] = "Old Spot Pig",
        },
        ["Sheeps"] = {
            [1] = "Grey Sheep",
            [2] = "White Sheep",
            [3] = "Black Sheep",
        },
        ["Cows"] = {
            [1] = "Cow (Brown-White)",
            [2] = "Cow (Dark Brown)",
            [3] = "Cow (Brown White)",
            [4] = "Cow (Light)",
            [5] = "Cow (Black White)",
            [6] = "Cow (White Brown)",
            [7] = "Cow (Black White)",
            [8] = "Cow (Light)",
            [9] = "Cow (White Black)",
            [10] = "Cow (Black White)",
            [11] = "Cow (Albino)",
            [12] = "Cow (Dark Brown)",
            [13] = "Cow (Black)", 
        },
        ["Bulls"] = {
            [1] = "Devon Ox",
            [2] = "Angus Ox",
            [3] = "Hereford Bull",
            [4] = "Devon Bull",
            [5] = "Angus Bull",
         
            
        },
    },
   
}

Config.NPCS = {
    { -- farm animal seller valentine
        coords = vector4(1373.15, 301.24, 86.89, 247.03), -- Npc coordinates
        model = 'a_m_m_emrfarmhand_01', -- Npc model
        weapon = false,
        outfit = false,
        scenario = false,
        anim = { animDict = false, animName = '' }, 
        scale = false,
    },
    { -- farm animal seller emerald
        coords = vector4(-1792.99, -582.97, 154.83, 64.92), -- Npc coordinates
        model = 'a_m_m_farmtravelers_cool_01', -- Npc model
        weapon = false,
        outfit = false,
        scenario = false,
        anim = { animDict = false, animName = '' }, 
        scale = false,
    },
    { -- farm animal seller strawberry
        coords = vector4(-2400.34, -2458.5, 59.12, 31.75), -- Npc coordinates
        model = 'a_m_m_farmtravelers_warm_01', -- Npc model
        weapon = false,
        outfit = false,
        scenario = false,
        anim = { animDict = false, animName = '' },
        scale = false,
    },
    { -- farm animal seller mcfarlane
        coords = vector4(-275.16, 659.89, 112.38, 298.54), -- Npc coordinates
        model = 'mp_u_m_m_nat_farmer_04', -- Npc model
        weapon = false, 
        outfit = false, 
        scenario = false, 
        anim = { animDict = false, animName = '' },
        scale = false,
    },
    { -- farm animal seller buyer
    coords = vector4(2125.36, -1308.05, 42.83, 230.47), -- Npc coordinates
    model = 's_m_m_unibutchers_01', -- Npc model
    weapon = false, 
    outfit = 9, 
    scenario = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE', 
    anim = { animDict = false, animName = '' },
    scale = false,
   },
   { -- farm animal seller buyer kamsa river
   coords = vector4(2075.06, 1000.12, 111.5, 270.32), -- Npc coordinates
   model = 'u_m_m_valbutcher_01', -- Npc model
   weapon = false, 
   outfit = 5, 
   scenario = 'WORLD_HUMAN_CLEAN_TABLE', 
   anim = { animDict = false, animName = '' },
   scale = false,
  },
  { -- farm animal seller buyer kamsa river
   coords = vector4(-929.19, -1388.51, 48.9, 141.91), -- Npc coordinates
   model = 'u_m_m_valbutcher_01', -- Npc model
   weapon = false, 
   outfit = 9, 
   scenario = 'WORLD_HUMAN_CLEAN_TABLE', 
   anim = { animDict = false, animName = '' },
   scale = false,
  },
  { -- farm animal seller buyer kamsa river
   coords = vector4(-1397.54, -2329.43, 42.75, 107.93), -- Npc coordinates
   model = 'u_m_m_valbutcher_01', -- Npc model
   weapon = false, 
   outfit = 12, 
   scenario = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE', 
   anim = { animDict = false, animName = '' },
   scale = false,
  },
  { -- farm animal seller buyer kamsa river
  coords = vector4(1420.7, -1302.33, 76.60, 207.98), -- Npc coordinates
  model = 'a_m_m_emrfarmhand_01', -- Npc model
  weapon = false, 
  outfit = false, 
  scenario = false, 
  anim = { animDict = false, animName = '' },
  scale = false,
 }
  
}

Config.AnimalPrices = {
    [1] = 30,
    [2] = 30, 
    [3] = 30,
    [4] = 30,
    [5] = 30,
    [6] = 30,
    [7] = 30,
    [8] = 30,
    [9] = 35,
    [10] = 60,
    [11] = 60,
    [12] = 60,
    [13] = 60,
    [14] = 60,
    [15] = 60,
    [16] = 60,
    [17] = 60,
    [18] = 90,
    [19] = 90,
    [20] = 90,
    [21] = 90,
    [22] = 90,
    [23] = 90,
    [24] = 90,
    [25] = 90,
    [26] = 90,
    [27] = 90,
    [28] = 90,
    [29] = 90,
    [30] = 90,
    [31] = 100,
    [32] = 100,
    [33] = 100,
    [34] = 100,
    [35] = 100,
    [36] = 100,

    
}