-- ------------------------------------------------ JOIN
-- Выводит информацию о убитых ботах и в каких группах они состояли
select death.bot_id, bot_groups_id from death
	join bot_groups
	where is_kill = 1;
-- ------------------------------------------------

-- Выводит информацию о количестве друзей
select count(*) from (select target_id from friend where status = 'approved') as my_tmp_table;
-- ------------------------------------------------

-- Группирует оружие по урону
select count(*) from weapon group by damage;
-- ------------------------------------------------


-- ------------------------------------------------ Представления
-- Вывод информации является ли мне другом бот под определенным идентификатором
delimiter //

create function check_friendship(i_id INT, check_friend_id INT)
returns int reads sql data
begin
	declare res INT;
	select count(*) into res from friend 
	where 
		((initiator_id = i_id and target_id = check_friend_id) 
		or (target_id = i_id and initiator_id = check_friend_id))
		and status = 'approved';
	return res;
end//

delimiter ;

select check_friendship(1,3);
-- ------------------------------------------------

-- Выводит информацию о количестве оружия с уроном больше введенного значения
select name from weapon where damage > 5

delimiter //

create function check_damage(check_damage INT)
returns int reads sql data
begin
	declare res_weapon INT;
	select count(*) into res_weapon from weapon
	where damage > check_damage;
	return res_weapon;
end//

delimiter ;

select check_damage(5);
-- ------------------------------------------------


-- ------------------------------------------------ Хранимые процедуры
-- Выводит информацию об общих группах игрока
drop procedure if exists general_groups;

delimiter //

create procedure general_groups(in person_id int)
begin
	select distinct p2.bot_id
	from person_groups p1
	join bot_groups p2
	on p1.person_groups_id = p2.bot_groups_id
	where p1.person_id = 1
	and p1.person_id <> p2.bot_id;
	
-- общие группы
-- 	select distinct uc2.user_id
-- 	from users_communities uc1
-- 	join users_communities uc2
-- 	on uc1.community_id = uc2.community_id
-- 	where uc1.user_id = for_user_id
-- 	and uc1.user_id <> uc2.user_id
end//

delimiter ;

set @person_id = 1;

call general_groups(@person_id);
-- ------------------------------------------------


-- ------------------------------------------------ Тригеры
-- Выдает ошибку при удалении пользователя
drop trigger if exists check_last_person;

delimiter //

create trigger check_last_person before delete on person
for each row
begin
	declare total int;
	select count(*) into total from person;
	if total <= 1 then
		signal sqlstate '45000' set message_text = 'delete canceled';
	end if;
end//

delimiter ;

delete from person limit 1;
-- ------------------------------------------------