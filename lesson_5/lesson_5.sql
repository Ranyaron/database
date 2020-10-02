use snet1509;

-- ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.

drop table if exists users_5;
create table users_5(
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp
);

insert into users_5 (created_at, updated_at) values(null, null);

update users_5 set created_at = now(), updated_at = now();



-- ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10. ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

drop table if exists users_5;
create table users_5(
	created_at varchar(50),
	updated_at varchar(50)
);

insert into users_5 (created_at, updated_at) values('20.10.2017 8:10', '20.10.2017 8:10');

update users_5 set created_at = str_to_date(created_at, '%d.%m.%Y %k:%i'), updated_at = str_to_date(updated_at, '%d.%m.%Y %k:%i');

alter table users_5 change created_at created_at datetime default current_timestamp on update current_timestamp;
alter table users_5 change updated_at updated_at datetime default current_timestamp on update current_timestamp;



-- � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. ������ ������� ������ ������ ���������� � �����, ����� ���� �������.

drop table if exists storehouses_products;
create table storehouses_products(
	value int unsigned
);

insert into storehouses_products (value) values(0), (2500), (0), (30), (500), (1);

select * from storehouses_products order by if(value > 0, 0, 1), value;



-- ����������� ������� ������� ������������� � ������� users.

select round(avg(timestampdiff(year, birthday, now()))) as age from users;



-- ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.

select date_format(date(concat_ws('-', year(now()), month(birthday), day(birthday))), '%W') as day, count(*) as total from users group by day order by total desc;
