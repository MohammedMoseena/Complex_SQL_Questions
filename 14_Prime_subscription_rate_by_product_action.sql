use complex_sql;
create table if not exists users_1
(
user_id integer,
name varchar(20),
join_date date
);
truncate table users_1;
insert into users_1
values (1, 'Jon',str_to_date('2-14-20','%m-%d-%y')), 
(2, 'Jane', str_to_date('2-14-20','%m-%d-%y')), 
(3, 'Jill', str_to_date('2-15-20','%m-%d-%y')), 
(4, 'Josh', str_to_date('2-15-20','%m-%d-%y')), 
(5, 'Jean', str_to_date('2-16-20','%m-%d-%y')), 
(6, 'Justin', str_to_date('2-17-20','%m-%d-%y')),
(7, 'Jeremy',str_to_date('2-18-20','%m-%d-%y'));


create table if not exists `events`
(
user_id integer,
type varchar(10),
access_date date
);
truncate table `events`;
insert into `events` values
(1, 'Pay',str_to_date('3-1-20','%m-%d-%y')), 
(2, 'Music',str_to_date('3-2-20','%m-%d-%y')), 
(2, 'P', str_to_date('3-12-20','%m-%d-%y')),
(3, 'Music',str_to_date('3-15-20','%m-%d-%y')), 
(4, 'Music',str_to_date('3-15-20','%m-%d-%y')), 
(1, 'P',str_to_date('3-16-20','%m-%d-%y')), 
(3, 'P',str_to_date('3-22-20','%m-%d-%y'));

select * from users_1;
select * from `events`;

-- m.user_id,m.access_date as music_date,p.access_date as sub_date,m.type,p.type
select count(m.user_id) as total_users_music_access,
sum(if((p.user_id is not null),1,0)) as total_users_music_prime_access,
round((sum(if((p.user_id is not null),1,0))/count(m.user_id)),2) as fraction_users
from users_1 as m
left join `events` as p on (p.type='P') and (m.user_id=p.user_id) and (datediff(p.access_date,m.join_date) between 0 and 30)
where (m.user_id) in (select user_id from `events` where `type`='Music')
