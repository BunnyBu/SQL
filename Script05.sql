use shop;

/*����� � ������� users ���� created_at � updated_at ��������� ��������������. 
 * ��������� �� �������� ����� � ��������.*/
update users u 
set created_at = now(),
	updated_at = now();
	

/*
������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR 
� � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10. 
���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

ALTER TABLE shop.users MODIFY COLUMN created_at VARCHAR(26) DEFAULT NULL NULL;
ALTER TABLE shop.users MODIFY COLUMN updated_at VARCHAR(26) DEFAULT NULL NULL;
*/
ALTER TABLE shop.users MODIFY COLUMN created_at DATETIME DEFAULT NULL;
ALTER TABLE shop.users MODIFY COLUMN updated_at DATETIME DEFAULT NULL;

/*� ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 
 * 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. 
 * ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. 
 * ������ ������� ������ ������ ���������� � �����, ����� ���� �������.*/

select * from storehouses_products
order by isnull(case when value='0' then null else value end), 4; /*0 ��������� � NULL, �� � �����*/



/*����������� ������� ������� ������������� � ������� users.*/
select 	sum(TIMESTAMPDIFF(YEAR,u.birthday_at,CURDATE())) / count(1) as average	
from users u;


/*����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. 
 ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.*/

select case when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =1 then "�����������"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =2 then "�������"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =3 then "�����"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =4 then "�������"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =5 then "�������"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =6 then "�������"
			when WEEKDAY(DATE_FORMAT(birthday_at, concat(year(now()),'-%m-%d'))) =0 then "�����������"
			end as days, 
			count(1) 
		from users u
group by 1
order by 1;
