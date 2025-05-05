Config = {

-- ##### SELECT YOUR FRAMEWORK #####
-- IMPORTANT: ONLY ONE MUST BE TRUE, OTHERS SHOULD BE FALSE.
["VORP"] = true,
["RedEM"] = false,
-- #################################

-- INVENTORY SETTINGS
["CloseOnUse"] = false, -- Determines whether the inventory will close after using an item. VORP must be true!	

-- NOTIFICATIONS
["MSG"] = "You consumed", -- Message to display when consumed 
["FoodNotify"] = "You hear your belly rumbling and start to feel weak...", -- When your food is low it displays this notification
["WaterNotify"] = "Your throat feels incredibly dry and your lips begin to dry out...", -- When your water is low it displays this notification
["FoodNotification"] = 20, -- Determines when the ["LowFoodNotification"] notifications displays
["WaterNotification"] = 20, -- Determines when the ["LowWaterNotification"] notifications displays

-- INITIAL VALUES
["InitialFood"] = 60, -- INITIAL FOOD -- MAX VALUE 100%
["InitialWater"] = 60, -- INITIAL FOOD -- MAX VALUE 100%

-- METABOLISM
-- **IMPORTANT: REMEMBER FEMALE PLAYERS MAY NOT UPDATE ITS BODY**
["MetabolismFiesta"] = true, -- This will disable visual body changes

["InitialMetabolism"] = 10000, -- Initial metabolism where 0 is super skinny and 20000 is super fat, 10000 would be normal
["MetabolismLossIdle"] = 0.1, -- Metabolism drop rate while on stand by
["MetabolismLossWalking"] = 0.5, -- Metabolism drop rate per tick while walking
["MetabolismLossRunning"] = 0.5, -- Metabolism drop rate per tick while running. Go do some exercise!

-- TICK: This is the time (rate) it takes to excecute every check 
-- For e.g: 2 food is drain per tick
-- 1000 = 1 second; 20000 = 20 seconds; 3600 = 3,5 seconds
-- **WARNING: ONLY TOUCH THIS VARIABLES IF YOU NEED, MAY HIGHLY AFFECT OPERATION**
["NeedsTick"] = 10000, -- Checks your needs over time
["MetabolismTick"] = 30000, -- Checks your metabolism over time

-- DRAINS PER TICK ("NeedsTick")
["FoodDrainIdle"] = 0.3, -- Food drop rate on stand by
["FoodDrainRunning"] = 1, -- Food drop rate while running
["FoodDrainWalking"] = 0.5, -- Food drop rate while walking
["WaterDrainIdle"] = 0.4, -- Water drop rate on stand by
["WaterDrainRunning"] = 1, -- Water drop rate while running
["WaterDrainWalking"] = 1, -- Water drop rate while walking

-- HEALTH LOSS STRIPE
["HealthLoss"] = 5, -- Health you lose per tick
["FoodStripe"] = 0, -- Food stripe that determines when you start to lose health
["WaterStripe"] = 0, -- Water stripe that determines when you start to lose health

-- TEMPERATURE DEBUFF STRIPE
["TooCold!"] = true, -- Enables/disables Temperature System
["MinTemperature"] = -5, -- -20°C From this temperature below, you'll lose more food and water
["MaxTemperature"] = 38, -- 20°C From this temperature above, you'll lose more food and water
["TempNotify1"] = "You are feeling very cold, you should cover yourself more!!",
["TempNotify2"] = "You're cold, you should cover yourself",
["TempNotify3"] = "You're freezing cover yourself up, otherwise you will die!",

-- FOOD AND WATER DROP RATE FROM TEMPERATURE
["WaterHotLoss"] = 2, -- Water drop rate increment for higher temperatures
["FoodColdLoss"] = 2, -- Food drop rate increment for lower temperatures

-- DRUNK SYSTEM
["VomitMe"] = true, -- Enables/disables Vomit system
["DisableDrunkRun"] = true, -- Enables/disables running when drunk

-- CLOTHES TEMPERATURE
-- Temperature increment each clothes gives.
["HatTemp"] = 1, -- Hats
["ShirtTemp"] = 2, -- Shirts
["PantsTemp"] = 2, -- Pants
["BootsTemp"] = 2, -- Boots
["CoatTemp"] = 3, -- Coats
["ClosedCoatTemp"] = 4, -- Closed Coats
["GlovesTemp"] = 1, -- Gloves
["VestTemp"] = 1, -- Vest
["PonchoTemp"] = 5, -- Poncho

}

