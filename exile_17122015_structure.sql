-- phpMyAdmin SQL Dump
-- version 4.0.10.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 17, 2015 at 08:31 PM
-- Server version: 5.5.44-0+deb8u1
-- PHP Version: 5.6.13-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `exile`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE IF NOT EXISTS `account` (
  `uid` varchar(32) NOT NULL,
  `clan_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `money` double NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  `kills` int(11) unsigned NOT NULL DEFAULT '0',
  `deaths` int(11) unsigned NOT NULL DEFAULT '0',
  `first_connect_at` datetime NOT NULL,
  `last_connect_at` datetime NOT NULL,
  `last_disconnect_at` datetime DEFAULT NULL,
  `total_connections` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`uid`),
  KEY `clan_id` (`clan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `clan`
--

CREATE TABLE IF NOT EXISTS `clan` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `leader_uid` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL,
  `insignia_texture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `leader_uid` (`leader_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `construction`
--

CREATE TABLE IF NOT EXISTS `construction` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(64) NOT NULL,
  `account_uid` varchar(32) NOT NULL,
  `spawned_at` datetime NOT NULL,
  `position_x` double NOT NULL DEFAULT '0',
  `position_y` double NOT NULL DEFAULT '0',
  `position_z` double NOT NULL DEFAULT '0',
  `direction_x` double NOT NULL DEFAULT '0',
  `direction_y` double NOT NULL DEFAULT '0',
  `direction_z` double NOT NULL DEFAULT '0',
  `up_x` double NOT NULL DEFAULT '0',
  `up_y` double NOT NULL DEFAULT '0',
  `up_z` double NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `pin_code` varchar(6) NOT NULL DEFAULT '000000',
  `territory_id` int(11) unsigned DEFAULT NULL,
  `last_updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `account_uid` (`account_uid`),
  KEY `territory_id` (`territory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Triggers `construction`
--
DROP TRIGGER IF EXISTS `trigg_construct`;
DELIMITER //
CREATE TRIGGER `trigg_construct` BEFORE INSERT ON `construction`
 FOR EACH ROW BEGIN
SET NEW.spawned_at=NOW();
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `container`
--

CREATE TABLE IF NOT EXISTS `container` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(64) NOT NULL,
  `spawned_at` datetime NOT NULL,
  `account_uid` varchar(32) DEFAULT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `position_x` double NOT NULL DEFAULT '0',
  `position_y` double NOT NULL DEFAULT '0',
  `position_z` double NOT NULL DEFAULT '0',
  `direction_x` double NOT NULL DEFAULT '0',
  `direction_y` double NOT NULL DEFAULT '0',
  `direction_z` double NOT NULL DEFAULT '0',
  `up_x` double NOT NULL DEFAULT '0',
  `up_y` double NOT NULL DEFAULT '0',
  `up_z` double NOT NULL DEFAULT '1',
  `cargo_items` text NOT NULL,
  `cargo_magazines` text NOT NULL,
  `cargo_weapons` text NOT NULL,
  `cargo_container` text NOT NULL,
  `last_updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pin_code` varchar(6) NOT NULL DEFAULT '000000',
  `territory_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_uid` (`account_uid`),
  KEY `territory_id` (`territory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=1 ;

--
-- Triggers `container`
--
DROP TRIGGER IF EXISTS `trigg_contain`;
DELIMITER //
CREATE TRIGGER `trigg_contain` BEFORE INSERT ON `container`
 FOR EACH ROW BEGIN
 SET NEW.spawned_at=NOW();
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kills`
--

CREATE TABLE IF NOT EXISTS `kills` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identification number of each kill',
  `killer_name` varchar(50) NOT NULL DEFAULT 'Unkown' COMMENT 'Name of the Killer',
  `killer_uid` varchar(32) DEFAULT NULL COMMENT 'UID of the Killer',
  `victim_name` varchar(50) NOT NULL DEFAULT 'Unkown' COMMENT 'Name of the Person who died',
  `victim_uid` varchar(32) DEFAULT NULL COMMENT 'UID of the Victim',
  `weapon` varchar(50) NOT NULL DEFAULT 'Unkown' COMMENT 'Name of the weapon/vehicle or item used to kill',
  `distance` varchar(10) NOT NULL DEFAULT '0' COMMENT 'Number of distance in meters between the killer and the victim',
  `respect` varchar(10) DEFAULT '0' COMMENT 'Number of respect the killer earned',
  `died_at` datetime DEFAULT '0000-00-00 00:00:00' COMMENT 'Date and time the victim was killed',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Kill Feeds by GR8\r\nWith Victom, Killer, distance and gun' AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE IF NOT EXISTS `player` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `account_uid` varchar(32) NOT NULL,
  `damage` double unsigned NOT NULL DEFAULT '0',
  `hunger` double unsigned NOT NULL DEFAULT '100',
  `thirst` double unsigned NOT NULL DEFAULT '100',
  `alcohol` double unsigned NOT NULL DEFAULT '0',
  `oxygen_remaining` double unsigned NOT NULL DEFAULT '1',
  `bleeding_remaining` double unsigned NOT NULL DEFAULT '0',
  `hitpoints` varchar(255) NOT NULL DEFAULT '[]',
  `direction` double NOT NULL DEFAULT '0',
  `position_x` double NOT NULL DEFAULT '0',
  `position_y` double NOT NULL DEFAULT '0',
  `position_z` double NOT NULL DEFAULT '0',
  `spawned_at` datetime NOT NULL,
  `assigned_items` text NOT NULL,
  `backpack` varchar(64) NOT NULL,
  `backpack_items` text NOT NULL,
  `backpack_magazines` text NOT NULL,
  `backpack_weapons` text NOT NULL,
  `current_weapon` varchar(64) NOT NULL,
  `goggles` varchar(64) NOT NULL,
  `handgun_items` varchar(255) NOT NULL,
  `handgun_weapon` varchar(64) NOT NULL,
  `headgear` varchar(64) NOT NULL,
  `binocular` varchar(64) NOT NULL,
  `loaded_magazines` varchar(255) NOT NULL,
  `primary_weapon` varchar(64) NOT NULL,
  `primary_weapon_items` varchar(255) NOT NULL,
  `secondary_weapon` varchar(64) NOT NULL,
  `secondary_weapon_items` varchar(255) NOT NULL,
  `uniform` varchar(64) NOT NULL,
  `uniform_items` text NOT NULL,
  `uniform_magazines` text NOT NULL,
  `uniform_weapons` text NOT NULL,
  `vest` varchar(64) NOT NULL,
  `vest_items` text NOT NULL,
  `vest_magazines` text NOT NULL,
  `vest_weapons` text NOT NULL,
  `last_updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `player_uid` (`account_uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=53 ;

-- --------------------------------------------------------

--
-- Table structure for table `player_history`
--

CREATE TABLE IF NOT EXISTS `player_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_uid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `died_at` datetime NOT NULL,
  `position_x` double NOT NULL,
  `position_y` double NOT NULL,
  `position_z` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table `territory`
--

CREATE TABLE IF NOT EXISTS `territory` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner_uid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `position_x` double NOT NULL,
  `position_y` double NOT NULL,
  `position_z` double NOT NULL,
  `radius` double NOT NULL,
  `level` int(11) NOT NULL,
  `flag_texture` varchar(255) NOT NULL,
  `flag_stolen` tinyint(1) NOT NULL DEFAULT '0',
  `flag_stolen_by_uid` varchar(32) DEFAULT NULL,
  `flag_stolen_at` datetime DEFAULT NULL,
  `flag_steal_message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_paid_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `build_rights` varchar(640) NOT NULL DEFAULT '0',
  `moderators` varchar(320) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `owner_uid` (`owner_uid`),
  KEY `flag_stolen_by_uid` (`flag_stolen_by_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Triggers `territory`
--
DROP TRIGGER IF EXISTS `trigg_terro`;
DELIMITER //
CREATE TRIGGER `trigg_terro` BEFORE INSERT ON `territory`
 FOR EACH ROW BEGIN
 SET NEW.created_at=NOW();
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(64) NOT NULL,
  `spawned_at` datetime NOT NULL,
  `account_uid` varchar(32) DEFAULT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `fuel` double unsigned NOT NULL DEFAULT '0',
  `damage` double unsigned NOT NULL DEFAULT '0',
  `hitpoints` text NOT NULL,
  `position_x` double NOT NULL DEFAULT '0',
  `position_y` double NOT NULL DEFAULT '0',
  `position_z` double NOT NULL DEFAULT '0',
  `direction_x` double NOT NULL DEFAULT '0',
  `direction_y` double NOT NULL DEFAULT '0',
  `direction_z` double NOT NULL DEFAULT '0',
  `up_x` double NOT NULL DEFAULT '0',
  `up_y` double NOT NULL DEFAULT '0',
  `up_z` double NOT NULL DEFAULT '1',
  `cargo_items` text NOT NULL,
  `cargo_magazines` text NOT NULL,
  `cargo_weapons` text NOT NULL,
  `cargo_container` text NOT NULL,
  `last_updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pin_code` varchar(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`id`),
  KEY `account_uid` (`account_uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Triggers `vehicle`
--
DROP TRIGGER IF EXISTS `trigg_vehicle`;
DELIMITER //
CREATE TRIGGER `trigg_vehicle` BEFORE INSERT ON `vehicle`
 FOR EACH ROW BEGIN
 SET NEW.spawned_at=NOW();
END
//
DELIMITER ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`clan_id`) REFERENCES `clan` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `clan`
--
ALTER TABLE `clan`
  ADD CONSTRAINT `clan_ibfk_1` FOREIGN KEY (`leader_uid`) REFERENCES `account` (`uid`) ON DELETE CASCADE;

--
-- Constraints for table `construction`
--
ALTER TABLE `construction`
  ADD CONSTRAINT `construction_ibfk_1` FOREIGN KEY (`account_uid`) REFERENCES `account` (`uid`) ON DELETE CASCADE,
  ADD CONSTRAINT `construction_ibfk_2` FOREIGN KEY (`territory_id`) REFERENCES `territory` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `container`
--
ALTER TABLE `container`
  ADD CONSTRAINT `container_ibfk_1` FOREIGN KEY (`account_uid`) REFERENCES `account` (`uid`) ON DELETE CASCADE,
  ADD CONSTRAINT `container_ibfk_2` FOREIGN KEY (`territory_id`) REFERENCES `territory` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player`
--
ALTER TABLE `player`
  ADD CONSTRAINT `player_ibfk_1` FOREIGN KEY (`account_uid`) REFERENCES `account` (`uid`) ON DELETE CASCADE;

--
-- Constraints for table `territory`
--
ALTER TABLE `territory`
  ADD CONSTRAINT `territory_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `account` (`uid`) ON DELETE CASCADE,
  ADD CONSTRAINT `territory_ibfk_2` FOREIGN KEY (`flag_stolen_by_uid`) REFERENCES `account` (`uid`) ON DELETE SET NULL;

--
-- Constraints for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`account_uid`) REFERENCES `account` (`uid`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
