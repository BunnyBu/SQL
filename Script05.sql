use shop;

/*ѕусть в таблице users пол€ created_at и updated_at оказались незаполненными. 
 * «аполните их текущими датой и временем.*/
update users u 
set created_at = now(),
	updated_at = now();
	

/*
“аблица users была неудачно спроектирована. «аписи created_at и updated_at были заданы типом VARCHAR 
и в них долгое врем€ помещались значени€ в формате 20.10.2017 8:10. 
Ќеобходимо преобразовать пол€ к типу DATETIME, сохранив введЄнные ранее значени€.

ALTER TABLE shop.users MODIFY COLUMN created_at VARCHAR(26) DEFAULT NULL NULL;
ALTER TABLE shop.users MODIFY COLUMN updated_at VARCHAR(26) DEFAULT NULL NULL;
*/
ALTER TABLE shop.users MODIFY COLUMN created_at DATETIME DEFAULT NULL;
ALTER TABLE shop.users MODIFY COLUMN updated_at DATETIME DEFAULT NULL;

/*¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры: 
 * 0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы. 
 * Ќеобходимо отсортировать записи таким образом, чтобы они выводились в пор€дке увеличени€ значени€ value. 
 * ќднако нулевые запасы должны выводитьс€ в конце, после всех записей.*/

select * from storehouses_products
order by isnull(case when value='0' then null else value end), 4; /*0 приравнен к NULL, всЄ в конце*/



/*ѕодсчитайте средний возраст пользователей в таблице users.*/
select 	sum(TIMESTAMPDIFF(YEAR,u.birthday_at,CURDATE())) / count(1) as average	
from users u;


/*ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждый из дней недели. 
 —ледует учесть, что необходимы дни недели текущего года, а не года рождени€.*/

select case when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =1 then "понедельник"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =2 then "вторник"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =3 then "среда"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =4 then "четверг"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =5 then "п€тница"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =6 then "суббота"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =0 then "воскресенье"
			end as days, 
			count(1) 
		from users u
group by 1
order by 1;
