CREATE TABLE `batop-jail` (
  `jailId` int(11) NOT NULL,
  `identifier` varchar(70) NOT NULL,
  `time` int(11) DEFAULT 0,
  `raison` longtext DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 