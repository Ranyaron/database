-- Generation time: Tue, 27 Oct 2020 12:27:46 +0000
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




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

