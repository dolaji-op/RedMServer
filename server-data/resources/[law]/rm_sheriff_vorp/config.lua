Config = {}


-- Enable if u own these plugins of mine
Config.PrisonJailPlugin = true 


-- Map & Blips
Config.MapBlipsNames = 'Sheriff Office'
Config.MapBlipsSprites = 778811758
Config.MapBlips = { -- !!! Lockers "enable_locker" is not Avaible on VORP CORE, leave it on "false" !!!
    [1] = { x = 1361.72,  y = -1302.4,  z = 77.77,  blip_enabled = true, enable_locker = false, locker_name = 'NOT AVAIBLE ON VORP' }, -- Rhodes
    [2] = { x = 2506.72,  y = -1309.3,  z = 48.95,  blip_enabled = true, enable_locker = false, locker_name = 'NOT AVAIBLE ON VORP' }, -- St Denis
    [3] = { x = 2907.92,  y = 1312.13,  z = 44.94,  blip_enabled = true, enable_locker = false, locker_name = 'NOT AVAIBLE ON VORP' }, -- Annesburg
    [4] = { x = -277.8,   y = 806.05,   z = 119.38, blip_enabled = true, enable_locker = false, locker_name = 'NOT AVAIBLE ON VORP' }, -- Valentine
    [5] = { x = -1808.93, y = -348.25,  z = 164.65, blip_enabled = true, enable_locker = false, locker_name = 'NOT AVAIBLE ON VORP' }, -- Strawberry
    [6] = { x = -762.34,  y = -1268.21, z = 44.04,  blip_enabled = true, enable_locker = false, locker_name = 'NOT AVAIBLE ON VORP' }, -- Blackwater
    [7] = { x = -3623.23, y = -2602.22, z = -13.34, blip_enabled = true, enable_locker = false, locker_name = 'NOT AVAIBLE ON VORP' }, -- Armadillo
    [8] = { x = -5530.32, y = -2928.86, z = -1.36,  blip_enabled = true, enable_locker = false, locker_name = 'NOT AVAIBLE ON VORP' }, -- Tumbleweed
}


-- Sheriff Wagons
Config.EnableWagons = true

Config.WagonMenuMarkers = { -- First Coords are Menu Coors / Second Coords are Wagon Spawn Point Coords
    [1] = { x = 1359.07,  y = -1295.48, z = 76.64,  enabled = true, xs = 1364.3,   ys = -1294.6,  zs = 76.52,  zh = 241.9  }, -- Rhodes
    [2] = { x = 2481.73,  y = -1306.62, z = 48.67,  enabled = true, xs = 2487.28,  ys = -1312.35, zs = 48.67,  zh = 178.64 }, -- St Denis
    [3] = { x = 2910.56,  y = 1305.85,  z = 44.5,   enabled = true, xs = 2915.86,  ys = 1302.13,  zs = 43.93,  zh = 155.51 }, -- Annesburg
    [4] = { x = -280.64,  y = 821.82,   z = 119.12, enabled = true, xs = -280.6,   ys = 828.58,   zs = 119.29, zh = 284.83 }, -- Valentine
    [5] = { x = -1804.87, y = -356.2,   z = 163.94, enabled = true, xs = -1799.5,  ys = -353.77,  zs = 163.84, zh = 200.01 }, -- Strawberry
    [6] = { x = -764.52,  y = -1258.22, z = 43.31,  enabled = true, xs = -763.83,  ys = -1255.12, zs = 43.13,  zh = 263.36 }, -- Blackwater
    [7] = { x = -3616.71, y = -2597.47, z = -14.05, enabled = true, xs = -3610.07, ys = -2596.13, zs = -14.12, zh = 38.54  }, -- Armadillo
    [8] = { x = -5533.1,  y = -2931.59, z = -2.11,  enabled = true, xs = -5536.31, ys = -2939.15, zs = -2.0,   zh = 263.63 }, -- Tumbleweed
}

Config.WagonsList = {
    [1] = { model = 'POLICEWAGON01X', 		 displayname = 'Police Wagon' 		  },
	[2] = { model = 'POLICEWAGONGATLING01X', displayname = 'Police Wagon Gatling' },
}


