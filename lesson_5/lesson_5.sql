use snet1509;

-- ѕусть в таблице users пол€ created_at и updated_at оказались незаполненными. «аполните их текущими датой и временем.

drop table if exists users_5;
create table users_5(
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp
);

insert into users_5 (created_at, updated_at) values(null, null);

update users_5 set created_at = now(), updated_at = now();



-- “аблица users была неудачно спроектирована. «аписи created_at и updated_at были заданы типом VARCHAR и в них долгое врем€ помещались значени€ в формате 20.10.2017 8:10. Ќеобходимо преобразовать пол€ к типу DATETIME, сохранив введЄнные ранее значени€.

drop table if exists users_5;
create table users_5(
	created_at varchar(50),
	updated_at varchar(50)
);

insert into users_5 (created_at, updated_at) values('20.10.2017 8:10', '20.10.2017 8:10');

update users_5 set created_at = str_to_date(created_at, '%d.%m.%Y %k:%i'), updated_at = str_to_date(updated_at, '%d.%m.%Y %k:%i');

alter table users_5 change created_at created_at datetime default current_timestamp on update current_timestamp;
alter table users_5 change updated_at updated_at datetime default current_timestamp on update current_timestamp;



-- ¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры: 0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы. Ќеобходимо отсортировать записи таким образом, чтобы они выводились в пор€дке увеличени€ значени€ value. ќднако нулевые запасы должны выводитьс€ в конце, после всех записей.

drop table if exists storehouses_products;
create table storehouses_products(
	value int unsigned
);

insert into storehouses_products (value) values(0), (2500), (0), (30), (500), (1);

select * from storehouses_products order by if(value > 0, 0, 1), value;



-- ѕодсчитайте средний возраст пользователей в таблице users.

select round(avg(timestampdiff(year, birthday, now()))) as age from users;



-- ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждый из дней недели. —ледует учесть, что необходимы дни недели текущего года, а не года рождени€.

select date_format(date(concat_ws('-', year(now()), month(birthday), day(birthday))), '%W') as day, count(*) as total from users group by day order by total desc;
