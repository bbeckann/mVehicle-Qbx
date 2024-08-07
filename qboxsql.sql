CREATE TABLE `player_vehicles` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`license` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`citizenid` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`vehicle` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`hash` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`mods` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`plate` VARCHAR(15) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`fakeplate` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`garage` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`fuel` INT(11) NULL DEFAULT '100',
	`engine` FLOAT NULL DEFAULT '1000',
	`body` FLOAT NULL DEFAULT '1000',
        `state` INT(11) NULL DEFAULT '1', -- Estado do veículo: 1 = Na garagem, 0 = Fora da garagem
	`depotprice` INT(11) NOT NULL DEFAULT '0',
	`drivingdistance` INT(50) NULL DEFAULT NULL,
        `status` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci', -- Informações detalhadas sobre o estado do veículo
	`glovebox` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`trunk` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`mileage` INT(11) NULL DEFAULT '0',
	`coords` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`lastparking` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`type` VARCHAR(20) NOT NULL DEFAULT 'automobile' COLLATE 'utf8mb4_unicode_ci',
	`job` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`pound` VARCHAR(60) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	---`stored` TINYINT(4) NOT NULL DEFAULT '0', ///removido
	`keys` LONGTEXT NULL DEFAULT '[]' COLLATE 'utf8mb4_unicode_ci',
	`metadata` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`parking` VARCHAR(60) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `plate` (`plate`) USING BTREE,
	INDEX `citizenid` (`citizenid`) USING BTREE,
	INDEX `license` (`license`) USING BTREE,
	CONSTRAINT `player_vehicles_ibfk_1` FOREIGN KEY (`citizenid`) REFERENCES `players` (`citizenid`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `player_vehicles_ibfk_2` FOREIGN KEY (`license`) REFERENCES `players` (`license`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
AUTO_INCREMENT=139
;