-- Sheriff Job Name
Config.SheriffJobName = {
	'sheriff',
	'police',
	'marshal',
}


-- Handcuffs
Config.EnableHandcuffsMenu = true
Config.UseHandcuffsFunctions = true -- Enable Handcuffs Logic? / It set to false it wil not load the functions from "handcuffs" folder.
Config.HandcuffsItemName = 'handcuffs'


-- Sheriff Search Player
Config.EnableSearchMenu = true


-- Sheriff Allow Destroy/Remove Vehicles Menu
Config.EnableDestroyVehicleMenu = true


-- Sheriff Armory
Config.EnableArmory = true

Config.EnableArmoryWeapons = true
Config.ArmoryWeapons = {
    [1] =   { weapon = 'WEAPON_MELEE_KNIFE',	 	 	  displayname = 'Knife', 	  			  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_melee_knife.png'>"       		 },
    [2] =   { weapon = 'WEAPON_BOW',	 	 			  displayname = 'Bow', 	  				  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_bow.png'>"       				 },
    [3] =   { weapon = 'weapon_rifle_elephant',	 	 	  displayname = 'Elephant Rifle', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_rifle_elephant.png'>"       	 },
    [4] =   { weapon = 'WEAPON_RIFLE_VARMINT',	 	 	  displayname = 'Varmint Rifle', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_rifle_varmint.png'>"       	 },
    [5] =   { weapon = 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK', displayname = 'Rollingblock Rifle', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_sniperrifle_rollingblock.png'>" },
    [6] =   { weapon = 'WEAPON_SNIPERRIFLE_CARCANO',	  displayname = 'Carcano Rifle', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_sniperrifle_carcano.png'>"      },
    [7] =   { weapon = 'WEAPON_RIFLE_SPRINGFIELD',	 	  displayname = 'Springfield Rifle', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_rifle_springfield.png'>"        },
    [8] =   { weapon = 'WEAPON_RIFLE_BOLTACTION',	 	  displayname = 'Boltaction Rifle', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_rifle_boltaction.png'>"         },
    [9] =   { weapon = 'WEAPON_REPEATER_WINCHESTER',	  displayname = 'Winchester Repeater', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_repeater_winchester.png'>"      },
    [10] =  { weapon = 'WEAPON_REPEATER_HENRY',	 	 	  displayname = 'Henry Repeater', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_repeater_henry.png'>"       	 },
    [11] =  { weapon = 'WEAPON_REPEATER_EVANS',	 	 	  displayname = 'Evans Repeater', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_repeater_evans.png'>"       	 },
    [12] =  { weapon = 'WEAPON_REPEATER_CARBINE',	 	  displayname = 'Carbine Repeater', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_repeater_carbine.png'>"         },
    [13] =  { weapon = 'WEAPON_PISTOL_SEMIAUTO',	 	  displayname = 'SemiAuto Pistol', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_pistol_semiauto.png'>"       	 },
    [14] =  { weapon = 'WEAPON_PISTOL_MAUSER',	 	 	  displayname = 'Mauser Pistol', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_pistol_mauser.png'>"       	 },
    [15] =  { weapon = 'WEAPON_PISTOL_VOLCANIC',	 	  displayname = 'Volcanic Pistol', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_pistol_volcanic.png'>"       	 },
    [16] =  { weapon = 'WEAPON_PISTOL_M1899',	 	 	  displayname = 'M1899 Pistol', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_pistol_m1899.png'>"       	  	 },
    [17] =  { weapon = 'WEAPON_REVOLVER_SCHOFIELD',	 	  displayname = 'Schofield Revolver', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_revolver_schofield.png'>"       },
    [18] =  { weapon = 'WEAPON_REVOLVER_LEMAT',	 	 	  displayname = 'Lemat Revolver', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_revolver_lemat.png'>"       	 },
    [19] =  { weapon = 'WEAPON_REVOLVER_DOUBLEACTION',	  displayname = 'Double Action Revolver', price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_revolver_doubleaction.png'>"    },
    [20] =  { weapon = 'WEAPON_REVOLVER_CATTLEMAN',	 	  displayname = 'Cattleman Revolver"', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_revolver_cattleman.png'>"       },
    [21] =  { weapon = 'weapon_revolver_navy',	 	 	  displayname = 'Navy Revolver', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/WEAPON_REVOLVER_NAVY.png'>"       	 },
    [22] =  { weapon = 'WEAPON_SHOTGUN_SEMIAUTO',	 	  displayname = 'Semiauto Shotgun', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_shotgun_semiauto.png'>"         },
    [23] =  { weapon = 'WEAPON_SHOTGUN_SAWEDOFF',	 	  displayname = 'Sawedoff Shotgun', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_shotgun_sawedoff.png'>"         },
    [24] =  { weapon = 'WEAPON_SHOTGUN_REPEATING',	 	  displayname = 'Repeating Shotgun', 	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_shotgun_repeating.png'>"        },
    [25] =  { weapon = 'WEAPON_SHOTGUN_PUMP',	 	 	  displayname = 'Pump Shotgun', 	  	  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_shotgun_pump.png'>"       	  	 },
    [26] =  { weapon = 'WEAPON_SHOTGUN_DOUBLEBARREL',	  displayname = 'Doublebarrel Shotgun',   price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_shotgun_doublebarrel.png'>"     },
    [27] =  { weapon = 'WEAPON_LASSO',	 	 			  displayname = 'Lasso', 	  			  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_lasso.png'>"       			 },
    [28] =  { weapon = 'weapon_kit_binoculars',	 	 	  displayname = 'Binoculars', 	  		  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_kit_binoculars.png'>"       	 },
    [29] =  { weapon = 'weapon_melee_lantern',	 	 	  displayname = 'Lantern', 	  			  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/weapon_melee_lantern.png'>"       	 },
}

Config.EnableArmoryAmmo = true  -- Make sure u are using "vorp_weaponsv2" or any other weapon shop with working ammo types!
Config.ArmoryAmmo = {
    [1] =  { ammo = 'ammorepeaterexplosive',  displayname = 'Repeater Ammo Explosive', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorepeaterexplosive.png'>"  },
    [2] =  { ammo = 'ammorepeaterexpress',    displayname = 'Repeater Ammo Express', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorepeaterexpress.png'>"    },
    [3] =  { ammo = 'ammorepeaternormal',     displayname = 'Repeater Ammo Normal', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorepeaternormal.png'>" 	   },
    [4] =  { ammo = 'ammorepeatervelocity',   displayname = 'Repeater Ammo Velocity', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorepeatervelocity.png'>"   },
    [5] =  { ammo = 'ammorepeatersplitpoint', displayname = 'Repeater Ammo Splitpoint',  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorepeatersplitpoint.png'>" },
    [6] =  { ammo = 'ammorevolverexplosive',  displayname = 'Revolver Ammo Explosive',   price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorevolverexplosive.png'>"  },
    [7] =  { ammo = 'ammorevolverexpress', 	  displayname = 'Revolver Ammo Express', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorevolverexpress.png'>"    },
    [8] =  { ammo = 'ammorevolvernormal', 	  displayname = 'Revolver Ammo Normal', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorevolvernormal.png'>"     },
    [9] =  { ammo = 'ammorevolvervelocity',   displayname = 'Revolver Ammo Velocity', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorevolvervelocity.png'>"   },
    [10] = { ammo = 'ammorevolversplitpoint', displayname = 'Revolver Ammo Splitpoint',  price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorevolversplitpoint.png'>" },
    [11] = { ammo = 'ammorifleexplosive', 	  displayname = 'Rifle Ammo Explosive', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorifleexplosive.png'>" 	   },
    [12] = { ammo = 'ammorifleexpress', 	  displayname = 'Rifle Ammo Express', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammorifleexpress.png'>" 	   },
    [13] = { ammo = 'ammoriflenormal', 		  displayname = 'Rifle Ammo Normal', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoriflenormal.png'>" 	   },
    [14] = { ammo = 'ammoriflevelocity', 	  displayname = 'Rifle Ammo Velocity', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoriflevelocity.png'>" 	   },
    [15] = { ammo = 'ammoriflesplitpoint', 	  displayname = 'Rifle Ammo Splitpoint', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoriflesplitpoint.png'>"    },
    [16] = { ammo = 'ammoelephant', 		  displayname = 'Elephant Rifle Ammo', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoelephant.png'>" 		   },
    [17] = { ammo = 'ammoshotgunincendiary',  displayname = 'Shotgun Ammo Incendiary',   price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoshotgunincendiary.png'>"  },
    [18] = { ammo = 'ammoshotgunexplosive',   displayname = 'Shotgun Ammo Explosive', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoshotgunexplosive.png'>"   },
    [19] = { ammo = 'ammoshotgunnormal',      displayname = 'Shotgun Ammo Normal', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoshotgunnormal.png'>" 	   },
    [20] = { ammo = 'ammoshotgunslug', 		  displayname = 'Shotgun Ammo Slug', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoshotgunslug.png'>" 	   },
    [21] = { ammo = 'ammopistolexplosive',    displayname = 'Pistol Ammo Explosive', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammopistolexplosive.png'>"    },
    [22] = { ammo = 'ammopistolexpress', 	  displayname = 'Pistol Ammo Express', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammopistolexpress.png'>" 	   },
    [23] = { ammo = 'ammopistolnormal', 	  displayname = 'Pistol Ammo Normal', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammopistolnormal.png'>" 	   },
    [24] = { ammo = 'ammopistolvelocity', 	  displayname = 'Pistol Ammo Velocity', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammopistolvelocity.png'>" 	   },
    [25] = { ammo = 'ammopistolsplitpoint',   displayname = 'Pistol Ammo Splitpoint', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammopistolsplitpoint.png'>"   },
    [26] = { ammo = 'ammoarrowdynamite', 	  displayname = 'Arrow Dynamite', 			 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoarrowdynamite.png'>" 	   },
    [27] = { ammo = 'ammoarrowfire', 		  displayname = 'Arrow Fire', 				 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoarrowfire.png'>" 		   },
    [28] = { ammo = 'ammoarrmownormal', 	  displayname = 'Arrow Normal', 			 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoarrmownormal.png'>" 	   },
    [29] = { ammo = 'ammoarrowimproved', 	  displayname = 'Arrow Improved', 			 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoarrowimproved.png'>" 	   },
    [30] = { ammo = 'ammoarrowsmallgame', 	  displayname = 'Arrow Small Game', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoarrowsmallgame.png'>" 	   },
    [31] = { ammo = 'ammoarrowpoison', 		  displayname = 'Arrow Poison', 			 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoarrowpoison.png'>" 	   },
    [32] = { ammo = 'ammovarmint', 			  displayname = 'Varmint Ammo', 			 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammovarmint.png'>" 		   },
    [33] = { ammo = 'ammovarminttranq', 	  displayname = 'Varmint Tranquilizer Ammo', price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammovarminttranq.png'>" 	   },
    [34] = { ammo = 'ammoknives', 			  displayname = 'Knives Ammo', 				 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammoknives.png'>" 			   },
    [35] = { ammo = 'ammotomahawk', 		  displayname = 'Tonmahawk Ammo', 			 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammotomahawk.png'>" 		   },
    [36] = { ammo = 'ammopoisonbottle', 	  displayname = 'Poison Bottle Ammo', 		 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammopoisonbottle.png'>" 	   },
    [37] = { ammo = 'ammobolla', 			  displayname = 'Bolla Ammo', 				 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammobolla.png'>" 			   },
    [38] = { ammo = 'ammodynamite', 		  displayname = 'Dynamite Ammo', 			 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammodynamite.png'>" 		   },
    [39] = { ammo = 'ammovoldynamite', 		  displayname = 'Volatile Dynamite Ammo', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammovoldynamite.png'>" 	   },
    [40] = { ammo = 'ammomolotov', 			  displayname = 'Molotov Ammo', 			 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammomolotov.png'>" 		   },
    [41] = { ammo = 'ammovolmolotov', 		  displayname = 'Volatile Molotov Ammo', 	 price = 1, image = "<img src='nui://vorp_inventory/html/img/items/ammovolmolotov.png'>" 		   },
}

Config.EnableArmoryItems = true
Config.ArmoryItems = {
    [1] = { item = 'handcuffs', displayname = 'handcuffs', price = 2, image = "<img src='nui://vorp_inventory/html/img/items/handcuffs.png'>" },
}


-- Sheriff Locker
Config.EnableLocker = false -- !!! Lockers are not Avaible on VORP CORE, leave it on "false" !!!


-- Badges
Config.MaleBadge = 0x1FC12C9C
Config.FemaleBadge = 0x0929677D


-- Display On Duty HUD logo?
Config.DisplayOnDutyHud = true


-- Sheriff On Duty Payment
Config.EnablePaymentForSheriff = true -- Disable if u dont want the sheriffs on duty to be paid.
Config.PaymentMoney = 10 -- 10$ Every Config.PaymentTimer setting.
Config.PaymentTimer = 600000 -- On duty Sheriff Will Get Payment Every 10 Minutes ( 1 Minute = 60000 )


-- Mobile Menu Open Command
Config.SheriffMobileMenuCommand = 'sff'


-- Office Menu Open Key
Config.KeyToOpenOfficeMenu = 0x760A9C6F -- G


-- Wagons Menu Open Key
Config.KeyToOpenWagonsMenu = 0x760A9C6F -- G


-- Stuff to Translate if u want...
Config.PressToOpen = 'Press ~e~[ G ]~q~ to open sheriff office menu'
Config.PressToOpenWagons = 'Press ~e~[ G ]~q~ to open sheriff wagons menu'
Config.MenuDataWagons = 'Sheriff Wagons'
Config.NotificationTitle = 'Sheriff'
Config.NotificationTitleFailed = 'Failed'
Config.NotSheriff = 'Youre not the sheriff!'
Config.DutyStart = 'Youre going On Duty'
Config.DutyStop =  'Youre going Off Duty'
Config.OfficeMenuOnDuty =  'Go On/Off Duty'
Config.OfficeMenuOnDutyDesc =  'Go ON or OFF Duty...'
Config.PaymentNotification = 'You have received your salary'
Config.SheriffMobileMenuSearch = 'Search Target'
Config.SheriffMobileMenuSearchDesc = 'Search Target Inventory'
Config.SheriffSearchTargetNotFount = 'Target not Found'
Config.JailMenu = 'Jail/Prison Menu'
Config.RemoveCurrentVehicle = 'Destroy Vehicle'
Config.RemoveCurrentVehicleDesc = 'Destroy Current Vehicle'
Config.SheriffCuff = 'Cuff/Uncuff'
Config.SheriffCuffDesc = 'Cuff/Uncuff Target'
Config.ArmoryMenu = 'Armory'
Config.ArmoryMenuDesc = 'Sheriff Armory'
Config.SheriffLocker = 'Locker'
Config.SheriffLockerDesc = 'Sheriff Locker'
Config.MenuDataMobile = 'Sheriff Mobile'
Config.MenuDataOffice = 'Sheriff Office'
Config.MenuDataArmory = 'Sheriff Armory'
Config.ArmoryWeaponsName = 'Weapons'
Config.ArmoryAmmoName = 'Ammo'
Config.ArmoryItemsName = 'Items'
Config.YouBought = 'You bought '
Config.YouCantBuy = 'You cant buy '
Config.ThePriceIs = ' the price is $'
Config.ThePriceWas = ' the price was $'
Config.NoHandcuffNot = 'You have no handcuffs in your inventory'
Config.SearchForMoney = 'Search Money'
Config.SearchForItems = 'Search Items'
Config.SearchForWeapons = 'Search Weapons'
Config.MoneyName = 'Money'
Config.TakeMoney = 'Take Money'
Config.TakeMoneyQuantity = 'Quantity'
Config.TakeItem = 'Take Item'
Config.TakeItemQuantity = 'Quantity'
Config.TakeItemWeapon = 'Take Weapon'
-- Weapon Names Translation for Search Function
Config.WEAPON_MELEE_KNIFE_TRADER = 'Tradders Knife'
Config.WEAPON_MELEE_KNIFE = 'Knife'
Config.WEAPON_MELEE_KNIFE_JAWBONE = 'JawBone Knife'
Config.WEAPON_MELEE_CLEAVER = 'Cleaver'
Config.WEAPON_MELEE_HATCHET_HUNTER = 'Hunter Hatchet'
Config.WEAPON_MELEE_MACHETE = 'Machete'
Config.WEAPON_MELEE_MACHETE_COLLECTOR = 'Collector Machete'
Config.WEAPON_BOW = 'Bow'
Config.WEAPON_BOW_IMPROVED = 'Improved Bow'
Config.WEAPON_RIFLE_ELEPHANT = 'Elephant Rifle'
Config.WEAPON_RIFLE_VARMINT = 'Varmint Rifle'
Config.WEAPON_SNIPERRIFLE_ROLLINGBLOCK = 'Rollingblock Rifle'
Config.WEAPON_SNIPERRIFLE_CARCANO = 'Carcano Rifle'
Config.WEAPON_RIFLE_SPRINGFIELD = 'Springfield Rifle'
Config.WEAPON_RIFLE_BOLTACTION = 'Boltaction Rifle'
Config.WEAPON_REPEATER_WINCHESTER = 'Winchester Repeater'
Config.WEAPON_REPEATER_HENRY = 'Henry Repeater'
Config.WEAPON_REPEATER_EVANS = 'Evans Repeater'
Config.WEAPON_REPEATER_CARBINE = 'Carbine Repeater'
Config.WEAPON_PISTOL_SEMIAUTO = 'SemiAuto Pistol'
Config.WEAPON_PISTOL_MAUSER = 'Mauser Pistol'
Config.WEAPON_PISTOL_VOLCANIC = 'Volcanic Pistol'
Config.WEAPON_PISTOL_M1899 = 'M1899 Pistol'
Config.WEAPON_REVOLVER_SCHOFIELD = 'Schofield Revolver'
Config.WEAPON_REVOLVER_LEMAT = 'Lemat Revolver'
Config.WEAPON_REVOLVER_DOUBLEACTION = 'Double Action Revolver'
Config.WEAPON_REVOLVER_CATTLEMAN = 'Cattleman Revolver'
Config.WEAPON_REVOLVER_NAVY = 'Navy Revolver'
Config.WEAPON_THROWN_TOMAHAWK = 'Tomahawk'
Config.WEAPON_THROWN_THROWING_KNIVES = 'Knives'
Config.WEAPON_THROWN_POISONBOTTLE = 'Poison Bottle'
Config.WEAPON_THROWN_BOLAS = 'Bolas'
Config.WEAPON_THROWN_DYNAMITE = 'Dynamite'
Config.WEAPON_THROWN_MOLOTOV = 'Molotov'
Config.WEAPON_SHOTGUN_SEMIAUTO = 'Semiauto Shotgun'
Config.WEAPON_SHOTGUN_SAWEDOFF = 'Sawedoff Shotgun'
Config.WEAPON_SHOTGUN_REPEATING = 'Repeating Shotgun'
Config.WEAPON_SHOTGUN_PUMP = 'Pump Shotgun'
Config.WEAPON_SHOTGUN_DOUBLEBARREL = 'Doublebarrel Shotgun'
Config.WEAPON_LASSO = 'Lasso'
Config.WEAPON_LASSO_REINFORCED = 'Reinforced Lasso'
Config.WEAPON_KIT_BINOCULARS_IMPROVED = 'Improved Binoculars'
Config.WEAPON_KIT_BINOCULARS = 'Binoculars'
Config.WEAPON_FISHINGROD = 'Fishing Rod'
Config.WEAPON_KIT_CAMERA = 'Camera'
Config.WEAPON_KIT_CAMERA_ADVANCED = 'Advanced Camera'
Config.WEAPON_MELEE_LANTERN = 'Lantern'
Config.WEAPON_MELEE_DAVY_LANTERN = 'Davy Lantern'