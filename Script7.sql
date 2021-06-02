use shop;

/*Ошибка в source! Пропущена буква в "desription"
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  desription TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';*/

/*Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/
/*В source нет заполнения таблицы orders.*/

select id, name from users u
where exists (select 1 from orders o where o.user_id=u.id);

/*insert into orders (id, user_id, created_at, updated_at)
			values (1, 4, now(), null);
insert into orders (id, user_id, created_at, updated_at)
			values (2, 2, now(), null);*/

/*Выведите список товаров products и разделов catalogs, который соответствует товару.*/
/*Не понятно что имеется ввиду декартово произведение или left(right) join*/

select c.name as "Раздел", p.name as "Наименование" 
from products p 
	left join catalogs c on c.id = p.catalog_id
order by 1; 

/*(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.*/

drop table if exists flights;
create table shop.flights(id SERIAL PRIMARY KEY,
 					 `from` varchar(50),
 					 `to` varchar(50));

drop table if exists cities;
create table cities(label varchar(50) PRIMARY KEY,
					name varchar(50));
				
insert into flights(id, `from`, `to`)
values (1, "Moscow", "Omsk"), (2, "Novgorod", "Kazan"), (3, "Irkutsk", "Moscow"), (4, "Omsk", "Irkutsk"),
	(5, "Moscow", "Kazan");
insert into cities(label, name)
values("Moscow", "Москва"), ("Irkutsk", "Иркутск"), ("Novgorod", "Новгород"), ("Kazan", "Казань"), ("Omsk", "Омск");

select c.name as `from`, c2.name as `to`
from flights f, cities c, cities c2
where f.`from` = c.label
and f.`to` = c2.label;

