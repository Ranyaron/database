-- Generation time: Tue, 27 Oct 2020 12:34:42 +0000
-- Host: mysql.hostinger.ro
-- DB name: u574849695_19
/*!40030 SET NAMES UTF8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `bot`;
CREATE TABLE `bot` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bot_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bot_gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bot_health` bigint(20) DEFAULT NULL,
  `bot_force` bigint(20) DEFAULT NULL,
  `bot_endurance` bigint(20) DEFAULT NULL,
  `bot_dexterity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bot_name` (`bot_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `bot` VALUES ('1','ut','m','76','3','5','7'),
('2','repudiandae','m','98','0','2','6'),
('3','ipsum','m','65','9','7','4'),
('4','ut','f','51','7','1','1'),
('5','pariatur','f','60','2','8','1'),
('6','cupiditate','m','61','7','3','7'),
('7','consequatur','f','94','1','2','8'),
('8','rerum','m','81','6','8','4'),
('9','nisi','m','56','7','4','2'),
('10','sed','m','50','9','6','5'); 


DROP TABLE IF EXISTS `bot_groups`;
CREATE TABLE `bot_groups` (
  `bot_id` bigint(20) unsigned NOT NULL,
  `bot_groups_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`bot_id`,`bot_groups_id`),
  KEY `bot_groups_id` (`bot_groups_id`),
  CONSTRAINT `bot_groups_ibfk_1` FOREIGN KEY (`bot_id`) REFERENCES `bot` (`id`),
  CONSTRAINT `bot_groups_ibfk_2` FOREIGN KEY (`bot_groups_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `bot_groups` VALUES ('1','3'),
('2','1'),
('3','3'),
('4','4'),
('5','4'); 


DROP TABLE IF EXISTS `death`;
CREATE TABLE `death` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) unsigned NOT NULL,
  `bot_id` bigint(20) unsigned NOT NULL,
  `is_kill` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `bot_id` (`bot_id`),
  CONSTRAINT `death_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `death_ibfk_2` FOREIGN KEY (`bot_id`) REFERENCES `bot` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `death` VALUES ('1','1','2','1'),
('2','1','9','0'),
('3','1','9','1'),
('4','1','1','1'),
('5','1','10','1'),
('6','1','1','0'),
('7','1','4','1'),
('8','1','8','0'),
('9','1','6','0'),
('10','1','8','1'); 


DROP TABLE IF EXISTS `enemy`;
CREATE TABLE `enemy` (
  `initiator_id` bigint(20) unsigned NOT NULL,
  `target_id` bigint(20) unsigned NOT NULL,
  `status` enum('passive','aggressive','irrepressible') COLLATE utf8_unicode_ci DEFAULT 'passive',
  `requested_at` datetime DEFAULT current_timestamp(),
  `confirmed_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_id`,`target_id`),
  KEY `target_id` (`target_id`),
  CONSTRAINT `enemy_ibfk_1` FOREIGN KEY (`initiator_id`) REFERENCES `bot` (`id`),
  CONSTRAINT `enemy_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `enemy` VALUES ('1','1','passive','1999-08-25 21:31:31','1978-03-08 14:36:58'); 


DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `initiator_id` bigint(20) unsigned NOT NULL,
  `target_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','unfriended','declined') COLLATE utf8_unicode_ci DEFAULT 'requested',
  `requested_at` datetime DEFAULT current_timestamp(),
  `confirmed_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_id`,`target_id`),
  KEY `target_id` (`target_id`),
  CONSTRAINT `friend_ibfk_1` FOREIGN KEY (`initiator_id`) REFERENCES `person` (`id`),
  CONSTRAINT `friend_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `bot` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `friend` VALUES ('1','2','unfriended','2007-05-30 10:47:09','1970-12-29 22:15:18'),
('1','3','declined','2001-07-01 19:09:05','2017-09-30 23:18:48'),
('1','4','declined','1999-11-04 16:16:44','2013-04-07 22:31:27'),
('1','5','requested','1981-04-16 02:01:54','2010-02-07 11:08:41'),
('1','6','declined','1986-12-05 21:28:47','2018-03-12 23:01:09'); 


DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `groups_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `groups` VALUES ('2','doloribus'),
('3','in'),
('1','molestiae'),
('5','natus'),
('4','nemo'); 


DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `person_gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `person_health` bigint(20) DEFAULT NULL,
  `person_force` bigint(20) DEFAULT NULL,
  `person_endurance` bigint(20) DEFAULT NULL,
  `person_dexterity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_name` (`person_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `person` VALUES ('1','cupiditate','f','81','4','8','2'); 


DROP TABLE IF EXISTS `person_groups`;
CREATE TABLE `person_groups` (
  `person_id` bigint(20) unsigned NOT NULL,
  `person_groups_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`person_id`,`person_groups_id`),
  KEY `person_groups_id` (`person_groups_id`),
  CONSTRAINT `person_groups_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `person_groups_ibfk_2` FOREIGN KEY (`person_groups_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `person_groups` VALUES ('1','1'),
('1','2'),
('1','4'); 


DROP TABLE IF EXISTS `skill`;
CREATE TABLE `skill` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `skill_level` bigint(20) DEFAULT 1,
  `experience` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `skill` VALUES ('1','8','96'); 


DROP TABLE IF EXISTS `weapon`;
CREATE TABLE `weapon` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ammunition` bigint(20) DEFAULT NULL,
  `damage` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `weapon` VALUES ('1','adipisci','34','7'),
('2','ratione','84','1'),
('3','numquam','7','1'),
('4','et','23','6'),
('5','non','40','3'),
('6','voluptas','61','9'),
('7','quia','60','4'),
('8','natus','76','6'),
('9','sit','15','4'),
('10','ut','73','1'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

