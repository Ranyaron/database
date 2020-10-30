drop database if exists game;
create database game;

use game;

drop table if exists person; -- игрок
create table person(
	id serial primary key,
	person_name varchar(50),
	person_gender char(1),
	person_health bigint, -- здоровье
	person_force bigint, -- сила
	person_endurance bigint, -- выносливость
	person_dexterity bigint, -- ловкость
	index(person_name)
);

INSERT INTO `person` VALUES ('1','cupiditate','f','81','4','8','2'); 


drop table if exists bot; -- бот
create table bot(
	id serial primary key,
	bot_name varchar(50),
	bot_gender char(1),
	bot_health bigint, -- здоровье
	bot_force bigint, -- сила
	bot_endurance bigint, -- выносливость
	bot_dexterity bigint, -- ловкость
	index(bot_name)
);

INSERT INTO `bot` values
	('1','ut','m','76','3','5','7'),
	('2','repudiandae','m','98','0','2','6'),
	('3','ipsum','m','65','9','7','4'),
	('4','ut','f','51','7','1','1'),
	('5','pariatur','f','60','2','8','1'),
	('6','cupiditate','m','61','7','3','7'),
	('7','consequatur','f','94','1','2','8'),
	('8','rerum','m','81','6','8','4'),
	('9','nisi','m','56','7','4','2'),
	('10','sed','m','50','9','6','5');


drop table if exists friend;
create table friend(
	-- id serial primary key,
	initiator_id bigint unsigned not null,
	target_id bigint unsigned not null,
	status enum('requested', 'approved', 'unfriended', 'declined') default 'requested',
	requested_at datetime default now(),
	confirmed_at datetime default current_timestamp on update current_timestamp,
	primary key(initiator_id, target_id),
	foreign key (initiator_id) references person (id),
	foreign key (target_id) references bot (id)
);

INSERT INTO `friend` values
	('1','2','unfriended','2007-05-30 10:47:09','1970-12-29 22:15:18'),
	('1','3','approved','2001-07-01 19:09:05','2017-09-30 23:18:48'),
	('1','4','declined','1999-11-04 16:16:44','2013-04-07 22:31:27'),
	('1','5','requested','1981-04-16 02:01:54','2010-02-07 11:08:41'),
	('1','6','declined','1986-12-05 21:28:47','2018-03-12 23:01:09');


drop table if exists enemy;
create table enemy(
	-- id serial primary key,
	initiator_id bigint unsigned not null,
	target_id bigint unsigned not null,
    status enum('passive', 'aggressive', 'irrepressible') default 'passive',
	requested_at datetime default now(),
	confirmed_at datetime default current_timestamp on update current_timestamp,
	primary key(initiator_id, target_id),
	foreign key (initiator_id) references bot (id),
	foreign key (target_id) references person (id)
);

INSERT INTO `enemy` values
	('1','1','passive','1999-08-25 21:31:31','1978-03-08 14:36:58'),
	('7','1','aggressive','1999-08-25 21:31:31','1978-03-08 14:36:58'),
	('8','1','aggressive','1999-08-25 21:31:31','1978-03-08 14:36:58'),
	('9','1','irrepressible','1999-08-25 21:31:31','1978-03-08 14:36:58'),
	('10','1','passive','1999-08-25 21:31:31','1978-03-08 14:36:58');


drop table if exists my_groups;
create table my_groups(
	id serial primary key,
	name varchar(150),
	index groups_name (name)
);

INSERT INTO `my_groups` values
	('2','doloribus'),
	('3','in'),
	('1','molestiae'),
	('5','natus'),
	('4','nemo'); 


drop table if exists person_groups;
create table person_groups(
	person_id bigint unsigned not null,
	person_groups_id bigint unsigned not null,
	primary key(person_id, person_groups_id),
	foreign key (person_id) references person (id),
	foreign key (person_groups_id) references my_groups (id)
);

INSERT INTO `person_groups` values
	('1','1'),
	('1','2'),
	('1','4');


drop table if exists bot_groups;
create table bot_groups(
	bot_id bigint unsigned not null,
	bot_groups_id bigint unsigned not null,
	primary key(bot_id, bot_groups_id),
	foreign key (bot_id) references bot (id),
	foreign key (bot_groups_id) references my_groups (id)
);

INSERT INTO `bot_groups` values
	('1','3'),
	('2','1'),
	('3','2'),
	('4','4'),
	('5','4');


drop table if exists death;
create table death(
	id serial primary key,
	person_id bigint unsigned not null,
	bot_id bigint unsigned not null,
	is_kill bool default 0,
	foreign key (person_id) references person (id),
	foreign key (bot_id) references bot (id)
);

INSERT INTO `death` values
	('1','1','2','1'),
	('2','1','9','0'),
	('3','1','9','1'),
	('4','1','1','1'),
	('5','1','10','1'),
	('6','1','1','0'),
	('7','1','4','1'),
	('8','1','8','0'),
	('9','1','6','0'),
	('10','1','8','1');


drop table if exists weapon; -- оружие
create table weapon(
	id serial primary key,
	name varchar(50),
	ammunition bigint, -- боезапас
	damage bigint -- урон
);

INSERT INTO `weapon` values
	('1','adipisci','34','7'),
	('2','ratione','84','1'),
	('3','numquam','7','1'),
	('4','et','23','6'),
	('5','non','40','3'),
	('6','voluptas','61','9'),
	('7','quia','60','4'),
	('8','natus','76','6'),
	('9','sit','15','4'),
	('10','ut','73','1');


drop table if exists skill;
create table skill(
	id serial primary key,
	skill_level bigint default 1,
	experience bigint -- опыт
);

INSERT INTO `skill` VALUES ('1','8','96');