CREATE TABLE `rm_prison` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `characterid` int(11) NOT NULL DEFAULT 0,
  `prison_number` varchar(100) NOT NULL DEFAULT '0',
  `prison_time` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `rm_prison`
  ADD PRIMARY KEY (`id`);
  
ALTER TABLE `rm_prison`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;