-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for vorpcore_34e5f3
CREATE DATABASE IF NOT EXISTS `vorpcore_34e5f3` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `vorpcore_34e5f3`;

-- Dumping structure for table vorpcore_34e5f3.as_jobs
CREATE TABLE IF NOT EXISTS `as_jobs` (
  `id` int(7) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `data` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.as_jobs: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.aw_battlepass
CREATE TABLE IF NOT EXISTS `aw_battlepass` (
  `identifier` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `playtime` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.aw_battlepass: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.banks
CREATE TABLE IF NOT EXISTS `banks` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.banks: ~4 rows (approximately)
INSERT INTO `banks` (`name`) VALUES
	('Blackwater'),
	('Rhodes'),
	('SaintDenis'),
	('Valentine');

-- Dumping structure for table vorpcore_34e5f3.bank_users
CREATE TABLE IF NOT EXISTS `bank_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `money` double(22,2) DEFAULT 0.00,
  `gold` double(22,2) DEFAULT 0.00,
  `items` longtext DEFAULT '[]',
  `invspace` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `bankusers` (`identifier`),
  CONSTRAINT `bank` FOREIGN KEY (`name`) REFERENCES `banks` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bankusers` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.bank_users: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.banneds
CREATE TABLE IF NOT EXISTS `banneds` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_steam` varchar(100) NOT NULL,
  `b_license` varchar(255) DEFAULT NULL,
  `b_discord` varchar(100) DEFAULT NULL,
  `b_reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `b_banned` varchar(100) NOT NULL,
  `b_unban` varchar(100) NOT NULL,
  `b_permanent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`b_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.banneds: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.bcchousing
CREATE TABLE IF NOT EXISTS `bcchousing` (
  `charidentifier` varchar(50) NOT NULL,
  `house_coords` longtext NOT NULL,
  `house_radius_limit` varchar(100) NOT NULL,
  `houseid` int(11) NOT NULL AUTO_INCREMENT,
  `furniture` longtext NOT NULL DEFAULT 'none',
  `doors` longtext NOT NULL DEFAULT 'none',
  `allowed_ids` longtext NOT NULL DEFAULT 'none',
  `invlimit` varchar(50) NOT NULL DEFAULT '200',
  `player_source_spawnedfurn` varchar(50) NOT NULL DEFAULT 'none',
  `taxes_collected` varchar(50) NOT NULL DEFAULT 'false',
  `ledger` int(11) NOT NULL DEFAULT 0,
  `tax_amount` int(11) NOT NULL DEFAULT 0,
  `tpInt` int(10) DEFAULT 0,
  `tpInstance` int(10) DEFAULT 0,
  PRIMARY KEY (`houseid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.bcchousing: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.bcchousinghotels
CREATE TABLE IF NOT EXISTS `bcchousinghotels` (
  `charidentifier` varchar(50) NOT NULL,
  `hotels` longtext NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.bcchousinghotels: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `bill_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `sender_account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sender_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sender_citizenid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `recipient_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `recipient_citizenid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table vorpcore_34e5f3.bills: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.birds
CREATE TABLE IF NOT EXISTS `birds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `model` int(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `preset` int(2) NOT NULL DEFAULT 0,
  `xp` int(6) NOT NULL DEFAULT 0,
  `price` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.birds: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.boats
CREATE TABLE IF NOT EXISTS `boats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.boats: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.bountyboard
CREATE TABLE IF NOT EXISTS `bountyboard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT '',
  `bounty` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.bountyboard: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `steamname` varchar(50) NOT NULL DEFAULT '',
  `charidentifier` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(10) DEFAULT 'user',
  `money` double(11,2) DEFAULT 0.00,
  `gold` double(11,2) DEFAULT 0.00,
  `rol` double(11,2) NOT NULL DEFAULT 0.00,
  `xp` int(11) DEFAULT 0,
  `healthouter` int(4) DEFAULT 500,
  `healthinner` int(4) DEFAULT 100,
  `staminaouter` int(4) DEFAULT 100,
  `staminainner` int(4) DEFAULT 100,
  `hours` float NOT NULL DEFAULT 0,
  `LastLogin` date DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `joblabel` varchar(255) DEFAULT 'job label',
  `status` varchar(140) DEFAULT '{}',
  `meta` varchar(255) NOT NULL DEFAULT '{}',
  `firstname` varchar(50) DEFAULT ' ',
  `lastname` varchar(50) DEFAULT ' ',
  `age` int(11) NOT NULL DEFAULT 0,
  `character_desc` mediumtext NOT NULL DEFAULT 'none',
  `nickname` varchar(50) DEFAULT 'none',
  `gender` varchar(50) NOT NULL DEFAULT 'none',
  `skinPlayer` longtext DEFAULT NULL,
  `compPlayer` longtext DEFAULT NULL,
  `compTints` longtext DEFAULT NULL,
  `jobgrade` int(11) DEFAULT 0,
  `coords` longtext DEFAULT NULL,
  `isdead` tinyint(1) DEFAULT 0,
  `clanid` int(11) DEFAULT 0,
  `trust` int(11) DEFAULT 0,
  `supporter` int(11) DEFAULT 0,
  `walk` varchar(50) DEFAULT 'noanim',
  `crafting` longtext DEFAULT '{"medical":0,"blacksmith":0,"basic":0,"survival":0,"brewing":0,"food":0}',
  `info` longtext DEFAULT '{}',
  `gunsmith` double(11,2) DEFAULT 0.00,
  `ammo` longtext DEFAULT '{}',
  `clan` int(11) DEFAULT 0,
  `discordid` varchar(255) DEFAULT '0',
  `lastjoined` longtext DEFAULT '[]',
  `motel` varchar(255) DEFAULT '0',
  `moonshineenty` longtext DEFAULT '{}',
  `ranchid` int(10) DEFAULT 0,
  UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE,
  KEY `charidentifier` (`charidentifier`) USING BTREE,
  KEY `clanid` (`clanid`),
  KEY `crafting` (`crafting`(768)),
  KEY `compPlayer` (`compPlayer`(768)),
  KEY `info` (`info`(768)),
  KEY `inventory` (`inventory`(768)),
  KEY `coords` (`coords`(768)),
  KEY `money` (`money`),
  KEY `meta` (`meta`),
  KEY `steamname` (`steamname`),
  KEY `ammo` (`ammo`(768)),
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.characters: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.character_inventories
CREATE TABLE IF NOT EXISTS `character_inventories` (
  `character_id` int(11) DEFAULT NULL,
  `inventory_type` varchar(100) NOT NULL DEFAULT 'default',
  `item_crafted_id` int(11) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  KEY `character_inventory_idx` (`character_id`,`inventory_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.character_inventories: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.child
CREATE TABLE IF NOT EXISTS `child` (
  `identifier` varchar(40) NOT NULL,
  `charidentifier` int(11) NOT NULL DEFAULT 0,
  `dog` varchar(255) NOT NULL,
  `skin` int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.child: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.companions
CREATE TABLE IF NOT EXISTS `companions` (
  `identifier` varchar(40) NOT NULL,
  `charidentifier` int(11) NOT NULL DEFAULT 0,
  `dog` varchar(255) NOT NULL,
  `skin` int(11) NOT NULL DEFAULT 0,
  `xp` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.companions: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.container
CREATE TABLE IF NOT EXISTS `container` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `items` longtext NOT NULL DEFAULT '{}',
  `invslots` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.container: ~4 rows (approximately)
INSERT INTO `container` (`id`, `name`, `items`, `invslots`) VALUES
	(1, 'police', '[{"label":"Revolver Ammo Normal","limit":10,"type":"item_standard","count":1,"name":"ammorevolvernormal"},{"count":1,"limit":20,"name":"salt","label":"Salt","type":"item_standard"}]', 0),
	(2, 'miner', '[]', 0),
	(3, 'horsetrainer', '[]', 0),
	(4, 'doctor', '[]', 0);

-- Dumping structure for table vorpcore_34e5f3.doorlocks
CREATE TABLE IF NOT EXISTS `doorlocks` (
  `doorid` int(11) NOT NULL AUTO_INCREMENT,
  `doorinfo` longtext NOT NULL,
  `jobsallowedtoopen` longtext NOT NULL DEFAULT 'none',
  `keyitem` varchar(50) NOT NULL DEFAULT 'none',
  `locked` varchar(50) NOT NULL DEFAULT 'false',
  `ids_allowed` longtext DEFAULT NULL,
  PRIMARY KEY (`doorid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.doorlocks: ~1 rows (approximately)
INSERT INTO `doorlocks` (`doorid`, `doorinfo`, `jobsallowedtoopen`, `keyitem`, `locked`, `ids_allowed`) VALUES
	(1, '[688797849,1650744725,"p_door33x",-3680.8815917969,-2624.1164550781,-14.401723861694]', '[]', 'none', 'true', '[]');

-- Dumping structure for table vorpcore_34e5f3.doors
CREATE TABLE IF NOT EXISTS `doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doorinfo` longtext NOT NULL DEFAULT '[]',
  `job` longtext NOT NULL DEFAULT '[]',
  `item` longtext NOT NULL,
  `break` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.doors: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.farmanimals
CREATE TABLE IF NOT EXISTS `farmanimals` (
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `animalid` int(10) NOT NULL,
  `model` bigint(32) NOT NULL,
  `preset` int(2) NOT NULL,
  `name` varchar(50) NOT NULL,
  `xp` int(5) NOT NULL,
  `price` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.farmanimals: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.herbalists
CREATE TABLE IF NOT EXISTS `herbalists` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.herbalists: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.horses
CREATE TABLE IF NOT EXISTS `horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components` varchar(5000) NOT NULL DEFAULT '{}',
  `exp` int(11) NOT NULL DEFAULT 0,
  `items` longtext DEFAULT '{}',
  `sex` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  KEY `model` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.horses: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.horse_complements
CREATE TABLE IF NOT EXISTS `horse_complements` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `complements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.horse_complements: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.housing
CREATE TABLE IF NOT EXISTS `housing` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `key` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.housing: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.invoice
CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `montant` int(255) NOT NULL,
  `business` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.invoice: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.items
CREATE TABLE IF NOT EXISTS `items` (
  `item` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT 1,
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(50) DEFAULT NULL,
  `usable` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'Item Group ID for Filtering',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}' CHECK (json_valid(`metadata`)),
  `desc` varchar(5550) NOT NULL DEFAULT 'nice item',
  PRIMARY KEY (`item`) USING BTREE,
  UNIQUE KEY `id` (`id`),
  KEY `FK_items_item_group` (`groupId`),
  CONSTRAINT `FK_items_item_group` FOREIGN KEY (`groupId`) REFERENCES `item_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2601 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.items: ~832 rows (approximately)
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`) VALUES
	('acid', 'Acid', 10, 1, 'item_standard', 1, 1, 1, '{}', 'nice item'),
	('Agarita', 'Agarita', 21, 1, 'item_standard', 1, 2, 1, '{}', 'nice item'),
	('Agarita_Seed', 'Agarita Seed', 10, 1, 'item_standard', 1, 3, 1, '{}', 'nice item'),
	('Alaskan_Ginseng', 'Alaskan Ginseng', 21, 1, 'item_standard', 1, 4, 1, '{}', 'nice item'),
	('Alaskan_Ginseng_Seed', 'Alaskan Ginseng Seed', 10, 1, 'item_standard', 1, 5, 1, '{}', 'nice item'),
	('alcohol', 'Alcohol', 10, 1, 'item_standard', 1, 6, 1, '{}', 'nice item'),
	('aligatormeat', 'Alligator Meat', 20, 1, 'item_standard', 1, 568, 1, '{}', 'nice item'),
	('aligators', 'Alligator pelt', 20, 1, 'item_standard', 1, 544, 1, '{}', 'nice item'),
	('aligatorto', 'Alligator tooth', 20, 1, 'item_standard', 1, 543, 1, '{}', 'nice item'),
	('American_Ginseng', 'American Ginseng', 21, 1, 'item_standard', 1, 7, 1, '{}', 'nice item'),
	('American_Ginseng_Seed', 'American Ginseng Seed', 10, 1, 'item_standard', 1, 8, 1, '{}', 'nice item'),
	('ammoarrowdynamite', 'Arrow Dynamite', 10, 1, 'item_standard', 1, 10, 1, '{}', 'nice item'),
	('ammoarrowfire', 'Arrow Fire', 10, 1, 'item_standard', 1, 11, 1, '{}', 'nice item'),
	('ammoarrowimproved', 'Arrow Improved', 10, 1, 'item_standard', 1, 12, 1, '{}', 'nice item'),
	('ammoarrownormal', 'Arrow Normal', 10, 1, 'item_standard', 1, 9, 1, '{}', 'nice item'),
	('ammoarrowpoison', 'Arrow Poison', 10, 1, 'item_standard', 1, 13, 1, '{}', 'nice item'),
	('ammoarrowsmallgame', 'Arrow Small Game', 10, 1, 'item_standard', 1, 14, 1, '{}', 'nice item'),
	('ammobolahawk', 'Bola Ammo Hawk', 10, 1, 'item_standard', 1, 15, 1, '{}', 'nice item'),
	('ammobolainterwired', 'Bola Ammo Interwired', 10, 1, 'item_standard', 1, 16, 1, '{}', 'nice item'),
	('ammobolaironspiked', 'Bola Ammo Ironspiked', 10, 1, 'item_standard', 1, 17, 1, '{}', 'nice item'),
	('ammobolla', 'Bolla Ammo', 10, 1, 'item_standard', 1, 18, 1, '{}', 'nice item'),
	('ammodynamite', 'Dynamite Ammo', 10, 1, 'item_standard', 1, 19, 1, '{}', 'nice item'),
	('ammoelephant', 'Elephant Rifle Ammo', 10, 1, 'item_standard', 1, 20, 1, '{}', 'nice item'),
	('ammoknives', 'Knives Ammo', 10, 1, 'item_standard', 1, 21, 1, '{}', 'nice item'),
	('ammomolotov', 'Molotov Ammo', 10, 1, 'item_standard', 1, 22, 1, '{}', 'nice item'),
	('ammopistolexplosive', 'Pistol Ammo Explosive', 10, 1, 'item_standard', 1, 23, 1, '{}', 'nice item'),
	('ammopistolexpress', 'Pistol Ammo Express', 10, 1, 'item_standard', 1, 24, 1, '{}', 'nice item'),
	('ammopistolnormal', 'Pistol Ammo Normal', 10, 1, 'item_standard', 1, 25, 1, '{}', 'nice item'),
	('ammopistolsplitpoint', 'Pistol Ammo Splitpoint', 10, 1, 'item_standard', 1, 26, 1, '{}', 'nice item'),
	('ammopistolvelocity', 'Pistol Ammo Velocity', 10, 1, 'item_standard', 1, 27, 1, '{}', 'nice item'),
	('ammopoisonbottle', 'Poison Bottle Ammo', 10, 1, 'item_standard', 1, 28, 1, '{}', 'nice item'),
	('ammorepeaterexplosive', 'Repeater Ammo Explosive', 10, 1, 'item_standard', 1, 29, 1, '{}', 'nice item'),
	('ammorepeaterexpress', 'Repeater Ammo Express', 10, 1, 'item_standard', 1, 30, 1, '{}', 'nice item'),
	('ammorepeaternormal', 'Repeater Ammo Normal', 10, 1, 'item_standard', 1, 31, 1, '{}', 'nice item'),
	('ammorepeatersplitpoint', 'Repeater Ammo Splitpoint', 10, 1, 'item_standard', 1, 32, 1, '{}', 'nice item'),
	('ammorepeatervelocity', 'Repeater Ammo Velocity', 10, 1, 'item_standard', 1, 33, 1, '{}', 'nice item'),
	('ammorevolverexplosive', 'Revolver Ammo Explosive', 10, 1, 'item_standard', 1, 34, 1, '{}', 'nice item'),
	('ammorevolverexpress', 'Revolver Ammo Express', 10, 1, 'item_standard', 1, 35, 1, '{}', 'nice item'),
	('ammorevolvernormal', 'Revolver Ammo Normal', 10, 1, 'item_standard', 1, 36, 1, '{}', 'nice item'),
	('ammorevolversplitpoint', 'Revolver Ammo Splitpoint', 10, 1, 'item_standard', 1, 37, 1, '{}', 'nice item'),
	('ammorevolvervelocity', 'Revolver Ammo Velocity', 10, 1, 'item_standard', 1, 38, 1, '{}', 'nice item'),
	('ammorifleexplosive', 'Rifle Ammo Explosive', 10, 1, 'item_standard', 1, 39, 1, '{}', 'nice item'),
	('ammorifleexpress', 'Rifle Ammo Express', 10, 1, 'item_standard', 1, 40, 1, '{}', 'nice item'),
	('ammoriflenormal', 'Rifle Ammo Normal', 10, 1, 'item_standard', 1, 41, 1, '{}', 'nice item'),
	('ammoriflesplitpoint', 'Rifle Ammo Splitpoint', 10, 1, 'item_standard', 1, 42, 1, '{}', 'nice item'),
	('ammoriflevelocity', 'Rifle Ammo Velocity', 10, 1, 'item_standard', 1, 43, 1, '{}', 'nice item'),
	('ammoshotgunexplosive', 'Shotgun Ammo Explosive', 10, 1, 'item_standard', 1, 44, 1, '{}', 'nice item'),
	('ammoshotgunincendiary', 'Shotgun Ammo Incendiary', 10, 1, 'item_standard', 1, 45, 1, '{}', 'nice item'),
	('ammoshotgunnormal', 'Shotgun Ammo Normal', 10, 1, 'item_standard', 1, 46, 1, '{}', 'nice item'),
	('ammoshotgunslug', 'Shotgun Ammo Slug', 10, 1, 'item_standard', 1, 47, 1, '{}', 'nice item'),
	('ammotomahawk', 'Tonmahawk Ammo', 10, 1, 'item_standard', 1, 48, 1, '{}', 'nice item'),
	('ammovarmint', 'Varmint Ammo', 10, 1, 'item_standard', 1, 49, 1, '{}', 'nice item'),
	('ammovarminttranq', 'Varmint Tranquilizer Ammo', 10, 1, 'item_standard', 1, 50, 1, '{}', 'nice item'),
	('ammovoldynamite', 'Volatile Dynamite Ammo', 10, 1, 'item_standard', 1, 51, 1, '{}', 'nice item'),
	('ammovolmolotov', 'Volatile Molotov Ammo', 10, 1, 'item_standard', 1, 52, 1, '{}', 'nice item'),
	('antipoison', 'Antipoison', 20, 1, 'item_standard', 1, 53, 1, '{}', 'nice item'),
	('antipoison2', 'Anti Snake Poison', 20, 1, 'item_standard', 1, 617, 1, '{}', 'nice item'),
	('apple', 'Apple', 21, 1, 'item_standard', 1, 54, 1, '{}', 'nice item'),
	('applebarrel', 'Apple Barrel', 20, 1, 'item_standard', 1, 762, 1, '{}', 'nice item'),
	('applebasket', 'Apple Basket', 20, 1, 'item_standard', 1, 763, 1, '{}', 'nice item'),
	('appleCrumbMash', 'Minty Berry Mash', 10, 1, 'item_standard', 1, 55, 1, '{}', 'nice item'),
	('appleCrumbMoonshine', 'Minty Berry Moonshine', 10, 1, 'item_standard', 0, 56, 1, '{}', 'nice item'),
	('apple_barrel', 'Apple Barrel', 20, 1, 'item_standard', 1, 634, 1, '{}', 'nice item'),
	('apple_basket', 'Apple Basket', 20, 1, 'item_standard', 1, 635, 1, '{}', 'nice item'),
	('Apple_Seed', 'Apple Seed', 10, 1, 'item_standard', 1, 727, 1, '{}', 'nice item'),
	('armadilloc', 'Armadillo claws', 20, 1, 'item_standard', 1, 449, 1, '{}', 'nice item'),
	('armadillos', 'Armadillo pelt', 20, 1, 'item_standard', 1, 448, 1, '{}', 'nice item'),
	('asnakes', 'Copperhead Snake pelt', 20, 1, 'item_standard', 1, 487, 1, '{}', 'nice item'),
	('a_c_fishbluegil_01_ms', 'Medium Bluegil', 10, 1, 'item_standard', 0, 57, 1, '{}', 'nice item'),
	('a_c_fishbluegil_01_sm', 'Small Bluegil', 5, 1, 'item_standard', 0, 58, 1, '{}', 'nice item'),
	('a_c_fishbullheadcat_01_ms', 'Medium Bullhead', 10, 1, 'item_standard', 0, 59, 1, '{}', 'nice item'),
	('a_c_fishbullheadcat_01_sm', 'Small Bullhead', 5, 1, 'item_standard', 0, 60, 1, '{}', 'nice item'),
	('a_c_fishchainpickerel_01_ms', 'Medium Pickerel', 10, 1, 'item_standard', 0, 61, 1, '{}', 'nice item'),
	('a_c_fishchainpickerel_01_sm', 'Small Pickerel', 5, 1, 'item_standard', 0, 62, 1, '{}', 'nice item'),
	('a_c_fishchannelcatfish_01_lg', 'Channel Catfish (Large)', 10, 1, 'item_standard', 0, 930, 1, '{}', 'nice item'),
	('a_c_fishchannelcatfish_01_xl', 'Channel Catfish (Extra Large)', 10, 1, 'item_standard', 0, 931, 1, '{}', 'nice item'),
	('a_c_fishlakesturgeon_01_lg', 'Lake Sturgeon (Large)', 10, 1, 'item_standard', 0, 932, 1, '{}', 'nice item'),
	('a_c_fishlargemouthbass_01_lg', 'Large Mouth Bass (Large)', 10, 1, 'item_standard', 0, 933, 1, '{}', 'nice item'),
	('a_c_fishlargemouthbass_01_ms', 'Lardgemouth Bass', 10, 1, 'item_standard', 0, 63, 1, '{}', 'nice item'),
	('a_c_fishlongnosegar_01_lg', 'Long Nose Gar (Large)', 10, 1, 'item_standard', 0, 934, 1, '{}', 'nice item'),
	('a_c_fishmuskie_01_lg', 'Muskie (Large)', 10, 1, 'item_standard', 0, 935, 1, '{}', 'nice item'),
	('a_c_fishnorthernpike_01_lg', 'Northern Pike (Large)', 10, 1, 'item_standard', 0, 936, 1, '{}', 'nice item'),
	('a_c_fishperch_01_ms', 'Medium Perch', 10, 1, 'item_standard', 0, 64, 1, '{}', 'nice item'),
	('a_c_fishperch_01_sm', 'Small Perch', 5, 1, 'item_standard', 0, 65, 1, '{}', 'nice item'),
	('a_c_fishrainbowtrout_01_lg', 'Rainbow Trout (Large)', 10, 1, 'item_standard', 0, 937, 1, '{}', 'nice item'),
	('a_c_fishrainbowtrout_01_ms', 'Rainbow Trout', 10, 1, 'item_standard', 0, 66, 1, '{}', 'nice item'),
	('a_c_fishredfinpickerel_01_ms', 'Medium Redfin Pickerel', 10, 1, 'item_standard', 0, 67, 1, '{}', 'nice item'),
	('a_c_fishredfinpickerel_01_sm', 'Small Redfin Pickerel', 5, 1, 'item_standard', 0, 68, 1, '{}', 'nice item'),
	('a_c_fishrockbass_01_ms', 'Medium Rockbass', 10, 1, 'item_standard', 0, 69, 1, '{}', 'nice item'),
	('a_c_fishrockbass_01_sm', 'Small Rockbass', 5, 1, 'item_standard', 0, 70, 1, '{}', 'nice item'),
	('a_c_fishsalmonsockeye_01_lg', 'Salmon Sockeye (Large)', 10, 1, 'item_standard', 0, 938, 1, '{}', 'nice item'),
	('a_c_fishsalmonsockeye_01_ml', 'Salmon Sockeye (Medium-Large)', 10, 1, 'item_standard', 0, 939, 1, '{}', 'nice item'),
	('a_c_fishsalmonsockeye_01_ms', 'Sockeye Salmon', 10, 1, 'item_standard', 0, 71, 1, '{}', 'nice item'),
	('a_c_fishsmallmouthbass_01_lg', 'Small Mouth Bass (Large)', 10, 1, 'item_standard', 0, 940, 1, '{}', 'nice item'),
	('a_c_fishsmallmouthbass_01_ms', 'Smallmouth Bass', 10, 1, 'item_standard', 0, 72, 1, '{}', 'nice item'),
	('badgers', 'Badger skin', 20, 1, 'item_standard', 1, 491, 1, '{}', 'nice item'),
	('bagofcoal', 'Bag Of Coal', 10, 1, 'item_standard', 0, 1122, 1, '{}', 'nice item'),
	('bait', 'Bait', 20, 1, 'item_standard', 1, 73, 1, '{}', 'nice item'),
	('banana', 'Banana', 20, 1, 'item_standard', 1, 74, 1, '{}', 'nice item'),
	('bandage', 'Bandage', 20, 1, 'item_standard', 1, 75, 1, '{}', 'nice item'),
	('bandage_clean', 'Bandage Clean', 10, 1, 'item_standard', 1, 1131, 1, '{}', 'A clean bandage for medical use.'),
	('bandage_dirty', 'Bandage Dirty', 10, 1, 'item_standard', 1, 1132, 1, '{}', 'A dirty bandage, not ideal for treatment.'),
	('barrel', 'Barrel', 5, 1, 'item_standard', 1, 800, 1, '{}', 'nice item'),
	('bat_c', 'Bat', 20, 1, 'item_standard', 1, 420, 1, '{}', 'nice item'),
	('Bay_Bolete', 'Bay Bolete', 21, 1, 'item_standard', 1, 76, 1, '{}', 'nice item'),
	('Bay_Bolete_Seed', 'Bay Bolete Seed', 10, 1, 'item_standard', 1, 77, 1, '{}', 'nice item'),
	('bbears', 'Black Bear skin', 20, 1, 'item_standard', 1, 452, 1, '{}', 'nice item'),
	('bbirdb', 'Cormorant beak', 20, 1, 'item_standard', 1, 528, 1, '{}', 'nice item'),
	('bbirdf', 'Cormorant feather', 20, 1, 'item_standard', 1, 527, 1, '{}', 'nice item'),
	('bcandle', 'Bottle Candle', 20, 1, 'item_standard', 1, 663, 1, '{}', 'nice item'),
	('bearbench', 'Bear Bench', 20, 1, 'item_standard', 1, 773, 1, '{}', 'nice item'),
	('bearc', 'Bear claws', 20, 1, 'item_standard', 1, 450, 1, '{}', 'nice item'),
	('beart', 'Bear tooth', 20, 1, 'item_standard', 1, 451, 1, '{}', 'nice item'),
	('bear_bench', 'Bear Bench', 20, 1, 'item_standard', 1, 645, 1, '{}', 'nice item'),
	('bear_trap', 'bear trap', 10, 1, 'item_standard', 1, 1130, 1, '{}', 'nice item'),
	('beavertail', 'Beaver tail', 20, 1, 'item_standard', 1, 542, 1, '{}', 'nice item'),
	('beawers', 'Beaver pelt', 20, 1, 'item_standard', 1, 541, 1, '{}', 'nice item'),
	('beef', 'Beef', 20, 1, 'item_standard', 1, 567, 1, '{}', 'nice item'),
	('beefjerky', 'Beef Jerky', 20, 1, 'item_standard', 1, 78, 1, '{}', 'nice item'),
	('beer', 'Beer', 10, 1, 'item_standard', 1, 79, 1, '{}', 'nice item'),
	('beerbox', 'Beer Box', 20, 1, 'item_standard', 1, 586, 1, '{}', 'nice item'),
	('bigchest', 'Big Chest', 1, 1, 'item_standard', 1, 658, 1, '{}', 'nice item'),
	('biggame', 'Big Game Meat', 20, 1, 'item_standard', 1, 565, 1, '{}', 'nice item'),
	('BigGameMeat', 'BigGameMeat', 12, 1, 'item_standard', 1, 1043, 1, '{}', 'nice item'),
	('Big_Leather', 'Big Leather', 10, 1, 'item_standard', 1, 80, 1, '{}', 'nice item'),
	('bird', 'Bird Meat', 20, 1, 'item_standard', 1, 569, 1, '{}', 'nice item'),
	('bisonhorn', 'Bison horn', 20, 1, 'item_standard', 1, 461, 1, '{}', 'nice item'),
	('bisons', 'Bison pelt', 20, 1, 'item_standard', 1, 462, 1, '{}', 'nice item'),
	('Bitter_Weed', 'Bitter Weed', 21, 1, 'item_standard', 1, 81, 1, '{}', 'nice item'),
	('Bitter_Weed_Seed', 'Bitter Weed Seed', 10, 1, 'item_standard', 1, 82, 1, '{}', 'nice item'),
	('blackberryale', 'Black Berry Ale', 21, 1, 'item_standard', 1, 83, 1, '{}', 'nice item'),
	('Black_Berry', 'Black Berry', 21, 1, 'item_standard', 1, 84, 1, '{}', 'nice item'),
	('Black_Berry_Seed', 'Black Berry Seed', 10, 1, 'item_standard', 1, 85, 1, '{}', 'nice item'),
	('Black_Currant', 'Black Currant', 21, 1, 'item_standard', 1, 86, 1, '{}', 'nice item'),
	('Black_Currant_Seed', 'Black Currant Seed', 10, 1, 'item_standard', 1, 87, 1, '{}', 'nice item'),
	('blanketbox', 'Blanket Box', 20, 1, 'item_standard', 1, 760, 1, '{}', 'nice item'),
	('blanket_box', 'Blanket Box', 20, 1, 'item_standard', 1, 632, 1, '{}', 'nice item'),
	('Blood_Flower', 'Blood Flower', 21, 1, 'item_standard', 1, 88, 1, '{}', 'nice item'),
	('Blood_Flower_Seed', 'Blood Flower Seed', 10, 1, 'item_standard', 1, 89, 1, '{}', 'nice item'),
	('blueberry', 'Blueberry', 20, 1, 'item_standard', 1, 90, 1, '{}', 'nice item'),
	('bluejay_c', 'Blue jay', 20, 1, 'item_standard', 1, 421, 1, '{}', 'nice item'),
	('bmdresser', 'brown mirror dresser', 20, 1, 'item_standard', 1, 652, 1, '{}', 'nice item'),
	('boarmusk', 'Boar tusk', 20, 1, 'item_standard', 1, 456, 1, '{}', 'nice item'),
	('boars', 'Boar pelt', 20, 1, 'item_standard', 1, 457, 1, '{}', 'nice item'),
	('boaskin', 'Boa Snake pelt', 20, 1, 'item_standard', 1, 486, 1, '{}', 'nice item'),
	('boiledegg', 'Boiled Egg', 10, 1, 'item_standard', 1, 91, 1, '{}', 'nice item'),
	('boobyb', 'Red-footed booby beak', 20, 1, 'item_standard', 1, 501, 1, '{}', 'nice item'),
	('boobyf', 'Red-footed booby feather', 20, 1, 'item_standard', 1, 500, 1, '{}', 'nice item'),
	('book', 'Book', 5, 1, 'item_standard', 1, 92, 1, '{}', 'nice item'),
	('bountylicns', 'Bounty Hunter License', 10, 1, 'item_standard', 1, 93, 1, '{}', 'nice item'),
	('bouquet', 'Bouquet', 1, 1, 'item_standard', 1, 342, 1, '{}', 'nice item'),
	('bparrotb', 'Parrot beak', 20, 1, 'item_standard', 1, 522, 1, '{}', 'nice item'),
	('bparrotf', 'Parrot feather', 20, 1, 'item_standard', 1, 521, 1, '{}', 'nice item'),
	('broom', 'Broom', 5, 1, 'item_standard', 1, 1127, 1, '{}', 'nice item'),
	('buckantler', 'Buck Antlers', 20, 1, 'item_standard', 1, 459, 1, '{}', 'nice item'),
	('bucks', 'Buck skin', 20, 1, 'item_standard', 1, 460, 1, '{}', 'nice item'),
	('bullhorn', 'Bull horn', 20, 1, 'item_standard', 1, 463, 1, '{}', 'nice item'),
	('bulls', 'Bull pelt', 20, 1, 'item_standard', 1, 464, 1, '{}', 'nice item'),
	('Bulrush', 'Bulrush', 21, 1, 'item_standard', 1, 94, 1, '{}', 'nice item'),
	('Bulrush_Seed', 'Bulrush Seed', 10, 1, 'item_standard', 1, 95, 1, '{}', 'nice item'),
	('bunkbed', 'bunk bed', 20, 1, 'item_standard', 1, 665, 1, '{}', 'nice item'),
	('Burdock_Root', 'Burdock Root', 20, 1, 'item_standard', 1, 96, 1, '{}', 'nice item'),
	('Burdock_Root_Seed', 'Burdock Root Seed', 10, 1, 'item_standard', 1, 97, 1, '{}', 'nice item'),
	('butchertable1', 'Small Butcher Table', 20, 1, 'item_standard', 1, 583, 1, '{}', 'nice item'),
	('butchertable2', 'Medium Butcher Table', 20, 1, 'item_standard', 1, 582, 1, '{}', 'nice item'),
	('butchertable3', 'Large Butcher Table', 20, 1, 'item_standard', 1, 581, 1, '{}', 'nice item'),
	('bwdresser', 'brown wood dresser', 20, 1, 'item_standard', 1, 651, 1, '{}', 'nice item'),
	('camera', 'Camera', 1, 1, 'item_standard', 1, 346, 1, '{}', 'nice item'),
	('campfire', 'Campfire', 5, 1, 'item_standard', 1, 98, 1, '{}', 'nice item'),
	('candlea', 'Candle', 20, 1, 'item_standard', 1, 661, 1, '{}', 'nice item'),
	('cane', 'Cane', 1, 1, 'item_standard', 1, 344, 1, '{}', 'nice item'),
	('canteen', 'Canteen', 1, 1, 'item_standard', 1, 910, 1, '{}', 'nice item'),
	('cardinal_c', 'Cardinal bird', 20, 1, 'item_standard', 1, 422, 1, '{}', 'nice item'),
	('Cardinal_Flower', 'Cardinal Flower', 21, 1, 'item_standard', 1, 99, 1, '{}', 'nice item'),
	('Cardinal_Flower_Seed', 'Cardinal Flower Seed', 10, 1, 'item_standard', 1, 100, 1, '{}', 'nice item'),
	('carrots', 'Carrot', 10, 1, 'item_standard', 1, 101, 1, '{}', 'nice item'),
	('cedarwaxwing_c', 'Cedar waxwing', 20, 1, 'item_standard', 1, 423, 1, '{}', 'nice item'),
	('Chanterelles', 'Chanterelles', 21, 1, 'item_standard', 1, 102, 1, '{}', 'nice item'),
	('Chanterelles_Seed', 'Chanterelles Seed', 10, 1, 'item_standard', 1, 103, 1, '{}', 'nice item'),
	('char', 'Char', 10, 1, 'item_standard', 0, 104, 1, '{}', 'nice item'),
	('chestc', 'Chest C', 20, 1, 'item_standard', 1, 578, 1, '{}', 'nice item'),
	('chewingtobacco', 'Chewing Tobacco', 20, 1, 'item_standard', 1, 105, 1, '{}', 'nice item'),
	('chickenf', 'Chicken feather', 20, 1, 'item_standard', 1, 525, 1, '{}', 'nice item'),
	('chickenheart', 'Chicken heart', 20, 1, 'item_standard', 1, 526, 1, '{}', 'nice item'),
	('chipmunk_c', 'Chipmunk', 20, 1, 'item_standard', 1, 419, 1, '{}', 'nice item'),
	('Choc_Daisy', 'Choc Daisy', 21, 1, 'item_standard', 1, 106, 1, '{}', 'nice item'),
	('Choc_Daisy_Seed', 'Choc Daisy Seed', 10, 1, 'item_standard', 1, 107, 1, '{}', 'nice item'),
	('cigar', 'Cigar', 20, 1, 'item_standard', 1, 108, 1, '{}', 'nice item'),
	('cigarette', 'Cigarette', 20, 1, 'item_standard', 1, 109, 1, '{}', 'nice item'),
	('cigarettefilter', 'Cig Filter', 20, 1, 'item_standard', 1, 110, 1, '{}', 'nice item'),
	('cinematicket', 'Ticket', 2, 1, 'item_standard', 0, 351, 1, '{}', 'nice item'),
	('clay', 'Clay', 20, 1, 'item_standard', 1, 111, 1, '{}', 'nice item'),
	('cleanser', 'Cleanser', 5, 1, 'item_standard', 1, 340, 1, '{}', 'nice item'),
	('clothbench', 'Cloth Bench', 20, 1, 'item_standard', 1, 776, 1, '{}', 'nice item'),
	('clothesline', 'Clothes Line', 20, 1, 'item_standard', 1, 766, 1, '{}', 'nice item'),
	('clothes_line', 'Clothes Line', 20, 1, 'item_standard', 1, 638, 1, '{}', 'nice item'),
	('cloth_bench', 'Cloth Bench', 20, 1, 'item_standard', 1, 648, 1, '{}', 'nice item'),
	('coal', 'Coal', 20, 1, 'item_standard', 1, 112, 1, '{}', 'nice item'),
	('cockc', 'Rooster claws', 20, 1, 'item_standard', 1, 499, 1, '{}', 'nice item'),
	('cockf', 'Rooster feather', 20, 1, 'item_standard', 1, 498, 1, '{}', 'nice item'),
	('cocoa', 'Cocoa', 21, 1, 'item_standard', 1, 113, 1, '{}', 'nice item'),
	('cocoaseeds', 'Cocoa Seeds', 10, 1, 'item_standard', 1, 733, 1, '{}', 'nice item'),
	('coffindecor', 'Coffin Decor', 20, 1, 'item_standard', 1, 629, 1, '{}', 'nice item'),
	('compass', 'Compass ', 1, 1, 'item_standard', 0, 1141, 1, '{}', 'nice item'),
	('condenser', 'Condenser', 5, 1, 'item_standard', 1, 816, 1, '{}', 'nice item'),
	('condorb', 'Condor beak', 20, 1, 'item_standard', 1, 480, 1, '{}', 'nice item'),
	('condorf', 'Condor feather', 20, 1, 'item_standard', 1, 479, 1, '{}', 'nice item'),
	('consumable_applepie', 'applepie', 12, 1, 'item_standard', 1, 1038, 1, '{}', 'nice item'),
	('consumable_blueberrypie', 'blueberrypie', 25, 1, 'item_standard', 1, 1041, 1, '{}', 'nice item'),
	('consumable_bluegil', 'Dried Bluegil', 10, 1, 'item_standard', 1, 114, 1, '{}', 'nice item'),
	('consumable_breakfast', 'Breakfast', 5, 1, 'item_standard', 1, 115, 1, '{}', 'nice item'),
	('consumable_caramel', 'Caramel', 5, 1, 'item_standard', 1, 116, 1, '{}', 'nice item'),
	('consumable_chocolate', 'Chocolate Bar', 10, 1, 'item_standard', 1, 117, 1, '{}', 'nice item'),
	('consumable_coffee', 'Coffee', 5, 1, 'item_standard', 1, 118, 1, '{}', 'nice item'),
	('consumable_fruitsalad', 'Fruit Salad', 5, 1, 'item_standard', 1, 119, 1, '{}', 'nice item'),
	('consumable_game', 'Jerkied GameMeat', 10, 1, 'item_standard', 1, 120, 1, '{}', 'nice item'),
	('consumable_haycube', 'Haycube', 10, 1, 'item_standard', 1, 121, 1, '{}', 'nice item'),
	('consumable_herb_chanterelles', 'Chanterelles', 10, 1, 'item_standard', 1, 122, 1, '{}', 'nice item'),
	('consumable_herb_evergreen_huckleberry', 'Evergreen Huckleberry', 10, 1, 'item_standard', 1, 123, 1, '{}', 'nice item'),
	('consumable_herb_oregano', 'Oregano', 10, 1, 'item_standard', 1, 124, 1, '{}', 'nice item'),
	('consumable_herb_vanilla_flower', 'Vanilla Flower', 10, 1, 'item_standard', 1, 125, 1, '{}', 'nice item'),
	('consumable_herb_wintergreen_berry', 'Wintergreen Berry', 10, 1, 'item_standard', 1, 126, 1, '{}', 'nice item'),
	('consumable_kidneybeans_can', 'Kidney Beans', 5, 1, 'item_standard', 1, 127, 1, '{}', 'nice item'),
	('consumable_lock_breaker', 'Lock Breaker', 10, 1, 'item_standard', 1, 128, 1, '{}', 'nice item'),
	('consumable_meat_greavy', 'Meat Stew', 12, 1, 'item_standard', 1, 129, 1, '{}', 'nice item'),
	('consumable_medicine', 'Medicine', 10, 1, 'item_standard', 1, 130, 1, '{}', 'nice item'),
	('consumable_peach', 'Peach', 5, 1, 'item_standard', 1, 131, 1, '{}', 'nice item'),
	('consumable_pear', 'Pear', 10, 1, 'item_standard', 1, 132, 1, '{}', 'nice item'),
	('consumable_raspberrywater', 'Berry Water', 10, 1, 'item_standard', 1, 133, 1, '{}', 'nice item'),
	('consumable_salmon', 'Dried Salmon', 10, 1, 'item_standard', 1, 134, 1, '{}', 'nice item'),
	('consumable_salmon_can', 'Salmon Can', 10, 1, 'item_standard', 1, 135, 1, '{}', 'nice item'),
	('consumable_trout', 'Cooked Trout', 10, 1, 'item_standard', 1, 136, 1, '{}', 'nice item'),
	('consumable_veggies', 'Edible Veggies', 5, 1, 'item_standard', 1, 137, 1, '{}', 'nice item'),
	('CookedBigGameMeat', 'CookedBigGameMeat', 25, 1, 'item_standard', 1, 1045, 1, '{}', 'nice item'),
	('cookedbird', 'cookedbird', 12, 1, 'item_standard', 1, 1048, 1, '{}', 'nice item'),
	('cookedbluegil', 'Cooked Bluegil with Veggies', 5, 1, 'item_standard', 1, 138, 1, '{}', 'nice item'),
	('cookedpork', 'cookedpork', 25, 1, 'item_standard', 1, 1046, 1, '{}', 'nice item'),
	('cookedsmallgame', 'cookedsmallgame', 25, 1, 'item_standard', 0, 1037, 1, '{}', 'nice item'),
	('copper', 'Copper', 30, 1, 'item_standard', 1, 139, 1, '{}', 'nice item'),
	('corn', 'Corn', 10, 1, 'item_standard', 1, 140, 1, '{}', 'nice item'),
	('cornseed', 'Corn seed', 10, 1, 'item_standard', 1, 141, 1, '{}', 'nice item'),
	('cougarf', 'Cougar tooth', 20, 1, 'item_standard', 1, 558, 1, '{}', 'nice item'),
	('cougars', 'Cougar skin', 20, 1, 'item_standard', 1, 557, 1, '{}', 'nice item'),
	('cougartaxi', 'Cougar Taxidermy', 20, 1, 'item_standard', 1, 771, 1, '{}', 'nice item'),
	('cougar_taxidermy', 'Cougar Taxidermy', 20, 1, 'item_standard', 1, 643, 1, '{}', 'nice item'),
	('cowh', 'Cow horn', 20, 1, 'item_standard', 1, 562, 1, '{}', 'nice item'),
	('cows', 'Cow pelt', 20, 1, 'item_standard', 1, 561, 1, '{}', 'nice item'),
	('coyotef', 'Coyote tooth', 20, 1, 'item_standard', 1, 560, 1, '{}', 'nice item'),
	('coyotepelt', 'Coyote Pelt', 20, 1, 'item_standard', 1, 759, 1, '{}', 'nice item'),
	('coyotes', 'Coyote skin', 20, 1, 'item_standard', 1, 559, 1, '{}', 'nice item'),
	('coyotetaxi', 'Coyote Taxidermy', 20, 1, 'item_standard', 1, 768, 1, '{}', 'nice item'),
	('coyote_pelt', 'Coyote Pelt', 20, 1, 'item_standard', 1, 631, 1, '{}', 'nice item'),
	('coyote_taxidermy', 'Coyote Taxidermy', 20, 1, 'item_standard', 1, 640, 1, '{}', 'nice item'),
	('crab_c', 'Crab', 20, 1, 'item_standard', 1, 425, 1, '{}', 'nice item'),
	('Cradle1', 'Cradle1', 1, 1, 'item_standard', 1, 1063, 1, '{}', 'nice item'),
	('craftingfire', 'Crafting Fire', 20, 1, 'item_standard', 1, 753, 1, '{}', 'nice item'),
	('crafting_fire', 'Crafting Fire', 20, 1, 'item_standard', 1, 625, 1, '{}', 'nice item'),
	('crawfish_c', 'Crawfish', 20, 1, 'item_standard', 1, 424, 1, '{}', 'nice item'),
	('Creeking_Thyme', 'Creeping Thyme', 21, 1, 'item_standard', 1, 142, 1, '{}', 'nice item'),
	('Creeking_Thyme_Seed', 'Creeping Thyme Seed', 10, 1, 'item_standard', 1, 143, 1, '{}', 'nice item'),
	('Creekplum', 'Creekplum', 21, 1, 'item_standard', 1, 144, 1, '{}', 'nice item'),
	('Creekplum_Seed', 'Creekplum Seed', 10, 1, 'item_standard', 1, 145, 1, '{}', 'nice item'),
	('Crows_Garlic', 'Crows Garlic', 21, 1, 'item_standard', 1, 146, 1, '{}', 'nice item'),
	('Crows_Garlic_Seed', 'Crows Garlic Seed', 10, 1, 'item_standard', 1, 147, 1, '{}', 'nice item'),
	('crow_c', 'Crow', 20, 1, 'item_standard', 1, 426, 1, '{}', 'nice item'),
	('darub', 'Crane beak', 20, 1, 'item_standard', 1, 530, 1, '{}', 'nice item'),
	('daruf', 'Crane feather', 20, 1, 'item_standard', 1, 529, 1, '{}', 'nice item'),
	('dbcandle', 'Dbl Candle', 20, 1, 'item_standard', 1, 660, 1, '{}', 'nice item'),
	('decortent1', 'Decor Tent 1 Set', 20, 1, 'item_standard', 1, 600, 1, '{}', 'nice item'),
	('decortent2', 'Decor Tent 2 Set', 20, 1, 'item_standard', 1, 601, 1, '{}', 'nice item'),
	('decortent3', 'Decor Tent 3 Set', 20, 1, 'item_standard', 1, 602, 1, '{}', 'nice item'),
	('deerheart', 'Deer heart', 20, 1, 'item_standard', 1, 466, 1, '{}', 'nice item'),
	('deerpelt', 'Deer Pelt', 20, 1, 'item_standard', 1, 758, 1, '{}', 'nice item'),
	('deerskin', 'Deer skin', 20, 1, 'item_standard', 1, 465, 1, '{}', 'nice item'),
	('deertaxi', 'Deer Taxidermy', 20, 1, 'item_standard', 1, 770, 1, '{}', 'nice item'),
	('deer_pelt', 'Deer Pelt', 20, 1, 'item_standard', 1, 630, 1, '{}', 'nice item'),
	('deer_taxidermy', 'Deer Taxidermy', 20, 1, 'item_standard', 1, 642, 1, '{}', 'nice item'),
	('Desert_Sage', 'Desert Sage', 21, 1, 'item_standard', 1, 148, 1, '{}', 'nice item'),
	('Desert_Sage_Seed', 'Desert Sage Seed', 10, 1, 'item_standard', 1, 149, 1, '{}', 'nice item'),
	('diamond', 'Diamond', 20, 1, 'item_standard', 1, 150, 1, '{}', 'nice item'),
	('dino_bone', 'Dinosaur Bone', 5, 1, 'item_standard', 1, 1125, 1, '{}', 'A dinosaur bone.'),
	('dleguans', 'Desert Iguana pelt', 20, 1, 'item_standard', 1, 551, 1, '{}', 'nice item'),
	('dreamcatcher', 'Dream Catcher', 20, 1, 'item_standard', 1, 591, 1, '{}', 'nice item'),
	('Drink_For_Dog', 'Pet Water', 10, 1, 'item_standard', 1, 151, 1, '{}', 'nice item'),
	('duckfat', 'Duck fat', 20, 1, 'item_standard', 1, 467, 1, '{}', 'nice item'),
	('Duck_Egg', 'Duck Egg', 10, 1, 'item_standard', 1, 152, 1, '{}', 'nice item'),
	('dynamite', 'Pipe charge dynamite', 30, 1, 'item_standard', 1, 153, 1, '{}', 'nice item'),
	('dynamitebundle', 'Dynamite Bundle', 10, 1, 'item_standard', 0, 1124, 1, '{}', 'nice item'),
	('eaglef', 'Eagle feather', 20, 1, 'item_standard', 1, 468, 1, '{}', 'nice item'),
	('eaglet', 'Eagle claws', 20, 1, 'item_standard', 1, 469, 1, '{}', 'nice item'),
	('egg', 'Egg', 20, 1, 'item_standard', 1, 796, 1, '{}', 'nice item'),
	('eggs', 'Egg', 50, 1, 'item_standard', 1, 154, 1, '{}', 'nice item'),
	('egretb', 'Snowy Egret beak', 20, 1, 'item_standard', 1, 473, 1, '{}', 'nice item'),
	('egretf', 'Snowy Egret feather', 20, 1, 'item_standard', 1, 472, 1, '{}', 'nice item'),
	('elkantler', 'Elk antler', 20, 1, 'item_standard', 1, 474, 1, '{}', 'nice item'),
	('elks', 'Vapiti pelt', 20, 1, 'item_standard', 1, 475, 1, '{}', 'nice item'),
	('emerald', 'Emerald', 20, 1, 'item_standard', 1, 155, 1, '{}', 'nice item'),
	('English_Mace', 'English Mace', 21, 1, 'item_standard', 1, 156, 1, '{}', 'nice item'),
	('English_Mace_Seed', 'English Mace Seed', 10, 1, 'item_standard', 1, 157, 1, '{}', 'nice item'),
	('Evergreen_Huckleberry', 'Evergreen Huckleberry', 21, 1, 'item_standard', 1, 158, 1, '{}', 'nice item'),
	('Evergreen_Huckleberry_Seed', 'Evergreen Huckleberry Seed', 10, 1, 'item_standard', 1, 159, 1, '{}', 'nice item'),
	('fan', 'Fan', 5, 1, 'item_standard', 1, 160, 1, '{}', 'nice item'),
	('fancydouble', 'fancy double', 20, 1, 'item_standard', 1, 667, 1, '{}', 'nice item'),
	('Fat', 'Animal Fat', 10, 1, 'item_standard', 1, 161, 1, '{}', 'nice item'),
	('Feather', 'Feather', 20, 1, 'item_standard', 1, 162, 1, '{}', 'nice item'),
	('Feed_For_Dog', 'Dog Food', 10, 1, 'item_standard', 1, 163, 1, '{}', 'nice item'),
	('fertilizer', 'Fertilizer', 20, 1, 'item_standard', 1, 736, 1, '{}', 'nice item'),
	('fertilizerbless', 'Blessed Fertilizer', 10, 1, 'item_standard', 1, 738, 1, '{}', 'nice item'),
	('fertilizeregg', 'Fertilizer with Eggs', 10, 1, 'item_standard', 1, 737, 1, '{}', 'nice item'),
	('fertilizerpro', 'Fertilizer with Produce', 10, 1, 'item_standard', 1, 740, 1, '{}', 'nice item'),
	('fertilizerpulpsap', 'Fertilizer with Pulp/Sap', 10, 1, 'item_standard', 1, 741, 1, '{}', 'nice item'),
	('fertilizersn', 'Fertilizer with Snake', 10, 1, 'item_standard', 1, 742, 1, '{}', 'nice item'),
	('fertilizersq', 'Fertilizer with Squirrel', 10, 1, 'item_standard', 1, 743, 1, '{}', 'nice item'),
	('fertilizersw', 'Fertilizer with Soft Wood', 10, 1, 'item_standard', 1, 745, 1, '{}', 'nice item'),
	('fertilizerwoj', 'Fertilizer with Wojape', 10, 1, 'item_standard', 1, 744, 1, '{}', 'nice item'),
	('fibers', 'Fibers', 20, 1, 'item_standard', 0, 164, 1, '{}', 'nice item'),
	('fish', 'Fish', 50, 1, 'item_standard', 1, 165, 1, '{}', 'nice item'),
	('fishbait', 'Fishbait', 10, 1, 'item_standard', 1, 166, 1, '{}', 'nice item'),
	('fishchips', 'Fish and Chips', 10, 1, 'item_standard', 1, 167, 1, '{}', 'nice item'),
	('fishmeat', 'Bigfish Meat', 20, 1, 'item_standard', 1, 572, 1, '{}', 'nice item'),
	('flag', 'Camp Flag', 10, 1, 'item_standard', 1, 168, 1, '{}', 'nice item'),
	('flour', 'flour', 25, 1, 'item_standard', 1, 1040, 1, '{}', 'nice item'),
	('flowerboxes', 'Flower Boxes', 20, 1, 'item_standard', 1, 628, 1, '{}', 'nice item'),
	('foodbarrel', 'Food Barrel', 20, 1, 'item_standard', 1, 764, 1, '{}', 'nice item'),
	('food_barrel', 'Food Barrel', 20, 1, 'item_standard', 1, 636, 1, '{}', 'nice item'),
	('foxskin', 'Foxskin', 20, 1, 'item_standard', 1, 512, 1, '{}', 'nice item'),
	('foxt', 'Fox tooth', 20, 1, 'item_standard', 1, 513, 1, '{}', 'nice item'),
	('friedtater', 'Fried Taters', 10, 1, 'item_standard', 1, 169, 1, '{}', 'nice item'),
	('frogbull2_c', 'Poisoned Frogbull', 20, 1, 'item_standard', 1, 428, 1, '{}', 'nice item'),
	('frogbull_c', 'Frogbull', 20, 1, 'item_standard', 1, 427, 1, '{}', 'nice item'),
	('fsnakes', 'Blacktail rattlesnake pelt', 20, 1, 'item_standard', 1, 488, 1, '{}', 'nice item'),
	('game', 'Game Meat', 20, 1, 'item_standard', 1, 570, 1, '{}', 'nice item'),
	('Gamey_Meat', 'Gamey Meat', 10, 1, 'item_standard', 1, 170, 1, '{}', 'nice item'),
	('Gator_Egg_3', 'Aligator Egg 3', 10, 1, 'item_standard', 1, 171, 1, '{}', 'nice item'),
	('Gator_Egg_4', 'Aligator Egg 4', 10, 1, 'item_standard', 1, 172, 1, '{}', 'nice item'),
	('Gator_Egg_5', 'Aligator Egg 5', 10, 1, 'item_standard', 1, 173, 1, '{}', 'nice item'),
	('gbarrelx', 'Gun Barrel', 20, 1, 'item_standard', 1, 761, 1, '{}', 'nice item'),
	('gbears', 'Grizzly Bear skin', 20, 1, 'item_standard', 1, 453, 1, '{}', 'nice item'),
	('ginsengtea', 'Ginseng Tea', 10, 1, 'item_standard', 1, 174, 1, '{}', 'nice item'),
	('glassbottle', 'Glass Bottle', 15, 1, 'item_standard', 1, 175, 1, '{}', 'nice item'),
	('gleguans', 'Green Iguana pelt', 20, 1, 'item_standard', 1, 552, 1, '{}', 'nice item'),
	('goathead', 'Goat head', 20, 1, 'item_standard', 1, 556, 1, '{}', 'nice item'),
	('goats', 'Goat pelt', 20, 1, 'item_standard', 1, 555, 1, '{}', 'nice item'),
	('goldbar', 'GoldBar', 5, 1, 'item_standard', 1, 176, 1, '{}', 'nice item'),
	('Golden_Currant', 'Golden Currant', 21, 1, 'item_standard', 1, 177, 1, '{}', 'nice item'),
	('Golden_Currant_Seed', 'Golden Currant Seed', 10, 1, 'item_standard', 1, 178, 1, '{}', 'nice item'),
	('goldfish', 'Gold Fish', 10, 1, 'item_standard', 0, 179, 1, '{}', 'nice item'),
	('goldnugget', 'goldnugget', 30, 1, 'item_standard', 0, 912, 1, '{}', 'nice item'),
	('goldpan', 'Gold pan', 10, 1, 'item_standard', 1, 181, 1, '{}', 'nice item'),
	('goldring', 'Gold Ring', 10, 1, 'item_standard', 1, 182, 1, '{}', 'nice item'),
	('gold_nugget', 'Gold nugget', 30, 1, 'item_standard', 0, 180, 1, '{}', 'nice item'),
	('gooseb', 'Goose beak', 20, 1, 'item_standard', 1, 532, 1, '{}', 'nice item'),
	('goosef', 'Goose feather', 20, 1, 'item_standard', 1, 531, 1, '{}', 'nice item'),
	('Goose_Egg_4', 'Goose Egg', 10, 1, 'item_standard', 1, 183, 1, '{}', 'nice item'),
	('guitar', 'Classic Guitar', 1, 1, 'item_standard', 1, 341, 1, '{}', 'nice item'),
	('gun_barrel', 'Gun Barrel', 20, 1, 'item_standard', 1, 633, 1, '{}', 'nice item'),
	('gun_oil', 'Gun Oil', 10, 1, 'item_standard', 1, 2600, 1, '{}', 'nice item'),
	('gypsywagon', 'Gypsys Wagon Set', 20, 1, 'item_standard', 1, 585, 1, '{}', 'nice item'),
	('hairpomade', 'Hair Pomade', 5, 1, 'item_standard', 1, 184, 1, '{}', 'nice item'),
	('handcuffs', 'Handcuffs', 10, 1, 'item_standard', 1, 185, 1, '{}', 'nice item'),
	('hatchet', 'Hatchet', 1, 1, 'item_standard', 1, 186, 1, '{}', 'nice item'),
	('hawkf', 'Hawk feather', 20, 1, 'item_standard', 1, 535, 1, '{}', 'nice item'),
	('hawkt', 'Hawk claws', 20, 1, 'item_standard', 1, 536, 1, '{}', 'nice item'),
	('Health_For_Dog', 'Pet Bandages', 10, 1, 'item_standard', 1, 187, 1, '{}', 'nice item'),
	('hemp', 'Hemp', 10, 1, 'item_standard', 1, 188, 1, '{}', 'nice item'),
	('hemp_cig', 'Hemp Cigarette', 1, 1, 'item_standard', 1, 189, 1, '{}', 'nice item'),
	('hemp_seed', 'Hemp Seed', 20, 1, 'item_standard', 1, 615, 1, '{}', 'nice item'),
	('herbal_medicine', 'Herbal Medicine', 20, 1, 'item_standard', 1, 338, 1, '{}', 'nice item'),
	('herbal_tonic', 'Herbal Tonic', 20, 1, 'item_standard', 1, 339, 1, '{}', 'nice item'),
	('herbmed', 'Herbal Remedy', 10, 1, 'item_standard', 1, 190, 1, '{}', 'nice item'),
	('heroin', 'Heroin', 5, 1, 'item_standard', 1, 191, 1, '{}', 'nice item'),
	('herptile', 'Herptile meat', 20, 1, 'item_standard', 1, 573, 1, '{}', 'nice item'),
	('hitchingpost', 'Hitching Post', 20, 1, 'item_standard', 1, 580, 1, '{}', 'nice item'),
	('hk_1', 'House Key', 1, 1, 'item_standard', 1, 1068, 1, '{}', 'nice item'),
	('hk_101', 'House Key Braithwaite Manor', 1, 1, 'item_standard', 1, 1071, 1, '{}', 'nice item'),
	('hk_102', 'House Key Kamassa River', 1, 1, 'item_standard', 1, 1072, 1, '{}', 'nice item'),
	('hk_103', 'House Key Rock Farm', 1, 1, 'item_standard', 1, 1073, 1, '{}', 'nice item'),
	('hk_104', 'House Key Lannahechee River', 1, 1, 'item_standard', 1, 1074, 1, '{}', 'nice item'),
	('hk_105', 'House Key Lake O\'Creagh\'s', 1, 1, 'item_standard', 1, 1075, 1, '{}', 'nice item'),
	('hk_106', 'House Key Southfield Plains', 1, 1, 'item_standard', 1, 1076, 1, '{}', 'nice item'),
	('hk_107', 'House Key the swamp', 1, 1, 'item_standard', 1, 1077, 1, '{}', 'nice item'),
	('hk_108', 'House Key Roanoke Valley', 1, 1, 'item_standard', 1, 1078, 1, '{}', 'nice item'),
	('hk_109', 'House Key  Cabin Rhodes', 1, 1, 'item_standard', 1, 1079, 1, '{}', 'nice item'),
	('hk_110', 'House Key snow town', 1, 1, 'item_standard', 1, 1080, 1, '{}', 'nice item'),
	('hk_111', 'House Key snow', 1, 1, 'item_standard', 1, 1081, 1, '{}', 'nice item'),
	('hk_112', 'House Key Cabin in Valentine', 1, 1, 'item_standard', 1, 1082, 1, '{}', 'nice item'),
	('hk_113', 'House Key Dakota River Cabin', 1, 1, 'item_standard', 1, 1083, 1, '{}', 'nice item'),
	('hk_114', 'House Key Dakota River House', 1, 1, 'item_standard', 1, 1084, 1, '{}', 'nice item'),
	('hk_115', 'House Key Big Valley Farm House', 1, 1, 'item_standard', 1, 1085, 1, '{}', 'nice item'),
	('hk_116', 'House Key Aurora Basin', 1, 1, 'item_standard', 1, 1086, 1, '{}', 'nice item'),
	('hk_117', 'House Key Little Creek River', 1, 1, 'item_standard', 1, 1087, 1, '{}', 'nice item'),
	('hk_118', 'House Key outskirts of Blackwater', 1, 1, 'item_standard', 1, 1088, 1, '{}', 'nice item'),
	('hk_119', 'House Key Little Creek River cabin', 1, 1, 'item_standard', 1, 1089, 1, '{}', 'nice item'),
	('hk_120', 'House Key  Cumberland Forest', 1, 1, 'item_standard', 1, 1090, 1, '{}', 'nice item'),
	('hk_121', 'House Key ', 1, 1, 'item_standard', 1, 1091, 1, '{}', 'nice item'),
	('hk_122', 'House Key Lakay', 1, 1, 'item_standard', 1, 1092, 1, '{}', 'nice item'),
	('hk_123', 'House Key Emerald station', 1, 1, 'item_standard', 1, 1093, 1, '{}', 'nice item'),
	('hk_124', 'House Key Don Julio river', 1, 1, 'item_standard', 1, 1094, 1, '{}', 'nice item'),
	('hk_125', 'House Key Cholla Springs', 1, 1, 'item_standard', 1, 1095, 1, '{}', 'nice item'),
	('hk_126', 'House Key Tumbleweed', 1, 1, 'item_standard', 1, 1096, 1, '{}', 'nice item'),
	('hk_127', 'House Key Big Valley', 1, 1, 'item_standard', 1, 1097, 1, '{}', 'nice item'),
	('hk_128', 'House Key Brandywine  Cabin', 1, 1, 'item_standard', 1, 1098, 1, '{}', 'nice item'),
	('hk_129', 'House Key Eris Fields Forest', 1, 1, 'item_standard', 1, 1099, 1, '{}', 'nice item'),
	('hk_130', 'House Key Cumberland Waterfall', 1, 1, 'item_standard', 1, 1100, 1, '{}', 'nice item'),
	('hk_131', 'House Key Mansion Braithwaite', 1, 1, 'item_standard', 1, 1101, 1, '{}', 'nice item'),
	('hk_132', 'House Key Dodge Ranch', 1, 1, 'item_standard', 1, 1102, 1, '{}', 'nice item'),
	('hk_133', 'House Key Clary Ranch', 1, 1, 'item_standard', 1, 1103, 1, '{}', 'nice item'),
	('hk_134', 'House Key Bluewater Farm', 1, 1, 'item_standard', 1, 1104, 1, '{}', 'nice item'),
	('hk_2', 'House Key', 1, 1, 'item_standard', 1, 1069, 1, '{}', 'nice item'),
	('hk_3', 'House Key', 1, 1, 'item_standard', 1, 1070, 1, '{}', 'nice item'),
	('hoe', 'Garden Hoe', 10, 1, 'item_standard', 1, 679, 1, '{}', 'nice item'),
	('honey', 'Honey', 10, 1, 'item_standard', 1, 192, 1, '{}', 'nice item'),
	('hop', 'Hop', 21, 1, 'item_standard', 1, 685, 1, '{}', 'nice item'),
	('hop_seed', 'Hop Seed', 10, 1, 'item_standard', 1, 684, 1, '{}', 'nice item'),
	('horsebrush', 'Horse Brush', 5, 1, 'item_standard', 1, 193, 1, '{}', 'nice item'),
	('horsehitches', 'Horse Hitches Set', 20, 1, 'item_standard', 1, 603, 1, '{}', 'nice item'),
	('horsemeal', 'Horse ration', 10, 1, 'item_standard', 1, 348, 1, '{}', 'nice item'),
	('Hummingbird_Sage', 'Hummingbird Sage', 21, 1, 'item_standard', 1, 194, 1, '{}', 'nice item'),
	('Hummingbird_Sage_Seed', 'Hummingbird Sage Seed', 10, 1, 'item_standard', 1, 195, 1, '{}', 'nice item'),
	('huntinglicense', 'id card', 10, 1, 'item_standard', 1, 1137, 1, '{}', 'nice item'),
	('hwood', 'Hard Wood', 20, 1, 'item_standard', 0, 196, 1, '{}', 'nice item'),
	('idcard', 'id card', 1, 1, 'item_standard', 0, 1135, 1, '{}', 'nice item'),
	('Indian_Tobbaco', 'Indian Tobbaco', 21, 1, 'item_standard', 1, 197, 1, '{}', 'nice item'),
	('Indian_Tobbaco_Seed', 'Indian Tobbaco Seed', 10, 1, 'item_standard', 1, 198, 1, '{}', 'nice item'),
	('iron', 'Iron Ore', 30, 1, 'item_standard', 1, 199, 1, '{}', 'nice item'),
	('ironbar', 'Iron Bar', 30, 1, 'item_standard', 1, 200, 1, '{}', 'nice item'),
	('ironextract', 'Iron Extract', 1, 1, 'item_standard', 0, 201, 1, '{}', 'nice item'),
	('ironhammer', 'Iron Hammer', 5, 1, 'item_standard', 1, 202, 1, '{}', 'nice item'),
	('kbirdb', 'Great Blue Heron beak', 20, 1, 'item_standard', 1, 534, 1, '{}', 'nice item'),
	('kbirdf', 'Great Blue Heron feather', 20, 1, 'item_standard', 1, 533, 1, '{}', 'nice item'),
	('kitchencounter', 'Kitchen Counter', 20, 1, 'item_standard', 1, 611, 1, '{}', 'nice item'),
	('kit_bandana', 'Bandana', 2, 1, 'item_standard', 1, 203, 1, '{}', 'nice item'),
	('knifecooking', 'knifecooking', 25, 1, 'item_standard', 0, 1042, 1, '{}', 'nice item'),
	('lamppost1', 'Lamp Post 1 Set', 20, 1, 'item_standard', 1, 606, 1, '{}', 'nice item'),
	('lamppost2', 'Lamp Post 2 Set', 20, 1, 'item_standard', 1, 607, 1, '{}', 'nice item'),
	('lanterna', 'Lantern', 20, 1, 'item_standard', 1, 659, 1, '{}', 'nice item'),
	('leather', 'Leather', 50, 1, 'item_standard', 1, 204, 1, '{}', 'nice item'),
	('leatherchair', 'Leather Chair', 20, 1, 'item_standard', 1, 748, 1, '{}', 'nice item'),
	('leather_chair', 'Leather Chair', 20, 1, 'item_standard', 1, 620, 1, '{}', 'nice item'),
	('legalbook', 'Legal Book', 1, 1, 'item_standard', 1, 892, 1, '{}', 'nice item'),
	('legaligators', 'Legendary Alligator pelt', 20, 1, 'item_standard', 1, 417, 1, '{}', 'nice item'),
	('legaligators1', 'Legendary Teca Alligator pelt', 20, 1, 'item_standard', 1, 400, 1, '{}', 'nice item'),
	('legaligators2', 'Legendary Sun Alligator pelt', 20, 1, 'item_standard', 1, 401, 1, '{}', 'nice item'),
	('legaligators3', 'Legendary Banded Alligator pelt', 20, 1, 'item_standard', 1, 402, 1, '{}', 'nice item'),
	('legalpaper', 'Legal Paper', 4, 1, 'item_standard', 1, 891, 1, '{}', 'nice item'),
	('legbears1', 'Legendary Deadly Bear pelt', 20, 1, 'item_standard', 1, 376, 1, '{}', 'nice item'),
	('legbears2', 'Legendary Owiza Bear pelt', 20, 1, 'item_standard', 1, 377, 1, '{}', 'nice item'),
	('legbears3', 'Legendary Ridgeback Spirit Bear pelt', 20, 1, 'item_standard', 1, 378, 1, '{}', 'nice item'),
	('legbears4', 'Legendary Golden Spirit Bear pelt', 20, 1, 'item_standard', 1, 379, 1, '{}', 'nice item'),
	('legbeavers1', 'Legendary Grey Beaver pelt', 20, 1, 'item_standard', 1, 397, 1, '{}', 'nice item'),
	('legbeavers2', 'Legendary White Beaver pelt', 20, 1, 'item_standard', 1, 398, 1, '{}', 'nice item'),
	('legbeavers3', 'Legendary Black Beaver pelt', 20, 1, 'item_standard', 1, 399, 1, '{}', 'nice item'),
	('legbeawers', 'Legendary Beaver pelt', 20, 1, 'item_standard', 1, 411, 1, '{}', 'nice item'),
	('legbisonhorn', 'Legendary Bison Horns', 20, 1, 'item_standard', 1, 353, 1, '{}', 'nice item'),
	('legbisons', 'Legendary Bison pelt', 20, 1, 'item_standard', 1, 416, 1, '{}', 'nice item'),
	('legbisons1', 'Legendary Tatanka Bison pelt', 20, 1, 'item_standard', 1, 365, 1, '{}', 'nice item'),
	('legbisons2', 'Legendary Winyan Bison pelt', 20, 1, 'item_standard', 1, 366, 1, '{}', 'nice item'),
	('legbisons3', 'Legendary Payata Bison pelt', 20, 1, 'item_standard', 1, 367, 1, '{}', 'nice item'),
	('legbisonstak', 'Legendary Takanta Bison pelt', 20, 1, 'item_standard', 1, 415, 1, '{}', 'nice item'),
	('legboars', 'Legendary Boar pelt', 20, 1, 'item_standard', 1, 414, 1, '{}', 'nice item'),
	('legboars1', 'Legendary Cogi Boar pelt', 20, 1, 'item_standard', 1, 393, 1, '{}', 'nice item'),
	('legboars2', 'Legendary Wakpa Boar pelt', 20, 1, 'item_standard', 1, 394, 1, '{}', 'nice item'),
	('legboars3', 'Legendary Icahi Boar pelt', 20, 1, 'item_standard', 1, 395, 1, '{}', 'nice item'),
	('legboars4', 'Legendary Wildhog pelt', 20, 1, 'item_standard', 1, 396, 1, '{}', 'nice item'),
	('legbucks', 'Legendary Buck skin', 20, 1, 'item_standard', 1, 410, 1, '{}', 'nice item'),
	('legbucks1', 'Legendary Buck pelt', 20, 1, 'item_standard', 1, 368, 1, '{}', 'nice item'),
	('legbucks2', 'Legendary Mudrunner Buck pelt', 20, 1, 'item_standard', 1, 369, 1, '{}', 'nice item'),
	('legbucks3', 'Legendary Snow Buck pelt', 20, 1, 'item_standard', 1, 370, 1, '{}', 'nice item'),
	('legbucks4', 'Legendary Shadow Buck pelt', 20, 1, 'item_standard', 1, 371, 1, '{}', 'nice item'),
	('legcougars', 'Legendary Cougar skin', 20, 1, 'item_standard', 1, 409, 1, '{}', 'nice item'),
	('legcougars1', 'Legendary Iguga Cougar pelt', 20, 1, 'item_standard', 1, 389, 1, '{}', 'nice item'),
	('legcougars2', 'Legendary Maza Cougar pelt', 20, 1, 'item_standard', 1, 390, 1, '{}', 'nice item'),
	('legcougars3', 'Legendary Sapa Cougar pelt', 20, 1, 'item_standard', 1, 391, 1, '{}', 'nice item'),
	('legcougars4', 'Legendary Black Cougar pelt', 20, 1, 'item_standard', 1, 392, 1, '{}', 'nice item'),
	('legcoyotes', 'Legendary Coyote skin', 20, 1, 'item_standard', 1, 408, 1, '{}', 'nice item'),
	('legcoyotes1', 'Legendary Red Streak Coyote pelt', 20, 1, 'item_standard', 1, 386, 1, '{}', 'nice item'),
	('legcoyotes2', 'Legendary Midnight Paw Coyote pelt', 20, 1, 'item_standard', 1, 387, 1, '{}', 'nice item'),
	('legcoyotes3', 'Legendary Milk Coyote pelt', 20, 1, 'item_standard', 1, 388, 1, '{}', 'nice item'),
	('legelkantler', 'Legendary Elk Antlers', 20, 1, 'item_standard', 1, 355, 1, '{}', 'nice item'),
	('legelks', 'Legendary Elk pelt', 20, 1, 'item_standard', 1, 403, 1, '{}', 'nice item'),
	('legelks1', 'Legendary Katata Elk pelt', 20, 1, 'item_standard', 1, 362, 1, '{}', 'nice item'),
	('legelks2', 'Legendary Ozula Elk pelt', 20, 1, 'item_standard', 1, 363, 1, '{}', 'nice item'),
	('legelks3', 'Legendary Inahme Elk pelt', 20, 1, 'item_standard', 1, 364, 1, '{}', 'nice item'),
	('legendbuckantler', 'Legendary Buck Antlers', 20, 1, 'item_standard', 1, 356, 1, '{}', 'nice item'),
	('legendsnakes', 'Legendary Boa pelt', 20, 1, 'item_standard', 1, 418, 1, '{}', 'nice item'),
	('legfoxs2', 'Legendary Marble Fox pelt', 20, 1, 'item_standard', 1, 360, 1, '{}', 'nice item'),
	('legfoxs3', 'Legendary Cross Fox pelt', 20, 1, 'item_standard', 1, 361, 1, '{}', 'nice item'),
	('legfoxskin', 'Legendary Fox skin', 20, 1, 'item_standard', 1, 413, 1, '{}', 'nice item'),
	('leggbears', 'Legendary Bear skin', 20, 1, 'item_standard', 1, 404, 1, '{}', 'nice item'),
	('legmooseantler', 'Legendary Moose Antlers', 20, 1, 'item_standard', 1, 352, 1, '{}', 'nice item'),
	('legmooses', 'Legendary Moose pelt', 20, 1, 'item_standard', 1, 405, 1, '{}', 'nice item'),
	('legmooses1', 'Legendary Snowflake Moose pelt', 20, 1, 'item_standard', 1, 357, 1, '{}', 'nice item'),
	('legmooses2', 'Legendary Knight Moose pelt', 20, 1, 'item_standard', 1, 358, 1, '{}', 'nice item'),
	('legmooses3', 'Legendary Rudy Moose pelt', 20, 1, 'item_standard', 1, 359, 1, '{}', 'nice item'),
	('legpanthers1', 'Legendary Nightwalker Panther pelt', 20, 1, 'item_standard', 1, 383, 1, '{}', 'nice item'),
	('legpanthers2', 'Legendary Ghost Panther pelt', 20, 1, 'item_standard', 1, 384, 1, '{}', 'nice item'),
	('legpanthers3', 'Legendary Iwakta Panther pelt', 20, 1, 'item_standard', 1, 385, 1, '{}', 'nice item'),
	('legprongs', 'Legendary Pronghorn skin', 20, 1, 'item_standard', 1, 407, 1, '{}', 'nice item'),
	('legramhorn', 'Legendary Ram Horns', 20, 1, 'item_standard', 1, 354, 1, '{}', 'nice item'),
	('legrams', 'Legendary Ram pelt', 20, 1, 'item_standard', 1, 412, 1, '{}', 'nice item'),
	('legrams1', 'Legendary Gabbro Horn Ram pelt', 20, 1, 'item_standard', 1, 372, 1, '{}', 'nice item'),
	('legrams2', 'Legendary Chalk Horn Ram pelt', 20, 1, 'item_standard', 1, 373, 1, '{}', 'nice item'),
	('legrams3', 'Legendary Rutile Horn Ram pelt', 20, 1, 'item_standard', 1, 374, 1, '{}', 'nice item'),
	('legrams4', 'Legendary GreatHorn Ram pelt', 20, 1, 'item_standard', 1, 375, 1, '{}', 'nice item'),
	('legwolfpelt', 'Legendary Wolf skin', 20, 1, 'item_standard', 1, 406, 1, '{}', 'nice item'),
	('legwolfs1', 'Legendary Emerald Wolf pelt', 20, 1, 'item_standard', 1, 380, 1, '{}', 'nice item'),
	('legwolfs2', 'Legendary Onyx Wolf pelt', 20, 1, 'item_standard', 1, 381, 1, '{}', 'nice item'),
	('legwolfs3', 'Legendary Moonstone Wolf pelt', 20, 1, 'item_standard', 1, 382, 1, '{}', 'nice item'),
	('lizardl', 'Lizard foot', 20, 1, 'item_standard', 1, 554, 1, '{}', 'nice item'),
	('lizards', 'Lizard pelt', 20, 1, 'item_standard', 1, 553, 1, '{}', 'nice item'),
	('lockpick', 'Lockpick', 5, 1, 'item_standard', 1, 205, 1, '{}', 'nice item'),
	('lockpickmold', 'Lockpick Mold', 5, 1, 'item_standard', 1, 206, 1, '{}', 'nice item'),
	('logbechs', 'Log Bench 2', 20, 1, 'item_standard', 1, 775, 1, '{}', 'nice item'),
	('logbench', 'Log Bench 1', 20, 1, 'item_standard', 1, 774, 1, '{}', 'nice item'),
	('log_bencha', 'Log Bench 1', 20, 1, 'item_standard', 1, 646, 1, '{}', 'nice item'),
	('log_benchb', 'Log Bench 2', 20, 1, 'item_standard', 1, 647, 1, '{}', 'nice item'),
	('loonb', 'Common loon beak', 20, 1, 'item_standard', 1, 538, 1, '{}', 'nice item'),
	('loonf', 'Common loon feather', 20, 1, 'item_standard', 1, 537, 1, '{}', 'nice item'),
	('loungechair', 'Lounge Chair', 20, 1, 'item_standard', 1, 598, 1, '{}', 'nice item'),
	('loungechair2', 'Lounge Chair 2', 20, 1, 'item_standard', 1, 599, 1, '{}', 'nice item'),
	('lumberaxe', 'Lumber Axe', 1, 1, 'item_standard', 1, 345, 1, '{}', 'nice item'),
	('mackerel', 'Mackerel', 10, 1, 'item_standard', 0, 207, 1, '{}', 'nice item'),
	('map', 'map ', 1, 1, 'item_standard', 0, 1142, 1, '{}', 'nice item'),
	('marriagebook', 'Marriage Book', 1, 1, 'item_standard', 1, 894, 1, '{}', 'nice item'),
	('marriagecertification', 'Marriage Certify', 2, 1, 'item_standard', 1, 895, 1, '{}', 'nice item'),
	('mashalaskan', 'Alaskan Gin Mash', 20, 1, 'item_standard', 1, 824, 1, '{}', 'nice item'),
	('mashamerican', 'Alaskan Gin Mash', 20, 1, 'item_standard', 1, 825, 1, '{}', 'nice item'),
	('mashapple', 'Apple Mash', 20, 1, 'item_standard', 1, 826, 1, '{}', 'nice item'),
	('mashblackberry', 'Blackberry Mash', 20, 1, 'item_standard', 1, 827, 1, '{}', 'nice item'),
	('mashblackberry90p', 'Blackberry Mash 90p', 20, 1, 'item_standard', 1, 828, 1, '{}', 'nice item'),
	('mashpeach', 'Peach Mash', 20, 1, 'item_standard', 1, 829, 1, '{}', 'nice item'),
	('mashplum', 'Plum Mash', 20, 1, 'item_standard', 1, 830, 1, '{}', 'nice item'),
	('mashraspberry', 'Raspberry Mash', 20, 1, 'item_standard', 1, 831, 1, '{}', 'nice item'),
	('mashraspberry90p', 'Raspberry Mash 90p', 20, 1, 'item_standard', 1, 832, 1, '{}', 'nice item'),
	('mashstrong', 'Strong Mash Batch', 20, 1, 'item_standard', 1, 833, 1, '{}', 'nice item'),
	('meat', 'Meat', 20, 1, 'item_standard', 1, 208, 1, '{}', 'nice item'),
	('milk', 'Milk', 50, 1, 'item_standard', 1, 209, 1, '{}', 'nice item'),
	('Milk_Weed', 'Milk Weed', 21, 1, 'item_standard', 1, 210, 1, '{}', 'nice item'),
	('Milk_Weed_Seed', 'Milk Weed Seed', 10, 1, 'item_standard', 1, 211, 1, '{}', 'nice item'),
	('moonshine', 'Moonshine', 10, 1, 'item_standard', 1, 212, 1, '{}', 'nice item'),
	('mooseantler', 'Moose Antlers', 20, 1, 'item_standard', 1, 548, 1, '{}', 'nice item'),
	('mooses', 'Moose pelt', 20, 1, 'item_standard', 1, 549, 1, '{}', 'nice item'),
	('morpcert', 'Morphine Perscription', 10, 1, 'item_standard', 1, 213, 1, '{}', 'nice item'),
	('morphine', 'Morphine', 10, 1, 'item_standard', 1, 214, 1, '{}', 'nice item'),
	('mountainmen', 'Mountain Camp Set', 20, 1, 'item_standard', 1, 608, 1, '{}', 'nice item'),
	('mp001_p_mp_still02x', 'Brennerei', 1, 1, 'item_standard', 1, 215, 1, '{}', 'nice item'),
	('muskrats', 'Muskrat skin', 20, 1, 'item_standard', 1, 547, 1, '{}', 'nice item'),
	('Mutton', 'Mutton', 20, 1, 'item_standard', 1, 216, 1, '{}', 'nice item'),
	('nails', 'Nails', 40, 1, 'item_standard', 1, 217, 1, '{}', 'nice item'),
	('nativebasket1', 'Native Basket 1', 20, 1, 'item_standard', 1, 593, 1, '{}', 'nice item'),
	('nativebasket2', 'Native Basket 2', 20, 1, 'item_standard', 1, 594, 1, '{}', 'nice item'),
	('nativedecor', 'Native Decor Set', 20, 1, 'item_standard', 1, 584, 1, '{}', 'nice item'),
	('nativepot', 'Native Pot', 20, 1, 'item_standard', 1, 592, 1, '{}', 'nice item'),
	('nativeskull', 'Native Decor 1', 20, 1, 'item_standard', 1, 595, 1, '{}', 'nice item'),
	('naturalwagon', 'Naturalists Wagon Set', 20, 1, 'item_standard', 1, 605, 1, '{}', 'nice item'),
	('newspaper', 'NewsPaper', 20, 1, 'item_standard', 1, 218, 1, '{}', 'nice item'),
	('nightstand', 'night stand', 20, 1, 'item_standard', 1, 653, 1, '{}', 'nice item'),
	('nitrite', 'Nitrite', 20, 1, 'item_standard', 1, 219, 1, '{}', 'nice item'),
	('nitroglyserolia', 'Nitroglycerol', 30, 1, 'item_standard', 1, 220, 1, '{}', 'nice item'),
	('normaltable', 'Table', 20, 1, 'item_standard', 1, 750, 1, '{}', 'nice item'),
	('notebook', 'Notebook', 5, 1, 'item_standard', 1, 221, 1, '{}', 'nice item'),
	('obed', 'Old bed', 20, 1, 'item_standard', 1, 664, 1, '{}', 'nice item'),
	('oil_lantern', 'Oil Lantern', 1, 1, 'item_standard', 1, 1126, 1, '{}', 'nice item'),
	('Oleander_Sage', 'Oleander Sage', 21, 1, 'item_standard', 1, 222, 1, '{}', 'nice item'),
	('Oleander_Sage_Seed', 'Oleander Sage Seed', 10, 1, 'item_standard', 1, 223, 1, '{}', 'nice item'),
	('opossumc', 'Opossum claws', 20, 1, 'item_standard', 1, 515, 1, '{}', 'nice item'),
	('opossums', 'Opossum skin', 20, 1, 'item_standard', 1, 514, 1, '{}', 'nice item'),
	('orden_presidente', 'Order of the President', 10, 1, 'item_standard', 0, 224, 1, '{}', 'nice item'),
	('Oregano', 'Oregano', 20, 1, 'item_standard', 1, 225, 1, '{}', 'nice item'),
	('Oregano_Seed', 'Oregano Seed', 10, 1, 'item_standard', 1, 226, 1, '{}', 'nice item'),
	('oriole2_c', 'Hooded Oriole', 20, 1, 'item_standard', 1, 430, 1, '{}', 'nice item'),
	('oriole_c', 'Oriole', 20, 1, 'item_standard', 1, 429, 1, '{}', 'nice item'),
	('owlf', 'Owl feather', 20, 1, 'item_standard', 1, 539, 1, '{}', 'nice item'),
	('owlt', 'Owl claws', 20, 1, 'item_standard', 1, 540, 1, '{}', 'nice item'),
	('oxhorn', 'Angus Bull horn', 20, 1, 'item_standard', 1, 545, 1, '{}', 'nice item'),
	('oxs', 'Angus Bull pelt', 20, 1, 'item_standard', 1, 546, 1, '{}', 'nice item'),
	('panthere', 'Panther eyes', 20, 1, 'item_standard', 1, 564, 1, '{}', 'nice item'),
	('panthers', 'Panther skin', 20, 1, 'item_standard', 1, 563, 1, '{}', 'nice item'),
	('paper', 'Paper', 20, 1, 'item_standard', 1, 227, 1, '{}', 'nice item'),
	('parasol', 'Parasol', 1, 1, 'item_standard', 1, 343, 1, '{}', 'nice item'),
	('Parasol_Mushroom', 'Parasol Mushroom', 21, 1, 'item_standard', 1, 228, 1, '{}', 'nice item'),
	('Parasol_Mushroom_Seed', 'Parasol Mushroom Seed', 10, 1, 'item_standard', 1, 229, 1, '{}', 'nice item'),
	('peacepipe', 'PeacePipe', 5, 1, 'item_standard', 1, 1062, 1, '{}', 'nice item'),
	('peach', 'peach', 21, 1, 'item_standard', 1, 1064, 1, '{}', 'nice item'),
	('peachseeds', 'Peach Seeds', 10, 1, 'item_standard', 1, 735, 1, '{}', 'nice item'),
	('peasantb', 'Peasant beak', 20, 1, 'item_standard', 1, 518, 1, '{}', 'nice item'),
	('peasantf', 'Peasant feather', 20, 1, 'item_standard', 1, 517, 1, '{}', 'nice item'),
	('pecaris', 'Peccary pelt', 20, 1, 'item_standard', 1, 550, 1, '{}', 'nice item'),
	('pelicanb', 'Pelican beak', 20, 1, 'item_standard', 1, 520, 1, '{}', 'nice item'),
	('pelicanf', 'Pelican feather', 20, 1, 'item_standard', 1, 519, 1, '{}', 'nice item'),
	('pen', 'Pen', 2, 1, 'item_standard', 0, 896, 1, '{}', 'nice item'),
	('pheasant_taxidermy', 'Pheasant Taxidermy', 20, 1, 'item_standard', 1, 641, 1, '{}', 'nice item'),
	('phestaxi', 'Pheasant Taxidermy', 20, 1, 'item_standard', 1, 769, 1, '{}', 'nice item'),
	('pickaxe', 'Pickaxe', 1, 1, 'item_standard', 0, 230, 1, '{}', 'nice item'),
	('pigeon_c', 'Pigeon', 20, 1, 'item_standard', 1, 431, 1, '{}', 'nice item'),
	('pigs', 'Pig pelt', 20, 1, 'item_standard', 1, 516, 1, '{}', 'nice item'),
	('pipe', 'Pipe', 5, 1, 'item_standard', 1, 231, 1, '{}', 'nice item'),
	('pipecopper', 'Copper Pipe', 5, 1, 'item_standard', 1, 835, 1, '{}', 'nice item'),
	('plainsmallgame', 'plainsmallgame', 25, 1, 'item_standard', 1, 1050, 1, '{}', 'nice item'),
	('planttrimmer', 'Plant Trimmer', 10, 1, 'item_standard', 1, 678, 1, '{}', 'nice item'),
	('pocket_watch', 'Pocket Watch', 5, 1, 'item_standard', 1, 232, 1, '{}', 'nice item'),
	('pokerset', 'Poker Table Set', 20, 1, 'item_standard', 1, 579, 1, '{}', 'nice item'),
	('pork', 'Pork', 20, 1, 'item_standard', 1, 571, 1, '{}', 'nice item'),
	('porkfat', 'Pig fat', 20, 1, 'item_standard', 1, 458, 1, '{}', 'nice item'),
	('porknapples', 'porknapples', 25, 1, 'item_standard', 1, 1058, 1, '{}', 'nice item'),
	('portable_canoe', 'Portable Canoe', 1, 1, 'item_standard', 1, 1066, 1, '{}', 'Bryce Canyon Canoes'),
	('pot', 'Distillery Pot', 1, 1, 'item_standard', 1, 836, 1, '{}', 'nice item'),
	('pota', 'House Pot', 20, 1, 'item_standard', 1, 626, 1, '{}', 'nice item'),
	('potato', 'Potato', 21, 1, 'item_standard', 1, 233, 1, '{}', 'nice item'),
	('potatoseed', 'Potato Seed', 10, 1, 'item_standard', 1, 731, 1, '{}', 'nice item'),
	('prairib', 'Prairi chicken beak', 20, 1, 'item_standard', 1, 509, 1, '{}', 'nice item'),
	('Prairie_Poppy', 'Prairie Poppy', 20, 1, 'item_standard', 1, 234, 1, '{}', 'nice item'),
	('Prairie_Poppy_Seed', 'Prairie Poppy Seed', 10, 1, 'item_standard', 1, 235, 1, '{}', 'nice item'),
	('prairif', 'Prairi chicken feather', 20, 1, 'item_standard', 1, 508, 1, '{}', 'nice item'),
	('pronghornh', 'Pronghorn horn', 20, 1, 'item_standard', 1, 511, 1, '{}', 'nice item'),
	('prongs', 'Pronghorn skin', 20, 1, 'item_standard', 1, 510, 1, '{}', 'nice item'),
	('provision_jail_keys', 'Jail Keys', 10, 1, 'item_standard', 1, 236, 1, '{}', 'nice item'),
	('pulp', 'Pulp', 20, 1, 'item_standard', 0, 237, 1, '{}', 'nice item'),
	('p_baitBread01x', 'Bread Bait', 20, 1, 'item_standard', 1, 838, 1, '{}', 'nice item'),
	('p_baitCheese01x', 'Cheese Bait', 10, 1, 'item_standard', 1, 917, 1, '{}', 'nice item'),
	('p_baitCorn01x', 'Corn Bait', 10, 1, 'item_standard', 1, 916, 1, '{}', 'nice item'),
	('p_baitCricket01x', 'Cricket Bait', 10, 1, 'item_standard', 1, 919, 1, '{}', 'nice item'),
	('p_baitWorm01x', 'Worm Bait', 10, 1, 'item_standard', 1, 918, 1, '{}', 'nice item'),
	('p_barrelmoonshine', 'Barrel', 1, 1, 'item_standard', 1, 238, 1, '{}', 'nice item'),
	('p_crawdad01x', 'Crawfish Bait', 10, 1, 'item_standard', 1, 920, 1, '{}', 'nice item'),
	('p_FinisdFishlure01x', 'Fish Lure', 10, 1, 'item_standard', 1, 922, 1, '{}', 'nice item'),
	('p_finisdfishlurelegendary01x', 'Legendary Fish Lure', 10, 1, 'item_standard', 1, 925, 1, '{}', 'nice item'),
	('p_finishdcrawd01x', 'Crawfish Lure', 10, 1, 'item_standard', 1, 923, 1, '{}', 'nice item'),
	('p_finishdcrawdlegendary01x', 'Legendary Crawfish Lure', 10, 1, 'item_standard', 1, 926, 1, '{}', 'nice item'),
	('p_finishedragonfly01x', 'Dragonfly Lure', 10, 1, 'item_standard', 1, 921, 1, '{}', 'nice item'),
	('p_finishedragonflylegendary01x', 'Legendary Dragonfly Lure', 10, 1, 'item_standard', 1, 924, 1, '{}', 'nice item'),
	('p_lgoc_spinner_v4', 'Spinner V4', 10, 1, 'item_standard', 1, 927, 1, '{}', 'nice item'),
	('p_lgoc_spinner_v6', 'Spinner V6', 10, 1, 'item_standard', 1, 928, 1, '{}', 'nice item'),
	('quailb', 'Quail beak', 20, 1, 'item_standard', 1, 471, 1, '{}', 'nice item'),
	('quailf', 'Quail feather', 20, 1, 'item_standard', 1, 470, 1, '{}', 'nice item'),
	('quartz', 'Quartz', 20, 1, 'item_standard', 1, 239, 1, '{}', 'nice item'),
	('rabbitpaw', 'Rabbitfoot', 20, 1, 'item_standard', 1, 507, 1, '{}', 'nice item'),
	('rabbits', 'Rabbitskin', 20, 1, 'item_standard', 1, 506, 1, '{}', 'nice item'),
	('raccoons', 'Raccoon skin', 20, 1, 'item_standard', 1, 504, 1, '{}', 'nice item'),
	('raccoont', 'Raccoon tooth', 20, 1, 'item_standard', 1, 505, 1, '{}', 'nice item'),
	('rajahdysoljy', 'Explosive Oil', 30, 1, 'item_standard', 1, 240, 1, '{}', 'nice item'),
	('ramhorn', 'Ram Horn', 20, 1, 'item_standard', 1, 454, 1, '{}', 'nice item'),
	('rams', 'Ram pelt', 20, 1, 'item_standard', 1, 455, 1, '{}', 'nice item'),
	('Rams_Head', 'Rams Head', 21, 1, 'item_standard', 1, 241, 1, '{}', 'nice item'),
	('Rams_Head_Seed', 'Rams Head Seed', 10, 1, 'item_standard', 1, 242, 1, '{}', 'nice item'),
	('raspberryale', 'Raspberry Ale', 10, 1, 'item_standard', 1, 243, 1, '{}', 'nice item'),
	('rat_c', 'Rat', 20, 1, 'item_standard', 1, 432, 1, '{}', 'nice item'),
	('ravenc', 'Raven claws', 20, 1, 'item_standard', 1, 502, 1, '{}', 'nice item'),
	('ravenf', 'Raven feather', 20, 1, 'item_standard', 1, 503, 1, '{}', 'nice item'),
	('rawbirdmeat', 'rawbirdmeat', 25, 1, 'item_standard', 0, 1047, 1, '{}', 'nice item'),
	('rectable', 'Rectangle Table', 20, 1, 'item_standard', 1, 751, 1, '{}', 'nice item'),
	('rectangle_table', 'Rectangle Table', 20, 1, 'item_standard', 1, 623, 1, '{}', 'nice item'),
	('Red_Raspberry', 'Red Raspberry', 21, 1, 'item_standard', 1, 244, 1, '{}', 'nice item'),
	('Red_Raspberry_Seed', 'Red Raspberry Seed', 10, 1, 'item_standard', 1, 245, 1, '{}', 'nice item'),
	('Red_Sage', 'Red Sage', 21, 1, 'item_standard', 1, 246, 1, '{}', 'nice item'),
	('Red_Sage_Seed', 'Red Sage Seed', 10, 1, 'item_standard', 1, 247, 1, '{}', 'nice item'),
	('repeaterbarrel', 'Repeater Barrel', 5, 1, 'item_standard', 1, 248, 1, '{}', 'nice item'),
	('repeatermold', 'Repeater Mold', 5, 1, 'item_standard', 1, 249, 1, '{}', 'nice item'),
	('repeaterreceiver', 'Repeater Receiver', 5, 1, 'item_standard', 1, 250, 1, '{}', 'nice item'),
	('repeaterrecmold', 'Repeater Receiver Mold', 5, 1, 'item_standard', 1, 251, 1, '{}', 'nice item'),
	('repeaterstock', 'Repeater Stock', 5, 1, 'item_standard', 1, 252, 1, '{}', 'nice item'),
	('revolverbarrel', 'Revolver Barrel', 5, 1, 'item_standard', 1, 253, 1, '{}', 'nice item'),
	('revolvercylinder', 'Revolver Cylinder', 5, 1, 'item_standard', 1, 254, 1, '{}', 'nice item'),
	('revolverhandle', 'Revolver Handle', 5, 1, 'item_standard', 1, 255, 1, '{}', 'nice item'),
	('revolvermold', 'Revolver Mold', 5, 1, 'item_standard', 1, 256, 1, '{}', 'nice item'),
	('riflebarrel', 'Rifle Barrel', 5, 1, 'item_standard', 1, 257, 1, '{}', 'nice item'),
	('riflemold', 'Rifle Mold', 5, 1, 'item_standard', 1, 258, 1, '{}', 'nice item'),
	('riflereceiver', 'Rifle Receiver', 5, 1, 'item_standard', 1, 259, 1, '{}', 'nice item'),
	('riflerecmold', 'Rifle Receiver Mold', 5, 1, 'item_standard', 1, 260, 1, '{}', 'nice item'),
	('riflestock', 'Rifle Stock', 5, 1, 'item_standard', 1, 261, 1, '{}', 'nice item'),
	('roach', 'Roach', 10, 1, 'item_standard', 0, 262, 1, '{}', 'nice item'),
	('robberyplanning', 'Robbery Planning Set', 20, 1, 'item_standard', 1, 604, 1, '{}', 'nice item'),
	('robin_c', 'Robin', 20, 1, 'item_standard', 1, 433, 1, '{}', 'nice item'),
	('rock', 'Rock', 30, 1, 'item_standard', 0, 263, 1, '{}', 'nice item'),
	('rollingpaper', 'Rolling paper', 30, 1, 'item_standard', 1, 264, 1, '{}', 'nice item'),
	('rope', 'rope', 25, 1, 'item_standard', 0, 1052, 1, '{}', 'nice item'),
	('roundtable', 'Round Table', 20, 1, 'item_standard', 1, 749, 1, '{}', 'nice item'),
	('round_table', 'Round Table', 20, 1, 'item_standard', 1, 621, 1, '{}', 'nice item'),
	('rspoonb', 'Roseta Spoonbill beak', 20, 1, 'item_standard', 1, 497, 1, '{}', 'nice item'),
	('rspoonf', 'Roseta Spoonbill feather', 20, 1, 'item_standard', 1, 496, 1, '{}', 'nice item'),
	('rubber', 'Rubber', 20, 1, 'item_standard', 0, 265, 1, '{}', 'nice item'),
	('rubbertube', 'Rubber Tube', 5, 1, 'item_standard', 0, 841, 1, '{}', 'nice item'),
	('salamelle', 'Fresh Pork ', 20, 1, 'item_standard', 1, 266, 1, '{}', 'nice item'),
	('salmon', 'Salmon', 10, 1, 'item_standard', 0, 267, 1, '{}', 'nice item'),
	('salt', 'Salt', 20, 1, 'item_standard', 1, 268, 1, '{}', 'nice item'),
	('Saltbush', 'Saltbush', 21, 1, 'item_standard', 1, 269, 1, '{}', 'nice item'),
	('Saltbush_Seed', 'Saltbush Seed', 10, 1, 'item_standard', 1, 270, 1, '{}', 'nice item'),
	('SaltedCookedBigGameMeat', 'Big game meat', 25, 1, 'item_standard', 1, 1044, 1, '{}', 'nice item'),
	('sap', 'Sap', 20, 1, 'item_standard', 0, 271, 1, '{}', 'nice item'),
	('sarsaparilla', 'Sarsaparilla', 10, 1, 'item_standard', 1, 272, 1, '{}', 'nice item'),
	('scale', 'Scale', 5, 1, 'item_standard', 1, 273, 1, '{}', 'nice item'),
	('scentg', 'Scent glad', 20, 1, 'item_standard', 1, 492, 1, '{}', 'nice item'),
	('seagullb', 'Seagull beak', 20, 1, 'item_standard', 1, 495, 1, '{}', 'nice item'),
	('seagullf', 'Seagull feather', 20, 1, 'item_standard', 1, 494, 1, '{}', 'nice item'),
	('secondchance', 'Second Chance', 10, 1, 'item_standard', 1, 274, 1, '{}', 'nice item'),
	('sheephead', 'Sheep head', 20, 1, 'item_standard', 1, 493, 1, '{}', 'nice item'),
	('shellcasing', 'Shell Casing', 40, 1, 'item_standard', 1, 275, 1, '{}', 'nice item'),
	('shootingtarget', 'Shooting Target', 20, 1, 'item_standard', 1, 613, 1, '{}', 'nice item'),
	('shotgunbarrel', 'Shotgun Barrel', 5, 1, 'item_standard', 1, 276, 1, '{}', 'nice item'),
	('shotgunmold', 'Shotgun Mold', 5, 1, 'item_standard', 1, 277, 1, '{}', 'nice item'),
	('shotgunstock', 'Shotgun Stock', 5, 1, 'item_standard', 1, 278, 1, '{}', 'nice item'),
	('shovel', 'shovel', 1, 1, 'item_standard', 1, 1065, 1, '{}', 'nice item'),
	('shrimps', 'Shrimp Stew', 1, 1, 'item_standard', 1, 279, 1, '{}', 'nice item'),
	('sidetable', 'side table 1', 20, 1, 'item_standard', 1, 782, 1, '{}', 'nice item'),
	('sidetablea', 'side table 2', 20, 1, 'item_standard', 1, 783, 1, '{}', 'nice item'),
	('sidetableb', 'side table 3', 20, 1, 'item_standard', 1, 784, 1, '{}', 'nice item'),
	('side_table', 'side table 1', 20, 1, 'item_standard', 1, 654, 1, '{}', 'nice item'),
	('side_tablea', 'side table 2', 20, 1, 'item_standard', 1, 655, 1, '{}', 'nice item'),
	('side_tableb', 'side table 3', 20, 1, 'item_standard', 1, 656, 1, '{}', 'nice item'),
	('singlebed', 'single bed', 20, 1, 'item_standard', 1, 666, 1, '{}', 'nice item'),
	('skullpost', 'Skull Post', 20, 1, 'item_standard', 1, 597, 1, '{}', 'nice item'),
	('smallchest', 'Small Chest', 1, 1, 'item_standard', 1, 657, 1, '{}', 'nice item'),
	('smallmcandle', 'Small Melted Candle', 20, 1, 'item_standard', 1, 662, 1, '{}', 'nice item'),
	('Small_Leather', 'Small Leather', 10, 1, 'item_standard', 1, 280, 1, '{}', 'nice item'),
	('SnakeSkin', 'Snake Skin', 20, 1, 'item_standard', 1, 281, 1, '{}', 'nice item'),
	('snaket', 'Snake tooth', 20, 1, 'item_standard', 1, 490, 1, '{}', 'nice item'),
	('Snake_Poison', 'Snake Poison', 10, 1, 'item_standard', 1, 282, 1, '{}', 'nice item'),
	('soborno', 'Soborno Alcohol', 15, 1, 'item_standard', 0, 283, 1, '{}', 'nice item'),
	('songbird2_c', 'Scarlet songbird', 20, 1, 'item_standard', 1, 435, 1, '{}', 'nice item'),
	('songbird_c', 'Songbird', 20, 1, 'item_standard', 1, 434, 1, '{}', 'nice item'),
	('sparrow0_c', 'Common Sparrow', 20, 1, 'item_standard', 1, 436, 1, '{}', 'nice item'),
	('sparrow1_c', 'Sparrow', 20, 1, 'item_standard', 1, 437, 1, '{}', 'nice item'),
	('sparrow2_c', 'Golden Sparrow', 20, 1, 'item_standard', 1, 438, 1, '{}', 'nice item'),
	('squirrel_black_c', 'Black Squirrel', 20, 1, 'item_standard', 1, 441, 1, '{}', 'nice item'),
	('squirrel_grey_c', 'Gray Squirrel', 20, 1, 'item_standard', 1, 439, 1, '{}', 'nice item'),
	('squirrel_red_c', 'Red Squirrel', 20, 1, 'item_standard', 1, 440, 1, '{}', 'nice item'),
	('standard_table', 'Table', 20, 1, 'item_standard', 1, 622, 1, '{}', 'nice item'),
	('standingtorch', 'Stading Torch', 20, 1, 'item_standard', 1, 612, 1, '{}', 'nice item'),
	('steak', 'Steak', 10, 1, 'item_standard', 1, 284, 1, '{}', 'nice item'),
	('steakeggs', 'steakeggs', 12, 1, 'item_standard', 1, 1053, 1, '{}', 'nice item'),
	('steakveg', 'Steak with Veggies', 10, 1, 'item_standard', 1, 285, 1, '{}', 'nice item'),
	('stillkit', 'Still Kit', 5, 1, 'item_standard', 1, 843, 1, '{}', 'nice item'),
	('stim', 'Horse Stimulant', 2, 1, 'item_standard', 1, 286, 1, '{}', 'nice item'),
	('stolenmerch', 'Stolen Items', 10, 1, 'item_standard', 0, 287, 1, '{}', 'nice item'),
	('stonehammer', 'Stone Hammer', 5, 1, 'item_standard', 1, 288, 1, '{}', 'nice item'),
	('stringy', 'Stringy meat', 20, 1, 'item_standard', 1, 574, 1, '{}', 'nice item'),
	('sugar', 'Sugar', 20, 1, 'item_standard', 0, 289, 1, '{}', 'nice item'),
	('sugarcaneseed', 'Surgarcane seed', 10, 1, 'item_standard', 1, 290, 1, '{}', 'nice item'),
	('sugarcube', 'Sugar Cube', 10, 1, 'item_standard', 1, 347, 1, '{}', 'nice item'),
	('sulfur', 'Sulfur', 30, 1, 'item_standard', 0, 291, 1, '{}', 'nice item'),
	('synpackage', 'Syn Package', 10, 1, 'item_standard', 1, 293, 1, '{}', 'nice item'),
	('syringe', 'Syringe', 20, 1, 'item_standard', 1, 294, 1, '{}', 'nice item'),
	('syringecert', 'Syringe Cert', 10, 1, 'item_standard', 1, 295, 1, '{}', 'nice item'),
	('syringe_adrenalin', 'Syringe of Adrenalin', 5, 1, 'item_standard', 1, 1134, 1, '{}', 'A syringe filled with adrenalin.'),
	('syringe_steroids', 'Syringe of Steroids', 5, 1, 'item_standard', 1, 1133, 1, '{}', 'A syringe containing steroids.'),
	('tent', 'Tent', 1, 1, 'item_standard', 1, 296, 1, '{}', 'nice item'),
	('tent2', 'Trader Tent', 20, 1, 'item_standard', 1, 588, 1, '{}', 'nice item'),
	('tent3', 'Simple Tent', 20, 1, 'item_standard', 1, 589, 1, '{}', 'nice item'),
	('tent4', 'Canvas Shade', 20, 1, 'item_standard', 1, 590, 1, '{}', 'nice item'),
	('tequila', 'Tequila', 10, 1, 'item_standard', 1, 297, 1, '{}', 'nice item'),
	('Texas_Bonnet', 'Texas Bonnet', 21, 1, 'item_standard', 1, 298, 1, '{}', 'nice item'),
	('Texas_Bonnet_Seed', 'Texas Bonnet Seed', 10, 1, 'item_standard', 1, 299, 1, '{}', 'nice item'),
	('timbertable', 'Timber Table', 20, 1, 'item_standard', 1, 752, 1, '{}', 'nice item'),
	('timber_table', 'Timber Table', 20, 1, 'item_standard', 1, 624, 1, '{}', 'nice item'),
	('tipi', 'Native Tipi', 20, 1, 'item_standard', 1, 596, 1, '{}', 'nice item'),
	('toaddesert_c', 'Desert Toad', 20, 1, 'item_standard', 1, 444, 1, '{}', 'nice item'),
	('toadpoison_c', 'Poisoned Toad', 20, 1, 'item_standard', 1, 443, 1, '{}', 'nice item'),
	('toad_c', 'Toad', 20, 1, 'item_standard', 1, 442, 1, '{}', 'nice item'),
	('token', 'Camp License', 5, 1, 'item_standard', 1, 300, 1, '{}', 'nice item'),
	('toolbarrel', 'Tool Barrel', 20, 1, 'item_standard', 1, 767, 1, '{}', 'nice item'),
	('tool_barrel', 'Tool Barrel', 20, 1, 'item_standard', 1, 639, 1, '{}', 'nice item'),
	('trainkey', 'Train Key', 1, 1, 'item_standard', 1, 301, 1, '{}', 'nice item'),
	('trainoil', 'Train Oil', 10, 1, 'item_standard', 0, 1123, 1, '{}', 'nice item'),
	('trayoffood', 'Serving Table', 20, 1, 'item_standard', 1, 614, 1, '{}', 'nice item'),
	('treasuremap', 'map', 10, 1, 'item_standard', 1, 1136, 1, '{}', 'nice item'),
	('tropicalPunchMash', 'Ginseng Mash', 10, 1, 'item_standard', 0, 302, 1, '{}', 'nice item'),
	('tropicalPunchMoonshine', 'Ginseng Moonshine', 10, 1, 'item_standard', 0, 303, 1, '{}', 'nice item'),
	('trout', 'Trout', 10, 1, 'item_standard', 0, 304, 1, '{}', 'nice item'),
	('turkeyb', 'Turkey beak', 20, 1, 'item_standard', 1, 484, 1, '{}', 'nice item'),
	('turkeyf', 'Turkey feather', 20, 1, 'item_standard', 1, 483, 1, '{}', 'nice item'),
	('TurtleShell', 'Turtle Shell', 20, 1, 'item_standard', 1, 305, 1, '{}', 'nice item'),
	('turtlet', 'Turtle tooth', 20, 1, 'item_standard', 1, 482, 1, '{}', 'nice item'),
	('tylenol', 'Tylenol', 10, 1, 'item_standard', 1, 306, 1, '{}', 'nice item'),
	('undertaker1', 'Coffin', 20, 1, 'item_standard', 1, 609, 1, '{}', 'nice item'),
	('undertaker2', 'Flower Coffin', 21, 1, 'item_standard', 1, 610, 1, '{}', 'nice item'),
	('unique_brad_horsesugar', 'Brad Horse Sugar', 5, 1, 'item_standard', 1, 350, 1, '{}', 'nice item'),
	('unique_horse_feed', 'Horse Feed', 5, 1, 'item_standard', 1, 349, 1, '{}', 'nice item'),
	('vanillaFlower', 'Vanille Flower', 20, 1, 'item_standard', 0, 307, 1, '{}', 'nice item'),
	('vegstew', 'vegstew', 25, 1, 'item_standard', 1, 1054, 1, '{}', 'nice item'),
	('venison', 'Venison', 20, 1, 'item_standard', 1, 566, 1, '{}', 'nice item'),
	('Violet_Snowdrop', 'Violet Snowdrop', 21, 1, 'item_standard', 1, 308, 1, '{}', 'nice item'),
	('Violet_Snowdrop_Seed', 'Violet Snowdrop Seed', 10, 1, 'item_standard', 1, 309, 1, '{}', 'nice item'),
	('vodka', 'Vodka', 10, 1, 'item_standard', 1, 310, 1, '{}', 'nice item'),
	('Volture_Egg', 'Volture Egg', 10, 1, 'item_standard', 1, 311, 1, '{}', 'nice item'),
	('vulturetaxi', 'Vulture Taxidermy', 20, 1, 'item_standard', 1, 772, 1, '{}', 'nice item'),
	('vulture_taxidermy', 'Vulture Taxidermy', 20, 1, 'item_standard', 1, 644, 1, '{}', 'nice item'),
	('washtub', 'Wash Tub', 20, 1, 'item_standard', 1, 637, 1, '{}', 'nice item'),
	('water', 'Water', 15, 1, 'item_standard', 1, 312, 1, '{}', 'nice item'),
	('waterbarrel', 'Water Barrel', 20, 1, 'item_standard', 1, 587, 1, '{}', 'nice item'),
	('wateringbucket', 'Watering Can', 1, 1, 'item_standard', 0, 1139, 1, '{}', 'nice item'),
	('wateringcan', 'Water Jug', 10, 1, 'item_standard', 1, 313, 1, '{}', 'nice item'),
	('wateringcan_dirtywater', 'Dirty Watering Jug', 10, 1, 'item_standard', 1, 314, 1, '{}', 'nice item'),
	('wateringcan_empty', 'Empty Watering Jug', 10, 1, 'item_standard', 1, 315, 1, '{}', 'nice item'),
	('waterpump', 'Water Pump', 20, 1, 'item_standard', 1, 755, 1, '{}', 'nice item'),
	('water_pump', 'Water Pump', 20, 1, 'item_standard', 1, 627, 1, '{}', 'nice item'),
	('weedbuds', 'Weed Buds', 21, 1, 'item_standard', 0, 987, 1, '{}', 'nice item'),
	('weedseed', 'Weed Seeds', 20, 1, 'item_standard', 0, 986, 1, '{}', 'nice item'),
	('whiskey', 'whiskey', 10, 1, 'item_standard', 1, 316, 1, '{}', 'nice item'),
	('wickerbench', 'Wicker Bench', 20, 1, 'item_standard', 1, 778, 1, '{}', 'nice item'),
	('wicker_bench', 'Wicker Bench', 20, 1, 'item_standard', 1, 650, 1, '{}', 'nice item'),
	('wildCiderMash', 'Black Berry Mash', 20, 1, 'item_standard', 0, 317, 1, '{}', 'nice item'),
	('wildCiderMoonshine', 'Black Berry Moonshine', 10, 1, 'item_standard', 0, 318, 1, '{}', 'nice item'),
	('Wild_Carrot', 'Wild Carrot', 21, 1, 'item_standard', 1, 319, 1, '{}', 'nice item'),
	('Wild_Carrot_Seed', 'Wild Carrot Seed', 10, 1, 'item_standard', 1, 320, 1, '{}', 'nice item'),
	('Wild_Feverfew', 'Wild Feverfew', 21, 1, 'item_standard', 1, 321, 1, '{}', 'nice item'),
	('Wild_Feverfew_Seed', 'Wild Feverfew Seed', 10, 1, 'item_standard', 1, 322, 1, '{}', 'nice item'),
	('Wild_Mint', 'Wild Mint', 21, 1, 'item_standard', 1, 323, 1, '{}', 'nice item'),
	('Wild_Mint_Seed', 'Wild Mint Seed', 10, 1, 'item_standard', 1, 324, 1, '{}', 'nice item'),
	('Wild_Rhubarb', 'Wild Rhubarb', 21, 1, 'item_standard', 1, 325, 1, '{}', 'nice item'),
	('Wild_Rhubarb_Seed', 'Wild Rhubarb Seed', 10, 1, 'item_standard', 1, 326, 1, '{}', 'nice item'),
	('wine', 'Wine', 10, 1, 'item_standard', 1, 327, 1, '{}', 'nice item'),
	('Wintergreen_Berry', 'Wintergreen Berry', 21, 1, 'item_standard', 1, 328, 1, '{}', 'nice item'),
	('Wintergreen_Berry_Seed', 'Wintergreen Berry Seed', 10, 1, 'item_standard', 1, 329, 1, '{}', 'nice item'),
	('Wisteria', 'Wisteria', 21, 1, 'item_standard', 1, 330, 1, '{}', 'nice item'),
	('Wisteria_Seed', 'Wisteria Seed', 10, 1, 'item_standard', 1, 331, 1, '{}', 'nice item'),
	('wojape', 'Wojape', 5, 1, 'item_standard', 1, 332, 1, '{}', 'nice item'),
	('wolfheart', 'Wolf heart', 20, 1, 'item_standard', 1, 476, 1, '{}', 'nice item'),
	('wolfpelt', 'Wolf skin', 20, 1, 'item_standard', 1, 477, 1, '{}', 'nice item'),
	('wolftooth', 'Wolf tooth', 20, 1, 'item_standard', 1, 478, 1, '{}', 'nice item'),
	('wood', 'Soft Wood', 20, 1, 'item_standard', 0, 333, 1, '{}', 'nice item'),
	('woodbench', 'Wooden Bench', 20, 1, 'item_standard', 1, 777, 1, '{}', 'nice item'),
	('woodchair', 'Wood Chair', 20, 1, 'item_standard', 1, 747, 1, '{}', 'nice item'),
	('wooden_bench', 'Wooden Bench', 20, 1, 'item_standard', 1, 649, 1, '{}', 'nice item'),
	('wooden_boards', 'Wooden Boards', 25, 1, 'item_standard', 0, 334, 1, '{}', 'nice item'),
	('woodpeck01_c', 'Woodpecker', 20, 1, 'item_standard', 1, 445, 1, '{}', 'nice item'),
	('woodpeck02_c', 'Woodpecker 2', 20, 1, 'item_standard', 1, 446, 1, '{}', 'nice item'),
	('wood_chair', 'Wood Chair', 20, 1, 'item_standard', 1, 619, 1, '{}', 'nice item'),
	('wool', 'Wool', 50, 1, 'item_standard', 1, 335, 1, '{}', 'nice item'),
	('wsnakes', 'Western rattlesnake pelt', 20, 1, 'item_standard', 1, 489, 1, '{}', 'nice item'),
	('wsnakeskin', 'Watersnake pelt', 20, 1, 'item_standard', 1, 485, 1, '{}', 'nice item'),
	('Yarrow', 'Yarrow', 20, 1, 'item_standard', 1, 336, 1, '{}', 'nice item'),
	('Yarrow_Seed', 'Yarrow Seed', 10, 1, 'item_standard', 1, 337, 1, '{}', 'nice item');

-- Dumping structure for table vorpcore_34e5f3.items_crafted
CREATE TABLE IF NOT EXISTS `items_crafted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`metadata`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`),
  KEY `crafted_item_idx` (`character_id`)
) ENGINE=InnoDB AUTO_INCREMENT=815 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.items_crafted: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.item_group
CREATE TABLE IF NOT EXISTS `item_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL COMMENT 'Description of Item Group',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.item_group: ~11 rows (approximately)
INSERT INTO `item_group` (`id`, `description`) VALUES
	(1, ''),
	(2, 'medical'),
	(3, 'foods'),
	(4, 'tools'),
	(5, 'weapons'),
	(6, 'ammo'),
	(7, 'documents'),
	(8, 'animals'),
	(9, 'valuables'),
	(10, 'horse'),
	(11, 'herbs');

-- Dumping structure for table vorpcore_34e5f3.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '0',
  `characterid` varchar(5) NOT NULL DEFAULT '0',
  `time` varchar(100) NOT NULL DEFAULT '0',
  `time_s` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table vorpcore_34e5f3.jail: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.jobmanager
CREATE TABLE IF NOT EXISTS `jobmanager` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `jobname` varchar(50) NOT NULL,
  PRIMARY KEY (`identifier`,`charidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.jobmanager: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.legendaries
CREATE TABLE IF NOT EXISTS `legendaries` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `trust` int(100) NOT NULL DEFAULT 0,
  UNIQUE KEY `charidentifier` (`charidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.legendaries: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.loadout
CREATE TABLE IF NOT EXISTS `loadout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ammo` varchar(255) NOT NULL DEFAULT '{}',
  `components` varchar(255) NOT NULL DEFAULT '{}',
  `dirtlevel` double DEFAULT 0,
  `mudlevel` double DEFAULT 0,
  `conditionlevel` double DEFAULT 0,
  `rustlevel` double DEFAULT 0,
  `used` tinyint(4) DEFAULT 0,
  `used2` tinyint(4) DEFAULT 0,
  `dropped` int(11) NOT NULL DEFAULT 0,
  `comps` longtext NOT NULL DEFAULT '{}',
  `label` varchar(50) DEFAULT NULL,
  `curr_inv` varchar(100) NOT NULL DEFAULT 'default',
  `custom_desc` varchar(50) DEFAULT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `custom_label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.loadout: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.loadout_props
CREATE TABLE IF NOT EXISTS `loadout_props` (
  `id` int(11) NOT NULL,
  `permDegradation` double NOT NULL DEFAULT 0,
  `degradation` double NOT NULL DEFAULT 0,
  `damage` double NOT NULL DEFAULT 0,
  `dirt` double NOT NULL DEFAULT 0,
  `soot` double NOT NULL DEFAULT 0,
  `isJammed` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.loadout_props: ~1 rows (approximately)
INSERT INTO `loadout_props` (`id`, `permDegradation`, `degradation`, `damage`, `dirt`, `soot`, `isJammed`) VALUES
	(65, 0.000078, 0.054, 0, 0, 0.072, 0);

-- Dumping structure for table vorpcore_34e5f3.mailbox_mails
CREATE TABLE IF NOT EXISTS `mailbox_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` varchar(50) DEFAULT NULL,
  `sender_firstname` varchar(50) DEFAULT NULL,
  `sender_lastname` varchar(50) DEFAULT NULL,
  `receiver_id` varchar(50) DEFAULT NULL,
  `receiver_firstname` varchar(50) DEFAULT NULL,
  `receiver_lastname` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `opened` tinyint(1) DEFAULT 0,
  `received_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.mailbox_mails: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.mms_huntingid
CREATE TABLE IF NOT EXISTS `mms_huntingid` (
  `identifier` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `picture` varchar(50) DEFAULT NULL,
  `days` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.mms_huntingid: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.mms_id
CREATE TABLE IF NOT EXISTS `mms_id` (
  `identifier` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `job` varchar(50) DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `picture` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.mms_id: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.moonshiner
CREATE TABLE IF NOT EXISTS `moonshiner` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object` text NOT NULL DEFAULT '',
  `xpos` float NOT NULL,
  `ypos` float NOT NULL,
  `zpos` float NOT NULL,
  `actif` int(10) unsigned DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.moonshiner: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.moonshiner_plants
CREATE TABLE IF NOT EXISTS `moonshiner_plants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object` text NOT NULL DEFAULT '',
  `xpos` float NOT NULL,
  `ypos` float NOT NULL,
  `zpos` float NOT NULL,
  `cooldown` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.moonshiner_plants: ~55 rows (approximately)
INSERT INTO `moonshiner_plants` (`id`, `object`, `xpos`, `ypos`, `zpos`, `cooldown`) VALUES
	(1, 'alaskanginseng_p', -139.81, 1931.9, 255.269, 0),
	(2, 'alaskanginseng_p', -148.19, 1928.39, 254.8, 0),
	(3, 'alaskanginseng_p', -147.9, 1917.46, 253.23, 0),
	(4, 'alaskanginseng_p', -156.46, 1924.57, 253.49, 0),
	(5, 'alaskanginseng_p', -134.9, 1918.82, 254.26, 0),
	(6, 'alaskanginseng_p', -126.98, 1929.65, 255.2, 0),
	(7, 'ginseng_p', -1441.57, -1551.41, 88.44, 0),
	(8, 'ginseng_p', -1440.07, -1567.56, 89.01, 0),
	(9, 'ginseng_p', -1490.11, -1522.28, 93.64, 0),
	(10, 'ginseng_p', -1490.11, -1522.28, 93.64, 0),
	(11, 'ginseng_p', -1412.69, -1544.3, 85.81, 0),
	(12, 'ginseng_p', -1393.44, -1550.06, 84.95, 0),
	(13, 's_inv_baybolete01bx', -2046.48, -1498.77, 128.76, 0),
	(14, 's_inv_baybolete01bx', -2043.81, -1487.83, 127.51, 0),
	(15, 's_inv_baybolete01bx', -2036.59, -1489.84, 125.56, 0),
	(16, 's_inv_baybolete01bx', -2031.76, -1506, 123.91, 0),
	(17, 'blackcurrant_p', -5169.28, -2565.08, -9.94, 0),
	(18, 'blackcurrant_p', -5182.47, -2565.79, -8.14, 0),
	(19, 'blackcurrant_p', -5189.39, -2564.81, -7.58, 0),
	(20, 'blackcurrant_p', -5192.56, -2570.35, -6.86, 0),
	(21, 'blackcurrant_p', -5173.05, -2559.49, -9.64, 0),
	(22, 's_inv_huckleberry01x', 2396.58, 1021.06, 89.35, 0),
	(23, 's_inv_huckleberry01x', 2395.36, 1004.37, 87.31, 0),
	(24, 's_inv_huckleberry01x', 2389.55, 1029.9, 89.35, 0),
	(25, 's_inv_huckleberry01x', 2378.31, 1025.52, 89.35, 0),
	(26, 's_inv_huckleberry01x', 2357.28, 860.63, 77.58, 0),
	(27, 's_inv_huckleberry01x', 2383.94, 867.17, 74.44, 0),
	(28, 's_inv_huckleberry01x', 2367.73, 848.99, 77.77, 0),
	(29, 's_inv_huckleberry01x', 2352.81, 853.82, 79.62, 0),
	(30, 'wildmint_p', -2781.61, -7.44, 154.7, 0),
	(31, 'wildmint_p', -2774.35, -29.88, 152.95, 0),
	(32, 'wildmint_p', -2785.41, 5.94, 155.35, 0),
	(33, 'wildmint_p', -2778.72, 11.01, 155.39, 0),
	(34, 'wildmint_p', -2766.75, -4.64, 154.39, 0),
	(35, 'wildmint_p', -2800.75, -41.03, 155.2, 0),
	(36, 'wildmint_p', -2799.97, -55.82, 155.25, 0),
	(37, 'wildmint_p', -2812.37, -41.92, 156.19, 0),
	(38, 'wildmint_p', -2809.4, -38.57, 156.09, 0),
	(39, 's_inv_blackberry01x', -669.59, 282.33, 89.22, 0),
	(40, 's_inv_blackberry01x', -1016.87, 197.81, 85.76, 0),
	(41, 's_inv_blackberry01x', -1023.06, 194.34, 87.56, 17),
	(42, 's_inv_blackberry01x', -1015.04, 190.29, 86.27, 0),
	(43, 's_inv_blackberry01x', -1027.94, 181.45, 89.29, 0),
	(44, 's_inv_blackberry01x', -1030.86, 198.4, 87.3, 27),
	(45, 's_inv_blackberry01x', -669.87, 261.07, 90, 0),
	(46, 's_inv_blackberry01x', -662.48, 271.38, 89.9, 0),
	(47, 's_inv_blackberry01x', -655.7, 264.41, 90.11, 0),
	(48, 's_inv_blackberry01x', -659.28, 285.87, 89.42, 0),
	(49, 's_inv_blackberry01x', -645.99, 281.11, 89.78, 0),
	(50, 's_inv_raspberry01x', 28.92, 483.13, 160.06, 0),
	(51, 's_inv_raspberry01x', 40.92, 484.13, 158.56, 0),
	(52, 's_inv_raspberry01x', 32.92, 470.13, 156.93, 0),
	(53, 's_inv_raspberry01x', 9, 486.13, 158.24, 0),
	(54, 's_inv_raspberry01x', -9, 519.13, 152.73, 0),
	(55, 's_inv_raspberry01x', -19, 554.13, 135.02, 0);

-- Dumping structure for table vorpcore_34e5f3.oil
CREATE TABLE IF NOT EXISTS `oil` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `manager_trust` int(100) NOT NULL DEFAULT 0,
  `enemy_trust` int(100) NOT NULL DEFAULT 0,
  `oil_wagon` varchar(50) NOT NULL DEFAULT 'none',
  `delivery_wagon` varchar(50) NOT NULL DEFAULT 'none',
  UNIQUE KEY `charidentifier` (`charidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.oil: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(45) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comps` longtext DEFAULT NULL,
  `compTints` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.outfits: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.pets
CREATE TABLE IF NOT EXISTS `pets` (
  `identifier` varchar(40) NOT NULL,
  `charidentifier` int(11) NOT NULL DEFAULT 0,
  `dog` varchar(255) NOT NULL,
  `skin` int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.pets: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.playerfarms
CREATE TABLE IF NOT EXISTS `playerfarms` (
  `charid` int(11) NOT NULL,
  `farm` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.playerfarms: ~0 rows (approximately)
INSERT INTO `playerfarms` (`charid`, `farm`) VALUES
	(1, '{"Alaskan Ginseng":[]}'),
	(11, '{"Alaskan Ginseng":[]}'),
	(24, '{"Alaskan Ginseng":[]}'),
	(26, '{"Black Currant":[],"Black Berry":[],"Alaskan Ginseng":[]}'),
	(27, '{"Alaskan Ginseng":[]}'),
	(29, '{"Alaskan Ginseng":[],"Black Currant":[]}'),
	(33, '{"Yarrow":[]}');

-- Dumping structure for table vorpcore_34e5f3.player_horses
CREATE TABLE IF NOT EXISTS `player_horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `components` varchar(5000) NOT NULL DEFAULT '{}',
  `gender` enum('male','female') DEFAULT 'male',
  `xp` int(11) NOT NULL DEFAULT 0,
  `captured` int(11) NOT NULL DEFAULT 0,
  `born` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.player_horses: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.player_wagons
CREATE TABLE IF NOT EXISTS `player_wagons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.player_wagons: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.ranch
CREATE TABLE IF NOT EXISTS `ranch` (
  `charidentifier` varchar(50) NOT NULL,
  `ranchcoords` longtext NOT NULL,
  `ranchname` varchar(100) NOT NULL,
  `ranch_radius_limit` varchar(100) NOT NULL,
  `ranchid` int(11) NOT NULL AUTO_INCREMENT,
  `ranchCondition` int(10) NOT NULL DEFAULT 0,
  `cows` varchar(50) NOT NULL DEFAULT 'false',
  `cows_cond` int(10) NOT NULL DEFAULT 0,
  `pigs` varchar(50) NOT NULL DEFAULT 'false',
  `pigs_cond` int(10) NOT NULL DEFAULT 0,
  `chickens` varchar(50) NOT NULL DEFAULT 'false',
  `chickens_cond` int(10) NOT NULL DEFAULT 0,
  `goats` varchar(50) NOT NULL DEFAULT 'false',
  `goats_cond` int(10) NOT NULL DEFAULT 0,
  `cows_age` int(10) DEFAULT 0,
  `chickens_age` int(10) DEFAULT 0,
  `goats_age` int(10) DEFAULT 0,
  `pigs_age` int(10) DEFAULT 0,
  `chicken_coop` varchar(50) DEFAULT 'none',
  `chicken_coop_coords` longtext DEFAULT 'none',
  `ledger` int(10) DEFAULT 0,
  `shovehaycoords` longtext DEFAULT 'none',
  `wateranimalcoords` longtext DEFAULT 'none',
  `repairtroughcoords` longtext DEFAULT 'none',
  `scooppoopcoords` longtext DEFAULT 'none',
  `herdlocation` longtext DEFAULT 'none',
  `pigcoords` longtext DEFAULT 'none',
  `cowcoords` longtext DEFAULT 'none',
  `chickencoords` longtext DEFAULT 'none',
  `goatcoords` longtext DEFAULT 'none',
  `wagonfeedcoords` longtext DEFAULT 'none',
  PRIMARY KEY (`ranchid`),
  UNIQUE KEY `charidentifier` (`charidentifier`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.ranch: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.rm_prison
CREATE TABLE IF NOT EXISTS `rm_prison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `characterid` int(11) NOT NULL DEFAULT 0,
  `prison_number` varchar(100) NOT NULL DEFAULT '0',
  `prison_time` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.rm_prison: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `key` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.rooms: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.society
CREATE TABLE IF NOT EXISTS `society` (
  `business` varchar(255) NOT NULL,
  `pay` int(255) NOT NULL,
  PRIMARY KEY (`business`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.society: ~4 rows (approximately)
INSERT INTO `society` (`business`, `pay`) VALUES
	('doctor', 0),
	('farmer', 0),
	('gunsmith', 0),
	('police', 0);

-- Dumping structure for table vorpcore_34e5f3.society_bill
CREATE TABLE IF NOT EXISTS `society_bill` (
  `identifier` varchar(255) NOT NULL,
  `charid` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `society` varchar(255) NOT NULL,
  `reason` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table vorpcore_34e5f3.society_bill: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.society_ledger
CREATE TABLE IF NOT EXISTS `society_ledger` (
  `job` longtext DEFAULT NULL,
  `ledger` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.society_ledger: ~4 rows (approximately)
INSERT INTO `society_ledger` (`job`, `ledger`) VALUES
	('police', 0),
	('miner', 0),
	('doctor', 0),
	('horsetrainer', 0);

-- Dumping structure for table vorpcore_34e5f3.stables
CREATE TABLE IF NOT EXISTS `stables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `modelname` varchar(70) NOT NULL,
  `type` varchar(11) NOT NULL,
  `status` longtext DEFAULT NULL,
  `xp` int(11) DEFAULT 0,
  `injured` int(11) DEFAULT 0,
  `gear` longtext DEFAULT NULL,
  `isDefault` int(11) NOT NULL DEFAULT 0,
  `inventory` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.stables: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.stagecoaches
CREATE TABLE IF NOT EXISTS `stagecoaches` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stagecoach` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.stagecoaches: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.train
CREATE TABLE IF NOT EXISTS `train` (
  `charidentifier` int(11) NOT NULL,
  `trainid` int(11) NOT NULL AUTO_INCREMENT,
  `trainModel` varchar(50) NOT NULL,
  `fuel` int(11) NOT NULL,
  `condition` int(11) NOT NULL,
  PRIMARY KEY (`trainid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.train: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(50) DEFAULT 'user',
  `warnings` int(11) DEFAULT 0,
  `banned` tinyint(1) DEFAULT NULL,
  `banneduntil` int(10) DEFAULT 0,
  `char` int(11) DEFAULT 5,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.users: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.user_jail
CREATE TABLE IF NOT EXISTS `user_jail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `characterid` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT '0',
  `admin_name` varchar(100) NOT NULL DEFAULT '0',
  `admin_identifier` varchar(100) NOT NULL DEFAULT '0',
  `time` varchar(100) NOT NULL DEFAULT '0',
  `time_s` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table vorpcore_34e5f3.user_jail: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.vorp_queue
CREATE TABLE IF NOT EXISTS `vorp_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.vorp_queue: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.wagons
CREATE TABLE IF NOT EXISTS `wagons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `items` longtext DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  KEY `model` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpcore_34e5f3.wagons: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.wagon_water
CREATE TABLE IF NOT EXISTS `wagon_water` (
  `identifier` varchar(255) DEFAULT '0',
  `charid` varchar(255) DEFAULT '0',
  `wagon` varchar(255) DEFAULT '0',
  `water` varchar(255) DEFAULT '0',
  `wagon_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

-- Dumping data for table vorpcore_34e5f3.wagon_water: ~0 rows (approximately)

-- Dumping structure for table vorpcore_34e5f3.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `firstconnection` tinyint(1) DEFAULT 1,
  `discordid` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpcore_34e5f3.whitelist: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
