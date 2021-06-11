use vk;
						
/*Пусть задан некоторый пользователь. 
 * Из всех друзей этого пользователя найдите человека, 
 * который больше всех общался с нашим пользователем.*/
select u.firstname as to_, u1.firstname as from_,  count(1)   
from messages m, users u, users u1
where m.to_user_id = u.id
and u.id=1 			--USER_ID
and u1.id=m.from_user_id
and from_user_id in (select fr.initiator_user_id from friend_requests fr 
						where fr.target_user_id=u.id
						and fr.status='approved')
group by 1,2
order by 3 desc
limit 1;

/*Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.*/
select u.firstname, count(1) "got likes" 
from profiles p 
inner join media m on m.user_id = p.user_id
inner join likes l on l.media_id = m.id
inner join users u on u.id = p.user_id 
where TIMESTAMPDIFF(YEAR,p.birthday,CURDATE())<10
group by 1

/*Определить кто больше поставил лайков (всего): мужчины или женщины.*/
select Count(1) "Likes", p2.gender
	 from likes l
	 inner join profiles p2 on l.user_id =p2.user_id
	 group by 2
	 limit 1
