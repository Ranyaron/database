drop database if exists snet1509;
create database snet1509;
-- с указанием кодировки
-- create database snet1509 character set utf8mb4;
use snet1509;

drop table if exists users;
create table users(
	id serial primary key, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	name varchar(50),
	surname varchar(50),
	email varchar(120) unique,
	phone bigint,
	gender char(1),
	birthday date,
	hometown varchar(50),
	photo_id bigint unsigned,
	pass char(50),
	created_at datetime default current_timestamp,
	-- soft delete ('мягкое' удаление)
	-- is_deleted bool
	-- deleted_at datetime
	index(phone),
	index(email),
	index(name, surname)
);

drop table if exists messages;
create table messages(
	id serial primary key,
	from_user_id bigint unsigned not null,
	to_user_id bigint unsigned not null,
	body text,
	is_read bool default 0,
	created_at datetime default current_timestamp,
	foreign key (from_user_id) references users (id),
	foreign key (to_user_id) references users (id)
);

drop table if exists friend_requests;
create table friend_requests(
	-- id serial primary key,
	initiator_user_id bigint unsigned not null,
	target_user_id bigint unsigned not null,
	status enum('requested', 'approved', 'unfriended', 'declined') default 'requested',
	requested_at datetime default now(),
	confirmed_at datetime default current_timestamp on update current_timestamp,
	primary key(initiator_user_id, target_user_id),
	foreign key (initiator_user_id) references users (id),
	foreign key (target_user_id) references users (id)
);

alter table friend_requests add index(initiator_user_id);

drop table if exists communities;
create table communities(
	id serial primary key,
	name varchar(150),
	index communities_name_idx (name)
);


drop table if exists users_communities;
create table users_communities(
	user_id bigint unsigned not null,
	community_id bigint unsigned not null,
	is_admin bool default 0,
	primary key(user_id, community_id),
	foreign key (user_id) references users (id),
	foreign key (community_id) references communities (id)
);

drop table if exists posts;
create table posts(
	id serial primary key,
	user_id bigint unsigned not null,
	body text,
	metadata json,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	foreign key (user_id) references users (id)
);

drop table if exists comments;
create table comments (
	id serial primary key,
	user_id bigint unsigned not null,
	post_id bigint unsigned not null,
	body text,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	foreign key (user_id) references users (id),
	foreign key (post_id) references posts (id)
);

drop table if exists photos;
create table photos (
	id serial primary key,
	user_id bigint unsigned not null,
	description text,
	filename varchar(250),
	foreign key (user_id) references users (id)
);



drop table if exists likes;
create table likes (
	id serial primary key,
	from_user_id bigint unsigned not null,
	to_user_id bigint unsigned,
	post_id bigint unsigned,
	photo_id bigint unsigned,
	is_like bool default 0,
	foreign key (from_user_id) references users (id),
	foreign key (to_user_id) references users (id),
	foreign key (post_id) references posts (id),
	foreign key (photo_id) references photos (id)
);

-- Generation time: Fri, 25 Sep 2020 07:54:50 +0000
-- Host: mysql.hostinger.ro
-- DB name: u574849695_25
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

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `comments` VALUES ('1','87','1','Quam consequatur error sunt tempore fuga sequi. Adipisci facilis laudantium aut occaecati velit velit quisquam. Recusandae nam eum et.','2002-02-28 16:41:32','1982-07-24 02:33:03'),
('2','99','2','Earum qui nihil ducimus voluptate facere sit quia. Sit non eligendi temporibus omnis. Quibusdam porro quos omnis in laudantium ut tempora. Commodi inventore sit veniam doloribus ab veniam enim laudantium.','1979-10-09 14:12:10','1998-05-05 00:41:51'),
('3','52','3','Non odio natus quis rerum vel ab officiis. Quod voluptates facilis recusandae adipisci aut. Rerum maxime qui aut et rerum. Accusantium et animi dignissimos optio ad exercitationem quia.','1982-06-30 19:17:42','2005-12-16 05:39:10'),
('4','35','4','Officiis voluptas doloremque eos quo. Quo repellat sint eos cumque nihil illo deleniti eos. Consequatur ex quis in totam repudiandae autem ratione.','1982-10-06 06:46:22','2017-10-20 14:33:31'),
('5','86','5','Consequatur in vitae impedit voluptas expedita. Error sunt ut alias accusamus nulla. Et repudiandae mollitia quia beatae natus voluptas eaque rerum.','1975-10-23 02:44:48','1973-06-14 00:09:33'),
('6','53','6','Repellat vitae perferendis iusto accusamus illo natus dolor reprehenderit. Eligendi et consectetur cum ut. Placeat quia nisi animi sed libero. Repellat beatae est corrupti eos at in perferendis.','1992-12-08 08:06:30','1989-07-13 13:05:18'),
('7','67','7','Corrupti animi et sint quo dolores rerum. Quod quaerat porro odit modi recusandae excepturi libero culpa.','1992-05-30 13:24:44','2010-05-15 01:25:08'),
('8','52','8','Et voluptas optio saepe qui voluptatem est. Vero aut omnis voluptate nam eaque ab aliquam.','1974-08-05 20:56:22','2006-10-23 05:45:39'),
('9','37','9','Odio est facere nihil ipsa inventore tempora assumenda. Molestiae excepturi ipsam quia quae temporibus. Et possimus omnis alias quia ratione dolores. Optio tenetur mollitia consequuntur neque molestiae deserunt.','2019-05-16 08:44:14','2008-08-03 15:09:44'),
('10','59','10','Est tenetur doloribus delectus aut quibusdam. Omnis qui est et quis non esse et nemo.','1991-01-18 05:12:09','1977-12-15 11:16:10'),
('11','56','11','Sapiente animi et numquam hic eius. Non quibusdam est rem at. Nam deleniti saepe animi a modi. Iste ullam iure ratione dolorem tempore nisi voluptatem.','2014-07-23 19:13:39','1993-01-10 02:52:08'),
('12','2','12','Commodi ut modi doloribus officiis. Architecto facere expedita in. Eum libero sequi vero eaque qui sint. Aliquid et et sunt recusandae. Qui inventore aut aspernatur vel eveniet.','2002-09-27 15:19:36','2009-08-03 06:35:52'),
('13','62','13','Expedita ut ea quos similique velit. Sequi deleniti reprehenderit quo architecto voluptates ea non. Est est vel quo iure ullam commodi dolorem. Qui dolorem aut facere dicta deserunt. Recusandae eum vel labore dolores eaque quae.','1984-12-10 11:54:29','2006-07-29 13:25:48'),
('14','67','14','Architecto nesciunt fugiat qui. Ut qui doloribus ut.','1982-09-21 16:33:58','2020-09-21 06:40:45'),
('15','36','15','Modi voluptatem neque nisi vel. Voluptas quae est eveniet et repellendus eum.','1980-04-29 04:02:58','1998-10-13 08:31:00'),
('16','90','16','Sed occaecati quia odit qui expedita enim. Quod ullam vel ut sit distinctio fugiat quis. Cupiditate aut porro voluptatem aut.','1996-05-25 10:14:32','1970-07-29 18:31:24'),
('17','71','17','Magni porro ad modi totam consequuntur libero sit. Excepturi nulla et nam unde facilis quia tempora. Iusto vel dolorem corrupti et deleniti labore eaque.','1987-12-23 11:13:20','2019-08-07 02:17:27'),
('18','86','18','Possimus voluptate delectus voluptas dolor consectetur illum. Dolores tenetur illum quam commodi et dignissimos. Saepe dolores voluptate ipsam non nulla. Sit deleniti maxime a magnam earum dolor expedita.','1977-05-02 08:22:57','2015-09-22 01:35:43'),
('19','67','19','Sapiente veritatis quam repellat dolorum. Et corporis molestias dicta accusamus molestiae tempora. Numquam aut sit consequuntur sunt.','1997-02-05 03:21:15','1989-09-12 21:56:31'),
('20','23','20','Minima non enim et voluptas libero error neque quam. Velit et placeat natus ipsam officia et adipisci sed. Non quas ea aut quo distinctio animi. Eos autem ut perferendis et reiciendis.','2015-06-27 09:02:35','2013-10-28 20:27:55'),
('21','62','21','Quis harum dolorem fugit voluptatem iusto. Accusamus maiores sint consequuntur in dolorem. Ullam voluptas non voluptatum nisi harum. Est est ducimus qui adipisci velit quia.','2017-03-13 22:34:00','2015-06-09 05:47:07'),
('22','49','22','Placeat sint perferendis quibusdam voluptatem perferendis. Et eos voluptate veniam atque culpa odio et. Ducimus voluptate veritatis qui nisi quia ut sapiente.','2011-06-07 20:35:02','1971-01-18 00:59:30'),
('23','58','23','Placeat aspernatur non expedita voluptas velit sint. Non sed doloribus sunt repellat exercitationem. Eum sint delectus iusto voluptas et eum est aliquid. Fuga ut harum ea non vitae quae magnam accusamus.','2003-10-24 17:06:26','1988-05-26 09:39:53'),
('24','9','24','Harum vel placeat eius sit qui necessitatibus repellat. At expedita cupiditate suscipit enim at iste omnis. Dolore quia sint consectetur et.','2002-01-19 16:17:35','2013-03-26 16:16:28'),
('25','28','25','Labore laboriosam ut beatae aut officiis. Nemo id impedit omnis voluptates accusamus rem numquam. Dicta illo enim consequatur. Iusto doloribus error explicabo exercitationem libero sunt. Repudiandae est accusamus voluptatem repudiandae voluptas amet et dolor.','2007-01-28 23:44:36','1996-02-09 05:43:17'),
('26','88','26','Odio hic modi expedita omnis vitae suscipit mollitia odio. Modi eveniet et debitis quia eaque consequatur voluptatem. Laboriosam ducimus quasi et velit porro quia.','1971-11-16 09:03:39','1998-07-02 18:18:48'),
('27','74','27','Animi vero nisi perspiciatis nesciunt esse dolorem aut. Eaque in veniam beatae aut voluptatem culpa. Perferendis vel exercitationem reprehenderit corrupti est doloremque. Vero recusandae sit rerum quos quibusdam ut.','1976-03-28 04:22:53','2016-09-05 12:53:08'),
('28','82','28','Amet voluptas quo est autem assumenda. Praesentium delectus itaque sint debitis id qui quae. Est nobis accusantium exercitationem molestias quam optio fuga. Culpa eaque dolore cum inventore.','2020-07-05 07:12:45','2005-03-06 13:25:13'),
('29','49','29','Nihil dolor deleniti temporibus incidunt. Nisi est reiciendis possimus corrupti et est. Unde accusamus quis tempore quasi iusto saepe optio voluptatem. Libero quas et voluptas blanditiis dolor libero.','1996-10-11 11:21:56','2015-10-24 09:01:19'),
('30','12','30','Optio temporibus porro in minus eum facilis. Ad aut veniam eligendi rerum earum fugit. Incidunt aut consectetur ea odio aut. Dolor doloribus ullam dicta aut nihil est autem ut.','1990-11-21 21:52:32','2007-08-19 17:26:51'),
('31','12','31','Unde illum facere doloribus sunt est aliquid. Ipsa amet quis adipisci cumque. Placeat similique qui rem quas. Quis labore numquam esse enim suscipit cumque.','1989-03-23 22:34:18','1993-03-03 02:24:43'),
('32','36','32','Omnis consequatur nostrum quod repellendus. Et eos sint earum explicabo earum et officia animi. Et laudantium dolore numquam.','2014-05-27 22:47:54','1975-01-11 23:03:25'),
('33','11','33','Nam cum sit maiores dolorem dignissimos. Omnis nihil doloremque doloremque consequatur velit architecto. Molestiae facere non et ad rem est magnam.','2003-11-20 03:43:21','2016-10-11 02:31:43'),
('34','63','34','Ullam eius nostrum optio. Molestias distinctio consequuntur voluptatem atque. Unde enim quia hic fugit iste. Ab aliquam enim et excepturi laborum similique.','2003-06-08 11:40:57','2006-08-01 08:23:02'),
('35','70','35','Consequatur illum fuga libero quis incidunt voluptatem. Aliquam est ad cupiditate dicta molestiae hic reprehenderit.','1981-11-02 14:53:04','1971-05-25 02:52:31'),
('36','96','36','Ea non ut quia incidunt vel. Dolor qui sed sed error ut. Commodi quis quidem nostrum neque.','1984-02-27 11:30:07','1981-01-04 13:03:13'),
('37','16','37','In doloremque neque blanditiis. Distinctio est consequuntur nesciunt enim. Amet quo laborum sunt non nihil omnis nulla facere. Et facere necessitatibus eos beatae officia voluptas eaque.','1975-12-29 17:37:02','2009-04-12 05:36:38'),
('38','37','38','Praesentium numquam quia nostrum expedita cupiditate suscipit. Perspiciatis labore similique magni autem officia veritatis. Aut dolorem iure deleniti voluptates.','1973-04-19 13:25:09','1993-09-28 07:39:14'),
('39','48','39','Ipsum rem sapiente voluptatem eligendi eum sunt. Deleniti odit molestiae ab sed deleniti et et excepturi. Qui voluptas rerum ut magnam iusto. In ut consequuntur qui eos quae quo. Delectus eos a culpa omnis.','1981-10-07 23:27:28','2008-01-18 16:09:32'),
('40','52','40','Laborum est distinctio adipisci facilis. Incidunt dolorem labore voluptatem et et repellat. Eligendi vero explicabo sapiente rerum. Sed in praesentium esse excepturi quam.','1976-06-15 04:40:12','1984-12-10 06:41:20'),
('41','95','41','Ea vel occaecati commodi et qui voluptate voluptate. Libero reprehenderit suscipit blanditiis dolorum. In sed ut numquam natus vel. Sunt vero pariatur odit magni doloribus officiis sequi.','2008-04-28 06:55:13','1991-12-05 16:36:18'),
('42','3','42','Eaque qui quibusdam qui sed culpa laudantium est. Debitis quis deleniti eveniet voluptas. Eos officiis odit repudiandae rerum voluptas repellendus amet.','1999-06-11 05:42:17','2003-08-13 09:04:24'),
('43','53','43','Quia pariatur ullam rem cum quae distinctio necessitatibus asperiores. Est est non optio. Necessitatibus eligendi omnis omnis velit omnis veritatis. Fugit quaerat nihil aut. Non consectetur incidunt voluptatem at odit omnis similique.','2002-07-22 12:43:16','1982-07-18 14:51:42'),
('44','56','44','Rerum dolor voluptatem nemo ea. Mollitia iusto aut fuga adipisci veritatis. Commodi facere atque optio est fuga.','2015-11-09 06:06:39','1994-09-29 16:51:56'),
('45','69','45','Omnis quia neque similique rerum. Doloribus et maxime libero fuga est aperiam quam. Possimus iste rerum aut libero vitae laboriosam ex.','1994-11-25 00:06:14','2004-02-06 02:48:15'),
('46','89','46','Ut ad est consequatur animi nisi. Culpa dolor illum qui. Ad sunt magni itaque autem ex. Mollitia sunt dolorem corrupti vel. Deserunt dolor quis mollitia error aut consectetur rerum.','1982-08-03 10:52:54','2009-06-10 02:38:54'),
('47','46','47','Est pariatur quasi tempora commodi. Est et et voluptas iure quod laudantium. Facere iure fugit quia minus qui. Fuga et blanditiis voluptatem fuga suscipit impedit.','1997-06-28 21:42:23','2020-08-25 18:39:06'),
('48','40','48','Quam recusandae rerum enim debitis est dolorem omnis voluptatem. Expedita id aut architecto est ut quia corrupti. Beatae voluptate qui voluptates qui non explicabo saepe non. Placeat atque assumenda praesentium molestiae asperiores.','1991-08-10 17:11:12','1978-07-03 19:58:46'),
('49','74','49','Eius dicta ut assumenda voluptatibus. Dolorum alias voluptatem natus atque saepe. Necessitatibus deserunt tenetur odio accusamus hic sed voluptatem excepturi. Saepe consequatur labore consequatur sequi occaecati eum tenetur et.','1979-06-28 16:55:32','2002-04-25 00:27:30'),
('50','13','50','Est numquam ipsa dolor. Et eos quos odit ut dolorem. Veritatis et excepturi nobis tenetur itaque. Facere et laudantium ex explicabo ut. Quos quas tenetur debitis fuga quis.','1980-06-06 16:50:33','1978-01-15 18:13:13'),
('51','62','51','Sed autem at mollitia natus autem molestiae qui repellat. In neque sunt labore voluptatem harum. Et libero repellendus dignissimos non ut.','1980-05-29 00:43:33','1991-02-28 01:37:55'),
('52','35','52','Eaque aut occaecati tenetur deserunt vitae eligendi dolore. Tempore rerum illum nisi voluptas quis quia. Quo qui corporis hic qui nihil exercitationem. Fugiat explicabo eius animi maxime quisquam aperiam qui.','1988-09-26 12:45:43','1982-05-28 10:15:17'),
('53','62','53','Omnis minima commodi quasi laborum qui aspernatur omnis. Aliquam hic dolor facilis magnam voluptatum animi. Dolore minus molestias et est. Rerum nesciunt molestiae pariatur earum veniam voluptatem optio.','2005-12-16 19:36:32','1979-04-28 03:33:02'),
('54','20','54','Voluptatibus aut itaque omnis. Ut porro beatae dolorum eaque aut.','2006-12-20 03:22:42','1972-03-14 15:07:05'),
('55','43','55','Explicabo quod ipsa explicabo quia. Veniam vitae necessitatibus natus quo quis. Expedita consequatur recusandae non nihil. Asperiores hic reprehenderit maiores illum laboriosam.','2003-07-01 02:23:12','1995-05-11 02:01:09'),
('56','89','56','Et expedita nihil inventore est at. Saepe hic voluptates possimus error nulla. Ut consectetur voluptates voluptates magni harum. Sed molestiae asperiores ducimus aut.','1987-06-29 17:19:40','1972-08-27 21:31:36'),
('57','7','57','Provident dolore nesciunt incidunt sit nulla. Rem placeat qui nobis quae est sint rem. Quo modi consequatur distinctio voluptatum voluptatibus est et voluptas.','1994-07-30 17:22:50','1979-09-23 19:45:50'),
('58','17','58','Quam autem quasi culpa qui quia nostrum deserunt numquam. Sunt debitis earum et natus laboriosam. Fugit earum at quis eius ullam ducimus tempore magni.','1978-02-22 19:15:00','2008-03-14 13:23:08'),
('59','70','59','Ullam eum dolorem sit velit ab illo itaque. Ratione necessitatibus et odit nesciunt amet est quo laborum.','2008-08-08 19:29:53','2009-08-09 11:30:58'),
('60','55','60','Ab sit magnam eveniet omnis voluptatum. Omnis et aliquam sed ipsum. Ipsum excepturi dicta explicabo reiciendis est enim. Et est qui accusamus sed explicabo voluptatem.','2013-10-05 16:34:33','2014-05-25 20:15:05'),
('61','28','61','Animi eos deserunt et quia. Ullam excepturi ut aperiam nisi. Consequatur nemo laboriosam consequatur nesciunt.','2013-10-29 02:28:30','2018-07-19 18:06:42'),
('62','81','62','Voluptatem quo sint expedita quos laudantium inventore qui velit. Et labore autem adipisci et. Nisi totam doloribus sint rerum voluptas explicabo et.','1997-10-31 10:44:37','1976-07-06 13:10:40'),
('63','91','63','Facilis itaque magni quidem vel quibusdam ad. Reprehenderit asperiores aut itaque dolor eligendi nihil vel voluptatem. Laboriosam aspernatur necessitatibus officia numquam ab. Maxime quo est aut ea quibusdam accusamus corporis.','1992-06-03 04:23:30','2004-06-28 10:35:21'),
('64','38','64','Magnam cum non consequuntur dolor et esse ut deleniti. Ut voluptas rerum omnis accusantium. Iste inventore sit libero similique.','1993-01-28 05:32:42','1987-05-03 01:26:07'),
('65','43','65','Repellat veritatis et dicta maxime dolorem et vel. Consectetur esse voluptatibus vel est. Aut maxime ab magni cum omnis sed ad. Corporis maiores a harum dolor et ea.','1993-04-25 19:44:09','1998-11-29 18:22:39'),
('66','60','66','Inventore et incidunt assumenda qui et consequatur. Ipsam voluptatem soluta molestiae provident. Aspernatur accusantium quas laborum optio voluptas. Esse cum eos et quae.','2013-06-26 11:05:10','2016-02-09 03:28:05'),
('67','34','67','Ex molestias nihil veritatis rerum voluptates enim aut. Consequuntur iusto doloremque incidunt sint fugit. Soluta soluta aut repellat veritatis veritatis. Et rem et et nam voluptates placeat.','2007-09-07 19:04:50','1973-03-25 16:14:49'),
('68','59','68','Exercitationem et eos aut facere quasi. Ab expedita et fuga consequatur corrupti possimus. Dolor culpa harum ea. Aut quia magni magni nesciunt iusto corrupti.','1986-11-05 06:17:24','1986-02-05 09:40:22'),
('69','97','69','Nostrum consequuntur voluptas deleniti ex. Quo ut omnis similique iusto. Enim est aut perferendis laboriosam.','1989-02-18 18:28:24','1981-02-17 11:40:25'),
('70','81','70','Nihil non quo qui mollitia sunt. Exercitationem quisquam assumenda porro numquam eos.','2008-08-06 21:33:55','2013-10-24 01:57:28'),
('71','10','71','Id accusantium occaecati laudantium praesentium. Distinctio voluptas deleniti et ut impedit minima sapiente. Dolorem ut commodi incidunt dolor. Et quam quisquam consequatur culpa mollitia et.','1975-08-04 14:03:22','1985-04-11 20:38:39'),
('72','92','72','Totam sunt voluptate natus sequi mollitia facilis. Animi voluptatem aliquam hic autem. Nisi et similique consequatur nesciunt. Architecto hic assumenda inventore eaque.','1997-11-29 16:31:54','1975-10-15 22:47:05'),
('73','84','73','Accusamus et eum vel minus. Provident et tempore in possimus odit quaerat quaerat. Quo dolores dicta eaque vel omnis. Tempora voluptatem sed quibusdam perspiciatis nobis. Dolorum beatae possimus unde.','2018-01-04 14:31:36','2009-09-19 10:59:25'),
('74','63','74','Ipsa ut rerum ut quos deleniti porro quis reiciendis. Tempore enim et nobis natus. Optio voluptatibus ipsam dignissimos.','1987-11-26 07:55:19','1970-04-20 08:43:41'),
('75','48','75','Ipsam fugiat facere impedit nesciunt temporibus est aut debitis. Sed magnam et illo quo in libero aperiam.','1972-07-05 23:36:53','1993-08-01 07:39:53'),
('76','53','76','Sed rerum inventore sed et beatae. Repudiandae assumenda consequatur consectetur reiciendis et quae. Nobis corrupti eos aliquam velit consequatur et quidem. Occaecati ut dicta et qui veniam qui. Tempore dolor est nihil totam.','1992-09-19 08:58:49','1999-03-16 10:35:19'),
('77','51','77','Sequi quos unde ab incidunt iste ab. Blanditiis fuga nemo aut deleniti quo. Cumque voluptatem libero incidunt qui. Tempore eum aut animi earum.','1971-01-19 11:50:35','1989-04-01 12:55:47'),
('78','93','78','Recusandae quasi accusantium nihil provident ut. Rerum labore non et sit enim aut quia. Minus incidunt repellendus sint sit rerum.','2002-03-02 10:26:49','2017-08-23 03:18:14'),
('79','92','79','Voluptate aut est eum quis nostrum quisquam mollitia. Alias animi molestiae et velit consequatur vel sint. Est placeat id deleniti et.','2018-08-16 12:59:22','1973-04-14 07:09:12'),
('80','24','80','Aliquid sint officiis molestiae quo nesciunt blanditiis corrupti. Quos iure et molestiae delectus enim omnis atque. Aut natus soluta ut enim fugit repellat dolor excepturi. Pariatur deleniti tempore fugiat excepturi enim.','1996-06-26 07:02:24','1988-07-05 01:40:33'),
('81','5','81','Iste exercitationem distinctio veritatis sed. Ipsa id voluptatibus accusantium dolores enim enim sit. Voluptates dolorem consectetur deserunt eum ullam ullam velit.','2018-06-24 19:07:19','1974-11-03 06:47:08'),
('82','53','82','A iure alias at voluptatem. Magni vitae vel nulla laborum vel quis. Nobis quia consectetur omnis delectus. Impedit dolorem dolores non sit veniam unde sint. Vitae explicabo eveniet fugiat architecto optio qui.','1972-01-16 14:57:06','1973-12-01 06:07:20'),
('83','58','83','Veniam sequi sapiente illo omnis id officiis. Ea ducimus quidem voluptatem tempore eos ut adipisci. Nemo ut totam aut error. Aut qui perferendis quo quisquam. Dicta consequuntur ab sed sequi.','1998-04-12 01:42:54','1971-10-20 20:39:37'),
('84','66','84','Quasi molestiae ut natus possimus modi. Blanditiis occaecati similique expedita odit cupiditate neque omnis. Nisi maxime voluptatem illum odio. Accusantium deleniti distinctio eos ut.','2018-03-12 16:01:17','1985-01-03 19:40:30'),
('85','72','85','Perspiciatis et eaque nihil corporis. Beatae laborum veritatis sit iusto modi nostrum voluptatum iusto. Quis cum recusandae eos consequatur. Atque occaecati exercitationem recusandae rerum.','2002-05-16 09:11:58','2011-10-29 10:38:34'),
('86','1','86','Voluptas molestias nam culpa et temporibus est error rerum. Quae accusamus quis facilis et quos voluptas est. Qui corrupti nesciunt sunt temporibus sit iste. Voluptatum ab veritatis et aliquam facilis ut.','1989-06-12 21:02:02','1973-01-20 07:58:04'),
('87','55','87','Et repellendus deleniti suscipit ut. Cumque eligendi quod beatae occaecati quis laboriosam provident. Deleniti perspiciatis magnam voluptatem possimus vel doloremque saepe. Velit aliquam qui voluptas.','1992-03-22 09:37:17','2015-08-13 14:58:59'),
('88','79','88','Accusamus et non aut dolorem voluptatibus aut. Vel laborum molestiae neque deserunt. Quam veniam magnam ut distinctio maxime itaque. Consectetur ut atque dicta.','2020-08-25 15:37:08','2005-11-04 06:16:31'),
('89','17','89','Et reprehenderit doloremque repellendus soluta neque. In porro quia temporibus nostrum facilis autem. Expedita modi dicta quis optio omnis.','1981-03-30 20:33:12','1978-08-16 08:35:13'),
('90','24','90','Maiores ducimus mollitia eum et. Dolorem ipsa quia voluptatem provident sequi facere ut voluptas. Sunt illo praesentium omnis reiciendis error distinctio illo molestiae.','1970-10-27 13:23:47','1987-06-27 22:13:43'),
('91','34','91','Ad minus officia facere corrupti. Tempore est tempore quo ex rem commodi quia. Cupiditate alias nostrum blanditiis ut quibusdam tempora sunt. Dolores aut sit minus voluptatem odit harum.','2006-01-03 22:08:34','1995-03-29 19:06:41'),
('92','45','92','A cupiditate autem deleniti est voluptatem minima. Ex cum eos repellat harum sint ex. Quia consequatur autem laudantium ut deserunt fugiat.','1990-04-30 11:38:31','1983-12-05 03:14:36'),
('93','4','93','Earum dolor quos quisquam alias voluptatibus quos voluptates. Dolorem consequatur earum dolores reiciendis id cum ut.','1982-08-18 21:29:43','1993-09-26 07:25:21'),
('94','24','94','Ea cupiditate placeat optio voluptatum autem tempora. Aut ipsum mollitia nostrum consequatur. Nulla reiciendis occaecati est et pariatur. Excepturi labore soluta corrupti fuga repellendus.','2011-08-24 06:17:28','2012-05-30 21:07:52'),
('95','83','95','Architecto ipsa facere commodi voluptas sed. Tempora ad voluptates consequatur et nihil earum. Ab nulla dolores excepturi nulla voluptatem nobis sint. Delectus ipsam voluptatem veritatis in quis ut.','2001-04-04 08:20:33','1981-08-13 16:42:34'),
('96','47','96','Officia reiciendis sit nesciunt iure. Esse neque molestiae aut sit veritatis quia quisquam nobis. Itaque rem quod nobis et nemo occaecati quisquam omnis.','1989-02-10 13:15:23','2007-08-20 17:35:13'),
('97','83','97','Voluptatem voluptatem repellat accusantium quaerat dolor optio ex. Quas error ex sunt enim facere molestiae. Sint possimus omnis ut impedit laborum eum velit. Autem reiciendis praesentium itaque eius unde veniam dolorem.','2010-11-05 04:47:38','2013-06-29 12:53:49'),
('98','16','98','Quisquam fugiat tempore omnis quas distinctio. Et libero error eos id. Expedita eaque doloremque alias minus.','2003-04-26 23:23:51','1985-11-20 01:45:55'),
('99','5','99','Et necessitatibus qui repellendus. Quas omnis atque quasi inventore dolores qui. Velit quod temporibus ea consequatur sed. Minus sit sunt vitae eos aut corporis fugit.','1997-03-14 02:45:48','1990-04-05 23:05:53'),
('100','80','100','Quae ex architecto amet minus animi dolore. Aut eaque dolor et aperiam neque. Voluptatem sequi corrupti voluptates fuga natus commodi aliquam voluptas. Aut in illum cupiditate eos perspiciatis magni voluptatem. Molestiae architecto nemo hic similique cupiditate nihil magnam iste.','2005-05-18 00:54:43','1982-01-12 15:18:01'); 


DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `communities_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `communities` VALUES ('2','esse'),
('3','est'),
('4','est'),
('6','exercitationem'),
('1','hic'),
('8','necessitatibus'),
('10','occaecati'),
('7','quo'),
('5','reprehenderit'),
('9','velit'); 


DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','unfriended','declined') COLLATE utf8_unicode_ci DEFAULT 'requested',
  `requested_at` datetime DEFAULT current_timestamp(),
  `confirmed_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  KEY `initiator_user_id` (`initiator_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `friend_requests` VALUES ('1','49','unfriended','1995-03-17 16:35:32','2002-08-31 16:25:02'),
('1','86','approved','2014-01-01 20:32:42','1987-10-02 08:01:11'),
('9','22','requested','1974-12-06 09:58:00','2017-05-01 21:35:07'),
('12','66','unfriended','1982-01-02 18:41:57','1993-05-24 02:50:06'),
('12','86','unfriended','1978-12-04 12:23:45','2007-10-19 18:38:30'),
('13','16','declined','1970-10-07 18:16:19','2008-04-29 14:34:44'),
('13','86','unfriended','1992-02-09 01:48:43','1973-07-21 01:21:52'),
('13','95','unfriended','2003-04-11 09:21:01','1983-02-12 13:28:58'),
('14','69','approved','2017-05-22 20:04:59','1976-07-08 12:55:09'),
('16','34','declined','1994-11-27 10:23:33','1996-06-06 12:28:39'),
('16','50','declined','2000-12-22 11:15:15','1989-08-07 20:09:11'),
('17','97','approved','2019-04-02 01:56:12','1999-07-19 04:03:50'),
('18','74','approved','2012-10-24 06:19:45','1975-12-20 01:21:32'),
('18','90','declined','1987-01-07 11:47:01','1993-05-01 19:55:35'),
('19','49','requested','1972-04-30 04:18:57','1973-06-06 19:32:43'),
('21','69','unfriended','1984-02-22 17:14:49','1971-11-05 01:46:53'),
('22','76','approved','1998-08-10 17:18:00','1995-04-07 18:51:09'),
('24','90','declined','1976-10-09 07:36:10','2003-07-09 00:56:17'),
('26','7','declined','2009-01-20 09:45:34','1985-02-26 11:17:10'),
('26','13','declined','1977-05-04 12:56:54','1971-09-21 07:45:32'),
('28','31','approved','2010-01-29 01:48:55','2010-09-27 09:42:30'),
('28','87','approved','1987-10-27 11:07:36','1984-09-10 13:24:20'),
('29','38','unfriended','2006-10-11 00:00:27','2019-07-09 05:56:50'),
('30','2','unfriended','1979-01-15 16:09:28','1972-08-18 04:44:43'),
('30','36','approved','2010-12-13 13:26:42','1976-04-06 20:54:27'),
('31','3','approved','2009-08-16 10:48:57','1980-08-16 11:24:26'),
('32','40','requested','2011-04-01 05:56:20','1974-06-20 20:25:57'),
('32','58','declined','1981-01-24 21:13:49','1984-12-09 05:37:34'),
('33','7','approved','1997-02-10 12:00:13','1975-01-26 12:52:00'),
('33','27','unfriended','1999-05-04 19:14:46','2005-01-10 21:37:25'),
('33','86','requested','1996-03-09 03:19:24','2015-08-02 03:51:51'),
('35','86','approved','2019-05-30 01:21:29','2003-11-13 20:28:23'),
('36','31','declined','1975-04-02 20:48:34','1993-01-03 07:03:32'),
('37','35','requested','2011-10-15 20:55:08','2001-06-23 09:14:52'),
('37','49','declined','1998-05-06 07:12:10','1977-01-27 20:37:04'),
('39','61','requested','2006-03-27 13:24:44','1976-06-30 08:48:03'),
('39','77','requested','2001-09-28 15:13:52','1973-04-07 03:46:54'),
('40','95','approved','2002-03-03 06:29:47','1981-02-20 23:05:41'),
('41','52','unfriended','1987-10-02 02:22:02','1970-01-05 12:50:42'),
('41','90','requested','2006-01-11 12:41:13','1995-01-23 02:23:52'),
('42','93','declined','1985-12-27 05:59:13','1983-03-22 23:21:58'),
('43','57','approved','2018-01-19 04:05:38','2002-06-16 20:34:44'),
('44','83','approved','1971-09-13 13:17:22','2010-10-31 05:12:09'),
('46','97','approved','1999-04-02 17:58:59','2010-06-03 20:06:55'),
('47','27','approved','2010-02-03 22:32:22','1990-03-26 11:04:26'),
('49','37','declined','2010-02-02 16:43:48','2011-01-08 04:24:50'),
('49','66','unfriended','2003-06-11 04:28:18','2012-08-10 12:39:51'),
('49','86','requested','1983-01-27 05:15:04','2018-03-07 14:29:30'),
('51','5','unfriended','2006-01-04 19:41:40','2014-01-15 15:18:44'),
('51','7','declined','2007-06-15 15:19:17','2009-08-21 21:19:27'),
('51','63','approved','2008-12-02 00:19:26','1979-03-19 10:17:39'),
('54','65','approved','2012-11-15 04:23:36','2010-03-09 13:29:00'),
('55','17','declined','1978-11-11 01:18:19','2003-06-24 18:53:18'),
('56','10','approved','2017-04-10 20:57:03','2014-07-08 13:00:04'),
('56','40','approved','2006-04-14 10:47:00','1970-06-08 15:55:58'),
('56','64','unfriended','2004-09-08 19:57:20','1991-10-25 15:03:47'),
('56','100','requested','2018-06-09 06:34:50','2006-04-24 23:56:39'),
('58','8','requested','2015-06-30 07:48:39','2006-03-28 07:52:57'),
('58','40','approved','2019-12-28 20:35:24','2004-01-15 15:19:57'),
('61','61','approved','2015-07-24 12:00:30','2008-08-01 09:32:06'),
('61','63','approved','2018-05-11 03:19:42','2016-01-15 02:04:59'),
('63','27','requested','1995-01-20 15:32:44','1988-10-22 13:35:15'),
('64','4','approved','2016-12-01 18:19:02','2012-03-26 20:53:05'),
('64','9','requested','1996-10-21 17:51:22','1970-07-18 02:16:40'),
('65','29','approved','2010-09-03 09:06:12','2002-12-27 17:53:21'),
('66','32','requested','1985-04-21 17:30:00','1996-03-02 05:52:06'),
('70','15','declined','1999-04-23 00:32:27','1979-07-13 17:00:54'),
('70','16','declined','1993-06-10 20:40:55','1974-02-11 08:18:35'),
('72','57','unfriended','2010-10-25 23:00:40','1973-10-11 05:28:35'),
('72','60','unfriended','2000-10-28 01:20:00','2020-09-18 13:20:55'),
('72','86','declined','2018-11-08 18:06:24','2010-08-21 02:44:58'),
('74','45','requested','1980-07-06 07:51:30','1973-11-20 15:50:04'),
('74','85','requested','2011-10-17 02:25:13','2017-05-14 17:03:32'),
('75','3','unfriended','1995-08-21 01:28:09','2009-08-30 16:37:14'),
('75','12','approved','1970-11-27 21:44:07','1991-08-04 19:49:17'),
('75','34','unfriended','1994-05-01 21:42:50','2010-04-12 23:30:41'),
('76','90','approved','1983-01-09 22:02:57','2007-03-18 16:04:01'),
('79','12','approved','2007-05-13 23:15:57','1977-11-20 09:59:15'),
('79','91','declined','1989-11-04 04:27:54','2020-07-20 19:22:27'),
('80','14','declined','2009-09-09 03:37:41','1986-04-02 04:36:04'),
('81','6','requested','2018-03-21 09:27:34','1982-01-09 14:06:43'),
('83','72','approved','1997-11-15 07:56:14','1975-12-02 22:18:36'),
('84','8','unfriended','2002-11-12 05:15:24','1999-05-21 05:48:44'),
('85','11','requested','1999-11-28 11:54:26','1990-07-09 20:19:39'),
('85','88','unfriended','1998-03-08 22:51:13','2018-04-30 15:47:09'),
('86','9','approved','2016-09-28 22:57:13','1984-12-14 08:46:46'),
('88','47','requested','2004-01-24 02:23:55','1981-01-27 06:19:14'),
('89','1','declined','2004-07-20 11:04:58','1987-06-12 19:55:58'),
('91','51','unfriended','2013-02-07 11:42:04','1978-07-19 08:53:43'),
('92','30','unfriended','2003-07-02 06:48:37','2002-04-26 10:43:10'),
('92','90','unfriended','2001-03-10 16:58:26','1999-03-06 06:00:56'),
('93','48','declined','1996-05-31 07:50:43','2009-07-19 07:51:12'),
('94','90','requested','1995-11-15 15:10:45','1987-10-18 09:30:26'),
('95','7','approved','1979-09-20 10:59:32','1984-12-16 23:18:32'),
('95','44','unfriended','2014-08-05 10:55:16','1995-11-03 06:28:57'),
('97','4','requested','2006-04-16 16:53:27','1976-06-05 10:01:51'),
('97','29','declined','1987-02-24 01:27:15','2008-01-09 09:41:31'),
('97','72','unfriended','2017-09-11 17:52:23','2006-05-12 12:19:35'),
('98','4','declined','1997-10-13 09:19:43','2006-10-17 04:24:34'),
('98','27','approved','1987-06-09 17:10:55','1991-10-26 01:27:45'); 


DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL,
  `photo_id` bigint(20) unsigned NOT NULL,
  `is_like` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  KEY `post_id` (`post_id`),
  KEY `photo_id` (`photo_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `likes_ibfk_3` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `likes_ibfk_4` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `likes` VALUES ('1','79','66','32','78','0'),
('2','17','88','11','67','1'),
('3','95','92','26','96','0'),
('4','92','58','67','44','1'),
('5','99','37','67','65','1'),
('6','9','17','32','18','1'),
('7','22','57','82','25','0'),
('8','54','58','55','32','1'),
('9','24','87','10','40','0'),
('10','74','20','7','69','0'),
('11','12','32','64','3','0'),
('12','90','31','46','88','0'),
('13','67','12','53','75','1'),
('14','29','84','92','50','1'),
('15','40','74','75','94','0'),
('16','32','30','26','56','0'),
('17','16','35','96','90','1'),
('18','55','2','58','66','0'),
('19','34','22','69','23','1'),
('20','52','14','11','19','0'),
('21','26','63','93','54','0'),
('22','47','85','4','87','0'),
('23','59','78','80','91','1'),
('24','7','5','46','22','1'),
('25','40','41','12','95','0'),
('26','43','70','60','76','1'),
('27','91','28','99','43','0'),
('28','42','9','61','68','0'),
('29','72','54','21','18','0'),
('30','39','24','5','98','0'),
('31','1','85','88','8','1'),
('32','89','34','30','29','0'),
('33','75','41','23','17','0'),
('34','10','83','93','1','1'),
('35','10','92','43','52','1'),
('36','100','4','19','72','0'),
('37','58','40','90','96','0'),
('38','63','94','93','64','1'),
('39','78','81','71','67','1'),
('40','14','1','95','88','1'),
('41','41','18','5','50','1'),
('42','100','98','50','10','0'),
('43','89','93','61','89','1'),
('44','97','80','60','54','0'),
('45','19','49','50','82','0'),
('46','42','43','46','20','1'),
('47','23','17','86','37','0'),
('48','17','81','24','57','1'),
('49','98','29','7','97','0'),
('50','26','56','6','14','0'),
('51','49','67','2','45','1'),
('52','46','61','98','65','1'),
('53','9','47','46','51','0'),
('54','89','91','70','12','0'),
('55','7','56','48','23','1'),
('56','36','72','80','33','0'),
('57','100','86','29','25','1'),
('58','42','35','38','90','0'),
('59','1','40','35','47','1'),
('60','1','33','12','9','0'),
('61','79','57','60','68','1'),
('62','48','30','80','55','1'),
('63','85','27','78','20','0'),
('64','98','57','52','97','1'),
('65','43','81','22','84','0'),
('66','15','60','74','16','0'),
('67','99','8','63','99','0'),
('68','40','74','8','19','1'),
('69','30','67','87','78','1'),
('70','96','66','32','80','1'),
('71','93','10','99','90','1'),
('72','66','51','87','9','0'),
('73','31','8','92','46','0'),
('74','68','65','61','66','0'),
('75','73','23','64','13','1'),
('76','96','72','32','26','1'),
('77','38','18','3','34','0'),
('78','84','35','14','76','0'),
('79','44','13','66','10','1'),
('80','63','52','18','94','1'),
('81','60','9','39','27','0'),
('82','74','99','93','47','0'),
('83','22','56','59','17','1'),
('84','28','90','42','66','0'),
('85','8','45','99','91','0'),
('86','79','13','66','22','1'),
('87','25','31','31','88','0'),
('88','83','48','82','42','0'),
('89','57','20','69','30','1'),
('90','19','61','76','40','1'),
('91','17','35','56','44','0'),
('92','24','98','9','31','0'),
('93','42','8','21','20','1'),
('94','20','87','42','45','0'),
('95','17','72','33','99','1'),
('96','20','14','41','76','1'),
('97','33','9','5','52','1'),
('98','70','81','91','86','0'),
('99','15','47','29','39','1'),
('100','44','38','69','86','1'); 


DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `messages` VALUES ('1','64','25','Sint maiores molestias omnis illo qui dolorum eius. Assumenda recusandae possimus nisi dolor rerum excepturi. Adipisci est rerum est ducimus explicabo aliquam. Placeat facere illo dolor sequi qui id.','0','1993-04-12 01:33:23'),
('2','87','81','Corporis nihil consequatur ut non. Cumque quod assumenda vel quisquam perferendis et non. Consequatur ut cumque esse eligendi neque.','1','2010-05-17 05:51:04'),
('3','56','37','A illum sint ea ut nisi quod. Similique labore dolore sed ullam praesentium rerum sunt. Ut neque incidunt iusto quidem voluptatem. Officiis sunt totam fuga minus.','1','2004-02-03 15:04:15'),
('4','99','31','Laborum magni et veritatis iure nisi voluptatem nulla. Voluptas possimus minima quod corporis ipsum veritatis totam reiciendis. Dolorum dolore culpa molestiae maxime. Pariatur ut blanditiis labore quisquam.','1','2016-03-16 03:42:03'),
('5','45','50','Minus error quam maxime voluptatem. Magnam nihil qui non repellat nihil. Nihil expedita non nulla at qui praesentium error. Reprehenderit necessitatibus eius sed minus.','0','1981-01-13 10:25:53'),
('6','5','60','Consectetur tempora molestiae ut iste minima laboriosam impedit. Aut iure minima mollitia ipsum dignissimos est. Quia enim molestiae animi officiis totam.','0','1984-10-02 11:48:19'),
('7','53','100','Voluptates animi vitae quae animi nulla. Libero corrupti animi nesciunt nostrum voluptatibus minima voluptas. Dolor veritatis dolorem ea.','1','2016-03-25 13:07:16'),
('8','1','17','Cumque id qui quae. Voluptatem perspiciatis saepe unde hic. Qui sed enim exercitationem deserunt commodi. Vitae sit quo deleniti numquam.','1','2009-07-10 18:49:41'),
('9','23','4','Aperiam sapiente at est praesentium fugit voluptates repellendus. Ea assumenda voluptate dicta dolores. Laudantium omnis rerum sequi dolorem aut ut maiores ipsum. Consequatur libero sit quisquam harum.','1','2010-09-14 01:53:24'),
('10','50','39','Sed voluptatem non reiciendis repellat qui. Et corrupti officiis labore maxime. Ab minus id enim consequuntur. Rem expedita commodi nobis nemo blanditiis quia adipisci.','1','1988-07-13 08:58:43'),
('11','62','28','Totam perferendis sint et asperiores. Velit amet suscipit nemo adipisci id. Natus voluptatem quas fugit possimus provident praesentium. Suscipit veritatis doloremque et culpa.','1','1992-04-11 16:24:06'),
('12','89','74','Voluptas nostrum eligendi ipsa consectetur distinctio nisi placeat. Ut fuga architecto et mollitia facilis sit molestias. Iusto deleniti architecto eos animi expedita nesciunt. Facilis unde accusamus velit atque dignissimos et praesentium.','1','1979-09-04 10:01:39'),
('13','94','38','Qui et rerum placeat. Eum aut necessitatibus earum ipsum necessitatibus qui dolores. Non voluptas et mollitia ratione sit accusantium odio cupiditate. Perferendis fugiat quos sit fuga quam.','0','1972-11-29 12:24:16'),
('14','15','41','Beatae sunt non laborum maiores incidunt. Dolorem adipisci et possimus occaecati dolor rerum aspernatur adipisci. Nostrum ipsa illo saepe similique voluptates sequi ut. Ut debitis ab molestiae voluptatem quisquam.','1','2004-04-11 20:26:24'),
('15','90','5','Minima tenetur ut eligendi nisi aliquam. Assumenda veritatis eveniet consequuntur quia ex. Et atque minus sed atque incidunt. Qui dignissimos rerum delectus quisquam voluptatibus iste. Dolorum voluptate id quia excepturi maiores.','1','1991-08-25 09:36:31'),
('16','22','54','Voluptate pariatur ipsa in itaque porro. Neque et dolorem aperiam culpa.','0','2003-11-07 02:58:45'),
('17','29','9','Id quidem vel itaque ut in veritatis cum. Repellendus consequuntur aut cupiditate officiis quia vero beatae eum. Repellat velit possimus laudantium dolorem. Temporibus excepturi quia possimus incidunt molestiae et.','0','1990-10-06 14:08:38'),
('18','34','85','Reprehenderit maxime deserunt minima cupiditate. Est libero omnis aut placeat aut ut similique quo. Esse neque fugit necessitatibus voluptatum sunt tenetur.','1','2000-03-09 13:13:16'),
('19','45','33','Ratione non amet quam velit hic autem cum. A delectus ipsam est voluptas iste in est. Culpa qui sunt laborum.','1','1974-03-11 21:43:44'),
('20','16','90','Eius perspiciatis tempore rerum harum sed perferendis. Earum autem suscipit animi repudiandae. Ut nobis nihil nihil temporibus ut eum est. Quasi voluptatem doloremque maxime molestias.','0','1985-09-26 07:03:45'),
('21','82','20','Voluptatem et quo soluta temporibus quo impedit. Officia maxime ipsa autem ut harum. Sit quos hic sint eum tenetur recusandae. Repudiandae quaerat praesentium veritatis quas.','0','1987-10-17 16:28:33'),
('22','49','34','Et odio hic molestiae libero veniam. Ratione est odit dolorum aspernatur ad ut doloremque quia. Est dolore voluptatem qui delectus sed.','0','2001-04-11 10:56:26'),
('23','20','49','Eum deleniti error eaque. Qui dolorem officia doloribus nulla sequi quis quo. Illum ratione facilis quis et.','1','2015-08-08 19:57:09'),
('24','50','42','Itaque fuga sed est unde est. Ut et odio ut exercitationem. Ratione similique ut quibusdam accusantium. Laboriosam aperiam quo reprehenderit.','1','2006-08-13 07:37:28'),
('25','53','100','Nostrum dicta aliquid sunt corporis est. Debitis et temporibus fugit aut distinctio enim rerum. Eum velit nostrum nobis voluptatum animi. Quas earum nihil quisquam perferendis mollitia assumenda.','0','2001-12-09 07:28:09'),
('26','81','14','Ducimus dolorem eos cumque. Eveniet adipisci nam quis quae. Pariatur totam voluptate enim nobis ut aut. Saepe qui dolor assumenda rerum molestias officiis.','0','2013-02-24 13:54:06'),
('27','27','70','Dolor aliquid eveniet ea voluptatem sint aut doloremque. Tempora excepturi autem dolorem dolorem autem. Dolor nihil eos rerum.','1','2004-01-14 16:30:34'),
('28','87','20','Necessitatibus illum error unde. Natus alias quos nesciunt beatae quis occaecati.','0','2015-12-16 16:22:42'),
('29','7','2','Neque id perspiciatis earum. Velit voluptatem eveniet debitis quae doloremque. Itaque enim fuga dolorem voluptatem iste. Recusandae praesentium quos quia et enim nihil.','0','2014-08-08 21:02:00'),
('30','61','97','Quos qui officiis nisi. Officia placeat eaque qui dolores hic soluta. Ut dolor et velit corporis est ut blanditiis.','0','1981-06-29 12:47:39'),
('31','6','83','Sint voluptas laboriosam aut. Tempora in dolorem cumque vel velit dolorem hic. Dolores id tempora dolor illo tenetur dicta.','1','2000-09-17 06:51:12'),
('32','50','35','Distinctio minima recusandae vero velit consequatur. Harum dolor soluta illum ipsam. Non omnis in sunt ratione rem eaque.','1','1970-03-04 11:02:19'),
('33','91','83','Molestiae quisquam rerum aut in voluptatum. Consequatur ut distinctio soluta et id cum qui. Aut blanditiis dignissimos architecto molestias officiis. Cumque est eum sunt aut.','0','1996-05-06 20:46:37'),
('34','20','35','Ipsam molestias non nihil autem. Dolores amet repellendus quia minima aspernatur doloremque maiores.','0','1971-11-03 01:28:36'),
('35','15','36','Illum rerum sunt iste voluptas. Est voluptas corporis quia. Veritatis qui sequi rerum numquam tempora non.','1','1971-11-22 00:44:53'),
('36','24','97','Quos iusto libero eaque perspiciatis consequatur accusantium porro. Rem aspernatur vitae aut beatae labore et et. Occaecati eum aut et ea eum laboriosam ipsum. Ullam maiores qui officia expedita.','0','1989-06-01 11:10:18'),
('37','56','73','Minus delectus inventore provident. Aspernatur distinctio voluptatem quas incidunt maiores. Et itaque quos placeat nemo est. Fugit et expedita hic similique maiores.','0','2012-11-14 01:39:58'),
('38','30','75','Ut aspernatur non aut quia. Sint quidem rerum placeat qui sequi est ea. Tenetur at delectus quas similique.','1','2006-08-10 01:09:05'),
('39','22','80','Labore aut voluptatum sint sed. Et et eum ipsam occaecati ut sint et.','1','2002-04-21 17:30:30'),
('40','16','74','Quidem voluptatem est eum sapiente. Sunt aut ut est quia impedit qui nesciunt. Animi quo soluta libero dignissimos accusantium doloribus rerum.','0','1994-02-09 22:48:50'),
('41','79','97','Rerum cupiditate minima maiores natus repellat. Porro aliquam velit sed tempora dicta. Ad nesciunt ea fugit quibusdam provident sit. Est voluptatem nisi quis facilis ea accusantium.','1','2008-05-16 20:51:46'),
('42','87','6','Totam dolores autem dolorem dignissimos voluptatem atque ut. Id ex veritatis molestiae maxime cumque esse tenetur. Voluptatibus labore qui quia dolorem. Consequatur sunt est nam aut corporis quasi.','1','1980-06-24 01:07:50'),
('43','66','74','Est est doloribus neque laudantium qui ipsam id. Inventore hic voluptas cupiditate hic. Qui et et iure quidem voluptates possimus voluptatem asperiores.','1','1992-01-09 19:46:58'),
('44','25','73','Nihil sapiente quo vitae expedita qui voluptate nobis. Officiis voluptate facere quia a ullam et. Et dolor consequatur fugit veritatis magni. Quas pariatur voluptatem numquam ut maxime qui.','0','1980-11-14 17:22:36'),
('45','75','86','Quam cupiditate veritatis fugiat voluptas quo. Illum quo illo quia rerum et ducimus aut autem. Voluptatibus unde rerum ducimus dolores distinctio sunt qui occaecati.','1','2011-06-26 07:54:03'),
('46','69','81','Id odit laudantium optio expedita at aperiam repudiandae quod. Hic nemo odit occaecati repellendus aut. Mollitia et voluptas cum.','1','2016-04-09 18:20:02'),
('47','68','19','Non magni alias architecto eveniet. Omnis repellat eos dolores consequuntur.','1','1992-01-24 11:29:44'),
('48','16','58','Voluptatem laborum ipsam nisi et earum autem porro. Repellendus beatae qui ipsam repellendus expedita tempora quibusdam. Sunt nulla laboriosam quo. Cumque sint excepturi enim et natus expedita provident.','1','1998-05-15 20:50:53'),
('49','2','36','Est accusamus ab omnis explicabo et eius omnis. Ut voluptas ut cupiditate consectetur voluptatem est et. Cum cupiditate est id adipisci. Et excepturi illum id dolores facere quidem dicta.','0','1976-12-20 06:29:03'),
('50','93','16','Non atque quibusdam debitis quae aut voluptas delectus. Amet nesciunt necessitatibus molestias autem officia.','1','2010-12-05 18:38:01'),
('51','71','16','Itaque quis saepe eveniet. Excepturi quisquam optio sint sunt quos fugit aliquam saepe. Itaque aut maiores sed quia eius qui id incidunt.','0','1990-11-03 00:39:54'),
('52','13','26','Ut labore dolor laboriosam eaque sed reprehenderit corrupti. Molestiae blanditiis provident tenetur atque commodi velit consequatur. Est et exercitationem sapiente. Est eos laborum dignissimos quos nulla distinctio doloremque et.','0','2020-02-02 05:18:34'),
('53','89','42','Ea impedit omnis molestiae et et possimus officia. Sapiente quia nisi nemo. Et voluptatem sed aut officiis enim vitae et.','1','1995-11-14 02:56:29'),
('54','100','10','Aut autem sequi voluptas aut facere alias. Facere quia perferendis aliquam earum culpa. Non voluptas quia rem. Rerum omnis veniam corrupti corporis.','0','1983-10-22 13:39:03'),
('55','22','16','Sit officia nesciunt et ducimus dolorum. Quam optio voluptatem dolorum alias distinctio. Corrupti dicta maxime voluptatem explicabo. Ratione quasi architecto quibusdam nisi pariatur.','0','2007-02-09 17:24:19'),
('56','83','1','Aliquam natus ut et et. Iure assumenda eaque vitae qui omnis corporis. Maiores quibusdam sed et deserunt atque similique sit alias. Dolor harum dolorem ipsam enim nulla ut voluptas distinctio.','0','1972-04-17 16:17:36'),
('57','12','69','Sed voluptatem laboriosam expedita itaque velit tempore est blanditiis. Dolore possimus sit nisi nostrum ipsum quo. Ea nam sint qui.','0','1987-12-19 21:23:47'),
('58','6','78','Quibusdam aspernatur autem magnam rerum. Exercitationem repudiandae odio et quasi quo tenetur quia. Dolores iure provident dolorem sed. Fuga distinctio doloremque quidem assumenda dolores vel aut dolore.','1','1975-06-08 14:04:10'),
('59','42','31','Qui deserunt doloribus dignissimos totam aliquam dolore. Consequatur blanditiis fuga quam ut. Recusandae illum voluptatum est adipisci non.','1','1989-10-27 13:16:37'),
('60','50','17','Ea corporis voluptas est consequuntur et incidunt maxime. Id aliquid qui nostrum labore dolor accusantium ea. In sit placeat magnam perspiciatis corrupti sit nulla.','1','2007-11-22 14:22:49'),
('61','16','19','Quae rerum assumenda delectus. Adipisci inventore perferendis voluptatibus necessitatibus ut. Commodi reiciendis et voluptas officia sit non.','1','1993-03-07 02:10:52'),
('62','98','83','Provident ut eveniet quibusdam ut. Voluptatem quas est eos nam aliquid sit reiciendis molestiae. Quia eum quasi dolorem. In est possimus nostrum.','1','1986-04-22 15:22:58'),
('63','37','13','Voluptas qui voluptas mollitia commodi in fugiat labore. Qui perferendis quia neque quisquam est. Explicabo enim suscipit exercitationem delectus. Sequi veritatis eum at quasi cum ut.','0','2001-05-30 02:21:18'),
('64','41','39','Est est harum praesentium at ab voluptas. Nemo itaque dicta sunt voluptas corporis minus similique. Qui dolorem exercitationem mollitia non possimus. Sit ea incidunt itaque neque ut a et.','0','1985-11-02 21:41:13'),
('65','48','33','Voluptate iusto ut occaecati ipsa. Inventore qui omnis aut temporibus. Fuga doloremque ipsum ex.','1','2014-11-08 03:38:49'),
('66','54','19','Rem alias repellendus aut iste ullam et qui modi. Harum porro sapiente eos amet aliquam. Aperiam iure omnis et enim voluptatem consequatur aliquam adipisci.','1','1978-03-11 13:25:45'),
('67','49','66','Quia et minima aut quia et officia omnis ea. Et doloribus totam ullam voluptatem. Facere laboriosam fugit quis ad. Quaerat reiciendis iure ab. Ut quae omnis non.','1','1972-05-16 08:05:30'),
('68','44','37','Hic totam ab iusto molestias. Eligendi est expedita rerum vel sunt. Nesciunt similique assumenda enim eos. Quam recusandae a suscipit temporibus.','0','1983-09-05 07:49:57'),
('69','8','44','Officia doloremque qui enim non sit qui suscipit. Aut et alias dolores eos velit. Eaque ea vel sint dolores modi.','1','2008-04-27 14:33:31'),
('70','46','30','Rerum est dolorem voluptatibus ab nostrum necessitatibus. Voluptatem aut veritatis mollitia et nemo. Fuga harum voluptas ut esse ducimus.','1','2002-04-29 02:01:27'),
('71','60','28','Dolorem exercitationem a perferendis nemo consequatur sint alias. At ipsa quaerat ipsum temporibus aspernatur aut illo. Eos ullam voluptatem quo autem iusto. Quo ratione non autem nisi.','1','2007-10-28 08:09:53'),
('72','30','71','Sit nostrum qui cupiditate voluptas. Placeat illo aut modi eum.','1','2020-04-26 19:48:33'),
('73','97','36','Labore autem ipsam sunt vel omnis sed. Veritatis qui molestiae sequi voluptatem tempore et. Placeat expedita quibusdam adipisci quaerat tempore.','1','1985-08-22 18:10:40'),
('74','49','39','Aut harum vero voluptates incidunt neque tempora laborum. Sequi enim et eveniet placeat saepe.','0','1993-09-20 07:22:50'),
('75','66','99','Quidem est nobis rem nesciunt. Vel voluptatem ipsa dolorem rerum. Nam eum consequatur commodi odit omnis eos.','1','1987-04-24 16:02:06'),
('76','55','81','Dolor velit dolorem exercitationem nostrum officia officiis. Laborum et et dicta quo sit. Ea id dignissimos qui eligendi. Aliquam saepe velit soluta iusto.','0','2015-02-24 05:31:40'),
('77','17','53','Pariatur ut assumenda porro ipsum voluptatem nihil quia. Dolores quaerat aut non. Sunt suscipit qui quibusdam sed. Repellat labore rerum et dolores.','0','2018-08-28 11:38:09'),
('78','64','54','Dicta harum ut assumenda quidem rerum est reiciendis. Aut vel odit quaerat eveniet molestias veniam nihil. Nemo omnis enim quidem quis aliquid mollitia ea atque.','1','1976-05-22 05:48:03'),
('79','65','4','Ducimus quam aperiam repellendus omnis. Harum quas molestiae unde harum incidunt vel. Eligendi doloribus quia sit quos.','0','2002-10-07 12:04:02'),
('80','92','13','Rerum modi porro quasi error. Quia tempore molestiae ut velit doloremque a et. Earum architecto nihil debitis ad quia et nemo.','1','2004-06-12 00:37:16'),
('81','37','46','Incidunt et in voluptate veniam ducimus. Aut ratione quisquam placeat molestiae omnis optio facere praesentium. Et eligendi ipsa odit similique libero aut voluptatum. Enim est dolor velit assumenda culpa est.','1','1984-07-31 09:43:11'),
('82','31','85','Iusto incidunt temporibus et natus facilis ut. Aspernatur quisquam qui molestiae suscipit qui odit sint. Non nesciunt quo labore fugit nihil possimus quo illo. Accusamus eos perspiciatis sequi adipisci tempore. Dolores autem quibusdam officiis reiciendis accusamus maxime.','0','1970-07-09 12:43:59'),
('83','12','75','Enim aut sit quod corporis qui doloribus. Repellat perferendis perferendis quo quos accusamus non qui. Eos non culpa accusamus sed cum voluptatum.','0','2018-01-29 13:11:36'),
('84','22','20','Odio qui repellat maxime laborum consectetur. Iusto reiciendis consectetur nihil quasi omnis ab dolor hic. Ea rerum ea ratione maxime doloremque dolores. Eos architecto iusto cumque animi inventore.','1','1972-01-12 13:03:54'),
('85','19','68','Consequatur impedit voluptatum nulla voluptatem. Possimus autem est quae saepe dolores magni. Cum culpa sint sint.','1','2013-01-29 17:37:03'),
('86','49','78','Repellat rerum commodi quos aut. Et eaque ducimus enim excepturi quam. Velit rerum adipisci et expedita commodi nisi adipisci.','1','2012-01-03 09:02:37'),
('87','96','79','Deserunt ea autem doloremque qui consequuntur libero. Dolorem maxime soluta in aperiam ullam quos. Officiis hic ut omnis fuga omnis.','1','1986-06-15 17:27:21'),
('88','49','92','Vel omnis est dignissimos quis. Facilis ea nesciunt labore vero eum et cupiditate ab. Et earum id et nulla enim ea cumque minima. Eum maxime qui minima ut dolore vero.','0','1988-08-25 07:26:20'),
('89','14','97','Vitae dolorum et cupiditate. Eligendi placeat tempora fugiat laudantium.','0','2019-03-17 09:34:45'),
('90','31','79','Et temporibus ducimus ducimus consequatur sint maxime cum. Aut ipsa non expedita perspiciatis totam iste aliquam. Veritatis quae quo exercitationem et fugit aut. Saepe porro sint quia beatae.','1','2015-02-01 00:05:48'),
('91','95','86','Et occaecati quia nihil omnis. At eos quos maiores voluptatum iste. Culpa delectus qui ut magni cumque quisquam. Rerum dignissimos sed consequatur provident neque quidem earum.','0','1997-06-20 07:04:27'),
('92','60','12','Laudantium sed ut similique. Maxime voluptate molestiae ut. Laudantium libero eveniet nemo occaecati non omnis aperiam. Asperiores fugit hic est ducimus.','0','1983-04-12 02:51:23'),
('93','38','24','Pariatur qui repudiandae tenetur quaerat. Ipsa similique molestias consequuntur nihil alias exercitationem. Eos magnam provident consequatur consequatur. Quasi impedit quis praesentium voluptatem.','1','2008-04-23 21:54:08'),
('94','65','2','Nemo itaque dolor mollitia est dolores sed laboriosam. Placeat voluptates alias qui optio qui temporibus voluptas sint. Vero dolorum sunt in accusantium. Illum aliquid repudiandae repudiandae est reiciendis dicta.','0','2001-08-24 00:20:12'),
('95','27','57','Adipisci excepturi quod nisi corporis. Quis adipisci beatae cupiditate labore quis consequatur.','1','2003-07-12 04:41:37'),
('96','15','64','Animi maiores unde sed suscipit. Maiores sed corporis aut ea ut ut. Adipisci impedit qui tempora esse et nesciunt tempore.','1','2007-08-08 20:36:49'),
('97','3','45','Omnis voluptate minima et accusantium. Error est voluptatem maxime non modi quibusdam quis similique. Architecto in dolor dolores ullam tenetur sint.','0','1972-07-19 15:11:50'),
('98','49','14','Dolorem est dolorum consequatur voluptatibus porro consectetur omnis eveniet. Corrupti eveniet cum quos praesentium ut qui. In ab velit voluptatum aut reiciendis dolor expedita. Dicta fuga voluptates natus.','0','1997-09-24 23:38:30'),
('99','20','70','Aliquid veritatis aut cum minus. Quo dolor et fugiat recusandae repellendus eaque. Distinctio voluptatem qui quo quisquam tempora dolorum.','0','2000-07-09 05:42:46'),
('100','33','38','Veniam ea aliquam autem doloribus numquam. Aut vel eum odio cum excepturi corrupti. Vel sequi vitae recusandae aperiam deserunt error deleniti. Sunt consequatur neque porro. Voluptatum voluptas blanditiis debitis at.','0','1975-11-12 16:41:55'); 


DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `photos` VALUES ('1','88','Est aut temporibus ipsam quos placeat nobis. Debitis id numquam consequatur nemo. Nihil et aspernatur qui inventore et pariatur.','corporis'),
('2','97','Ullam veniam esse dolores nulla molestiae. Rerum deserunt quasi qui consectetur dolores ipsa necessitatibus non. Accusantium qui facere culpa commodi ab officia. Eaque eaque ratione nam.','officiis'),
('3','17','Tempora iusto iste suscipit voluptate magnam. Sunt quo veritatis eos hic recusandae. Modi odit natus ea dolorem non. Laboriosam sit necessitatibus et voluptatem. Temporibus quasi iure modi vel.','facilis'),
('4','27','Et quia veniam sunt quia qui ea fuga vel. Fuga rerum et pariatur ut similique nemo nemo.','non'),
('5','83','Fuga est officia omnis minima voluptatem nulla rerum est. Beatae perferendis animi ipsa distinctio voluptate quis blanditiis. Natus necessitatibus quod cum earum praesentium facilis.','consequatur'),
('6','26','Optio veritatis unde illum ex aliquam fugiat. Esse officia dolores a. Omnis eligendi itaque error commodi magnam nulla nihil et. Labore aut eius omnis repellat voluptates.','perferendis'),
('7','94','Earum et voluptate quo repellendus doloremque quisquam eum. Voluptas nemo rerum excepturi aut omnis ut sapiente. Architecto qui suscipit delectus quos est.','et'),
('8','5','Et amet facere voluptatem incidunt quae at deleniti rerum. Praesentium amet neque quo optio quibusdam. Vel consectetur inventore optio sed quis.','eos'),
('9','13','Quis illo nihil explicabo est architecto voluptatem veniam. Consectetur amet omnis corporis consequuntur esse nihil rerum. Temporibus omnis quasi quae modi sint.','velit'),
('10','19','Voluptas et laborum nisi quas voluptas fuga. Vitae officia architecto deleniti eum. Temporibus deleniti tempora ut vel.','possimus'),
('11','69','Perferendis facere in dolorem quaerat sed. Eum perspiciatis rerum aspernatur velit ut omnis labore quaerat. Aliquam qui voluptatibus id quibusdam ut est.','quasi'),
('12','96','Exercitationem quo dolore sed voluptas est aut. Praesentium nihil in non ut in doloribus autem neque. Consequatur rem praesentium voluptatem dolorem commodi repellendus dignissimos officiis.','voluptatum'),
('13','19','Alias ratione debitis autem aut quam ipsa facilis. Reprehenderit eum necessitatibus facilis saepe et. Incidunt ex rerum ducimus qui voluptas. Reiciendis quaerat molestiae deserunt accusamus occaecati dolore sint molestiae. Voluptatem enim voluptates ut eaque officiis voluptas.','et'),
('14','26','Nisi magni neque totam distinctio deleniti voluptatibus adipisci. Repellat sint vel placeat quia. Non quis non dolores minima fugit qui dolor. Sed fugit magni cumque molestiae.','placeat'),
('15','50','Ut ad est aut est sapiente iste voluptatum. Dolores dolores iste unde et fugiat. Accusantium et ducimus deleniti blanditiis. Ratione odit molestiae alias. Et quia necessitatibus expedita at repudiandae.','voluptatibus'),
('16','6','Aliquam aut et qui numquam. Facere earum est consequatur tempora eius quam. Cum sit quis commodi amet sit. Enim rerum rerum maxime quis aut et velit et.','maiores'),
('17','43','Expedita provident est alias. Quod et doloribus sed quod. Et pariatur sapiente enim vel dolor odit.','saepe'),
('18','86','Illum harum qui molestiae eum nam maxime sed. Earum porro ullam non iusto. Natus harum harum distinctio officiis temporibus aut quia. Voluptatem voluptatem hic corporis sed. Est et doloribus consequatur et consequuntur rem.','exercitationem'),
('19','17','Hic nisi rerum rerum. Expedita et esse eos explicabo consequatur. Ratione amet sapiente dolor.','voluptatem'),
('20','64','Facilis tempora eveniet voluptas est distinctio provident. Earum voluptatem nam quisquam qui dolore. Voluptatem autem sapiente iure et eum accusamus est.','quam'),
('21','52','Dolores quos omnis consequuntur et qui. Reiciendis modi natus velit facilis. Sit ratione odio ut quod est ad. Ut hic ut eius praesentium.','tenetur'),
('22','26','Sint rem laudantium reprehenderit. Sint omnis nam qui excepturi et non magnam. Cupiditate et odio quidem aut maiores sed dicta. Quo delectus incidunt odit aliquid.','rerum'),
('23','9','Quisquam quaerat facilis nostrum earum et reiciendis. Accusamus tempora aut omnis corporis adipisci labore. Modi doloribus unde qui est.','id'),
('24','73','Eum quam nobis optio autem. Dolorem et quaerat minima nulla. Rerum qui et ipsam soluta.','nemo'),
('25','85','At hic reprehenderit aut deleniti unde dicta ut. Repudiandae deserunt ratione beatae deserunt voluptatem. Qui enim ducimus accusamus aut qui ipsum. Corporis vero et facilis aut tempora.','id'),
('26','13','Porro nisi illum iusto assumenda quaerat minima. Amet nemo eos odit.','eos'),
('27','32','Delectus consectetur soluta neque neque. Quia voluptatem a tempore velit. Accusantium blanditiis id nobis est ipsum. Minima itaque et eaque repudiandae sint voluptate vero quidem.','est'),
('28','69','Iure impedit asperiores sunt soluta et. Consectetur aut aliquam voluptatem quia laborum. Quos vitae consequuntur temporibus ex quibusdam nobis. Fugit architecto eius maiores ea nesciunt et.','hic'),
('29','46','Accusantium totam fuga et reprehenderit. Consequatur consequatur nihil molestiae iusto. Placeat iste expedita in quae. Et ea sunt dolores ut.','assumenda'),
('30','7','Reprehenderit est dolorem nisi eum. Perspiciatis ipsa quidem ut nihil. Est ex placeat eum ipsa repellat in excepturi.','at'),
('31','38','Tempora dolore nam explicabo quo. Et quam minima est tenetur. Est eos in qui minus vero eos.','perspiciatis'),
('32','33','Ipsum voluptate illum iste nihil quia dolorum animi eum. Aut quia est et voluptatem quos nam quia minima. Sunt autem esse corrupti quia voluptas ut.','consequatur'),
('33','3','Atque nemo earum dolorem aut quas. Illo distinctio inventore praesentium deleniti molestiae.','sunt'),
('34','54','Placeat voluptatum dolores eveniet laboriosam consequuntur voluptas non. Quia aliquam velit et iusto nisi. Laudantium enim nesciunt optio debitis et distinctio nobis.','est'),
('35','60','Aut quia nihil eius sequi. Labore molestiae voluptatibus quisquam quam et iusto. Inventore officia voluptas ea provident.','esse'),
('36','86','Repellat hic nemo qui optio. Et qui est qui at molestiae vitae. Occaecati quis quia et eum fuga commodi.','maiores'),
('37','80','Sunt repellat aliquid reiciendis. Vitae quaerat sint ipsam nihil ut deleniti. Dolor architecto dolor totam in et sunt quo ipsum. Sit deleniti qui qui nulla officiis.','nihil'),
('38','54','Distinctio dolorum dolorem itaque commodi. Quis error impedit autem neque iure. Repellat ut commodi quod quia. Voluptatem dignissimos quia quam. Voluptatem ut quia aut nobis quidem esse omnis.','quis'),
('39','90','Et culpa molestiae dolores. Dignissimos est quisquam enim ut. Dolorem similique accusantium expedita quos atque quam minus. Laborum in sit qui aliquam quas. Magni perspiciatis fugiat necessitatibus et id sunt rem.','animi'),
('40','93','Repudiandae eligendi vero dignissimos ut est cum et et. Repellat est id sunt eius ut modi aut. Recusandae optio magnam soluta praesentium. Dolorem nulla quasi non nesciunt provident non voluptas sapiente.','eligendi'),
('41','72','Quia architecto voluptas non ut ducimus voluptas expedita. Molestiae et ut sed nemo ea.','asperiores'),
('42','59','Ut aperiam enim debitis recusandae autem. Aperiam consequatur saepe molestias. Fuga odio minus distinctio ullam provident nihil quia accusamus.','labore'),
('43','88','Quo quisquam et quibusdam odio. Amet nulla aperiam quas quo. Tenetur et minus similique fugiat laboriosam modi. Aut sint perspiciatis cupiditate provident porro porro sunt qui.','nisi'),
('44','91','Nesciunt eum nobis eum quia praesentium laudantium. Veritatis sequi optio quisquam id quo. Qui occaecati optio officia soluta id quasi. Repudiandae dolorum velit incidunt explicabo nesciunt.','deleniti'),
('45','84','Commodi nesciunt nam et hic. In ea impedit ut quo. Dolore doloremque accusamus possimus impedit voluptatem praesentium. Et ad vel voluptatum fugit nemo.','aut'),
('46','38','Qui facere et et praesentium voluptatem. Atque et iusto est aliquam porro quisquam.','dolores'),
('47','96','Cumque officiis nostrum similique eum culpa qui. Libero vel occaecati et explicabo. Qui sequi perspiciatis quisquam.','molestiae'),
('48','27','Voluptatibus eos perferendis eum quam non libero. Sit quam et velit. Ullam laudantium aliquam veniam eos ab quo sequi. Placeat omnis adipisci sequi ut.','beatae'),
('49','24','Eligendi laborum porro natus cum totam nihil ea. Eveniet sunt ipsum non ea non architecto. Magni consequatur maiores et quas.','nobis'),
('50','13','Nulla non et doloribus quo et eveniet at. Unde adipisci ut quis laborum cupiditate debitis numquam. Mollitia esse quos quae eos.','nostrum'),
('51','90','Et est ut quia totam sunt assumenda ipsam. Velit iusto ullam fugiat consequatur deserunt qui enim. Blanditiis sint in rerum doloremque fugiat pariatur voluptas. Odio perferendis veniam quae illo.','eveniet'),
('52','75','Porro sint magni ut velit molestias ipsa rerum. Incidunt eos velit molestiae nemo ad libero. Non rerum vel architecto dolores et quia eius. Dolore ratione eum natus aliquid quaerat perferendis.','fugiat'),
('53','38','Unde esse repellat eius eius. Quidem eligendi nihil et nobis aut excepturi. Quaerat deleniti culpa illo cum.','fugiat'),
('54','98','Ipsam voluptatibus accusamus magni dignissimos est. Quod atque sed deserunt. Ab pariatur quam vitae quibusdam sit et. Autem reiciendis odit aut.','assumenda'),
('55','48','Facere earum incidunt in rem. Aliquid reiciendis ducimus eum sint repudiandae. Et sint eveniet rem cumque nostrum laudantium.','maiores'),
('56','23','Et illo deserunt quidem distinctio laborum fugit. Facere voluptatem iusto magni dolorem. Fuga aut ipsum omnis sunt. Quae sint doloribus repellendus quos molestiae consequatur facere quas.','cum'),
('57','10','Non vel dolores velit sequi ut sint. Aperiam animi iste alias aut iusto. Minima magni officia ratione deleniti. Est maxime omnis eos quo.','voluptate'),
('58','79','Facilis pariatur vel incidunt ipsa iure odit. Eum eligendi sint modi quia numquam. Officiis et nobis sunt eveniet. Fugit modi animi in ut sed et cum.','eum'),
('59','91','Alias debitis ab ut aut cupiditate asperiores ratione soluta. Non dolor at beatae. Vel dolor debitis odio ratione et eos et saepe. Dolorem sunt earum voluptatem. Ut ea aut nesciunt voluptas.','corporis'),
('60','56','Beatae atque deserunt hic quibusdam illo omnis quaerat. Molestias fugiat consequuntur voluptatum adipisci harum. Sunt officia explicabo aut et eum omnis est ipsam.','neque'),
('61','86','Quia corrupti incidunt enim voluptatem. Quibusdam non esse aut laboriosam qui error deleniti iste. Expedita quis praesentium et sit praesentium illum. Est nobis eveniet molestiae molestias vitae. Quas sed sunt et consequatur quis commodi.','doloremque'),
('62','28','Tenetur labore explicabo consectetur inventore. Ex amet illo inventore aut nisi omnis. Nulla eos aut et dicta enim.','tempore'),
('63','88','Voluptatem quis eius qui voluptate et sint iusto. Vero sit aut sed. Ex cum voluptates molestiae.','unde'),
('64','88','Consequatur et et aut quas reiciendis sed dolores. Est reprehenderit velit odit voluptates. Quidem saepe eligendi adipisci pariatur omnis dolores. Et quo culpa dolorem nobis cum.','in'),
('65','82','In tempore accusantium qui corrupti quidem. Beatae minus quod natus dolore. Debitis consequatur eligendi fugit saepe amet illum et dolorem. Asperiores libero consequatur earum ratione reiciendis.','autem'),
('66','48','Nihil quibusdam enim et eum mollitia. Ipsum eligendi ullam soluta vitae labore saepe odit sit. Exercitationem incidunt omnis soluta architecto iste quasi harum. Magni dolorem et quia quas repudiandae eius aliquam.','distinctio'),
('67','74','Enim occaecati explicabo ut qui. Ad hic quibusdam dolores.','provident'),
('68','62','Qui perspiciatis qui nisi occaecati magnam rerum consequatur. Et non iure et quibusdam debitis adipisci. Aspernatur adipisci voluptatem rem quis debitis voluptate ab. Veniam voluptate eos illo velit rerum repellendus odio.','sit'),
('69','1','Aut vitae nihil et eos. Quis maxime ut sunt quae maiores asperiores iste. Sed nostrum cupiditate minima. Libero temporibus nobis itaque perspiciatis porro sunt.','et'),
('70','64','Aliquam excepturi sit rerum quasi soluta quia. Optio iusto est blanditiis officia illum. Blanditiis incidunt at nam enim cumque facilis ducimus. Voluptas enim est culpa autem vero eligendi.','accusantium'),
('71','55','Consequatur ipsa atque mollitia ut animi omnis. Ducimus voluptatum sunt qui enim incidunt dolore. Dolorem sit blanditiis illum sed consequatur vel inventore. Consequatur esse cum voluptas ex dignissimos veritatis.','eum'),
('72','72','Distinctio est ut itaque aut dolore blanditiis minima. Minus harum voluptas molestias commodi soluta mollitia. Porro dolore repellendus alias. Et dolor earum porro possimus quia sed molestias.','in'),
('73','22','In distinctio voluptatem veritatis. Quia beatae voluptatem neque aliquid vero et aut.','rerum'),
('74','42','Voluptas et eaque et laborum id nemo. Aut ratione quam omnis natus id quia. Velit architecto sint quia dolores corporis consequatur nemo.','impedit'),
('75','62','Itaque natus eos eum. Labore facilis possimus ipsa sit. Cumque placeat voluptatem natus.','numquam'),
('76','6','Et sed soluta magni dolores. Autem dignissimos ullam ipsa tenetur quos ut. Eaque aut molestiae iste et aperiam harum. Enim consequuntur laboriosam ut enim.','aliquid'),
('77','80','Velit hic eius velit. Nemo cumque eligendi reprehenderit voluptatem iste qui. Molestias amet amet doloribus nihil.','quaerat'),
('78','58','Incidunt eaque ratione voluptatem id qui accusantium. Maiores cumque repudiandae quaerat doloribus consequuntur quo aliquam. Ullam aut et quisquam voluptas et quibusdam et.','ut'),
('79','33','Similique eveniet iure ut ipsum quo. Est similique ipsam sapiente culpa beatae distinctio.','ipsa'),
('80','4','Asperiores eveniet magni enim vel ex voluptatem illum. Occaecati vel id iure.','omnis'),
('81','71','Perferendis doloribus unde voluptatibus voluptatibus et. Non est qui quia vel sed quibusdam dolore. Commodi dolore mollitia et sapiente deserunt vel rem.','animi'),
('82','22','Sint sunt maxime eos sed ipsa. Nobis corporis possimus accusantium excepturi. Officia animi magni impedit qui voluptatem minus.','in'),
('83','79','Eum omnis esse doloribus sunt. Nemo dolorum repellat dolores aut enim mollitia odio. Eveniet voluptates omnis omnis ut eos temporibus. Est amet aliquid architecto impedit sit.','suscipit'),
('84','9','Cupiditate sed reiciendis in mollitia maiores ut deserunt iure. Dolorum harum illum voluptatem laboriosam. Animi qui autem placeat rerum voluptates aut facere. Ut adipisci ab voluptate reprehenderit alias id laboriosam debitis.','facilis'),
('85','20','Possimus culpa reprehenderit velit sed. Odio aspernatur temporibus molestiae quas perspiciatis. Magni minus quo quos corporis.','quas'),
('86','26','Dolore porro soluta qui et eaque beatae. Beatae molestiae nesciunt ut. Quia aspernatur perspiciatis natus excepturi. Pariatur adipisci dolorem et est cupiditate laudantium.','aut'),
('87','31','Quia dignissimos magnam tenetur ab in a et. Occaecati provident animi minus porro corrupti. Amet repellat voluptas dignissimos voluptatem doloremque.','quisquam'),
('88','30','Qui adipisci et veritatis. Doloribus a nemo pariatur. Quibusdam et excepturi in nam. Omnis quia qui vel repellat perspiciatis. Numquam et tempora omnis harum ut debitis.','dolor'),
('89','5','Praesentium sint consectetur sint quia et quidem. Corrupti atque autem nulla harum sunt. Dolor libero blanditiis animi a. Dolore sit minima voluptatibus reiciendis. Deleniti in ab sequi voluptate assumenda.','quo'),
('90','21','Quas minima saepe sed dolor id. Dolores et dolorum occaecati omnis corporis dolor perspiciatis. Autem laboriosam vero alias quis maxime cumque voluptatem.','ad'),
('91','85','Vel voluptates similique sint quis numquam provident. Aliquid velit molestias dolor aut sequi aut et. At quam sit omnis cupiditate quaerat et et qui. Eum aut voluptatem cupiditate aut illum.','et'),
('92','90','Dolorem dolores aliquam aut qui et dolores. Non rem ratione nobis.','quibusdam'),
('93','49','Enim temporibus qui qui quia illum sunt asperiores. Ut non reiciendis voluptatem natus omnis id. Perspiciatis earum fugit quisquam maxime et recusandae. Et illo aut reiciendis suscipit voluptate. Voluptate voluptas aut libero et.','inventore'),
('94','73','Expedita sunt consequatur sunt possimus magni qui. Aperiam impedit vitae eveniet laboriosam blanditiis.','doloribus'),
('95','78','Consequatur aliquam laborum vel voluptates molestiae dolores. Aliquid animi ut temporibus quasi et. Velit quis odit quis non natus est.','facere'),
('96','30','Qui incidunt incidunt et eaque fuga unde eum. Et non voluptas sit eaque quo aliquam. Illum veritatis dolorem exercitationem. Doloremque porro distinctio est aut ut assumenda molestiae.','ad'),
('97','20','Nemo eius qui esse distinctio ipsa ut. Animi qui ut aperiam. Earum nostrum tempora nisi minus eos optio laboriosam.','facilis'),
('98','51','Quia porro ut qui ipsa quas. Magni molestiae illum et. Officia sit quia amet enim nemo.','omnis'),
('99','92','Veritatis beatae nobis similique maiores. Reiciendis non nemo id sed qui doloremque neque earum. Est voluptate quae quas dolor eum voluptas soluta.','eos'),
('100','20','Nesciunt praesentium dolores iste cum. Dolores rerum dicta officia quia. Odit fugiat ipsa quod. Repudiandae dolor iste aliquid quia.','minus'); 


DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `posts` VALUES ('1','80','Tempore molestias et voluptatem quod dolorem. Et voluptatum ipsa corporis consequatur.',NULL,'1975-12-18 01:50:42','2019-06-03 03:30:18'),
('2','25','Quia nulla sit voluptate ut dolorum. Est similique qui eligendi eum doloribus pariatur.',NULL,'1993-08-20 16:09:31','1971-10-28 00:17:10'),
('3','55','Nihil aperiam quo animi voluptas sed quasi. Cum eum et et sed. Quam sit voluptas laudantium corrupti molestias.',NULL,'2014-12-28 16:56:14','2003-06-07 08:23:45'),
('4','98','Aliquam facere deleniti autem illum. Natus aut quam sit aperiam quidem non modi. Sit harum a earum aut.',NULL,'1986-03-06 14:11:28','1993-11-07 15:10:23'),
('5','79','Maiores voluptatem tenetur ullam enim nemo qui. Aliquid doloremque quidem error magnam saepe autem. Sed cupiditate in expedita doloremque omnis. Nobis quia optio rerum rem sed nam.',NULL,'1970-11-11 19:37:19','2003-12-16 05:24:35'),
('6','33','Laudantium voluptatem corrupti ipsam quisquam adipisci quia corrupti. Placeat quia ut possimus sequi est quas. Fugiat iure et dolor ipsa omnis.',NULL,'1996-09-15 21:11:10','1975-06-21 06:04:27'),
('7','78','Qui et unde praesentium veritatis sint. Hic quaerat eum cum corrupti corporis. Laudantium voluptatibus nihil adipisci deleniti ipsa quo. Nesciunt et soluta sit debitis quia.',NULL,'2016-06-09 04:24:27','2003-10-27 05:52:22'),
('8','28','Ab repellat qui doloremque eius odio aperiam. Ut qui exercitationem cupiditate magnam hic quod voluptates asperiores. Ducimus reprehenderit adipisci et quas. Est id enim perferendis corrupti et. Culpa quisquam minima recusandae ea earum.',NULL,'1980-08-01 16:43:07','2013-07-25 20:21:09'),
('9','70','Officiis rerum saepe dolorum enim non ullam et. Perferendis dolor facere quam cumque ipsa alias quos architecto. Porro odio quisquam ea et. Optio molestias esse non qui qui veritatis.',NULL,'1978-06-12 16:31:14','1978-08-25 18:39:16'),
('10','83','Non quisquam sint iusto ab rerum. Est et veritatis labore voluptates. At libero numquam et delectus excepturi occaecati fuga ut. Deserunt est nostrum inventore nesciunt. Impedit aliquid voluptas sit inventore autem.',NULL,'1990-04-01 04:47:12','1979-05-08 23:32:46'),
('11','77','Quas ut amet repellendus porro laborum quas excepturi. Id nisi quibusdam amet eaque rerum earum dicta. Aliquam quia consequuntur amet explicabo aut aliquid. Repellat reprehenderit voluptates soluta accusamus voluptatibus quis.',NULL,'1978-09-29 19:52:44','1990-12-27 18:07:21'),
('12','93','Accusamus sed nobis omnis sed repudiandae et nostrum. Nihil nemo qui impedit accusantium eum consequatur provident est. Et debitis ullam porro. Ipsa aspernatur atque et asperiores.',NULL,'2014-11-25 02:44:54','1989-06-22 15:24:58'),
('13','49','Fugit explicabo odio consequuntur cumque. Eum libero et libero harum voluptates. Ut est odio esse possimus autem est.',NULL,'1981-03-31 21:48:49','1992-01-04 13:23:08'),
('14','29','Et at quia expedita enim. Est fugiat quas ut aut. Quia amet veritatis dolores ducimus dolorem repellat eveniet illum.',NULL,'1982-12-03 10:47:17','2005-10-23 22:28:45'),
('15','95','Et atque qui omnis. Dignissimos omnis ut repellendus atque vel voluptates occaecati nisi. Voluptatem placeat quis possimus. Nostrum repellendus quas et quo dignissimos aliquid voluptates.',NULL,'1979-01-22 10:57:13','1985-01-20 06:52:58'),
('16','48','Qui ut rerum facere. Praesentium aspernatur sed tenetur deserunt. Pariatur est deleniti iste accusamus fugit at. At delectus non ut ut velit ut vel nihil. Mollitia ducimus consequatur dolores voluptatibus adipisci consectetur veniam.',NULL,'1996-04-05 07:20:07','1988-02-17 12:06:28'),
('17','8','Eaque non facilis sit assumenda voluptatum ex enim. Dolor quia dignissimos est expedita. Fugiat minima debitis laboriosam labore hic quas harum. Voluptatem animi ab ea quia.',NULL,'1975-02-04 03:44:02','1983-07-22 23:55:59'),
('18','14','Ea nobis natus qui exercitationem dolores. Aut dolor cum amet sunt nostrum dolor. Aperiam ipsam fugit ut vero doloremque neque minus. Aperiam consectetur velit aut eius molestias omnis.',NULL,'1979-08-21 15:23:29','2006-03-30 18:08:37'),
('19','41','Adipisci et iure quaerat laboriosam. Ab repellat sit ducimus qui ullam ut. Perspiciatis omnis rerum cum amet et culpa. Iste qui molestias pariatur ipsa repellendus asperiores aut et.',NULL,'2009-12-15 14:40:06','1970-06-15 13:16:05'),
('20','69','Beatae rerum dolor et minima consequatur. Iure fuga quae atque molestiae. Error nisi et autem vel rem. Autem corrupti pariatur quod modi et ipsam reiciendis.',NULL,'1979-10-10 22:59:24','1992-12-13 04:51:09'),
('21','25','Id a eligendi sequi aut similique. Fugit beatae qui voluptas omnis. Rem dolorem pariatur maiores libero sit non.',NULL,'1993-08-19 03:01:59','2014-09-18 01:51:48'),
('22','7','Aliquam laboriosam et nulla illum sunt natus. Perferendis porro error provident facere dolor sunt. Expedita sunt quisquam nemo iusto soluta. Fuga et molestiae similique cupiditate asperiores magnam autem.',NULL,'1976-06-03 13:13:33','1987-04-26 23:08:40'),
('23','77','Modi vel repudiandae et sunt. Pariatur doloribus et ut commodi. Repellendus voluptatem et delectus necessitatibus consequatur quas ut consectetur.',NULL,'1991-11-25 21:12:26','2018-09-18 12:08:18'),
('24','16','Sit culpa ut at praesentium. Aut inventore voluptatibus laudantium minima voluptatem rem. Sed omnis enim quibusdam quis et et.',NULL,'1981-04-11 13:20:03','2017-03-27 15:58:01'),
('25','52','Assumenda sed est enim minus occaecati saepe nemo. Accusamus ut aut voluptatem odio dolores enim quam. Aut deserunt vel ipsa deleniti sunt consequatur voluptas. Deserunt autem occaecati non eveniet.',NULL,'2009-07-11 07:12:08','2012-11-23 06:09:46'),
('26','24','Deserunt quas quod voluptatibus odio. Reprehenderit consequatur voluptates saepe facilis dignissimos neque. Aliquid molestias eligendi dolores animi officia.',NULL,'2006-06-30 07:22:27','1974-11-28 15:37:43'),
('27','66','Ut aut eum quo provident deleniti nulla veniam. Autem atque voluptatem quod officia harum odio voluptate. Repellat amet voluptates optio perspiciatis voluptatibus vel odio. Voluptates aliquam qui numquam id.',NULL,'2018-06-02 22:52:40','1981-04-08 23:44:52'),
('28','19','Qui non cumque ipsam aut et officiis corporis. Doloribus eius omnis minima iure. Aperiam commodi eum totam ut quia in perferendis.',NULL,'2003-07-28 07:02:34','1977-09-15 13:50:18'),
('29','94','Nesciunt et voluptatibus et porro neque laudantium. Aut asperiores ut consectetur. Non aut quo est assumenda exercitationem. Perspiciatis est hic pariatur libero.',NULL,'1979-12-19 13:57:49','1989-02-05 11:36:32'),
('30','51','Et incidunt dolorum beatae. Dicta cumque qui qui porro. Possimus eos asperiores mollitia ut magnam accusamus voluptatem tempora. Aperiam est voluptatum facilis in veritatis qui adipisci.',NULL,'1975-12-16 21:17:44','1999-12-21 05:11:20'),
('31','65','Exercitationem sit fugiat qui atque. Voluptatem vero nihil id dicta. Qui at harum repellat vel pariatur aut nesciunt perspiciatis.',NULL,'1972-02-05 07:38:04','1977-05-23 12:46:02'),
('32','74','Officia laborum omnis possimus laudantium. Dolorem reiciendis eius delectus suscipit aut. Aut dolor odit consectetur est iusto.',NULL,'1998-12-28 18:53:13','1978-02-18 12:10:38'),
('33','76','Sapiente saepe maxime laboriosam eum expedita. Ut minus exercitationem voluptatibus. Reiciendis quas aut nesciunt officiis tempora.',NULL,'2012-05-01 09:01:22','2002-10-11 06:35:56'),
('34','19','Corrupti aut repellat ut dignissimos non repellendus sed. Eum expedita nam veniam ea. Aut occaecati unde natus nemo aut alias occaecati. Neque asperiores est voluptatibus enim tempore.',NULL,'1983-01-03 20:08:55','1983-11-25 06:51:39'),
('35','72','Aut animi enim dolor quasi odit. Consequatur consectetur facilis dolor ea sed dolorem.',NULL,'1986-06-22 19:31:52','1976-04-28 09:39:44'),
('36','55','Esse in molestiae libero sapiente at. Ipsam aliquam debitis qui et numquam necessitatibus explicabo. Quas totam quos fuga quam autem tempore tempora in. Illum rerum ducimus quia eligendi nam qui.',NULL,'2010-02-24 16:17:20','2017-03-08 23:33:36'),
('37','52','Rerum ut ipsum magnam ut aut aut consectetur. Asperiores id molestias necessitatibus sed porro iure fuga. Perspiciatis quia reprehenderit quod.',NULL,'1987-05-04 17:41:06','1971-04-24 18:50:31'),
('38','50','Nemo voluptatem est aperiam soluta id. Voluptas inventore est sed est ut dignissimos nihil explicabo. Porro omnis quidem itaque nobis enim ut. Aut sit dolor omnis eos.',NULL,'1977-03-21 04:09:24','2010-04-07 11:25:38'),
('39','83','Veniam aut qui atque voluptates minima. Dicta perspiciatis asperiores ipsam iusto. Et necessitatibus perspiciatis et cumque aut voluptas ducimus. Nisi totam est pariatur impedit officia dolore totam.',NULL,'1984-06-21 13:59:18','2013-11-27 21:11:10'),
('40','22','Nihil ut recusandae nostrum iste. Suscipit veritatis in illum. Vel voluptas sint quia et ut.',NULL,'2003-03-23 08:59:33','1979-01-21 10:24:41'),
('41','32','Id sit autem sint ab cum. Sed aliquid est cumque. Incidunt minus nemo sit quisquam.',NULL,'2000-09-22 21:51:49','1988-03-02 22:05:30'),
('42','59','Ad velit saepe maiores totam natus. Laboriosam expedita nemo odio reiciendis occaecati et optio. Occaecati quidem veniam assumenda sed voluptatum.',NULL,'1998-04-23 08:52:35','1980-05-09 16:11:26'),
('43','15','Eos quasi dolorem laudantium voluptatum atque consequuntur rerum. Ut totam occaecati facere expedita vel soluta non ullam. Velit architecto voluptatem accusantium non. Libero dolorum accusamus quas velit voluptas qui minima.',NULL,'2017-04-28 18:10:45','1999-04-27 21:39:01'),
('44','80','Excepturi officiis cum cupiditate non labore. Id autem rerum ipsam. Aut reprehenderit nobis doloribus natus quae soluta quod.',NULL,'1971-03-14 14:26:55','2005-11-13 06:16:24'),
('45','87','Quibusdam sapiente similique odit deleniti totam enim. Delectus temporibus quam recusandae vel sint eos. Ex non qui quia voluptatibus. Sequi atque tenetur id dolorem commodi velit.',NULL,'2011-12-02 03:56:11','1990-06-05 22:54:02'),
('46','9','Eum vitae ad sint mollitia. Voluptas dolore doloribus facere possimus. Quo odio ut aliquam veniam velit maiores.',NULL,'1976-01-16 23:17:04','1972-05-04 12:23:28'),
('47','28','Dolores veritatis cupiditate ut unde. Quas ipsum non cupiditate. In quidem nulla possimus blanditiis sed inventore. Porro eum doloribus neque nihil.',NULL,'1998-11-21 11:20:51','2002-08-26 16:17:52'),
('48','95','Aut nobis deleniti qui laudantium quia suscipit. Placeat earum ducimus corporis velit quas quas at dignissimos. Nulla aut dignissimos nobis molestias labore voluptate. Culpa illo sint et non totam. Harum et aperiam dolor.',NULL,'1976-10-10 10:49:25','2007-12-01 07:02:06'),
('49','22','Ut odio quo accusantium ea. Deleniti nobis rerum voluptatum.',NULL,'1978-01-20 00:32:00','1975-04-23 07:35:41'),
('50','69','Ipsum rerum incidunt dolores earum tempora. Eius quia voluptas aut praesentium. Quos qui laborum velit qui enim vero. Dolorem et excepturi cum.',NULL,'1984-06-21 02:34:02','2016-06-30 20:41:34'),
('51','64','Ducimus maiores vel incidunt dolorem. Beatae natus id corrupti est ab veritatis reprehenderit. Qui voluptatem illo autem. Eum rerum veritatis quaerat esse tempore similique voluptas dolorem.',NULL,'1987-12-25 04:36:03','1973-01-19 14:16:05'),
('52','46','Id deleniti velit sit doloribus incidunt rerum sit. Similique illo consequuntur repellendus aut. Eos autem quo dolorem illo et.',NULL,'1991-05-21 11:30:53','1983-02-27 11:15:39'),
('53','75','Velit eveniet nisi et ea laudantium quasi. Rerum enim nobis veniam blanditiis. Aliquid qui nihil quis accusantium aut eos. Enim reiciendis occaecati ut natus excepturi nulla.',NULL,'2011-04-05 01:20:55','1999-12-02 14:33:45'),
('54','40','Velit illum tempore et expedita delectus quasi. Dicta fuga recusandae unde quia sunt harum assumenda. Dignissimos ut atque nostrum laudantium enim eum qui. Unde quia voluptatem vero repellat consequuntur aut. Incidunt dolore deserunt id ad est.',NULL,'1978-05-16 00:56:01','1988-03-29 09:12:30'),
('55','62','Eos sint aliquid qui minima eaque. Temporibus fugiat culpa earum voluptas omnis ipsum. Quidem magnam ab fuga quam ipsam ducimus. Praesentium delectus et accusantium officia.',NULL,'2004-10-17 14:19:45','1976-11-29 20:00:09'),
('56','27','Iure adipisci voluptas qui reprehenderit. Molestiae porro numquam et sed itaque. Omnis et atque adipisci dolorem officia.',NULL,'2002-09-21 22:35:19','2004-08-15 21:13:53'),
('57','64','Adipisci eveniet dolorem sed ut nulla. Id sint quisquam aut minus autem officia delectus aut. Ducimus et quas nihil voluptatem optio laudantium. Laborum laboriosam at cum sunt. Nobis tempora molestias rerum omnis optio voluptates ullam repellat.',NULL,'1974-12-15 01:21:42','2014-08-01 16:52:26'),
('58','27','Dolor quia impedit saepe aut unde sunt. Cupiditate qui est quaerat ratione consequatur velit.',NULL,'1991-04-14 14:03:01','1970-03-20 15:14:41'),
('59','46','Dignissimos a aliquam itaque ut ut. Sit facere rerum eos voluptatem sit rem. Dignissimos quia officiis molestias et dolor rerum et. Modi autem aut dolore qui id hic. Enim laboriosam sunt aliquid quo est et.',NULL,'2015-03-12 15:00:54','2018-08-31 21:18:28'),
('60','58','Consequatur quas ipsum modi voluptas. Nihil ex libero a non quibusdam consequatur. Aspernatur mollitia molestiae sint ab sunt dolore facilis.',NULL,'1999-04-05 08:02:29','2015-05-19 05:11:11'),
('61','78','Velit ab eligendi reiciendis quod suscipit modi laboriosam. Sunt voluptates dolores omnis quos illum iusto est.',NULL,'2000-08-15 13:20:33','2008-06-01 14:01:57'),
('62','10','Aut repudiandae in est sed est. Magnam ut recusandae saepe dolorum consequatur aut. Inventore perferendis vel et ipsam quibusdam quod.',NULL,'1972-09-14 10:08:54','1983-09-24 19:51:26'),
('63','31','Quia corporis ratione autem quo modi. Aut excepturi iure debitis similique est culpa autem. Quam magnam laboriosam illum dolor autem recusandae. Quia et laboriosam quis cupiditate officiis. Asperiores nihil fugiat earum non vero est occaecati.',NULL,'1979-09-20 18:44:00','1996-05-06 10:11:21'),
('64','54','Est labore magni sint accusamus sit et ut. Assumenda vel voluptas doloribus unde sequi blanditiis vitae cupiditate. Pariatur rerum nihil et minus blanditiis. Quisquam temporibus provident aut pariatur saepe repudiandae.',NULL,'1989-12-01 16:21:15','2013-07-04 13:10:13'),
('65','29','Velit cupiditate deleniti voluptate aut aut nostrum sit. Accusantium optio non non accusantium voluptatibus aut ipsa. Delectus exercitationem ut exercitationem commodi est. Ipsam in voluptas quibusdam quia velit eum.',NULL,'2011-10-28 08:20:31','1982-08-30 19:59:43'),
('66','3','Et sit perspiciatis asperiores expedita occaecati fugiat quia qui. Rerum unde deleniti ut eum. Numquam incidunt molestiae voluptatem dicta earum consequatur. Eos maiores sint omnis sunt. Placeat tempora ut incidunt exercitationem id minus ea.',NULL,'1972-07-14 10:22:06','2000-11-09 17:44:24'),
('67','9','Magni ratione corporis dolorum autem consequatur qui. Ut omnis asperiores rerum. Unde rerum ipsam non ipsa tempora iste. Doloribus ea aut ut expedita omnis.',NULL,'2007-10-13 06:34:30','1986-06-19 21:37:19'),
('68','80','Est placeat consequatur porro aut ipsum. Reprehenderit eaque sint tempore a. Non culpa minima saepe sunt blanditiis quaerat. Est et sit consequatur autem est.',NULL,'1996-03-16 19:13:28','1978-08-11 18:27:41'),
('69','52','Explicabo quo aliquid dolore totam excepturi eos. Est est ut omnis est et delectus reprehenderit. Dolores nobis ut dolores quia vero deserunt minima et. Cumque est fugiat laudantium tempore atque veniam.',NULL,'1994-03-09 00:00:36','2013-10-31 11:41:13'),
('70','91','Est et sed ut quia non similique. Laborum amet sunt quis amet aut impedit. Est est nihil commodi expedita animi accusamus. Sed eligendi dolor magni ut qui.',NULL,'1984-08-28 10:10:49','1973-11-20 22:44:37'),
('71','2','Maiores earum perspiciatis enim ea. Velit velit voluptatem nihil et. Doloribus eos nostrum voluptatibus mollitia a. Vero eum ea accusantium qui.',NULL,'1983-03-11 08:53:16','2002-04-18 11:08:41'),
('72','83','Blanditiis sequi earum sequi ullam velit. Aliquid ex et et totam doloremque iure. Rerum qui aut voluptas. Ex accusamus ex aut aut et.',NULL,'1984-03-22 07:35:24','2019-05-21 03:32:41'),
('73','50','Quos qui maxime rem et velit earum. Sint aut et nulla delectus beatae vero. Beatae aut voluptatem est est. Facere suscipit mollitia officia et velit veniam.',NULL,'1979-05-23 08:40:36','2009-08-17 03:05:39'),
('74','16','Et rerum exercitationem reiciendis qui tenetur reprehenderit nisi rerum. Quia quos ut non facilis dolore ab aliquid nobis. Qui tempore quam aut. Est quia doloremque impedit dolorem.',NULL,'2003-09-11 07:18:40','1977-07-04 16:39:30'),
('75','63','Provident ut in adipisci. Dolor vero sint enim reiciendis voluptatem laborum id. Explicabo quod nostrum veritatis alias esse suscipit.',NULL,'1978-04-07 02:20:17','2017-07-04 23:41:00'),
('76','37','Quis fuga dolores laborum ullam non autem qui quis. Totam voluptas odio soluta non a.',NULL,'1990-06-09 12:19:59','2010-06-16 13:47:25'),
('77','24','Enim expedita libero vel id nostrum. Saepe odit accusantium nemo molestiae sequi excepturi ab quidem. Atque ut dolorum et qui.',NULL,'2002-02-15 05:44:12','2005-01-12 03:54:41'),
('78','90','Aspernatur ab placeat voluptates eum asperiores blanditiis. Dicta quibusdam voluptatem nulla enim cum. Porro et sed nostrum odit repellat unde odit. Necessitatibus culpa ratione vel eos corrupti consequatur.',NULL,'2008-03-03 15:27:13','2015-05-28 02:58:33'),
('79','31','Autem quasi veniam quos. Totam recusandae doloremque enim est saepe ex sed. Quas reprehenderit voluptatibus officia omnis voluptatibus est dicta.',NULL,'1981-05-21 13:01:12','2004-01-26 10:37:12'),
('80','45','Et sint et sunt consequatur esse id. Consequuntur dolor nesciunt quia et. Quia perspiciatis deleniti repellat deleniti est in tenetur. Neque dolorum omnis quis quibusdam minus. Quae numquam est consectetur dolore fugiat omnis sit.',NULL,'1989-10-06 23:08:19','2002-12-11 03:57:05'),
('81','59','Reprehenderit dolores ad praesentium quos. Non fugit possimus voluptatem vel quia quidem. Omnis optio qui fugit.',NULL,'1987-05-25 13:35:20','2011-10-16 20:41:00'),
('82','95','A ipsam ut quod. Dolorum perferendis nihil necessitatibus id fugit impedit corporis. Magni dolores in quisquam aliquam fuga sint culpa amet. Cupiditate nihil aut est ducimus ea.',NULL,'1973-02-13 17:38:06','1991-05-13 16:16:36'),
('83','91','Et sequi molestiae dolor velit dolorem facilis. Animi minima sint molestias ut ad. Et quas tempora eum enim.',NULL,'2017-09-21 20:55:50','2012-07-24 17:31:32'),
('84','34','Aut molestiae tempora pariatur ut alias at facere voluptatem. Ullam ut fugit odit. Deleniti in sequi hic et est. Voluptatem cupiditate nostrum consectetur dicta veritatis voluptatibus eum.',NULL,'1986-12-14 03:57:09','2017-12-14 23:46:32'),
('85','34','In iusto doloremque autem et officia. Quisquam deserunt enim cumque qui quae maxime. Mollitia ea nemo nisi minus. In saepe eligendi magni magnam et praesentium.',NULL,'1972-03-11 02:29:24','1972-01-08 03:57:04'),
('86','53','Asperiores minima quos molestiae quaerat accusamus nostrum. Tempora architecto et et fuga suscipit animi aut. Omnis et dolor atque placeat non.',NULL,'2006-04-13 16:05:32','1984-11-12 20:51:37'),
('87','60','Repellendus vitae dolor sed nihil optio eius. Rerum dolore fuga mollitia qui ea optio. Ducimus nobis quasi quia laborum numquam hic atque labore.',NULL,'1983-05-29 18:09:38','1977-02-17 10:19:06'),
('88','98','Qui corporis nobis adipisci sint qui tempore saepe. Occaecati quam et sed possimus sunt. Labore fugit eum ab sunt aut. Perspiciatis iusto velit sunt.',NULL,'1970-12-05 14:16:10','2017-08-25 09:17:47'),
('89','80','Unde culpa et at dignissimos ex esse vel. Ullam vitae perferendis commodi rem et doloremque. Provident molestias pariatur distinctio tenetur ut.',NULL,'1974-01-12 21:34:22','1996-10-13 22:53:19'),
('90','5','Perferendis est blanditiis placeat error rem aliquid accusamus. Voluptatem voluptatem aliquam nam quam.',NULL,'1979-10-04 00:20:28','2010-01-26 19:52:25'),
('91','55','Autem voluptas repellendus ut voluptatem ex vel. Ipsum qui aspernatur reprehenderit molestiae asperiores et. Animi et aut qui aut culpa quia. Voluptatem eaque laborum sed molestias nam velit.',NULL,'1984-06-07 21:00:19','2018-11-25 23:20:52'),
('92','57','Ut eligendi veniam consequatur voluptatem consequatur. Omnis voluptas voluptatem fugit non dolore. Sint non delectus mollitia dolores.',NULL,'2018-10-11 13:14:33','1970-11-02 00:12:25'),
('93','15','Iusto sint accusantium dolores quaerat est atque qui. Ut ut placeat beatae aut est aut quia. Nam assumenda at dignissimos eum voluptatum ratione.',NULL,'1993-07-21 18:00:33','2017-05-26 18:03:33'),
('94','85','Expedita dicta a aut. Eveniet harum ut doloremque dolorem odit. Libero blanditiis ut molestiae. Similique eligendi ut placeat ipsam tempore sunt dolores voluptatibus.',NULL,'1973-10-18 01:01:04','2019-08-25 07:40:19'),
('95','11','Aut quod reprehenderit accusamus placeat ipsam. Nobis sequi rerum dolor asperiores. Libero quia velit pariatur eligendi alias voluptas non cum. Quia et quibusdam aut quaerat.',NULL,'1984-07-31 07:48:31','1998-04-16 10:27:59'),
('96','43','Ut voluptates impedit ab laborum. Vitae reiciendis itaque laudantium. Qui rerum ut quas saepe.',NULL,'1974-12-23 22:29:29','2010-05-13 21:59:44'),
('97','87','Suscipit minima nulla alias quaerat dolores beatae doloribus voluptatem. Porro doloribus qui facere corrupti ullam voluptas id. Tempore doloribus quia aperiam.',NULL,'2002-07-25 07:47:47','1995-04-20 15:49:13'),
('98','19','Officiis ratione neque quis suscipit dolorem magni. Animi at velit ullam magnam accusamus expedita vero. Optio omnis necessitatibus nesciunt temporibus excepturi. Eum pariatur vitae ut.',NULL,'1980-02-01 04:11:50','1971-12-01 13:12:07'),
('99','23','Sequi sint quidem optio et doloribus. Corporis minus sint quod repudiandae itaque saepe. Tempore et et eum ut natus. Est atque rerum dolorem tempora quis deserunt. Officiis qui praesentium dolor.',NULL,'1989-10-11 20:50:18','2000-08-26 16:17:00'),
('100','39','Necessitatibus numquam in voluptatibus consequatur. Voluptatem iure itaque quis cumque aut beatae. Error mollitia est facilis sit laudantium sed.',NULL,'2007-03-25 14:59:50','1971-10-05 08:59:09'); 


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `surname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `hometown` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `pass` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `phone` (`phone`),
  KEY `email_2` (`email`),
  KEY `name` (`name`,`surname`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` VALUES ('1','Brad','Hessel','gibson.karine@example.com','722','m','1993-06-13','quo','8','875ba1f75f7723c7a43379a04c20dbe3','1987-03-01 00:33:21'),
('2','Janessa','Schuppe','dedric36@example.net','1','f','2020-09-15','sit','5','8199ac9eba7bacd135636f1a1cf2dbb9','2014-09-12 02:16:28'),
('3','Rosario','Tromp','velda78@example.com','1','m','2017-07-08','ut','2','8bb4493cdb8a1989b3e258a3faa0d7d4','1996-12-27 18:42:14'),
('4','Marlene','Roob','mrogahn@example.net','358636','m','2014-10-14','rerum','7','b37a81459578314c99398ee764557b98','2017-09-04 04:30:49'),
('5','Jolie','Wunsch','myost@example.org','598','f','1999-10-16','sint','8','3f22da36ed90a27c8f0a4d8d9f182981','1973-04-09 09:10:18'),
('6','London','Leuschke','tiara.klein@example.com','1','f','2011-03-24','quas','1','275eae0e40ca173f6e677e0854a9593e','1984-09-19 14:41:52'),
('7','Sylvia','Turner','hansen.dangelo@example.org','0','m','2004-12-22','corrupti','8','1fa9b86fd1227858aebb59b3abe4e22d','1990-07-17 20:57:32'),
('8','Pascale','Eichmann','lizzie.mayer@example.net','0','f','2015-08-09','hic','0','8b0c07cd96c79a4d64c3c427c1cf7de5','1976-10-09 17:59:19'),
('9','Bryce','Watsica','gibson.zena@example.com','141066','m','2018-05-04','quo','2','593e430cd6a75905a2f55ab90db85bf2','1997-07-22 19:42:49'),
('10','Jovanny','Lebsack','devan.cartwright@example.net','0','m','2008-12-05','itaque','8','afca13741ea9f39b378837cda8b736de','1993-08-14 17:10:08'),
('11','Ollie','Cassin','ppadberg@example.com','0','m','2002-06-28','sapiente','5','2dd5384e593a0f2947d39c94318c354d','1980-04-03 14:29:40'),
('12','Erik','Schinner','tracy.kohler@example.net','1','f','2017-02-03','in','0','15cc4550f79b5483354fde02e68f38c9','1981-05-04 19:50:51'),
('13','Keyon','Davis','galtenwerth@example.org','0','f','1975-04-21','sit','7','ea3892a5db91b1baa83ba07406103856','2015-01-24 22:21:37'),
('14','Milan','Bergnaum','aletha.will@example.org','6345718646','f','1983-12-03','id','0','2a24f020ad0458728912644530781e06','2007-02-11 15:40:17'),
('15','Breanna','Spencer','fblick@example.net','43','f','1989-02-18','eligendi','0','9d5cf56e303d8d6216496a40728b17b7','2020-06-21 20:54:48'),
('16','Jesus','Stokes','sdare@example.com','259757','m','1979-02-21','ut','7','63e426c62c91a3f3d86942d089571d52','1996-10-28 19:27:24'),
('17','Freddy','Hirthe','cecelia.orn@example.net','0','f','2012-12-17','qui','4','e90702a4518044d9666601375ff46b1d','2014-12-25 08:04:12'),
('18','Milo','Harris','rhaley@example.net','1','m','1989-04-14','nulla','6','1068ee374a7f1b6c3eac8506d8c834e4','2000-02-19 17:00:38'),
('19','Beulah','Bosco','swift.tyshawn@example.org','0','f','2014-03-17','pariatur','0','affff41c07f32c2f81502ff55199768c','2008-11-01 08:52:07'),
('20','Llewellyn','Crona','araceli.ortiz@example.net','58469','f','2016-11-19','illo','7','240ea4618ae7fd71aa41653875e857a3','2015-11-13 16:12:13'),
('21','Celestino','Dare','cronin.julio@example.com','218098','m','1984-05-12','doloremque','0','c15ab78968f1da56c06d3bef2b7ad34b','2018-11-18 13:21:11'),
('22','Joshuah','Lesch','hhaag@example.org','812714','f','2017-07-02','officia','7','97bffb26135023111d8fc52ce3d61df0','2015-07-16 21:00:35'),
('23','Karli','Towne','cristopher.hauck@example.com','43','m','2016-07-01','quam','4','d2e0d35f4584ea176d897d1855a43888','2012-01-09 23:43:16'),
('24','Rocky','Greenfelder','auer.kade@example.org','308','m','1996-04-06','debitis','3','28d44b1f05c440b1d687e2d38e96b108','1984-02-21 12:20:02'),
('25','Kadin','Jerde','keebler.donnie@example.net','580','m','1991-03-11','voluptates','6','03e81ea69c89f2ae820f3ca1a20c0153','1979-10-09 21:53:51'),
('26','Enrico','Donnelly','wilton69@example.org','1','m','2003-08-25','eveniet','6','b30fea9c538d9f91a894f088973b3373','2013-03-20 12:44:54'),
('27','Miracle','Bauch','pcole@example.net','1','m','2010-04-06','sequi','2','75f6ea9f14eec9e76c52b4c945d9dd4e','1997-05-21 04:55:14'),
('28','Frankie','Rempel','fay.annamarie@example.net','6838711638','f','1993-12-21','consectetur','3','741a184151d39bd6b7e695832cc58966','1987-01-18 14:03:56'),
('29','Kristofer','Boehm','rolfson.emery@example.org','839169','m','1973-06-12','animi','7','039cb0fbe81dd0a8a448b606a4f48b67','1973-06-14 07:15:27'),
('30','Emilio','Kunze','tschuppe@example.org','67896','m','1996-08-25','possimus','4','4f6b660c0ca333844d1fef6d937f212b','1970-10-04 09:48:59'),
('31','Destini','Nolan','azemlak@example.net','0','m','2019-04-25','tenetur','1','66a6a50129d1447fa3e2324d1b12d0a4','1978-01-21 01:04:35'),
('32','Edgardo','Mante','alphonso25@example.com','675857','f','2003-06-27','alias','5','189f555b4e2100a4e65594c0a068fa95','1996-02-05 00:19:53'),
('33','Caroline','Heidenreich','will.mcdermott@example.org','1','m','2013-10-19','dolorum','9','3ebd30e34b49682a2eae60cb2008a12f','1999-03-31 07:45:37'),
('34','Dolly','Lubowitz','joshuah64@example.org','893260','m','1986-06-17','dolorum','6','1944c0d9dc5a70a6e206e6171e4ed37e','2002-10-29 22:12:02'),
('35','Edmond','Beahan','clebsack@example.net','206','f','1995-11-29','maiores','5','7af85096041fa4109c423cceb0021200','2006-03-06 20:27:11'),
('36','Korey','Kuhn','cassidy.runte@example.com','1127177670','m','2011-02-10','corrupti','0','57799c0b6ac9801895919db8a4e019c3','1996-11-18 19:26:46'),
('37','Asha','Hayes','gibson.kimberly@example.net','43','f','2001-02-20','qui','5','920d01d4dbc78f07e86916d5b14f62df','2007-06-21 16:15:49'),
('38','Gennaro','Bartoletti','katherine.littel@example.net','887','f','2008-10-20','laborum','3','37354d129981dd55cf7dd1ff59c62ba6','2011-04-30 14:07:41'),
('39','Christian','O\'Connell','johnson53@example.org','336','f','1973-07-28','quasi','1','63222698fe920b4d713a44a3fb827474','2007-05-03 09:11:07'),
('40','Emmy','Champlin','maida61@example.net','1','f','1970-09-03','quod','3','7cfe0f910118a0abde586f5f02a83c32','2003-10-28 20:19:00'),
('41','Mariah','Herman','mario.johns@example.com','1','f','1981-04-16','molestias','0','2328cb552b3341c1b2517c5bb18953b9','2012-09-27 09:26:28'),
('42','Stefanie','Graham','wreichel@example.org','4794893629','m','2017-07-08','doloribus','5','35422b4f9edf88bd6829eec23e62d19a','1990-10-08 01:32:01'),
('43','Pietro','McDermott','myrtis81@example.net','0','f','2006-02-12','id','8','641fbbe8cca1b31fe2962f22a4e861be','1985-10-12 11:56:35'),
('44','Lisa','Casper','madalyn60@example.org','790812','f','1990-05-31','velit','5','64f49d128c2696cc4b4148102b0c179e','1976-09-27 12:01:54'),
('45','Hoyt','O\'Kon','leon57@example.net','1','f','2014-08-23','autem','0','440ac93326cdedee463ba23bcafbe062','1988-09-03 14:42:02'),
('46','Brody','Hansen','eleonore.carroll@example.com','1','m','2017-09-04','quisquam','1','bd062015dca5ec05bdde67edab706231','1983-11-27 04:22:53'),
('47','Berneice','Sporer','muhammad26@example.org','0','m','2008-07-09','ut','6','bf63be09dd8e9741cd24635b1cedc541','1980-10-20 06:38:27'),
('48','Madisyn','Bartoletti','isabell44@example.com','0','f','1994-09-12','aut','4','45ee75e1e76065db66ab97466fdb9cd0','1995-09-12 00:18:06'),
('49','Martin','Turner','delphine25@example.net','0','m','2003-05-04','ut','2','0a6fec13bea239e9172f2f69713caae7','1985-08-14 11:41:20'),
('50','Deshaun','Davis','mraz.kattie@example.net','249663','f','2003-01-10','nostrum','9','dd06c37e5cb2ba2122f2c838115adb6b','1999-02-04 05:04:19'),
('51','Genevieve','Fadel','unique82@example.org','152','f','1983-03-28','nisi','2','051fa7f14e18dd1a91282a44201e2bfa','2016-06-13 18:02:09'),
('52','Michaela','Runolfsson','clair.ziemann@example.net','1','f','1985-04-26','quae','5','7527d834c671cc45fb62cfcaa521b200','2007-06-05 09:29:25'),
('53','Lukas','Simonis','rafael16@example.net','1','m','1983-03-15','maiores','5','ca3da5a577a8e597cd2905afc785bb55','1993-03-19 06:43:37'),
('54','Zane','Bartoletti','joberbrunner@example.net','678462','m','1975-06-28','ducimus','6','9c77789949d901a825d869679a232783','1985-03-06 10:14:42'),
('55','Solon','Satterfield','fernando.quitzon@example.com','240','m','2015-06-28','dolor','4','727d84c13cf451a233d235e37ef4e6ea','1992-05-29 08:01:13'),
('56','Aida','Ullrich','sanford.davon@example.net','1','m','2007-08-13','officia','5','75cb2297ac8130efc9dad43923dcb163','2004-05-16 16:42:47'),
('57','Joany','Hane','marta38@example.org','841','m','1989-08-17','aut','6','41ac718e5a8f5f4b05a23c9f08901a6f','1983-05-13 13:21:52'),
('58','Presley','Rempel','nstamm@example.com','0','m','2016-06-01','minus','9','a4793555b79a80525e074a4be2ed8b8e','2007-11-25 19:18:53'),
('59','Anika','Ondricka','lamar.ward@example.net','65','m','2012-08-19','ex','1','62a1408e32e2785e5945f576d60ff6f8','2014-10-31 13:40:28'),
('60','Evalyn','Shields','jo96@example.com','1','f','2010-11-03','saepe','2','0e0082f39df6396e64c1446db1dbb498','2002-05-12 16:07:34'),
('61','Kamron','Ryan','hwyman@example.org','0','f','2002-11-10','minus','8','8c75089a890f3bec30599db6b914c154','2000-07-16 09:15:52'),
('62','Maurice','Dickens','henriette89@example.org','678','f','2018-01-10','et','6','2a71403418486a7af310d5f26cd74555','2015-11-06 18:38:19'),
('63','Adrienne','Kunze','rohan.destinee@example.org','1','m','1994-11-07','nihil','2','0ebadfac6b822978c5bd50b827735761','2000-12-06 09:37:50'),
('64','Marilyne','Rolfson','aurelia.rolfson@example.org','881029','m','1994-03-03','et','4','fcaaf6ae711a23a2c5a8cf1cf3978ca7','2004-12-26 16:55:05'),
('65','Fredy','Hyatt','macejkovic.dimitri@example.com','1','f','1976-05-28','at','4','5f74031edabe2efa5af25162cbe70b39','1993-07-31 02:20:22'),
('66','Janick','Nitzsche','kkautzer@example.net','78','m','1999-12-27','ut','1','d632a7ca0cbc56d439febe3681ca021a','1996-12-08 11:54:50'),
('67','Bert','Mills','ilynch@example.net','0','m','1994-02-04','soluta','8','9e31c21e084a31a96f8de13e97f25640','1989-12-29 11:46:17'),
('68','Bonnie','Lubowitz','dejah97@example.com','1','m','2003-12-22','facere','5','0fa006239c53b4c6244728f132d85764','2015-08-10 21:05:21'),
('69','Harmon','Gutkowski','ofunk@example.org','87','m','2016-08-28','porro','0','7985167c365071d6724a1184ae10f6f0','2010-12-08 13:06:08'),
('70','Sandra','Ortiz','gibson.anissa@example.org','714','f','2014-04-27','id','1','e9d74578bce7da31547a9c8d5db6823f','1983-02-23 20:21:43'),
('71','Maeve','Hills','ohane@example.net','58','m','1998-05-08','consequatur','0','0c6047bb1eead3becf114e1065cd4e85','1995-09-08 11:25:44'),
('72','Kenneth','Muller','hegmann.elliott@example.org','0','f','1988-08-30','optio','9','c031f91503948eef80c1619df62c07e1','1997-08-20 05:58:35'),
('73','Modesta','Jacobs','wpollich@example.com','677','f','1990-11-08','quod','9','a1a55bba94b36639e0af6ef98482b39c','1971-01-09 00:02:59'),
('74','Kenyon','Nicolas','rolando98@example.com','0','f','1974-01-07','sint','4','86688d47159ea0defea35b648dcf2610','2009-08-21 02:23:19'),
('75','Milan','Stiedemann','tmacejkovic@example.net','1','m','1973-02-01','consequatur','1','ee23e93d0ce5e02b483fccb4b6436aaf','1982-04-16 10:35:27'),
('76','Maybell','Prohaska','ebba90@example.org','9121560465','m','1978-06-13','voluptas','6','4189cc03d5280c48de46bc5d810c1a1a','2009-12-12 02:23:42'),
('77','Alford','Price','rkemmer@example.com','1','m','1989-07-11','ipsam','3','7e4d5c2381592325f3eb7fd18ab5fa75','2016-07-05 11:05:09'),
('78','Dagmar','Swaniawski','esmeralda47@example.com','1','f','1984-01-04','sunt','3','e4945c066833bdd215262cfcdb4e6007','1994-11-20 09:12:03'),
('79','Karianne','O\'Connell','dkunze@example.com','1','m','2002-08-31','nihil','6','9405d079008684b571d3b8e85c1365f4','1977-03-08 20:08:29'),
('80','Ryley','Bergnaum','metz.dovie@example.com','7','m','1971-03-23','nihil','1','37c98d581d638744bae8417567a40c8f','1973-03-16 01:38:27'),
('81','Orlo','Boyer','martin.harvey@example.net','1','f','2015-06-27','sed','5','3538ac9720c22be467ad18037dc2f206','1979-08-25 02:52:33'),
('82','Bradford','Nolan','jfahey@example.net','0','m','1993-02-05','illum','3','66f6959a3cb955aa27f66d5f9650a2aa','1990-01-14 14:50:00'),
('83','Bernadette','Bergstrom','bmueller@example.com','624','m','1976-06-24','cum','1','5c441bcb686d5fd8438280458987d313','1992-10-21 08:17:06'),
('84','Cleve','Bauch','cvandervort@example.org','1','f','1979-06-01','doloribus','9','219c74f73632518de57c1aa1e95adf28','2018-03-19 16:39:04'),
('85','Arianna','Corkery','clarissa.gerhold@example.net','1','m','2018-12-20','a','8','af0f28711a2d1ebb79f588a73c0616e0','2001-02-20 16:00:06'),
('86','Norberto','Bergnaum','gene.price@example.org','13','m','2005-08-29','quasi','5','8873dd1aa5833225b19fab27d8ba3283','1994-03-29 19:55:03'),
('87','Stanley','Koss','ludwig.hills@example.net','0','f','1989-02-04','asperiores','9','a253e3497783324feab1b09558ed618a','2002-05-08 14:47:02'),
('88','Moises','Jenkins','pbuckridge@example.net','1','m','2007-08-25','perferendis','4','baa8f91a5217c1995dfa0d8c9a7c7c8a','1995-09-15 11:47:51'),
('89','Rebekah','Sawayn','cadams@example.org','0','f','2002-11-04','quis','4','f1dd818751ee4bcde1ed1fa17008b6ee','2005-09-12 03:11:01'),
('90','Sage','Willms','nborer@example.com','48599','f','1996-11-14','optio','1','a34954c42733c55d17e608c8331494f9','1993-07-18 19:08:46'),
('91','Davin','Romaguera','gwyman@example.net','1','f','1980-04-27','amet','1','a86ff637ff5d754f1ebc9c279600d80c','1997-03-22 13:29:52'),
('92','Daron','Considine','gaylord.salvatore@example.com','444697','f','2012-06-24','illum','4','edba5895a0a703ea0ba237e407554eec','2007-02-06 10:28:20'),
('93','Stacey','Cummerata','dorothy.grimes@example.net','0','f','1984-10-06','autem','0','2810213291827c25483f08f171cd6c1b','1983-10-10 23:57:21'),
('94','Alvina','Hackett','hwest@example.com','1','f','1982-06-04','cupiditate','8','273718717fceaa76c338e4ea11894e1f','2002-08-02 11:56:46'),
('95','Mathew','Schmidt','nkessler@example.org','892969','m','2006-05-13','quibusdam','6','42c78637ccce91583b74feb8957c3cac','1982-02-12 17:08:56'),
('96','Aliyah','Mohr','edwardo32@example.net','514820','f','1999-09-28','expedita','7','60973c3b6e216114f07c0e82b2cdd316','2016-02-10 00:13:15'),
('97','Mateo','Barrows','grayce76@example.net','1','f','1971-02-14','quae','8','a0c2b3ce765958f7148fe1217b791b7a','1980-04-09 12:46:14'),
('98','Rene','Lindgren','nora.christiansen@example.net','520','f','2016-09-10','suscipit','9','02efa4d15f1dcef4dfb4ec9ca8f9ead3','2015-03-06 19:06:43'),
('99','Thelma','Mertz','bonnie20@example.com','141','f','1970-08-28','et','1','405355edcc3b78c13d5f979db1800d64','1987-01-27 10:18:26'),
('100','Lew','Boehm','triston.ebert@example.org','33','f','1982-04-11','repudiandae','1','b35ca72b125adb8938fba0865a2a86be','1989-04-04 15:17:43'); 


DROP TABLE IF EXISTS `users_communities`;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users_communities` VALUES ('1','1','1'),
('2','9','0'),
('3','1','1'),
('3','9','1'),
('4','9','1'),
('4','10','0'),
('5','4','0'),
('8','4','1'),
('8','5','1'),
('9','9','1'),
('11','3','1'),
('12','3','1'),
('12','5','1'),
('13','2','1'),
('14','1','0'),
('14','3','0'),
('15','1','1'),
('15','7','1'),
('17','3','1'),
('18','1','1'),
('18','9','1'),
('25','1','1'),
('25','2','0'),
('26','7','0'),
('28','5','1'),
('28','9','0'),
('28','10','1'),
('29','8','0'),
('29','9','1'),
('30','9','0'),
('31','7','0'),
('31','10','0'),
('32','7','0'),
('33','7','1'),
('35','4','1'),
('37','2','0'),
('37','7','1'),
('38','5','0'),
('40','1','1'),
('40','8','0'),
('44','1','1'),
('44','10','1'),
('45','5','0'),
('47','6','1'),
('48','10','1'),
('49','2','1'),
('50','3','1'),
('50','6','1'),
('51','4','1'),
('53','4','0'),
('54','5','1'),
('54','6','0'),
('55','2','0'),
('55','3','0'),
('55','5','0'),
('56','6','0'),
('56','7','1'),
('60','4','1'),
('60','9','0'),
('63','5','1'),
('64','10','0'),
('65','1','1'),
('65','4','1'),
('69','1','1'),
('69','4','0'),
('70','1','0'),
('70','2','0'),
('70','5','0'),
('70','7','0'),
('72','3','0'),
('72','7','0'),
('75','3','1'),
('75','5','1'),
('76','9','1'),
('77','2','0'),
('78','1','0'),
('78','8','0'),
('79','1','0'),
('79','2','1'),
('79','5','1'),
('82','5','1'),
('82','8','1'),
('83','5','1'),
('87','5','0'),
('89','5','1'),
('89','6','0'),
('90','1','0'),
('91','6','1'),
('92','1','0'),
('93','5','0'),
('93','9','1'),
('94','6','1'),
('94','8','1'),
('95','7','0'),
('96','4','1'),
('97','1','0'); 

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;



-- CRUD (РґР°РЅРЅС‹Рµ)
-- create INSERT
-- read SELECT
-- update UPDATE
-- delete DELETE, TRUNCATE

-- INSERT... VALUES


INSERT INTO users (id, name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
(102,'РЎРµСЂРіРµР№','РЎРµСЂРіРµРµРІ','qwe@asdf.qw',123123123,'m','1983-03-21','РЎР°СЂР°С‚РѕРІ',NULL,'fdkjgsdflskdjfgsdfg142356214','2020-09-25 22:09:27.0');

INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass) values
('Р�СЂРёРЅР°','РљРёР№РєРѕ','cattack2@unc.edu',2139527247,'f','1986-05-22','РЎР°СЂР°С‚РѕРІ',NULL,'5f91ea663688cc873be65a6cc107f07da84664ae');

INSERT INTO users values
(101, 'Р’РёРєС‚РѕСЂРёСЏ','Р’РѕРґРѕРїСЊСЏРЅРѕРІР°','scasotti3@usgs.gov',4187011526,'f','1984-04-06','Р§РµР»СЏР±РёРЅСЃРє',NULL,'f93c320ee2275544eb1b42d8278133c343fa5030','2020-09-25 22:09:27.0');

INSERT INTO users (id,name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
(109,'Р”РјРёС‚СЂРёР№','РўРёРјР°С€РѕРІ','segginton4@cam.ac.uk',4513359033,'m','1984-06-19','РљР°Р·Р°РЅСЊ',NULL,'e6ab5f555555fb26c7c60ddd23c8118307804330','2020-09-25 22:09:27.0')
,(104,'Р’Р»Р°РґРёСЃР»Р°РІ','РђРІСЂР°РјРµРЅРєРѕ','aswaddle5@altervista.org',1874462339,'m','1987-07-07','РњРѕСЃРєРІР°',NULL,'b25e49362b83833eece7d225717f2e285213bf25','2020-09-25 22:09:27.0')
,(105,'РђР»РµРєСЃРµР№','Р’РµР»РёС‡РєРѕ','fleahey6@ftc.gov',2951798252,'m','1984-11-27','РљР°Р·Р°РЅСЊ',NULL,'07521436ef4b4ad464ed04cdceb99f422bbbd9c5','2020-09-25 22:09:27.0')
,(106,'РђСЂС‚РµРј','Р¤РёР»РёРїС†РѕРІ','rcasley7@exblog.jp',3237322265,'m','1984-08-04','РљСЂР°СЃРЅРѕРґР°СЂ',NULL,'5aac7b105729d4ad431db6a4e73604ecec132fa8','2020-09-25 22:09:27.0')
,(107,'Р•Р»РµРЅР°','РљРѕР»РґР°РµРІР°','rlantry8@pen.io',3731144657,'f','1989-08-07','РўСЋРјРµРЅСЊ',NULL,'ba6c51c3064c20f9de84d4ed69733d9dd408e504','2020-09-25 22:09:27.0')
,(108,'РђРЅРґСЂРµР№','РђРЅС‚РёРїРѕРІ','egoatcher9@behance.net',8774858608,'m','1984-09-04','РљСЂР°СЃРЅРѕСЏСЂСЃРє',NULL,'16f4e6ac1aedd2d9707b56d767f452f3246e67f7','2020-09-25 22:09:27.0');

-- INSERT ... SET

INSERT INTO users 
set
name='Р•РІРіРµРЅРёР№',surname='Р“СЂР°С‡РµРІ',email='dcolquita@ucla.edu',phone='9744906651',gender='m',birthday='1987-11-26',hometown='РћРјСЃРє',pass='1487c1cf7c24df739fc97460a2c791a2432df062';
	
-- INSERT ... select
-- insert communities select * from snet1.communities;
insert communities (name) select name from snet1.communities;


-- select
select * from communities;
select * from communities order by id; -- ASC СЃРѕСЂС‚РёСЂРѕРІРєР° РїРѕ РІРѕР·СЂР°СЃС‚Р°РЅРёСЋ, DESC СЃРѕСЂС‚РёСЂРѕРІРєР° РїРѕ СѓР±С‹РІР°РЅРёСЋ
select surname, name, phone from users;
select * from users limit 10;
select * from users limit 10 offset 10;
select * from users limit 3 offset 8; -- РёРґРµРЅС‚РёС‡РЅРѕ select * from users limit 8,3;
select concat(surname,' ',name) persons from users;
select concat(SUBSTRING(name,1,1), '. ',surname) persons from users;
select distinct hometown from users;

select * from users where hometown = 'Р§РµР»СЏР±РёРЅСЃРє';

select name,surname, birthday 
	from users where birthday >= '1985-01-01' 
	order by birthday;

select name,surname, birthday 
	from users where birthday >= '1985-01-01' and birthday <= '1990-01-01';

select name,surname, birthday 
	from users where birthday between '1985-01-01' and '1990-01-01';

select name,surname,hometown from users where hometown != 'РњРѕСЃРєРІР°';
select name,surname,hometown from users where hometown <> 'РњРѕСЃРєРІР°';

select name,surname,hometown from users where hometown in ('РњРѕСЃРєРІР°', 'РЎР°РЅРєС‚-РџРµС‚РµСЂР±СѓСЂРі', 'РќРёР¶РЅРёР№ РќРѕРІРіРѕСЂРѕРґ');

select name,surname,hometown from users 
	where hometown = 'РњРѕСЃРєРІР°'
	or hometown ='РЎР°РЅРєС‚-РџРµС‚РµСЂР±СѓСЂРі'
 	or hometown ='РќРёР¶РЅРёР№ РќРѕРІРіРѕСЂРѕРґ';

select name,surname,hometown, gender from users 
	where (hometown = 'РњРѕСЃРєРІР°' or hometown ='РЎР°РЅРєС‚-РџРµС‚РµСЂР±СѓСЂРі') and gender='m';

select name,surname from users where surname like 'РљРё%';
select name,surname from users where surname like '%РєРѕ';
select name,surname from users where surname like 'РљРё_РєРѕ';

select count(*) from users;
select min(birthday) from users;

select hometown, count(*) from users group by hometown;

select hometown, count(*) from users group by hometown having count(*) >=10;

-- UPDATE 
update friend_requests 
	set status = 'approved'
	where initiator_user_id = 1 and target_user_id = 2;
	
-- TRUCATE 
delete from communities where name = 'Р‘РёРѕР»РѕРіРёСЏ РєР»РµС‚РєРё';
set foreign_key_checks = 0;
delete from communities where id between 2 and 10;
delete from communities;
set foreign_key_checks = 1;

set foreign_key_checks = 0; -- РѕС‚РєР»СЋС‡Р°РµРј РІРЅРµС€РЅРёРµ РєР»СЋС‡Рё
truncate table communities;
set foreign_key_checks = 1;-- РІРєР»СЋС‡Р°РµРј РІРЅРµС€РЅРёРµ РєР»СЋС‡Рё

INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р вЂќР В°РЎР‚РЎРЉРЎРЏ','Р СџР С•Р С—Р С•Р Р†Р В°','rthomazinb@ox.ac.uk',8151557164,'f','1984-11-28','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'32afa0b02c8399d1960509c3fbd4cc75ab4dcce2','2020-09-25 22:09:27.0')
,('Р пїЅРЎР‚Р С‘Р Р…Р В°','Р вЂњР С•Р Р…РЎвЂЎР В°РЎР‚Р С•Р Р†Р В°','gambridgec@sakura.ne.jp',2907266453,'f','1984-08-24','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'afd3e457d3b9f6f880623163ea8f72889777a58b','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘Р Р…Р В°','Р вЂ”Р В°Р С”РЎС“РЎРѓР С‘Р В»Р С•Р Р†Р В°','mantosikd@tinypic.com',5949091863,'f','1981-04-16','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'9154186410a62369bdf4fd2bd632ca3511b270a7','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р СњР В°Р С–Р С‘Р Р…Р В°','rtabere@admin.ch',6966471579,'f','1988-08-10','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'9bc443a6e52541784d52b69acc39343526886b11','2020-09-25 22:09:27.0')
,('Р вЂ™Р В°Р В»Р ВµРЎР‚Р С‘РЎРЏ','Р СџР В»Р В°РЎвЂљР С•РЎв‚¬Р С”Р С‘Р Р…Р В°','ckendellf@bloglines.com',1078902682,'f','1980-01-07','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'229aedb0a417bccab3ee0cbd89a4b1afaa080c51','2020-09-25 22:09:27.0')
,('Р РЋРЎвЂљР В°Р Р…Р С‘РЎРѓР В»Р В°Р Р†','Р РЋР Р†Р ВµРЎвЂљР В»РЎРЏР С”Р С•Р Р†','amckeandg@behance.net',9642922963,'m','1984-05-19','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'584b9241b06cfe87131bfdba7b53e877ec3bd940','2020-09-25 22:09:27.0')
,('Р пїЅРЎР‚Р С‘Р Р…Р В°','Р В§Р ВµРЎР‚Р Р…Р С‘Р С”Р С•Р Р†Р В°','csantryh@mit.edu',3118473791,'f','1982-10-20','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'129797dcb95127ce0541faa8d91d8f1969da0f45','2020-09-25 22:09:27.0')
,('Р С’Р В»Р С‘РЎРѓР В°','Р вЂ”Р В°Р в„–РЎвЂ Р ВµР Р†Р В°','dharcasei@dailymotion.com',4568198247,'f','1989-04-03','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'ea63b484704b7a8316da4025260b864453adb948','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р вЂ”Р В°РЎРѓРЎвЂљРЎР‚Р С•Р В¶Р Р…Р С•Р Р†Р В°','drouthamj@senate.gov',9259428337,'f','1983-05-07','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'9b1f31426e9caf75d46b9b4a7c58c1941daa33f0','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р пїЅРЎР‚Р С‘Р Р…Р В°','Р РЋРЎС“РЎв‚¬Р С”Р С•Р Р†Р В°','eshetliff0@virginia.edu',9442875153,'f','1984-12-19','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'9d0f9f7cdbe467af211a5d5bc91e2e16da891521','2020-09-25 22:09:27.0')
,('Р С’Р Р…Р Р…Р В°','Р вЂ�Р В°Р Р†РЎвЂ№Р С”Р С‘Р Р…Р В°','ldeguara1@bing.com',6774820315,'f','1982-04-19','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'3866567f83079af02f517913d98a34e8a5514111','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘Р Р…Р В°','Р С™Р С‘РЎР‚Р ВµР ВµР Р†Р В°','cdominick2@cnn.com',4056088011,'f','1984-04-26','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'37cda6f77b46bb92ebfea535bdd89d6a145ee28a','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р СљР С‘РЎвЂ¦Р В°Р в„–Р В»Р С•Р Р†Р В°','dbydaway3@hugedomains.com',2159168663,'f','1980-02-08','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'340287d956987900a051e920136b2c1c17351321','2020-09-25 22:09:27.0')
,('Р вЂєРЎР‹Р В±Р С•Р Р†РЎРЉ','Р В§Р С‘Р В»Р С‘Р С”Р С•Р Р†Р В°','hpullin4@state.gov',2619617364,'f','1983-11-22','Р СћР С•Р В»РЎРЉРЎРЏРЎвЂљРЎвЂљР С‘',NULL,'d4a54226f86124d38f463d60c3658a32be191e0e','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р РЋР ВµР В»Р С‘Р Р†Р В°Р Р…Р С•Р Р†Р В°','lhulme5@tamu.edu',1315489478,'f','1982-03-27','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'4cbd30f625fd3440804baf6f509246e8ff81d46b','2020-09-25 22:09:27.0')
,('Р РЋР ВµРЎР‚Р С–Р ВµР в„–','Р вЂєР С‘РЎРѓР С•Р Р†Р С•Р в„–','ngrzesiak6@blogspot.com',1253462931,'m','1988-08-03','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'89d65795895ed1c2f48114474ef37c92e1796dee','2020-09-25 22:09:27.0')
,('Р СљР С‘РЎвЂ¦Р В°Р С‘Р В»','Р СњР В°Р В·Р В°РЎР‚РЎРЉР ВµР Р†','ewathall7@slate.com',8696039405,'m','1984-06-06','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'011af674acb2a19440bb6a013d33dd9a231d53a4','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р СљР ВµРЎвЂљР В»Р С‘РЎвЂ Р С”Р С‘Р в„–','epindar8@oracle.com',2981339919,'m','1980-04-24','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'e3e589b0cc498fb982ed1cbae5d20d3766e97b36','2020-09-25 22:09:27.0')
,('Р В­Р В»РЎРЉР Р†Р С‘РЎР‚Р В°','Р вЂ�Р ВµР В»Р С•РЎС“РЎРѓР С•Р Р†Р В°','jdelacoste9@chicagotribune.com',4051023201,'f','1987-12-19','Р В§Р ВµР В»РЎРЏР В±Р С‘Р Р…РЎРѓР С”',NULL,'2def62b6a77064a15b157222f1b43bb538a0293e','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р вЂ™Р В»Р В°РЎРѓР С•Р Р†Р В°','sdowgilla@salon.com',7146665929,'f','1984-04-11','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'eb7fabdc4b4f70445a27467544e2a742dfad7bbb','2020-09-25 22:09:27.0')
,('Р В®РЎР‚Р С‘Р в„–','Р вЂ™Р С•Р В»РЎвЂЎР С”Р ВµР Р†Р С‘РЎвЂЎ','mhouchenb@jalbum.net',5826283675,'m','1981-10-15','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'1e65c000a98a92396d4ef31ec8d7740cbf578830','2020-09-25 22:09:27.0')
,('Р вЂўР Р†Р С–Р ВµР Р…Р С‘Р в„–','Р вЂ™Р С•Р В»РЎвЂ№Р Р…Р С”Р С‘Р Р…','rcogarc@storify.com',9707035248,'m','1981-03-19','Р РЋР В°РЎР‚Р В°РЎвЂљР С•Р Р†',NULL,'3627f911a7a4141f007ff0d25aa85f061f734742','2020-09-25 22:09:27.0')
,('Р вЂ™Р В»Р В°Р Т‘Р С‘Р С�Р С‘РЎР‚','Р вЂ™Р С•РЎР‚Р С•Р В±РЎРЉР ВµР Р†','gbartold@guardian.co.uk',8788528067,'m','1980-06-23','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'0be3ef277eac3ac46d547b579848cea67e075952','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р вЂєР С•Р С—РЎС“РЎвЂ¦Р С•Р Р†','dcuffline@harvard.edu',7107508285,'m','1983-11-03','Р СњР С‘Р В¶Р Р…Р С‘Р в„– Р СњР С•Р Р†Р С–Р С•РЎР‚Р С•Р Т‘',NULL,'5d3e5e579aa758ea28c1f53a6de174ee1f714701','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р вЂєР С•РЎвЂ¦Р С�Р В°РЎвЂЎР ВµР Р†Р В°','ctymf@uiuc.edu',6146928162,'f','1980-01-23','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'f89b2d6443e511fd742d16a5404b19d541f89f10','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С–Р В°РЎР‚Р С‘РЎвЂљР В°','Р С›Р Р†РЎвЂЎР С‘Р Р…Р Р…Р С‘Р С”Р С•Р Р†Р В°','vshelveyg@census.gov',5013560236,'f','1981-05-20','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'14aac374085e2782a8f1510f1bf49722b040731c','2020-09-25 22:09:27.0')
,('Р вЂ™РЎРЏРЎвЂЎР ВµРЎРѓР В»Р В°Р Р†','Р СџР С•Р С–Р С•РЎР‚Р ВµР В»РЎРЉРЎРѓР С”Р С‘Р в„–','sworboyh@about.me',6068012327,'m','1988-01-05','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'5530cf46cf0b1b5e787723e83012f93a5cd6b832','2020-09-25 22:09:27.0')
,('Р вЂ™Р В»Р В°Р Т‘Р С‘Р С�Р С‘РЎР‚','Р СџР С•Р В»Р С‘РЎвЂ°РЎС“Р С”','cmayhoi@xrea.com',6081230164,'m','1987-10-25','Р В Р С•РЎРѓРЎвЂљР С•Р Р†-Р Р…Р В°-Р вЂќР С•Р Р…РЎС“',NULL,'7ee4a9f5be784f551cfcb2d23698bc31b4e4069f','2020-09-25 22:09:27.0')
,('Р пїЅР С–Р С•РЎР‚РЎРЉ','Р СћР С•Р С”Р В°РЎР‚Р ВµР Р†','jromushkinj@census.gov',8843970434,'m','1985-07-08','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'a430faa2a1494af65cfa7cd72a7f46e1fad301c6','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р вЂўР Р†Р С–Р ВµР Р…Р С‘Р в„–','Р СћРЎС“РЎР‚Р В±Р С‘Р Р…','npesselk@buzzfeed.com',6414312198,'m','1987-08-18','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'1fa46ebf47f51c03b98c8379934b4b0182853ec3','2020-09-25 22:09:27.0')
,('Р С’Р Р…Р Р…Р В°','Р С™Р С•Р В»РЎвЂљР В°Р С”Р С•Р Р†Р В°','nhackettl@omniture.com',9059884608,'f','1989-03-04','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'e59558fde6118d3eb58c5b624bedf28b41da0ac7','2020-09-25 22:09:27.0')
,('Р СљР В°Р С”РЎРѓР С‘Р С�','Р СџР С•Р С—Р С•Р Р†','cwillimentm@livejournal.com',6549392162,'m','1989-05-01','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'1bc1a0536d38b6216b74a2819436ba0a925206c8','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р В§Р ВµРЎР‚Р ВµР С—Р Р…Р С‘Р Р…Р В°','civensn@deliciousdays.com',8361146361,'f','1982-04-09','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'47c16b5079e4409b613bcedfe75fcfa8c486963f','2020-09-25 22:09:27.0')
,('Р С’Р Р…Р Т‘РЎР‚Р ВµР в„–','Р СљР С•РЎв‚¬Р С”Р С‘Р Р…','rbrougho@elegantthemes.com',7586396136,'m','1980-04-06','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'ebb1057b6e438535963f3706ba15dd6a2df8926b','2020-09-25 22:09:27.0')
,('Р вЂўР Р†Р С–Р ВµР Р…Р С‘Р в„–','Р вЂ�РЎС“РЎвЂЎР Р…Р ВµР Р†','aandersenp@cisco.com',8482399498,'m','1982-01-29','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'9aeec57f845984b9ec57d44acd8d4990b2f21824','2020-09-25 22:09:27.0')
,('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р С™РЎР‚Р ВµРЎвЂљР С‘Р Р…Р С‘Р Р…Р В°','anorquoyq@home.pl',5605843880,'f','1989-07-09','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'b1ac483a02563c28d48284145535076aa39931ab','2020-09-25 22:09:27.0')
,('Р СџР В°Р Р†Р ВµР В»','Р СћРЎР‚РЎС“Р Р…РЎвЂљР В°Р ВµР Р†','bferrieresr@amazon.co.jp',8608680584,'m','1986-03-07','Р Р€РЎвЂћР В°',NULL,'e430a8c6a2f7272b9e5f295a7ecac609555be589','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р СџР ВµРЎвЂЎР ВµР Р…Р С”Р С‘Р Р…Р В°','soffilers@biblegateway.com',1682297034,'f','1987-03-26','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'8ac622757e94e702a3798d851b21d6d1d3ee5450','2020-09-25 22:09:27.0')
,('Р СљР С‘РЎвЂ¦Р В°Р С‘Р В»','Р ТђРЎР‚Р С‘Р С—Р С”Р С•Р Р†','srobilartt@wix.com',4765849891,'m','1987-02-04','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'44c2349e85e97eda950d824a82ab37c2da75bf92','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р С›Р В»РЎРЉР С–Р В°','Р В§Р ВµРЎР‚Р Р…Р С‘Р С”Р С•Р Р†Р В°','adabbotdoyleu@latimes.com',3659256004,'f','1980-07-25','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'151acd87edd4c6d68ce4a92bc846f2abeae49b8e','2020-09-25 22:09:27.0')
,('Р СљР В°Р С”РЎРѓР С‘Р С�','Р вЂ�Р В°РЎвЂ¦РЎвЂљР ВµРЎР‚Р ВµР Р†','gmedlerv@desdev.cn',7849899275,'m','1986-12-27','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'4613c2845f696b03d37b801e0cdab710fb6beaea','2020-09-25 22:09:27.0')
,('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р СџР С•Р С—Р С•Р Р†Р В°','pschonfelderw@icio.us',9788815521,'f','1989-01-09','Р СњР С‘Р В¶Р Р…Р С‘Р в„– Р СњР С•Р Р†Р С–Р С•РЎР‚Р С•Р Т‘',NULL,'3a4548bbbbed1c9d604750295dd22b34b706427f','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘Р Р…Р В°','Р РЋР Р†Р С‘РЎР‚Р С‘Р Т‘Р С•Р Р†Р В°','klilleyx@ftc.gov',7449749232,'f','1982-12-26','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'07dc7b613035be338b2d299bf481d9ced8731129','2020-09-25 22:09:27.0')
,('Р РЋР ВµРЎР‚Р С–Р ВµР в„–','Р В¦РЎС“РЎР‚Р С”Р В°Р Р…Р С•Р Р†','dtribey@foxnews.com',9461404246,'m','1985-07-24','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'4f2d890e00efe71d86b23d64aa3ab7c7f6c2262b','2020-09-25 22:09:27.0')
,('Р С’Р В»Р В»Р В°','Р СћР С•Р В»Р С�Р В°РЎвЂЎР ВµР Р†Р В°','alukockz@google.co.jp',5057501481,'f','1984-08-18','Р С›Р С�РЎРѓР С”',NULL,'cd21e4ceb76f06cbe1d3ecd30345701dfc01f28c','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р РЋРЎС“Р Р†Р С•РЎР‚Р С•Р Р†','acorrington10@barnesandnoble.com',2034001863,'m','1984-08-12','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'7fe1c2e54c91bb20754abe19f3633ecb294f69ce','2020-09-25 22:09:27.0')
,('Р вЂ™Р С‘РЎвЂљР В°Р В»Р С‘РЎРЏ','Р вЂ�РЎР‚Р ВµР Т‘Р С‘РЎвЂ¦Р С‘Р Р…Р В°','lradbourn11@diigo.com',5033419317,'f','1988-09-01','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'a1313b86956b58564bf1bc069cfdeaec107b235b','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р вЂ�РЎС“Р С�Р В°Р С”Р С•Р Р†Р В°','hdudeney12@digg.com',6621801231,'f','1987-01-10','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'b29ff9bce316ab42dfe8b8ae997b551fd05ba3a4','2020-09-25 22:09:27.0')
,('Р вЂњР В°Р В»Р С‘Р Р…Р В°','Р СљР В°Р С”РЎРѓР С‘Р С�Р С•Р Р†Р В°','bpressnell13@cargocollective.com',9315587169,'f','1988-05-14','Р Р€РЎвЂћР В°',NULL,'3f88873d6babca57eb1c5371be6a431c415c6ae5','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р вЂўР Р†Р С–Р ВµР Р…Р С‘РЎРЏ','Р СљР ВµР В»РЎРЉРЎвЂЎР ВµР Р…Р С”Р С•','gtaber14@ask.com',2634109732,'f','1981-07-24','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'af711421307bf3ea53e2a1fd5c7cdc47bc0464d4','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р СџР ВµРЎР‚Р ВµРЎРѓР В»Р В°Р Р†РЎвЂ Р ВµР Р†Р В°','harchell15@businessinsider.com',9437670910,'f','1985-08-23','Р С›Р С�РЎРѓР С”',NULL,'6da0975df3909e3928a20d54fbbca3c0361ff060','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р РЋР С‘РЎвЂљР В°Р В»Р С•','ssullly16@umn.edu',2822890926,'f','1988-02-03','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'e02ed0156bcadbc65c407e4f6d0c907449dcfb49','2020-09-25 22:09:27.0')
,('Р пїЅРЎР‚Р С‘Р Р…Р В°','Р С’Р Р…Р С‘РЎРѓР С‘Р С�Р С•Р Р†Р В°','ndunkerly17@elpais.com',6667018887,'f','1989-11-15','Р СњР С‘Р В¶Р Р…Р С‘Р в„– Р СњР С•Р Р†Р С–Р С•РЎР‚Р С•Р Т‘',NULL,'e08d50568524e1712fd178b2d453eccaec3497d9','2020-09-25 22:09:27.0')
,('Р СњР В°РЎвЂљР В°Р В»РЎРЉРЎРЏ','Р вЂќР С•Р С�Р В°РЎР‚Р ВµР Р†Р В°','bbass18@cloudflare.com',4094890532,'f','1985-09-18','Р Р€РЎвЂћР В°',NULL,'52bb52432e2afd23c8da1f5587ba6dcfc5321b3e','2020-09-25 22:09:27.0')
,('Р пїЅРЎР‚Р С‘Р Р…Р В°','Р РЋР С‘Р Т‘Р ВµР В»РЎРЉР Р…Р С‘Р С”Р С•Р Р†Р В°','hrivett19@nyu.edu',3198003378,'f','1988-03-18','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'ecabdafeec47fe7ae2303f3482e875ec47a504aa','2020-09-25 22:09:27.0')
,('Р пїЅРЎР‚Р В°Р С‘Р Т‘Р В°','Р вЂ™Р С•РЎР‚Р С•Р Р…РЎР‹Р С”','bpiggen1a@networkadvertising.org',6147416992,'f','1983-04-04','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'efaf246cf8b3e0fe4795e9a6bc33e852dcf76bb2','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р С’Р В·Р В°РЎР‚Р С•Р Р†Р В°','epiers1b@constantcontact.com',5283489590,'f','1983-10-13','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'c7f7a47fbda0cd6cd1e0d34265521b26dd561592','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘РЎРЏ','Р вЂўРЎвЂћР С‘Р С�Р С•Р Р†Р В°','mizod1c@1und1.de',9077450643,'f','1988-06-04','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'2cddeecac91feeb2f03c5b2eb5a0cda8407bf25b','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р С™Р С•Р Р…Р Т‘РЎР‚Р В°РЎвЂљРЎРЉР ВµР Р†Р В°','iwhetnell1d@kickstarter.com',4854790930,'f','1981-07-19','Р Р€РЎвЂћР В°',NULL,'1e570efd00e3262785cf1dcd9eb0dc4ecb6a213d','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р В®Р В»Р С‘РЎРЏ','Р С™Р С•РЎРѓР В°РЎР‚Р ВµР Р†Р В°','clamonby1e@boston.com',5239735195,'f','1987-11-04','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'659c44b7d1deec5ba15d5c2a24345a655f536cf8','2020-09-25 22:09:27.0')
,('Р пїЅРЎР‚Р С‘Р Р…Р В°','Р вЂєР В°Р С”Р С•Р С�Р С•Р Р†Р В°','ssimeons1f@scribd.com',8902784216,'f','1981-11-11','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'b48da6b9f87aa771566ab1d75cb69081105f6a50','2020-09-25 22:09:27.0')
,('Р С’Р Р…Р Р…Р В°','Р СџР С•Р В»РЎС“РЎРЊР С”РЎвЂљР С•Р Р†Р В°','lroggerone1g@engadget.com',8414878509,'f','1981-10-20','Р Р€РЎвЂћР В°',NULL,'2d10eec8cdac3f29976908c3efa65aed77028732','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р СњР С‘Р С”РЎС“Р В»Р С‘Р Р…Р В°','astandfield1h@themeforest.net',9347973825,'f','1989-09-28','Р С›Р С�РЎРѓР С”',NULL,'8113bb2b1039acc5d314fb74840c11963c2d0671','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р СљР В°Р С”РЎРѓР С‘Р С�Р ВµР Р…Р С”Р С•','educkit1i@globo.com',4777653528,'f','1987-11-29','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'49c2e20c7e932772449c133770fcb6fababacdae','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р С’РЎРѓР ВµР ВµР Р†Р В°','khudless1j@oakley.com',9035161534,'f','1989-05-27','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'5009a649664092e862d0eaaf055391e453889bbb','2020-09-25 22:09:27.0')
,('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р РЃР С‘Р С—Р С‘Р В»Р С•Р Р†Р В°','msandiland1k@unesco.org',4366159925,'f','1984-11-30','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'94b83db9e43e7aed7fa9bcf13adc71aa179f89cb','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р Р‡Р Р…Р С”Р С•Р Р†Р В°','mtrevers1l@amazon.com',7266747785,'f','1988-11-26','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'2cee62ceb700cc6f95e628d60a75b17b1732ef65','2020-09-25 22:09:27.0')
,('Р вЂўР Р†Р С–Р ВµР Р…Р С‘Р в„–','Р С™РЎР‚Р В°РЎРѓР В°Р Р†Р С‘Р Р…','uruffle1m@free.fr',7366490172,'m','1984-10-16','Р В Р С•РЎРѓРЎвЂљР С•Р Р†-Р Р…Р В°-Р вЂќР С•Р Р…РЎС“',NULL,'b02744a3459bf40c24434c311c7028547ad70889','2020-09-25 22:09:27.0')
,('Р С’Р Р…Р Р…Р В°','Р Р‡Р Р…РЎРЉРЎв‚¬Р С‘Р Р…Р В°','lpetruskevich1n@statcounter.com',8016989162,'f','1984-11-18','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'3314213f61429d374db27ef36b8caf681f649050','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р СњР В°РЎвЂљР В°Р В»РЎРЉРЎРЏ','Р СљР С‘РЎР‚Р С•Р Р…Р ВµР Р…Р С”Р С•','awinnett1o@hao123.com',5606350937,'f','1986-07-13','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'012724188466775fd1b41ce9803a36dca24a63b6','2020-09-25 22:09:27.0')
,('Р вЂєРЎР‹Р Т‘Р С�Р С‘Р В»Р В°','Р вЂќР В°Р Т‘Р С•Р Р…Р С•Р Р†Р В°','bfurphy1p@nifty.com',9375852898,'f','1982-06-07','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'9f3614ed85067d90f9a882975f6a8d4dfc3f43df','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р СљР С•РЎР‚Р Т‘Р В°РЎРѓР С•Р Р†Р В°','sstemp1q@theglobeandmail.com',6523490247,'f','1981-01-16','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'44ffb111616d23edfc480f0639b63d4d065147aa','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р В РЎвЂ№Р В¶Р С”Р С•Р Р†Р В°','gmazin1r@fotki.com',5301390113,'f','1986-06-25','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'c5e9fcc1e5c3991df06be270bdc1ccb4cd8c5ac1','2020-09-25 22:09:27.0')
,('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р вЂ�Р С•Р С–Р С•Р С�Р С•Р В»Р С•Р Р†Р В°','lkrale1s@google.com.br',8271364242,'f','1982-03-10','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'99d6158bc261ca00d6dcf348dbf9ea368a1ae46b','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘Р Р…Р В°','Р вЂњР С•Р В»Р С•РЎвЂ°Р В°Р С—Р С•Р Р†Р В°','ojosefs1t@shinystat.com',3192842536,'f','1988-06-07','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'7ba41712fe6615ae0cf36ee45daf697ccb143563','2020-09-25 22:09:27.0')
,('Р пїЅР Р…Р Р…Р В°','Р вЂќР С‘Р В±РЎвЂ Р ВµР Р†Р В°','apietesch1u@marketwatch.com',4447992090,'f','1986-12-17','Р В Р С•РЎРѓРЎвЂљР С•Р Р†-Р Р…Р В°-Р вЂќР С•Р Р…РЎС“',NULL,'3d7d5ac699eef8151fe1b7bfd533a321b56bb59d','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р СџР С•Р С—Р С•Р Р†','lgow1v@example.com',7897075774,'m','1981-08-23','Р В Р С•РЎРѓРЎвЂљР С•Р Р†-Р Р…Р В°-Р вЂќР С•Р Р…РЎС“',NULL,'176936e9534c8e4b7fa4e2823745770ee0b64880','2020-09-25 22:09:27.0')
,('Р вЂњР В°Р В»Р С‘Р Р…Р В°','Р В РЎС“Р С”Р В°Р Р†Р С‘РЎвЂ РЎвЂ№Р Р…Р В°','cmarte1w@globo.com',2396829153,'f','1986-03-14','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'e396e8928248b9331ee11b9c0c5a4653d6ad2fad','2020-09-25 22:09:27.0')
,('Р СњР С‘Р С”Р С‘РЎвЂљР В°','Р В РЎвЂ№Р С”РЎС“Р Р…Р С•Р Р†','lruddock1x@wikimedia.org',8866042922,'m','1981-09-03','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'5750b294231512ca402800e4eef400036e08507d','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р С’Р Р…Р В°РЎРѓРЎвЂљР В°РЎРѓР С‘РЎРЏ','Р В РЎвЂ№Р С”РЎС“Р Р…Р С•Р Р†Р В°','jscirman1y@about.me',9518059825,'f','1989-06-12','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'deb3e4b9c818260e9adf17b225f45234390713cf','2020-09-25 22:09:27.0')
,('Р В®РЎР‚Р С‘Р в„–','Р РЋР В°Р В±Р В»Р С‘Р Р…','tkitchingman1z@omniture.com',9061846141,'m','1988-02-24','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'dc4a7a560f689bf62ddc9aa22bbd64becceffca6','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р РЋР В°Р С�РЎРѓР С•Р Р…Р С•Р Р†','mlangman20@biblegateway.com',6284148195,'m','1981-07-20','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'3b802df74686705a1d5ed6c253b0d588bb02103c','2020-09-25 22:09:27.0')
,('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р РЋР С•Р С”Р С•Р В»Р С•Р Р†Р В°','jtuff21@yandex.ru',6686191671,'f','1984-09-14','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'32800bf3d9a44c1e74c4c697989d4d265c100716','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р С’РЎвЂћР В°Р Р…Р В°РЎРѓРЎРЉР ВµР Р†Р В°','dtidbold22@forbes.com',4804069885,'f','1987-05-15','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'fb762d0873e171610eace7e45c4728888990524d','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р вЂ�Р С•Р В»Р С–Р С•Р Р†','hspivie23@artisteer.com',9391944702,'m','1987-11-26','Р С›Р С�РЎРѓР С”',NULL,'581e202c66b30b0c2382af4e8d3eac3c831d0ddd','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р вЂќРЎР‚Р ВµР Р†Р В°Р В»РЎРЉ','dsimkiss24@youtu.be',8197243501,'m','1983-01-19','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'6b1258bd81342cb6d68ecb3b2fbeeba913bf70f3','2020-09-25 22:09:27.0')
,('Р СљР В°Р С”РЎРѓР С‘Р С�','Р вЂќРЎС“Р В±Р В°РЎвЂљР С•Р Р†Р С”Р С‘Р Р…','ttichelaar25@i2i.jp',1835522933,'m','1985-10-13','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'0e903f53c20657667ee04e67eba9bf70d13e8248','2020-09-25 22:09:27.0')
,('Р РЋР ВµРЎР‚Р С–Р ВµР в„–','Р СџРЎР‚Р С•РЎРѓРЎвЂљР В°Р С”Р С•Р Р†','vbyard26@dedecms.com',3912001914,'m','1980-03-11','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'e0d1f2c5ea78335ecc106a2d371616cedfc21505','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР В°Р Р…Р Т‘РЎР‚','Р СџР С•Р Р…Р С•Р С�Р В°РЎР‚Р ВµР Р†','lduigenan27@list-manage.com',9018710320,'m','1986-12-08','Р РЋР В°РЎР‚Р В°РЎвЂљР С•Р Р†',NULL,'8b8123b5ccb6aa6c06dbda8c75f91f62f44d5fe3','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р С’Р Р…Р Т‘РЎР‚Р ВµР в„–','Р С™Р С•РЎРѓРЎРЏР С”Р С•Р Р†','svery28@nsw.gov.au',1155125246,'m','1981-11-12','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'965cbe4558dce829055d547a3866f7d982997940','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р С™Р С•РЎРѓРЎРЏР С”Р С•Р Р†','slitzmann29@timesonline.co.uk',4947082181,'m','1983-03-05','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'460c92435c10f0ae5c3bb7596bc3ed757cbee69f','2020-09-25 22:09:27.0')
,('Р вЂєРЎР‹Р Т‘Р С�Р С‘Р В»Р В°','Р РЋР С”Р В°Р В±Р В°','jgiacomini2a@youtu.be',1236239169,'f','1989-01-28','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'a1cc4ab2add1ed470fa93495ece29978a51f8c00','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р РЋР С�Р С•Р В»РЎРЉРЎРЏР Р…Р С‘Р Р…Р С•Р Р†','edurston2b@google.ca',2249473665,'m','1987-10-17','Р СћР С•Р В»РЎРЉРЎРЏРЎвЂљРЎвЂљР С‘',NULL,'1976170ea8cb1a94b5572e5e67baad29c1a569fa','2020-09-25 22:09:27.0')
,('Р вЂ™РЎРЏРЎвЂЎР ВµРЎРѓР В»Р В°Р Р†','Р вЂќР С•Р С—Р С—Р ВµРЎР‚РЎвЂљ','kfoulks2c@sphinn.com',8301549057,'m','1981-10-02','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'5de1843e1bce099134f41d1522c17363245fc778','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р РЋРЎвЂљРЎР‚РЎвЂ№Р С–Р С‘Р Р…Р В°','jboken2d@wordpress.com',1086531264,'f','1988-05-04','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'deddfab8a1ec0d8b3395b3d692ddae01aafcfc22','2020-09-25 22:09:27.0')
,('Р РЋР ВµРЎР‚Р С–Р ВµР в„–','Р С’Р Р…Р С‘РЎРѓР С‘Р С�Р С•Р Р†','gcottage2e@prlog.org',5525263441,'m','1982-03-13','Р РЋР В°РЎР‚Р В°РЎвЂљР С•Р Р†',NULL,'e6582cbf8420fc471078f4e118fade0afb9830eb','2020-09-25 22:09:27.0')
,('Р вЂ™РЎРЏРЎвЂЎР ВµРЎРѓР В»Р В°Р Р†','Р вЂњР В°Р С�Р С•Р Р†','hstrotone2f@devhub.com',7393531761,'m','1982-11-10','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'4fdd2cbb6dfa134449dc7c0186f8ab86c56058f2','2020-09-25 22:09:27.0')
,('Р В®РЎР‚Р С‘Р в„–','Р вЂќР С•Р Р†Р С”Р В°','vtremmel2g@ed.gov',6139086790,'m','1980-01-29','Р РЋР В°РЎР‚Р В°РЎвЂљР С•Р Р†',NULL,'c2230720a13c0dbe4123d982a09fdfb421d85ae1','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР В°Р Р…Р Т‘РЎР‚','Р С™Р В°Р В»Р С‘Р Р…Р С‘Р Р…','jcarlesso2h@google.co.jp',3392340667,'m','1982-10-29','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'1e32b1e9e9066c24064cafebf9ed40aaf3aa647b','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р СњР С‘Р С”Р С•Р В»Р В°Р в„–','Р СџР С‘Р Р†Р С•Р Р†Р В°РЎР‚Р С•Р Р†','mrucklidge2i@amazon.co.jp',7988872107,'m','1988-05-20','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'204b2aedb33e12cdf4a3a0e9737e945870b17081','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р СћР С‘Р С�Р С•РЎв‚¬Р ВµР Р…Р С”Р С•','aprydie2j@vistaprint.com',6741632937,'m','1989-09-17','Р РЋР В°РЎР‚Р В°РЎвЂљР С•Р Р†',NULL,'ce449325f74a523bc1556da3d19921c684259925','2020-09-25 22:09:27.0')
,('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р вЂ�Р С•Р С–Р С•Р С�Р С•Р В»Р С•Р Р†Р В°','dbeardsall2k@dmoz.org',3151907707,'f','1988-12-27','Р СћР С•Р В»РЎРЉРЎРЏРЎвЂљРЎвЂљР С‘',NULL,'f1967dc12ed090fa0dd7259e2485cce97865e4d1','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘Р Р…Р В°','Р вЂњР С•Р В»Р С•РЎвЂ°Р В°Р С—Р С•Р Р†Р В°','rbulford2l@goodreads.com',7783646176,'f','1986-02-11','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'60ada1812162902fdf036cd8f41aed0b1ae31866','2020-09-25 22:09:27.0')
,('Р пїЅР Р…Р Р…Р В°','Р вЂќР С‘Р В±РЎвЂ Р ВµР Р†Р В°','rblankenship2m@aol.com',4963297188,'f','1986-01-05','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'74f7ad69beb17f40608046522c6cfe2ab75ffdfb','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р СџР С•Р С—Р С•Р Р†','lsiveter2n@cnbc.com',9517280949,'m','1982-02-26','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'c99c810a5782926b16d2aae0f5a029c3ca0de755','2020-09-25 22:09:27.0')
,('Р вЂњР В°Р В»Р С‘Р Р…Р В°','Р В РЎС“Р С”Р В°Р Р†Р С‘РЎвЂ РЎвЂ№Р Р…Р В°','csamples2o@wordpress.com',3923826386,'f','1984-11-06','Р В§Р ВµР В»РЎРЏР В±Р С‘Р Р…РЎРѓР С”',NULL,'3a19575039593db8300b30e3051cf15890783bbc','2020-09-25 22:09:27.0')
,('Р СњР С‘Р С”Р С‘РЎвЂљР В°','Р В РЎвЂ№Р С”РЎС“Р Р…Р С•Р Р†','bwhitby2p@furl.net',8487221955,'m','1984-06-03','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'404bb0046780c0377ef1e96ce9001a701668c6c6','2020-09-25 22:09:27.0')
,('Р С’Р Р…Р В°РЎРѓРЎвЂљР В°РЎРѓР С‘РЎРЏ','Р В РЎвЂ№Р С”РЎС“Р Р…Р С•Р Р†Р В°','sbearman2q@ebay.co.uk',8066940781,'f','1986-02-13','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'2d9f4c408a47c268a31fc39809d2fb04a2a04ec3','2020-09-25 22:09:27.0')
,('Р В®РЎР‚Р С‘Р в„–','Р РЋР В°Р В±Р В»Р С‘Р Р…','kscobie2r@sciencedaily.com',8186433808,'m','1982-11-23','Р Р€РЎвЂћР В°',NULL,'d0f98fc4b115f0ca2122f1ea0f53cdff006e0a90','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р РЋР В°Р С�РЎРѓР С•Р Р…Р С•Р Р†','afickena@businessweek.com',1437600801,'m','1986-03-09','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'a6042fbaffba5d97f05baf9bfe6163722d1d640d','2020-09-25 22:09:27.0')
,('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р РЋР С•Р С”Р С•Р В»Р С•Р Р†Р В°','mbaynhamb@howstuffworks.com',9798286372,'f','1982-08-25','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'60fb33d672eff5d474f18309e11320f40b7e7b4f','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р С’РЎвЂћР В°Р Р…Р В°РЎРѓРЎРЉР ВµР Р†Р В°','doxterbyc@ovh.net',5794027202,'f','1981-09-06','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'9967a9836ae9a490691dc6a7abf921c13de7693b','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р вЂ�Р С•Р В»Р С–Р С•Р Р†','ndurekd@facebook.com',4243478042,'m','1986-08-21','Р В§Р ВµР В»РЎРЏР В±Р С‘Р Р…РЎРѓР С”',NULL,'f0fe0f1cc166c63a8a8ec4ed6b0d56d4a6dc12c5','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р вЂќРЎР‚Р ВµР Р†Р В°Р В»РЎРЉ','echildse@sohu.com',7191538491,'m','1983-05-17','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'c94230c5967832c1cab80d57668a6d2418f3ce0e','2020-09-25 22:09:27.0')
,('Р СљР В°Р С”РЎРѓР С‘Р С�','Р вЂќРЎС“Р В±Р С•Р Р†Р В°РЎвЂљР С”Р С‘Р Р…','agrigorushkinf@infoseek.co.jp',5466692275,'m','1984-05-26','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'81d0d1ebcd2d75030d7f2fceab8e229e2795b1f2','2020-09-25 22:09:27.0')
,('Р РЋР ВµРЎР‚Р С–Р ВµР в„–','Р СџРЎР‚Р С•РЎРѓРЎвЂљР В°Р С”Р С•Р Р†','hmcganng@umn.edu',3805318987,'m','1987-02-03','Р Р€РЎвЂћР В°',NULL,'b896871061ded2bcdd77430613f262046c0465e5','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР В°Р Р…Р Т‘РЎР‚','Р СџР С•Р Р…Р С•Р С�Р В°РЎР‚Р ВµР Р†','mcumberpatchh@macromedia.com',9972401583,'m','1984-07-17','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'4ecb30007604ee7baf41e5b68cf4bb5e45cfb9c9','2020-09-25 22:09:27.0')
,('Р СљР В°Р С”РЎРѓР С‘Р С�','Р СџР В°РЎР‚РЎв‚¬Р С‘Р Р…','ebankei@senate.gov',1672124574,'m','1985-04-26','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'7bc86a9ac9b93f30c1af49c7423cc27c2773bd57','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р СџР ВµРЎвЂљРЎР‚Р С•Р Р†','tbrandij@cyberchimps.com',6387066678,'m','1987-06-13','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'6b3dd04daee595084ee9ff21279fe2b27cf87d3b','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р СњР С‘Р С”Р С•Р В»Р В°Р в„–','Р РЋР С‘Р Т‘Р С•РЎР‚Р С•Р Р†','kbarthramk@springer.com',4521952112,'m','1984-09-21','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'6c99e35fcb1313640ecc9ef074767cd912cb5fa3','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР В°Р Р…Р Т‘РЎР‚','Р вЂ™Р С•РЎР‚РЎвЂћР С•Р В»Р С•Р С�Р ВµР ВµР Р†','snewlandl@qq.com',4552946215,'m','1983-09-08','Р В§Р ВµР В»РЎРЏР В±Р С‘Р Р…РЎРѓР С”',NULL,'9e27dbd35bf80d7b000b78987f8136742db78694','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р С’Р В»Р ВµРЎвЂ¦Р С‘Р Р…','rstredderm@slideshare.net',5019199432,'m','1981-03-28','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'162f709959774d806963d0f4cf7946c3fd2d8a48','2020-09-25 22:09:27.0')
,('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р СџР В°РЎР‚РЎв‚¬Р С‘Р Р…Р В°','gpimn@github.com',8393364396,'f','1984-05-16','Р В§Р ВµР В»РЎРЏР В±Р С‘Р Р…РЎРѓР С”',NULL,'6213391ec7ef13d231e308d9e37d27bc3826f5d0','2020-09-25 22:09:27.0')
,('Р СњР В°РЎвЂљР В°Р В»РЎРЉРЎРЏ','Р СћРЎР‚РЎС“Р В±Р С‘РЎвЂ РЎвЂ№Р Р…Р В°','lbiniono@examiner.com',6376414090,'f','1987-08-20','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'c416fe919541a2135942fae312c6b9fa450b9910','2020-09-25 22:09:27.0')
,('Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В°','Р СџР В°РЎР‚РЎв‚¬Р С‘Р Р…Р В°','jkreberp@i2i.jp',7506356015,'f','1987-08-27','Р В§Р ВµР В»РЎРЏР В±Р С‘Р Р…РЎРѓР С”',NULL,'59c2c1bab5ce4f157ca65c0008d9dded06f77747','2020-09-25 22:09:27.0')
,('Р вЂўР Р†Р С–Р ВµР Р…Р С‘РЎРЏ','Р С™РЎР‚Р С‘Р Р†РЎвЂ Р С•Р Р†Р В°','mburnhamsq@baidu.com',1633500921,'f','1987-11-28','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'d39dd4390bdcd9c5d439c0fe6a3c4a327af221eb','2020-09-25 22:09:27.0')
,('Р С’Р Р…Р В°РЎРѓРЎвЂљР В°РЎРѓР С‘РЎРЏ','Р вЂ�РЎС“РЎР‚Р С�Р С‘РЎРѓРЎвЂљРЎР‚Р С•Р Р†Р В°','wlangtreer@example.com',9894901275,'f','1980-11-03','Р Р€РЎвЂћР В°',NULL,'b703cb35fb2298673e577f461482a2faeaaf1eab','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р вЂ™Р С•РЎР‚Р С•Р Р…Р С•Р Р†Р В°','cburlays@pen.io',2018695545,'f','1980-04-12','Р СћР С•Р В»РЎРЉРЎРЏРЎвЂљРЎвЂљР С‘',NULL,'b00c41bb74b9ae30d9513d48a1245e618fc5b210','2020-09-25 22:09:27.0')
,('Р СњР В°РЎвЂљР В°Р В»РЎРЉРЎРЏ','Р вЂ”Р В°Р Р†Р С•Р Т‘РЎРѓР С”Р С•Р Р†Р В°','filymanovt@nydailynews.com',3372167202,'f','1986-10-29','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'1b79c1723c0a8c65120d12a6be69a8fb9970a5b6','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р РЋР ВµРЎР‚Р С–Р ВµР в„–','Р вЂ™Р С•РЎР‚Р С•Р Р…Р С‘Р Р…','ckluliseku@theguardian.com',2624066456,'m','1985-06-21','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'d92336e60a1c39ef40a442db8758173836d127ad','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р вЂ�Р В°РЎР‚Р В°Р Р…Р С•Р Р†Р В°','fpointinv@yale.edu',8826412568,'f','1986-04-11','Р В§Р ВµР В»РЎРЏР В±Р С‘Р Р…РЎРѓР С”',NULL,'6b3a60494a2592cf1f643059de580662cc6cc524','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘Р Р…Р В°','Р РЋР ВµР С�Р С‘Р С”Р С•Р В·','hsisnerosw@surveymonkey.com',2822165316,'f','1981-04-23','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'b8d39e2a6a1b8add765f7f8cc02785f15d692c1c','2020-09-25 22:09:27.0')
,('Р С’Р Р…Р Т‘РЎР‚Р ВµР в„–','Р вЂ�РЎС“Р В»Р В°Р Р…РЎвЂ№Р в„–','gbretonx@clickbank.net',1823731974,'m','1989-06-04','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'83097b2b4d64b3e3c90487facd26beb9515434f4','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘РЎРЏ','Р СћР В°РЎвЂћР С‘Р Р…РЎвЂ Р ВµР Р†Р В°','smcivery@networkadvertising.org',9835391400,'f','1987-02-07','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'97f853a5ca84ffbd28b671b50e4da74c31091289','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р С’Р С”РЎРѓР ВµР Р…Р ВµР Р…Р С”Р С•Р Р†Р В°','cmacnamaraz@arstechnica.com',3841390714,'f','1984-05-14','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'c559cb1c9fc131914c12fe954f336adfcfce9dc0','2020-09-25 22:09:27.0')
,('Р вЂ™Р С‘Р С”РЎвЂљР С•РЎР‚Р С‘РЎРЏ','Р вЂєРЎС“Р Р…Р ВµР Р†Р В°','mseamer10@uol.com.br',7213293360,'f','1985-04-28','Р Р€РЎвЂћР В°',NULL,'8d9633614bbba01c2321c8ae792e81076353018e','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР В°Р Р…Р Т‘РЎР‚','Р В¤Р ВµР Т‘Р С•РЎР‚Р С•Р Р†','mjanew11@tuttocitta.it',5226134225,'m','1986-12-29','Р РЋР В°РЎР‚Р В°РЎвЂљР С•Р Р†',NULL,'bc80127d933e0d328ecdae39339f46eee4466085','2020-09-25 22:09:27.0')
,('Р вЂєРЎР‹Р В±Р С•Р Р†РЎРЉ','Р С™Р С•РЎР‚РЎвЂЎР В°Р С–Р С‘Р Р…Р В°','isibbald12@livejournal.com',9967628912,'f','1980-09-13','Р С›Р С�РЎРѓР С”',NULL,'83ddcad57c2f0fdad119f7ef5b0868b5bbc6db39','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р В©Р ВµРЎР‚Р В±Р С‘Р Р…Р С‘Р Р…Р В°','ocuardall13@mashable.com',9827001278,'f','1983-02-13','Р СњР С‘Р В¶Р Р…Р С‘Р в„– Р СњР С•Р Р†Р С–Р С•РЎР‚Р С•Р Т‘',NULL,'7d73b3cf8f25f66e0dcda5cdf5b86cc95a40087f','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р С’Р В»Р ВµР С”РЎРѓР В°Р Р…Р Т‘РЎР‚','Р вЂєР ВµР В±Р ВµР Т‘Р ВµР Р†','cwelbourn14@unblog.fr',1243478465,'m','1982-09-05','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'7d5b5340ccd8aa195530d45b0d531874c3157744','2020-09-25 22:09:27.0')
,('Р СџР В°Р Р†Р ВµР В»','Р С›РЎРѓРЎвЂљРЎР‚Р С•Р Р†Р ВµРЎР‚РЎвЂ¦Р С•Р Р†','mheyball15@wordpress.com',9958667317,'m','1980-04-20','Р В Р С•РЎРѓРЎвЂљР С•Р Р†-Р Р…Р В°-Р вЂќР С•Р Р…РЎС“',NULL,'38ceff79c9a3dc3022a29d4a321b8e1c1f9d573c','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р вЂњР В°РЎР‚РЎв‚¬Р С‘Р Р…Р В°','wbirth16@virginia.edu',4644317051,'f','1982-11-19','Р В§Р ВµР В»РЎРЏР В±Р С‘Р Р…РЎРѓР С”',NULL,'0705130b93d6ad48ed4a4cf1121b6c2da22451a5','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р Р‡Р С”РЎС“РЎв‚¬Р ВµР Р†Р В°','tpenas17@yahoo.com',5124099962,'f','1986-12-01','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'a4855604e4b371d4fc08269aadf4e53f41572af2','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР В°Р Р…Р Т‘РЎР‚','Р СџР С•РЎР‚Р С•РЎвЂљР С‘Р С”Р С•Р Р†','nwinder18@mail.ru',2443934792,'m','1989-01-27','Р В Р С•РЎРѓРЎвЂљР С•Р Р†-Р Р…Р В°-Р вЂќР С•Р Р…РЎС“',NULL,'7736a217376b568df8b3ccf9abb2b33d369651ab','2020-09-25 22:09:27.0')
,('Р С’Р Р…РЎвЂљР С•Р Р…','Р вЂњР С•Р Р…РЎвЂЎР В°РЎР‚Р С•Р Р†','lforsard19@spotify.com',3353138089,'m','1984-05-12','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'5e89b185348a2952d14d63ca8a8e918cbe76ffb6','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р вЂ”Р В°РЎвЂ¦Р В°РЎР‚Р С•Р Р†Р В°','sfenech1a@multiply.com',9601298201,'f','1988-05-29','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'29836521a8aaf747e81a4b73815567d2f0c391f2','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р СћР В°РЎР‚Р В°РЎРѓР С•Р Р†Р В°','jlehrle1b@trellian.com',3135058629,'f','1985-05-20','Р В§Р ВµР В»РЎРЏР В±Р С‘Р Р…РЎРѓР С”',NULL,'1a774e0a50f50122bf651dfcac8fbd7093fbadfe','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р вЂ�Р ВµР В»Р С•РЎС“РЎРѓР С•Р Р†Р В°','rrowbrey1c@engadget.com',9137682198,'f','1989-04-11','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'6612e2fcf05eb06abf6a270836c6bb0929881d2d','2020-09-25 22:09:27.0')
,('Р С™РЎР‚Р С‘РЎРѓРЎвЂљР С‘Р Р…Р В°','Р С™Р С•Р С�Р С•Р Р†Р В°','gboken1d@pbs.org',7535680736,'f','1983-08-14','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'bb35c705937669867fcb722070e7beb2d10ab622','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р СљР В°Р С”РЎРѓР С‘Р С�','Р СњР С‘Р С”Р С‘РЎвЂљР С‘Р Р…','ebakhrushin1e@nationalgeographic.com',7735098294,'m','1980-05-29','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'ae2706b4f4b393f95331b1686ed391bc4d5c997a','2020-09-25 22:09:27.0')
,('Р С›Р С”РЎРѓР В°Р Р…Р В°','Р РЋР Р…Р ВµР С–Р С‘РЎР‚Р ВµР Р†Р В°','rdrugan1f@domainmarket.com',7267503662,'f','1986-05-20','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'117e128e47bf9990fb42667c532fea870148154e','2020-09-25 22:09:27.0')
,('Р вЂ™Р С‘Р С”РЎвЂљР С•РЎР‚Р С‘РЎРЏ','Р В РЎС“Р Т‘Р Р…Р ВµР Р†Р В°','ladamec1g@businessweek.com',6437005614,'f','1981-06-21','Р СџР ВµРЎР‚Р С�РЎРЉ',NULL,'e161196978199abbf0aae9db3646c92160edb97a','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р С’РЎР‚Р В¶Р В°Р Р…Р С•Р Р†Р В°','sdehooch1h@liveinternet.ru',3264294858,'f','1980-11-03','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'27a45adcbb383228b8998eb3074059471a3143f0','2020-09-25 22:09:27.0')
,('Р В¤Р ВµР Т‘Р С•РЎР‚','Р РЃР С‘Р С—Р С”Р С•','glammertz1i@go.com',8854406327,'m','1989-05-14','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'f6576f732765b8b40fd758bcc0a83b65dea45ca1','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р СћР В°Р С�Р В±Р С•Р Р†РЎвЂ Р ВµР Р†Р В°','ghuzzey1j@creativecommons.org',5792854326,'f','1983-01-10','Р РЋР В°РЎР‚Р В°РЎвЂљР С•Р Р†',NULL,'27c2a6980f55455a7de39f0f4afbe96a112ae5c7','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р С™Р С•Р В·Р В°РЎР‚Р ВµР Р…Р С”Р С•','tcubbini1k@list-manage.com',8076928589,'f','1981-09-01','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'8da5db5f87ef06c2f7fb67846068d728e1f4fde2','2020-09-25 22:09:27.0')
,('Р СњР В°РЎвЂљР В°Р В»РЎРЉРЎРЏ','Р вЂ™Р С•Р В»Р С”Р С•Р Р†Р В°','pdanels1l@studiopress.com',3467878579,'f','1985-12-07','Р С›Р С�РЎРѓР С”',NULL,'60c3e33d3702766312b99c42d1be3a98b5e3eeaa','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р вЂєРЎвЂ№РЎРѓР В°Р С”Р С•Р Р†Р В°','mlarrett1m@china.com.cn',6804310209,'f','1981-06-26','Р РЋР В°РЎР‚Р В°РЎвЂљР С•Р Р†',NULL,'3cfb6181608ca073d4d59432c71d36ce3fb1bdbe','2020-09-25 22:09:27.0')
,('Р вЂ™Р В»Р В°Р Т‘Р С‘Р С�Р С‘РЎР‚','Р СџР С•РЎвЂЎР ВµР С—РЎвЂ Р С•Р Р†','dswancott1n@time.com',4101819985,'m','1987-01-02','Р СњР С‘Р В¶Р Р…Р С‘Р в„– Р СњР С•Р Р†Р С–Р С•РЎР‚Р С•Р Т‘',NULL,'c3b0adc093cbc45a0e02275a13a1f7e3609b257e','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р вЂўР Р†Р С–Р ВµР Р…Р С‘РЎРЏ','Р С™Р С•Р Р…Р Р…Р С‘Р С”Р С•Р Р†Р В°','cmorsey1o@purevolume.com',4578422856,'f','1989-10-09','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'9f85a0b32ae7fb3e952fa6f38de5a5405fc03810','2020-09-25 22:09:27.0')
,('Р СњР В°РЎвЂљР В°Р В»РЎРЉРЎРЏ','Р С™Р С•Р В·Р В»Р С‘РЎвЂљР С‘Р Р…Р В°','bkennler1p@reddit.com',5302291765,'f','1983-03-02','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'c75642bc2173f416bae563603aef9c3cee7a220e','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р В°РЎвЂљ','Р СњР В°Р В·Р С�Р С‘Р ВµР Р†','chuckett1q@istockphoto.com',3696664396,'m','1989-02-16','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'632cad88930380e011ef6423ac7a615cb62d81c7','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р СћР С‘Р С�Р В°РЎв‚¬Р С•Р Р†','dhowbrook1r@go.com',4771920220,'m','1983-02-13','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'38860af616b46f31444b2e0e570318a3b6491f77','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР В°Р Р…Р Т‘РЎР‚','Р СљР В°РЎР‚Р С‘РЎвЂЎР ВµР Р†','mosiaghail1s@dagondesign.com',1703242914,'m','1981-08-01','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'6403618b2d91965c995eeb165fb1810c5494a3e1','2020-09-25 22:09:27.0')
,('Р вЂќР С‘Р Р…Р В°','Р РЋР В°Р Р†Р ВµР В»РЎРЉР ВµР Р†Р В°','tvanni1t@soundcloud.com',1277342028,'f','1987-12-03','Р В Р С•РЎРѓРЎвЂљР С•Р Р†-Р Р…Р В°-Р вЂќР С•Р Р…РЎС“',NULL,'1e031de4f2b7a76c2f622b63cb1c6844c90094ec','2020-09-25 22:09:27.0')
,('Р В¤Р ВµР Т‘Р С•РЎР‚','Р РЃР С‘Р С—Р С”Р С•','athickin1u@linkedin.com',5234996624,'m','1989-02-21','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'9f02e6161b06ca3568c93d900f54cf24334c6c97','2020-09-25 22:09:27.0')
,('Р вЂ™Р В°РЎРѓР С‘Р В»Р С‘Р в„–','Р вЂ�Р ВµР В·РЎР‚РЎС“РЎвЂЎР ВµР Р…Р С”Р С•','dhaylands1v@list-manage.com',3877536636,'m','1982-04-26','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'8b70f86d265f5e021b157d3ead188efb0ea3374f','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р вЂєР С‘РЎвЂљР В°Р Р†РЎР‚Р С‘Р Р…','gtaplow1w@imgur.com',9947066870,'m','1983-05-10','Р С›Р С�РЎРѓР С”',NULL,'5ea7a3f00a784345a7c7df7dbf303921565c4bf2','2020-09-25 22:09:27.0')
,('Р С™Р С•Р Р…РЎРѓРЎвЂљР В°Р Р…РЎвЂљР С‘Р Р…','Р РЋРЎвЂљР В°РЎР‚Р С•Р Т‘РЎС“Р В±РЎвЂ Р ВµР Р†','ccatto1x@intel.com',9286831036,'m','1986-08-23','Р вЂ™Р С•Р В»Р С–Р С•Р С–РЎР‚Р В°Р Т‘',NULL,'fabb15a627158fbc7f8be2119755ef0ecf08e81a','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р С›Р В»РЎРЉР С–Р В°','Р С™РЎС“Р В·Р Р…Р ВµРЎвЂ Р С•Р Р†Р В°','jselway1y@odnoklassniki.ru',3532624836,'f','1986-09-15','Р СњР С‘Р В¶Р Р…Р С‘Р в„– Р СњР С•Р Р†Р С–Р С•РЎР‚Р С•Р Т‘',NULL,'0558138813a372455cce703fefc719b65604da68','2020-09-25 22:09:27.0')
,('Р С’Р Р…РЎвЂљР С•Р Р…','Р вЂ�Р С•РЎР‚Р Р…Р С‘Р С”Р С•Р Р†','goflaherty1z@umich.edu',7377444639,'m','1983-02-10','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'73351c9bf23a7e4e03f29ebd37b949ae1b866d09','2020-09-25 22:09:27.0')
,('Р В Р С•Р С�Р В°Р Р…','Р СћР В°РЎР‚Р В°РЎР‚РЎвЂ№Р С”Р С•Р Р†','bhercules20@ycombinator.com',3451661646,'m','1988-04-13','Р РЋР В°РЎР‚Р В°РЎвЂљР С•Р Р†',NULL,'ab4de688bf85cf865982dc2f2dc5a7e062ba54e5','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р пїЅРЎвЂ°Р ВµР Р…Р С”Р С•','njirzik21@utexas.edu',1132812314,'f','1985-12-04','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'843d6df418382066775420211bf9f923b6885c62','2020-09-25 22:09:27.0')
,('Р СџР В°Р Р†Р ВµР В»','Р СћРЎР‚РЎС“Р Р…РЎвЂљР В°Р ВµР Р†','lbradbeer22@pinterest.com',2312476133,'m','1985-05-21','Р СћР С•Р В»РЎРЉРЎРЏРЎвЂљРЎвЂљР С‘',NULL,'a34f88e21214740c1f0713a0b7158f035371ae52','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘Р Р…Р В°','Р вЂ™Р В»Р В°РЎРѓР С•Р Р†Р В°','vtosney23@lycos.com',5978627731,'f','1983-09-18','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'a90f3046a469a20d596d46f5868a3236cb56b410','2020-09-25 22:09:27.0')
,('Р РЋР ВµРЎР‚Р С–Р ВµР в„–','Р вЂ�Р ВµР В»РЎРЏР ВµР Р†','pfairnington24@baidu.com',2489356708,'m','1986-07-11','Р Р€РЎвЂћР В°',NULL,'78239b73d2286ecc07f0931666564f334b39bf0e','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р СљР С•РЎР‚Р С•Р В·Р С•Р Р†Р В°','jskellion25@about.me',8806637099,'f','1989-07-02','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'ef981b22143faa2ddd2e3e7938bf604de1020059','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р СњР ВµРЎРѓРЎвЂљР ВµРЎР‚Р С•Р Р†Р В°','lnealon26@hexun.com',9413536022,'f','1986-05-01','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'5eccaf8d7038358b307c14336cd565cb49f365c3','2020-09-25 22:09:27.0')
,('Р вЂўР Р†Р С–Р ВµР Р…Р С‘Р в„–','Р вЂ™Р С•Р В»РЎвЂ№Р Р…Р С”Р С‘Р Р…','bpresland27@ihg.com',5752887260,'m','1989-09-16','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'c2b671c251b4ed3838644585b047d0a1a3704133','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р СњР В°Р Т‘Р ВµР В¶Р Т‘Р В°','Р В Р ВµРЎС“Р С”Р С•Р Р†Р В°','cemlyn28@wikispaces.com',9404156548,'f','1982-12-22','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'95c0a7d5089c0ccf6fe8c88113462c2ab6950a17','2020-09-25 22:09:27.0')
,('Р СљР В°РЎР‚Р С‘Р Р…Р В°','Р вЂєРЎРЏР С�Р В·Р С‘Р Р…Р В°','lokinedy29@aboutads.info',5614317170,'f','1984-02-11','Р вЂўР С”Р В°РЎвЂљР ВµРЎР‚Р С‘Р Р…Р В±РЎС“РЎР‚Р С–',NULL,'425f5bab4afc290c1ec5e904cbed27fcf4c97f71','2020-09-25 22:09:27.0')
,('Р вЂєРЎР‹Р В±Р С•Р Р†РЎРЉ','Р С™Р В°РЎР‚РЎвЂљР В°РЎв‚¬Р С•Р Р†Р В°','ewestgarth2a@home.pl',9468369832,'f','1981-12-25','Р СћР С•Р В»РЎРЉРЎРЏРЎвЂљРЎвЂљР С‘',NULL,'4b069e5454103bc745477798dd66ea134c242a92','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР ВµР в„–','Р вЂ”Р С•Р В»Р С•РЎвЂљР С•РЎвЂљРЎР‚РЎС“Р В±Р С•Р Р†','adebell2b@netlog.com',2003010211,'m','1984-08-30','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'2d7566a285d69d24b2ad0753bbaeddc945aecc83','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р вЂњРЎС“Р В»РЎРЏР ВµР Р†Р В°','cwinchcomb2c@friendfeed.com',9006045417,'f','1989-07-27','Р вЂ™Р С•РЎР‚Р С•Р Р…Р ВµР В¶',NULL,'c4ec50ac1c3064f80f4cfd877ba2563928a33e27','2020-09-25 22:09:27.0')
,('Р В®Р В»Р С‘РЎРЏ','Р РЋРЎвЂ№РЎРѓР С•Р ВµР Р†Р В°','yzanardii2d@google.com.au',9613106434,'f','1987-11-14','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'87acb7a49196ed113ddf732a9a41a1291a68cb87','2020-09-25 22:09:27.0')
,('Р С’Р В»Р ВµР С”РЎРѓР В°Р Р…Р Т‘РЎР‚','Р вЂ�Р С•РЎР‚Р С‘РЎРѓР С•Р Р†','jpierce2e@ftc.gov',6559915444,'m','1982-05-17','Р С™РЎР‚Р В°РЎРѓР Р…Р С•Р Т‘Р В°РЎР‚',NULL,'10253a915f1b47f3032c84c71d7fd86a5a6624e8','2020-09-25 22:09:27.0')
,('Р С’Р Р…Р В°РЎвЂљР С•Р В»Р С‘Р в„–','Р С™Р С•РЎРѓР С‘Р Р…Р С•Р Р†','lbottini2f@whitehouse.gov',3036324530,'m','1983-06-01','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'d1532c3b8e8682bc769b2606320a1a0f54fc5925','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р СљР ВµР В»Р В°Р Р…РЎРЉР С‘Р Р…Р В°','wweaben2g@amazon.com',3193637029,'f','1981-05-06','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'6df61ed9ad812e2f327ae87bc855302c28f1c2e0','2020-09-25 22:09:27.0')
,('Р С›Р В»РЎРЉР С–Р В°','Р вЂќРЎС“Р В±Р С‘РЎвЂ°Р ВµР Р†Р В°','dborrow2h@oaic.gov.au',3234549546,'f','1987-04-11','Р СљР С•РЎРѓР С”Р Р†Р В°',NULL,'4e33f3ac62368f7104b84612d0b1ab5181cdd11b','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р В¤Р ВµР Т‘Р С•РЎР‚','Р РЃР С‘Р С—Р С”Р С•','pcoverdill2i@youtube.com',9608691146,'m','1984-06-14','Р В Р С•РЎРѓРЎвЂљР С•Р Р†-Р Р…Р В°-Р вЂќР С•Р Р…РЎС“',NULL,'5ccde04c88913a29f096d5ccfc1e9ec0cce67a71','2020-09-25 22:09:27.0')
,('Р СћР В°РЎвЂљРЎРЉРЎРЏР Р…Р В°','Р РЋР ВµР Р†Р С•РЎРѓРЎвЂљРЎРЉРЎРЏР Р…Р С•Р Р†Р В°','lbaldam2j@qq.com',8065210191,'f','1980-07-11','Р СњР С•Р Р†Р С•РЎРѓР С‘Р В±Р С‘РЎР‚РЎРѓР С”',NULL,'26a73caff7a0774d854d085586394becd291dc84','2020-09-25 22:09:27.0')
,('Р пїЅР Р…Р Р…Р В°','Р С™РЎР‚Р В°РЎРѓР Р…Р С‘Р С”Р С•Р Р†Р В°','rdunstan2k@gmpg.org',2141664371,'f','1987-11-03','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'b6f4fe122245e18ccbdf12bcf354bd693a87fedc','2020-09-25 22:09:27.0')
,('Р РЋР Р†Р ВµРЎвЂљР В»Р В°Р Р…Р В°','Р вЂњР В°РЎР‚РЎРЉР С”Р С•Р Р†РЎРѓР С”Р В°РЎРЏ','mmcglade2l@google.de',9804639490,'f','1981-05-20','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'c6ae3d969345bc2cacf2cf324468e5bae8fd449c','2020-09-25 22:09:27.0')
,('Р В­Р В»РЎРЉР В·Р В°','Р РЋР В°Р С�Р С•РЎР‚Р С•Р С”Р С•Р Р†РЎРѓР С”Р В°РЎРЏ','fantal2m@hp.com',8894215795,'f','1987-05-10','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'e643ae9bdbefd5da4c4e18a47c46f2db8b33f603','2020-09-25 22:09:27.0')
,('Р вЂўР В»Р ВµР Р…Р В°','Р С›РЎР‚Р В»Р С•Р Р†Р В°','brichings2n@dropbox.com',3913069006,'f','1988-08-11','Р РЋР В°Р С�Р В°РЎР‚Р В°',NULL,'5f37954b9fce380080982e51adba07e0718d0052','2020-09-25 22:09:27.0')
,('Р вЂњР В°Р В»Р С‘Р Р…Р В°','Р РЋРЎвЂљРЎР‚Р ВµР В»РЎРЉР Р…Р С‘Р С”Р С•Р Р†Р В°','lmundy2o@yellowbook.com',3699040307,'f','2020-09-05','Р СћРЎР‹Р С�Р ВµР Р…РЎРЉ',NULL,'0b5fcf87309858b956cc164df1a61acf8ca4773a','2020-09-25 22:09:27.0')
,('Р РЋР Р†Р ВµРЎвЂљР В»Р В°Р Р…Р В°','Р СњР В°Р В·Р В°РЎР‚Р С•Р Р†Р В°','aelsom2p@engadget.com',2811501912,'f','1984-04-07','Р С›Р С�РЎРѓР С”',NULL,'ad20ef3e300cc51ec105d937689feecfca82b66c','2020-09-25 22:09:27.0')
,('Р С’Р Р…РЎвЂљР С•Р Р…','Р РЃР В°РЎР‚РЎвЂ№Р С”Р С‘Р Р…','sholleran2q@technorati.com',8866959892,'m','1989-03-04','Р РЋР В°Р Р…Р С”РЎвЂљ-Р СџР ВµРЎвЂљР ВµРЎР‚Р В±РЎС“РЎР‚Р С–',NULL,'e28882d420f3f02df4ef85cf57a7900520dd19bf','2020-09-25 22:09:27.0')
,('Р пїЅРЎР‚Р С‘Р Р…Р В°','Р ТђРЎС“РЎРѓР В°Р С‘Р Р…Р С•Р Р†Р В°','jpalfreeman2r@example.com',6843424170,'f','1983-12-28','Р СћР С•Р В»РЎРЉРЎРЏРЎвЂљРЎвЂљР С‘',NULL,'b607f0f3ba714a20ee76785f523585be6fa4a022','2020-09-25 22:09:27.0')
;
INSERT INTO users (name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES 
('Р вЂќР В°РЎР‚РЎРЉРЎРЏ','Р пїЅР Р†Р В°Р Р…Р С•Р Р†Р В°','jpalfreeman@example.com',6843424170,'f','1999-12-28','Р С›Р С�РЎРѓР С”',NULL,'b607f0f3ba714a20ee76785f523585be6fa4a022','2020-09-25 22:09:27.0')
,('Р пїЅР Р†Р В°Р Р…','Р пїЅР Р†Р В°Р Р…Р С•Р Р†','jpalfreeman11@example.com',6843424170,'f','1999-12-28','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'b607f0f3ba714a20ee76785f523585be6fa4a022','2020-09-25 22:09:27.0')
,('Р РЋР ВµРЎР‚Р С–Р ВµР в„–','Р пїЅР Р†Р В°Р Р…Р С•Р Р†','11jpalfreeman11@example.com',6843424170,'f','1992-10-20','Р С™Р В°Р В·Р В°Р Р…РЎРЉ',NULL,'b607f0f3ba714a20ee76785f523585be6fa4a022','2020-09-25 22:09:27.0')
,('Р вЂќР С�Р С‘РЎвЂљРЎР‚Р С‘Р в„–','Р пїЅР Р†Р В°Р Р…Р С•Р Р†','131jpalfreeman11@example.com',6843424170,'f','1980-12-28','Р С™РЎР‚Р В°РЎРѓР Р…Р С•РЎРЏРЎР‚РЎРѓР С”',NULL,'b607f0f3ba714a20ee76785f523585be6fa4a022','2020-09-25 22:09:27.0')
,('Р СџРЎвЂ�РЎвЂљРЎР‚','Р пїЅР Р†Р В°Р Р…Р С•Р Р†','13sss1jpalfreeman11@example.com',6843424170,'f','2003-01-12','Р С›Р С�РЎРѓР С”',NULL,'b607f0f3ba714a20ee76785f523585be6fa4a022','2020-09-25 22:09:27.0')
;