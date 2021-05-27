use vk;

/*Пусть задан некоторый пользователь. 
 * Из всех друзей этого пользователя найдите человека, 
 * который больше всех общался с нашим пользователем.*/
select u.firstname as to_, u1.firstname as from_,  count(1)   
from messages m, users u, users u1
where m.to_user_id = u.id
and u.id=1
and u1.id=m.from_user_id
group by 1,2
order by 3 desc
limit 1;

/*Определить кто больше поставил лайков (всего): мужчины или женщины.*/
select Count(1), p2.gender
from likes l, profiles p2
where l.id =p2.user_id
group by 2
order by 1 desc
limit 1;

/*Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.*/
select count(1) from likes l
where user_id in
(select user_id from profiles p 
where TIMESTAMPDIFF(YEAR,p.birthday,CURDATE())>10)