select 
	name,
	surname,
	(select filename from photos where id = u.photo_id) 'personal_photo',
	(select count(*) from 
	(select target_user_id ff from friend_requests where initiator_user_id = u.id and status = 'approved'
		union
	select initiator_user_id ff from friend_requests where target_user_id = u.id and status = 'approved') 
	as fr_tbl) 'friends',
	(select count(*) from friend_requests where target_user_id = u.id and status = 'requested') 'followers',
	(select count(*) from photos where user_id = u.id) 'photos'
from users u
where id = 1;



-- 2. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT user_id FROM (
	(SELECT to_user_id as user_id, COUNT(*) as message_total FROM messages WHERE from_user_id = 1 GROUP BY to_user_id)
	UNION ALL
	(SELECT from_user_id as user_id, COUNT(*) as message_total FROM messages WHERE to_user_id = 1 GROUP BY from_user_id)
) as my_tmp_table
GROUP by user_id
ORDER BY SUM(message_total) DESC;



-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

select sum(is_like) from (
	(select users.birthday, likes.is_like as is_like FROM users, likes ORDER BY birthday DESC LIMIT 10)
) as my_tmp_table;



-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT gender FROM (
	(select users.gender as gender, sum(likes.is_like) as total FROM users, likes where gender = 'm')
	UNION
	(select users.gender as gender, sum(likes.is_like) as total FROM users, likes where gender = 'f')
) as my_sort
ORDER BY total DESC
LIMIT 1;



-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

WITH T AS (
	SELECT from_user_id as user_id, COUNT(*) as rnk FROM messages
	GROUP BY from_user_id
	UNION ALL
	SELECT id, COUNT(*) FROM likes
	GROUP BY id
	UNION ALL
	SELECT initiator_user_id, COUNT(*) FROM friend_requests
	GROUP BY initiator_user_id
	UNION ALL
	SELECT target_user_id, COUNT(*) FROM friend_requests 
	GROUP BY target_user_id
	UNION ALL
	SELECT user_id, COUNT(*) FROM users_communities
	GROUP BY user_id
)
SELECT name, SUM(T.rnk) AS rnk
FROM T
	INNER JOIN users U on U.id = T.user_id
GROUP BY name
ORDER BY rnk
LIMIT 10;
