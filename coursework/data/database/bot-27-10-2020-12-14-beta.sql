-- Generation time: Tue, 27 Oct 2020 12:14:40 +0000
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




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