--
-- ANIMATION LIST
-- Thanks to @Chico for helping me get all this cool animations.
--
-- 'eat' = You will make a simple eat animation with any prop you select to it ("PropName" variable)
-- 'drink' = You will make a simple drink animation with any prop you select to it ("PropName" variable)
-- 'drink_cup' = Drink from a coffee cup
-- 'smoke' = Smoke a cigar
-- 'bowl' = Animation where you eat from a bowl
-- 'shortbottle' = Animation where you drink from a short bottle
-- 'longbottle' = Animation where you drink from a long bottle
-- 'syringe' = Animation to inject yourself with a syringe
-- 'berry' = Animation where you eat berries


-- SOME PROPS
--
-- p_bottlejd01x = Whyskey bottle
-- p_bottlebeer01a = Beer bottle
-- p_bottlewine01x = Wine bottle
-- You can find more props in http://rdr2.mooshe.tv/


-- SOME EFFECTS
-- PlayerDrunk01
-- PlayerDrunkAberdeen
-- PlayerDrugsPoisonWell
-- You can find more effects in https://github.com/femga/rdr3_discoveries/blob/master/graphics/animpostfx/animpostfx.lua


-- JUST ADD YOUR ITEMS HERE WITH THE VALUES YOU WANT
-- CHECK YOUR COMMAS AND TYPING!!!
-- MAKE SURE YOU CHANGE THE DEFAULT VALUES. THE ONES DISPLAYED HERE ARE TEST VALUES!
Config.ItemsToUse = {
		-- Canned Beans
	{
		["Name"] = "cigar",
		["DisplayName"] = "cigar",
		["Animation"] = "smoke",
		["PropName"] = "p_cigarlit01x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 65,
		["Thirst"] = 0,
		["InnerCoreStamina"] = 10,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 10.0,
		["InnerCoreHealth"] = 10,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] =0.0,
		
		["HardAlcohol"] = false,
        ["SoftAlcohol"] = false,
        ["DrinkCount"] = 0,
        ["Effect"] = "PlayerDrunk01",
        ["EffectDuration"] = 120000,
	},

	{
		["Name"] = "consumable_kidneybeans_can",
		["DisplayName"] = "Canned Beans",
		["Animation"] = "eat",
		["PropName"] = "s_canbeans01x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 65,
		["Thirst"] = 0,
		["InnerCoreStamina"] = 10,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 10,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
    {
		["Name"] = "apple",
		["DisplayName"] = "apple",
		["Animation"] = "eat",
		["PropName"] = "p_apple02x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 65,
		["Thirst"] = 0,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
    {
		["Name"] = "consumable_salmon_can",
		["DisplayName"] = "salmon can",
		["Animation"] = "eat",
		["PropName"] = "s_canbeansused01x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 65,
		["Thirst"] = 0,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
    {
		["Name"] = "consumable_medicine",
		["DisplayName"] = "medicine ",
		["Animation"] = "drink",
		["PropName"] = "p_bottlemedicine01x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 65,
		["Thirst"] = 50,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 100,
		["OuterCoreHealthGold"] = 100,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
    {
		["Name"] = "meat",
		["DisplayName"] = "meat ",
		["Animation"] = "eat",
		["PropName"] = "p_redefleshymeat01xb",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 65,
		["Thirst"] = 0,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "peach",
		["DisplayName"] = "peach",
		["Animation"] = "eat",
		["PropName"] = "s_peach01x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 65,
		["Thirst"] = 0,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "consumable_pear",
		["DisplayName"] = "Pear",
		["Animation"] = "eat",
		["PropName"] = "s_peach01x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 65,
		["Thirst"] = 0,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "consumable_meat_greavy",
		["DisplayName"] = "Meat Greavy",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "consumable_veggies",
		["DisplayName"] = "veggies",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "consumable_breakfast",
		["DisplayName"] = " breakfast",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "consumable_chocolate",
		["DisplayName"] = "chocolate",
		["Animation"] = "eat",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "eggs",
		["DisplayName"] = "eggs",
		["Animation"] = "eat",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "apple",
		["DisplayName"] = "apple",
		["Animation"] = "eat",
		["PropName"] = "s_peach01x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "Red_Raspberry",
		["DisplayName"] = "Raspberry",
		["Animation"] = "eat",
		["PropName"] = "s_peach01x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "Black_Currant",
		["DisplayName"] = "black current",
		["Animation"] = "eat",
		["PropName"] = "s_peach01x",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	
	{
		["Name"] = "cookedsmallgame",
		["DisplayName"] = " cookedsmallgame",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},	{
		["Name"] = "consumable_applepie",
		["DisplayName"] = "applepie",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},	
	{
		["Name"] = "steak",
		["DisplayName"] = " steak",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "consumable_blueberrypie",
		["DisplayName"] = " blueberrypie",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	
	{
		["Name"] = "knifecooking",
		["DisplayName"] = "knifecooking",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	
	{
		["Name"] = "SaltedCookedBigGameMeat",
		["DisplayName"] = "BigGameMeat",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "CookedBigGameMeat",
		["DisplayName"] = "CookedBigGameMeat",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "cookedpork",
		["DisplayName"] = "cookedpork",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	 
	{
		["Name"] = "cookedbird",
		["DisplayName"] = "cookedbird",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "steakeggs",
		["DisplayName"] = "steakeggs",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	{
		["Name"] = "vegstew",
		["DisplayName"] = "vegstew",
		["Animation"] = "bowl",
		["PropName"] = "eat",
		["Remove"] = true,
		["Metabolism"] = 850,
		["Hunger"] = 85,
		["Thirst"] = 10,
		["InnerCoreStamina"] = 0.0,
		["InnerCoreStaminaGold"] = 0.0,
		["OuterCoreStaminaGold"] = 0.0,
		["InnerCoreHealth"] = 0.0,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = 0.0,
		["OuterCoreHealthGold"] = 0.0,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},
	
	
		-- Blank for copy and paste
	--[[{
		["Name"] = "",
		["DisplayName"] = "",
		["Animation"] = "",
		["PropName"] = "",
		["Metabolism"] = ,
		["Hunger"] = ,
		["Thirst"] = ,
		["InnerCoreStamina"] = ,
		["InnerCoreStaminaGold"] = ,
		["OuterCoreStaminaGold"] = ,
		["InnerCoreHealth"] = ,
		--["OuterCoreHealth"] = ,
		["InnerCoreHealthGold"] = ,
		["OuterCoreHealthGold"] = ,
		
		-- HardAlcohol, Soft Alcohol and DrinkCount are only used in "shortbottle" and "longbottle" animations
		["HardAlcohol"] = false,
		["SoftAlcohol"] = false,
		["DrinkCount"] = 0,
		["Effect"] = "",
		["EffectDuration"] = 0,
	},]]

    --
    -- DRINKS
    --
	-- Coffee
    {
        ["Name"] = "consumable_coffee", 
        ["DisplayName"] = "Coffee", 
        ["Animation"] = "drink_cup",
        ["PropName"] = "p_mugcoffee01x",
		["Remove"] = true,
        ["Metabolism"] = -5000,
        ["Hunger"] = 0,
        ["Thirst"] = 35,
        ["InnerCoreStamina"] = 50,
        ["InnerCoreStaminaGold"] = 0.0,
        ["OuterCoreStaminaGold"] = 0.0,
        ["InnerCoreHealth"] = 0,
        --["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 0.0,
        ["OuterCoreHealthGold"] = 0.0,
        ["HardAlcohol"] = false,
        ["SoftAlcohol"] = false,
        ["DrinkCount"] = 0,
        ["Effect"] = "",
        ["EffectDuration"] = 0,
   


    },
    {
        ["Name"] = "consumable_raspberrywater", 
        ["DisplayName"] = "Water", 
        ["Animation"] = "drink_cup",
        ["PropName"] = "p_mugcoffee01x",
		["Remove"] = true,
        ["Metabolism"] = -5000,
        ["Hunger"] = 0,
        ["Thirst"] = 35,
        ["InnerCoreStamina"] = 50,
        ["InnerCoreStaminaGold"] = 0.0,
        ["OuterCoreStaminaGold"] = 0.0,
        ["InnerCoreHealth"] = 0,
        --["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 0.0,
        ["OuterCoreHealthGold"] = 0.0,
        ["HardAlcohol"] = false,
        ["SoftAlcohol"] = false,
        ["DrinkCount"] = 0,
        ["Effect"] = "",
        ["EffectDuration"] = 0,
   


    },
    {
        ["Name"] = "water", 
        ["DisplayName"] = "Water", 
        ["Animation"] = "drink_cup",
        ["PropName"] = "p_mugcoffee01x",
		["Remove"] = true,
        ["Metabolism"] = -5000,
        ["Hunger"] = 0,
        ["Thirst"] = 35,
        ["InnerCoreStamina"] = 50,
        ["InnerCoreStaminaGold"] = 0.0,
        ["OuterCoreStaminaGold"] = 0.0,
        ["InnerCoreHealth"] = 0,
        --["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 0.0,
        ["OuterCoreHealthGold"] = 0.0,
        ["HardAlcohol"] = false,
        ["SoftAlcohol"] = false,
        ["DrinkCount"] = 0,
        ["Effect"] = "",
        ["EffectDuration"] = 0,
   


    },
	-- Beer
    {
        ["Name"] = "beer", 
        ["DisplayName"] = "Beer", 
        ["Animation"] = "shortbottle",
        ["PropName"] = "p_bottlebeer01a",
		["Remove"] = true,
        ["Metabolism"] = 115,
        ["Hunger"] = 0,
        ["Thirst"] = 20,
        ["InnerCoreStamina"] = 10,
        ["InnerCoreStaminaGold"] = 0.0,
        ["OuterCoreStaminaGold"] = 0.0,
        ["InnerCoreHealth"] = 0,
        --["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 0.0,
        ["OuterCoreHealthGold"] = 0.0,
        ["HardAlcohol"] = false,
        ["SoftAlcohol"] = true,
        ["DrinkCount"] = 2,
        ["Effect"] = "PlayerDrunk01",
        ["EffectDuration"] = 90000,

    },
	-- Whiskey
    {
        ["Name"] = "whiskey", 
        ["DisplayName"] = "whiskey", 
        ["Animation"] = "longbottle",
        ["PropName"] = "p_bottlejd01x",
		["Remove"] = true,
        ["Metabolism"] = 225,
        ["Hunger"] = 0,
        ["Thirst"] = 10,
        ["InnerCoreStamina"] = 10,
        ["InnerCoreStaminaGold"] = 0.10,
        ["OuterCoreStaminaGold"] = 0.0,
        ["InnerCoreHealth"] = 0,
        --["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 0.0,
        ["OuterCoreHealthGold"] = 0.0,
        ["HardAlcohol"] = false,
        ["SoftAlcohol"] = true,
        ["DrinkCount"] = 2,
        ["Effect"] = "PlayerDrunk01",
        ["EffectDuration"] = 120000,

    }
}   
