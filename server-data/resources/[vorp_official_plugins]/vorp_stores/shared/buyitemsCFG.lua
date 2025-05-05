-- * BUY ITEMS * --

-- * TO ADD DECIMAL PRICES TO THE RANDOMPRICE DO IT LIKE THIST math.random(30, 50) / 100 >> this will equal to 0.30 to 0.50 or math.random(300, 500) / 100 will equal to 3.00 to 5.00

-- * THESE ARE JUST EXAMPLES YOU MUST CONFIGURE YOUR OWN STORES *--
Config.BuyItems = {
    Valentine = {

        {
            itemLabel = "Pick Axe",                  -- Label of the item
            itemName = "pickaxe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 5,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(3, 5), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Pocket Watch",                  -- Label of the item
            itemName = "pocket_watch",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 5,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(3, 5), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy Pocket Watch",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },


        {
            itemLabel = "Bag Of Coal",                  -- Label of the item
            itemName = "bagofcoal",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 5,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(3, 5), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy Bag Of Coal",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Train Oil",                  -- Label of the item
            itemName = "trainoil",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 5,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(3, 5), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy Train Oil",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Apple",
            itemName = "apple",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Water",
            itemName = "water",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "food",
            itemLimit = 10,
        },
        {
            itemLabel = "bandage",
            itemName = "bandage",
            currencyType = "cash",
            buyprice = 10,
            randomprice = math.random(5, 10),
            desc = "Buy bandage",
            category = "meds",
            itemLimit = 0,
        },
        {
            itemLabel = "salt",
            itemName = "salt",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy salt",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "veggies",
            itemName = "consumable_veggies",
            currencyType = "cash",
            buyprice = 4,
            randomprice = math.random(3, 5),
            desc = "Buy veggies",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "coffee",
            itemName = "consumable_coffee",
            currencyType = "cash",
            buyprice = 2,
            randomprice = math.random(1, 3),
            desc = "Buy coffee",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "peach",
            itemName = "peach",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy peach",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "greavy",
            itemName = "consumable_meat_greavy",
            currencyType = "cash",
            buyprice = 5,
            randomprice = math.random(3, 5),
            desc = "Buy greavy",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "eggs",
            itemName = "eggs",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy eggs",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "chocolate",
            itemName = "consumable_chocolate",
            currencyType = "cash",
            buyprice = 5,
            randomprice = math.random(3, 5),
            desc = "Buy chocolate",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Gun Oil",
            itemName = "gun_oil",
            currencyType = "cash",
            buyprice = 5,
            randomprice = math.random(3, 5),
            desc = "Buy Gun Oil",
            category = "tools",
            itemLimit = 0,
        },
    },

    Rhodes = {
        {
            itemLabel = "Pick Axe",                  -- Label of the item
            itemName = "pickaxe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 10,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(5, 10), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "broom ",                  -- Label of the item
            itemName = "broom",                    -- same as in your database
            currencyType = "gold",                   -- cash or gold
            buyprice = 10,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(5, 10), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy broom ",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Bag Of Coal",                  -- Label of the item
            itemName = "bagofcoal",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 5,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(3, 5), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy Bag Of Coal",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Train Oil",                  -- Label of the item
            itemName = "trainoil",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 5,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(3, 5), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy Train Oil",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Apple",
            itemName = "apple",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Water",
            itemName = "water",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "food",
            itemLimit = 10,
        },
        {
            itemLabel = "bandage",
            itemName = "bandage",
            currencyType = "cash",
            buyprice = 10,
            randomprice = math.random(5, 10),
            desc = "Buy bandage",
            category = "meds",
            itemLimit = 0,
        },
        {
            itemLabel = "salt",
            itemName = "salt",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy salt",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "veggies",
            itemName = "consumable_veggies",
            currencyType = "cash",
            buyprice = 5,
            randomprice = math.random(5, 10),
            desc = "Buy veggies",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "coffee",
            itemName = "consumable_coffee",
            currencyType = "cash",
            buyprice = 5,
            randomprice = math.random(3, 5),
            desc = "Buy coffee",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "peach",
            itemName = "peach",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy peach",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "greavy",
            itemName = "consumable_meat_greavy",
            currencyType = "cash",
            buyprice = 5,
            randomprice = math.random(3, 6),
            desc = "Buy greavy",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "eggs",
            itemName = "eggs",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy eggs",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "chocolate",
            itemName = "consumable_chocolate",
            currencyType = "cash",
            buyprice = 5,
            randomprice = math.random(3, 5),
            desc = "Buy chocolate",
            category = "food",
            itemLimit = 0,
        },
    },

    Strawberry = {
        {
            itemLabel = "Pick Axe",                  -- Label of the item
            itemName = "pickaxe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 3,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(2, 4) / 100, -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Apple",
            itemName = "apple",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Water",
            itemName = "water",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "food",
            itemLimit = 10,
        },
        {
            itemLabel = "bandage",
            itemName = "bandage",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy bandage",
            category = "meds",
            itemLimit = 0,
        },
        {
            itemLabel = "salt",
            itemName = "salt",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy salt",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "veggies",
            itemName = "consumable_veggies",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy veggies",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "coffee",
            itemName = "consumable_coffee",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy coffee",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "peach",
            itemName = "peach",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy peach",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "greavy",
            itemName = "consumable_meat_greavy",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy greavy",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "eggs",
            itemName = "eggs",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy eggs",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "chocolate",
            itemName = "consumable_chocolate",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy chocolate",
            category = "food",
            itemLimit = 0,
        },
    },

    Blackwater = {
        {
            itemLabel = "Pick Axe",                  -- Label of the item
            itemName = "pickaxe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 3,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(2, 4) / 100, -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "broom ",                  -- Label of the item
            itemName = "broom",                    -- same as in your database
            currencyType = "gold",                   -- cash or gold
            buyprice = 10,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(5, 10), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy broom ",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Apple",
            itemName = "apple",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Water",
            itemName = "water",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "food",
            itemLimit = 10,
        },
        {
            itemLabel = "bandage",
            itemName = "bandage",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy bandage",
            category = "meds",
            itemLimit = 0,
        },
        {
            itemLabel = "salt",
            itemName = "salt",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy salt",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "veggies",
            itemName = "consumable_veggies",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy veggies",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "coffee",
            itemName = "consumable_coffee",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy coffee",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "peach",
            itemName = "peach",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy peach",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "greavy",
            itemName = "consumable_meat_greavy",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy greavy",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "eggs",
            itemName = "eggs",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy eggs",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "chocolate",
            itemName = "consumable_chocolate",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy chocolate",
            category = "food",
            itemLimit = 0,
        },
    },
    Armadillo = {
        {
            itemLabel = "Pick Axe",                  -- Label of the item
            itemName = "pickaxe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 3,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(2, 4) / 100, -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Apple",
            itemName = "apple",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Water",
            itemName = "water",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "food",
            itemLimit = 10,
        },
        {
            itemLabel = "bandage",
            itemName = "bandage",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy bandage",
            category = "meds",
            itemLimit = 0,
        },
        {
            itemLabel = "salt",
            itemName = "salt",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy salt",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "veggies",
            itemName = "consumable_veggies",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy veggies",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "coffee",
            itemName = "consumable_coffee",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy coffee",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "peach",
            itemName = "peach",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy peach",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "greavy",
            itemName = "consumable_meat_greavy",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy greavy",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "eggs",
            itemName = "eggs",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy eggs",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "chocolate",
            itemName = "consumable_chocolate",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy chocolate",
            category = "food",
            itemLimit = 0,
        },
    },
    Tumbleweed = {
        {
            itemLabel = "Pick Axe",                  -- Label of the item
            itemName = "pickaxe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 3,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(2, 4) / 100, -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Apple",
            itemName = "apple",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Water",
            itemName = "water",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "food",
            itemLimit = 10,
        },
        {
            itemLabel = "bandage",
            itemName = "bandage",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy bandage",
            category = "meds",
            itemLimit = 0,
        },
        {
            itemLabel = "salt",
            itemName = "salt",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy salt",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "veggies",
            itemName = "consumable_veggies",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy veggies",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "coffee",
            itemName = "consumable_coffee",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy coffee",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "peach",
            itemName = "peach",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy peach",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "greavy",
            itemName = "consumable_meat_greavy",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy greavy",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "eggs",
            itemName = "eggs",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy eggs",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "chocolate",
            itemName = "consumable_chocolate",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy chocolate",
            category = "food",
            itemLimit = 0,
        },
    },
    StDenis = {
        {
            itemLabel = "Pick Axe",                  -- Label of the item
            itemName = "pickaxe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 3,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(2, 4) / 100, -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Bag Of Coal",                  -- Label of the item
            itemName = "bagofcoal",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 5,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(3, 5), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy Bag Of Coal",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Train Oil",                  -- Label of the item
            itemName = "trainoil",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 5,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(3, 5), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy Train Oil",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "broom ",                  -- Label of the item
            itemName = "broom",                    -- same as in your database
            currencyType = "gold",                   -- cash or gold
            buyprice = 10,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(5, 10), -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy broom ",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Apple",
            itemName = "apple",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Water",
            itemName = "water",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "food",
            itemLimit = 10,
        },
        {
            itemLabel = "bandage",
            itemName = "bandage",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy bandage",
            category = "meds",
            itemLimit = 0,
        },
        {
            itemLabel = "salt",
            itemName = "salt",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy salt",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "veggies",
            itemName = "consumable_veggies",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy veggies",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "coffee",
            itemName = "consumable_coffee",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy coffee",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "peach",
            itemName = "peach",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy peach",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "greavy",
            itemName = "consumable_meat_greavy",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy greavy",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "eggs",
            itemName = "eggs",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy eggs",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "chocolate",
            itemName = "consumable_chocolate",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy chocolate",
            category = "food",
            itemLimit = 0,
        },
    },
    Vanhorn = {
        {
            itemLabel = "Pick Axe",                  -- Label of the item
            itemName = "pickaxe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 3,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(2, 4) / 100, -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "Apple",
            itemName = "apple",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Water",
            itemName = "water",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "food",
            itemLimit = 10,
        },
        {
            itemLabel = "bandage",
            itemName = "bandage",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy bandage",
            category = "meds",
            itemLimit = 0,
        },
        {
            itemLabel = "salt",
            itemName = "salt",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy salt",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "veggies",
            itemName = "consumable_veggies",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy veggies",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "coffee",
            itemName = "consumable_coffee",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy coffee",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "peach",
            itemName = "peach",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy peach",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "greavy",
            itemName = "consumable_meat_greavy",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy greavy",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "eggs",
            itemName = "eggs",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy eggs",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "chocolate",
            itemName = "consumable_chocolate",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy chocolate",
            category = "food",
            itemLimit = 0,
        },
    },
    BlackwaterFishing = {
        {
            itemLabel = "Worm Bait",
            itemName = "p_baitWorm01x",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "Corn Bait",
            itemName = "p_baitCorn01x",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "Bread Bait",
            itemName = "p_baitBread01x",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "Cricket Bait",
            itemName = "p_baitCricket01x",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "Crawfish Bait",
            itemName = "p_crawdad01x",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "Dragonfly Lure",
            itemName = "p_finishedragonfly01x",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "Legendary Dragonfly Lure",
            itemName = "p_finishedragonflylegendary01x",
            currencyType = "cash",
            buyprice = 10,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "Spinner V4",
            itemName = "p_lgoc_spinner_v4",
            currencyType = "cash",
            buyprice = 6,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },


    },
    Wapiti = {
        {
            itemLabel = "Apple",
            itemName = "apple",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "Water",
            itemName = "water",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(2),
            desc = "sell",
            category = "food",
            itemLimit = 0,
        },
        {
            itemLabel = "bandage",
            itemName = "bandage",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell bandage",
            category = "meds",
            itemLimit = 0,
        },
        {
            itemLabel = "Pick Axe",
            itemName = "pickaxe",
            currencyType = "cash",
            buyprice = 5,
            randomprice = math.random(1, 2),
            desc = "sell pick axe",
            category = "tools",
            itemLimit = 0,
        },
    },
    farmer = {
        {
            itemLabel = "hoe",                  -- Label of the item
            itemName = "hoe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 3,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(2, 4) / 100, -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "wateringcan empty",
            itemName = "wateringcan_empty",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "planttrimmer",
            itemName = "planttrimmer",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "tools",
            itemLimit = 10,
        },
        {
            itemLabel = "Plant fertilizer",
            itemName = "fertilizer",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy fertilizer",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Alaskan Ginseng",
            itemName = "Alaskan_Ginseng_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Black Berry",
            itemName = "Black_Currant_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Black Currant",
            itemName = "Black_Berry_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Apple Seed",
            itemName = "Apple_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seed",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Red Raspberry",
            itemName = "Red_Raspberry_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seed",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Prairie Poppy Seed",
            itemName = "Prairie_Poppy_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "American Ginseng Seed",
            itemName = "American_Ginseng_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Yarrow",
            itemName = "Yarrow_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Wild Mint Seed",
            itemName = "Wild_Mint_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seeds",
            category = "Farming",
            itemLimit = 0,
        },
    },
    farmerSaintD = {
        {
            itemLabel = "hoe",                  -- Label of the item
            itemName = "hoe",                    -- same as in your database
            currencyType = "cash",                   -- cash or gold
            buyprice = 3,                           -- fixed price if randomprices is false in this stores config
            randomprice = math.random(2, 4) / 100, -- random price between 30 and 50 if randomprices is true in this store. adding a /100 the price will be in decimals
            desc = "Buy pick axe",                  -- menu description
            category = "tools",                      -- category where this item will show up if set in the store config
            itemLimit = 0,                           -- limit of this item in the store to be sold for  all players
            -- weapon = false,                    -- set to true if you want to sell weapons, or delete this from items
        },
        {
            itemLabel = "wateringcan empty",
            itemName = "wateringcan_empty",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "planttrimmer",
            itemName = "planttrimmer",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1),
            desc = "sell",
            category = "tools",
            itemLimit = 10,
        },
        {
            itemLabel = "Plant fertilizer",
            itemName = "fertilizer",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy fertilizer",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Alaskan Ginseng",
            itemName = "Alaskan_Ginseng_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Black Berry",
            itemName = "Black_Currant_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Black Currant",
            itemName = "Black_Berry_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Apple Seed",
            itemName = "Apple_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seed",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Red Raspberry",
            itemName = "Red_Raspberry_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seed",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Prairie Poppy Seed",
            itemName = "Prairie_Poppy_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "American Ginseng Seed",
            itemName = "American_Ginseng_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Yarrow",
            itemName = "Yarrow_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seeds",
            category = "Farming",
            itemLimit = 0,
        },
        {
            itemLabel = "Wild Mint Seed",
            itemName = "Wild_Mint_Seed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy Seeds",
            category = "Farming",
            itemLimit = 0,
        },
    },
    weedshop = {
        {
            itemLabel = "weedseed",
            itemName = "weedseed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "weed",
            itemLimit = 0,
        },
        {
            itemLabel = "watering Buckett",
            itemName = "wateringbucket",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(2),
            desc = "sell",
            category = "weed",
            itemLimit = 0,
        },

    },
    mineshop = {
        {
            itemLabel = "pickaxe",
            itemName = "pickaxe",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "shovel",
            itemName = "shovel",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "goldpan",
            itemName = "goldpan",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },
        {
            itemLabel = "hatchet",
            itemName = "hatchet",
            currencyType = "cash",
            buyprice = 3,
            randomprice = math.random(2),
            desc = "sell",
            category = "tools",
            itemLimit = 0,
        },

    },
    horsecare = {
        {
            itemLabel = "horse Sugar",
            itemName = "unique_brad_horsesugar",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy",
            category = "horsecare",
            itemLimit = 0,
        },
        {
            itemLabel = "Horse Food",
            itemName = "unique_horse_feed",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(2),
            desc = "Buy",
            category = "horsecare",
            itemLimit = 0,
        },
        {
            itemLabel = "horse Meal",
            itemName = "horsemeal",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy",
            category = "horsecare",
            itemLimit = 0,
        },
        {
            itemLabel = "sugar cube",
            itemName = "sugarcube",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(2),
            desc = "Buy",
            category = "horsecare",
            itemLimit = 0,
        },
        {
            itemLabel = "wild carrot",
            itemName = "Wild_Carrot",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(2),
            desc = "Buy",
            category = "horsecare",
            itemLimit = 0,
        },
        {
            itemLabel = "Hay cube",
            itemName = "consumable_haycube",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(1, 2),
            desc = "Buy",
            category = "horsecare",
            itemLimit = 0,
        },
        {
            itemLabel = "stim ",
            itemName = "stim",
            currencyType = "cash",
            buyprice = 1,
            randomprice = math.random(2),
            desc = "Buy",
            category = "horsecare",
            itemLimit = 0,
        },
        {
            itemLabel = "horse brush ",
            itemName = "horsebrush",
            currencyType = "cash",
            buyprice = 2,
            randomprice = math.random(2),
            desc = "Buy",
            category = "horsecare",
            itemLimit = 0,
        },

    },
}
