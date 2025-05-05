
CREATE TABLE IF NOT EXISTS `playerfarms` (
  `charid` int(11) NOT NULL,
  `farm` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('wateringcan_empty', 'Empty Watering Can', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('wateringcan', 'Watering Can', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('wateringcan_dirtywater', 'Watering Can Dirty', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('planttrimmer', 'Plant Trimmer', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('hoe', 'Garden Hoe', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Alaskan_Ginseng_Seed', 'Alaskan Ginseng Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Alaskan_Ginseng', 'Alaskan Ginseng', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('American_Ginseng_Seed', 'American Ginseng Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('American_Ginseng', 'American Ginseng', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('hop_seed', 'Hop Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('hop', 'Hop', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Black_Berry_Seed', 'Black Berry Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Black_Berry', 'Black Berry', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Black_Currant_Seed', 'Black Currant Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Black_Currant', 'Black Currant', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Blood_Flower_Seed', 'Blood Flower Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Blood_Flower', 'Blood Flower', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Choc_Daisy_Seed', 'Choc Daisy Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Choc_Daisy', 'Choc Daisy', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Creekplum_Seed', 'Creekplum Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Creekplum', 'Creekplum', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Creeking_Thyme_Seed', 'Creeking Thyme Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Crows_Garlic_Seed', 'Crows Garlic Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Crows_Garlic', 'Crows Garlic', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('English_Mace_Seed', 'English Mace Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('English_Mace', 'English Mace', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Indian_Tobbaco_Seed', 'Indian Tobbaco Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Indian_Tobbaco', 'Indian Tobbaco', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Milk_Weed_Seed', 'Milk Weed Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Milk_Weed', 'Milk Weed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Oleander_Sage_Seed', 'Oleander Sage Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Oleander_Sage', 'Oleander Sage', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Oregano_Seed', 'Oregano Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Oregano', 'Oregano', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Parasol_Mushroom_Seed', 'Parasol Mushroom Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Parasol_Mushroom', 'Parasol Mushroom', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Prairie_Poppy_Seed', 'Prairie Poppy Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Prairie_Poppy', 'Prairie Poppy', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Red_Raspberry_Seed', 'Red Raspberry Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Red_Raspberry', 'Red Raspberry', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Red_Sage_Seed', 'Red Sage Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Red_Sage', 'Red Sage', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Wild_Carrot_Seed', 'Wild Carrot Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Wild_Carrot', 'Wild Carrot', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Wild_Mint_Seed', 'Wild Mint Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Wild_Mint', 'Wild Mint', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Wintergreen_Berry_Seed', 'Wintergreen Berry Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Wintergreen_Berry', 'Wintergreen Berry', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Yarrow', 'Yarrow', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Yarrow_Seed', 'Yarrow Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('cornseed', 'Corn Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('corn', 'Corn', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('Apple_Seed', 'Apple Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('apple', 'Apple', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('sugarcaneseed', 'Sugarcane Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('sugar', 'Sugar', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('potatoseed', 'Potato Seed', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('potato', 'Potato', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('cocoaseeds', 'Cocoa Seeds', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('cocoa', 'Cocoa', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('peachseeds', 'Peach Seeds', 10, 1, 'item_standard', 1);


INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizer', 'Fertilizer', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizeregg', 'Fertilizer with Eggs', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizerbless', 'Blessed Fertilizer', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizerfm', 'fmful Fertilizer', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizerpro', 'Fertilizer with Produce', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizerpulpsap', 'Fertilizer with Pulp/Sap', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizersn', 'Fertilizer with Snake', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizersq', 'Fertilizer with Squirrel', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizerwoj', 'Fertilizer with Wojape', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizersw', 'Fertilizer with Soft Wood', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('fertilizer', 'Fertilizer', 10, 1, 'item_standard', 1);
