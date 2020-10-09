-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select name from users where exists (select user_id from orders);



-- Выведите список товаров products и разделов catalogs, который соответствует товару.

select name, (select name from catalogs where id = catalog_id) as 'catalog'
from products
where catalog_id = (select id from catalogs where name = 'Процессоры');
