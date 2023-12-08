create database if not exists complex_sql;
use complex_sql;
drop table if exists entries;
create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries;
-- name,total_visits,most_visited_floor,resources
with table1 as
(
select t.name,t.floor as most_visited_floor
from
(select e.name,e.floor,count(*) as count_floor_visited,
row_number() over(partition by e.name order by count(*) desc) as rn
from entries as e
group by e.name,e.floor
) as t
where t.rn=1
),
table2 as (
select `name`,count(*) as total_visits,group_concat(distinct resources) as resources
from entries
group by `name`)

select t1.name,t2.total_visits,t1.most_visited_floor ,t2.resources
from table1 as t1
join table2 as t2
on t1.name=t2.name
