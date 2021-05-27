use shop;

/*Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
 * Заполните их текущими датой и временем.*/
update users u 
set created_at = now(),
	updated_at = now();
	

/*
Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
и в них долгое время помещались значения в формате 20.10.2017 8:10. 
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

ALTER TABLE shop.users MODIFY COLUMN created_at VARCHAR(26) DEFAULT NULL NULL;
ALTER TABLE shop.users MODIFY COLUMN updated_at VARCHAR(26) DEFAULT NULL NULL;
*/
ALTER TABLE shop.users MODIFY COLUMN created_at DATETIME DEFAULT NULL;
ALTER TABLE shop.users MODIFY COLUMN updated_at DATETIME DEFAULT NULL;

/*В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
 * 0, если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 * Однако нулевые запасы должны выводиться в конце, после всех записей.*/

select * from storehouses_products
order by isnull(case when value='0' then null else value end), 4; /*0 приравнен к NULL, всё в конце*/



/*Подсчитайте средний возраст пользователей в таблице users.*/
select 	sum(TIMESTAMPDIFF(YEAR,u.birthday_at,CURDATE())) / count(1) as average	
from users u;


/*Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

select case when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =1 then "понедельник"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =2 then "вторник"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =3 then "среда"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =4 then "четверг"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =5 then "пятница"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =6 then "суббота"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =0 then "воскресенье"
			end as days, 
			count(1) 
		from users u
group by 1
order by 1;
