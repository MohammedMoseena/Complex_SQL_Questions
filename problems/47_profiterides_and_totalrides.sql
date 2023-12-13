use complex_sql;
create table if not exists drivers
(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
truncate table drivers;
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

select * from drivers;
-- lead function
with table1 as
(
select *,lead(start_loc) over(partition by id order by start_time) as next_start_loc
from drivers
)
select id,count(*) as total_rides,
sum(if((end_loc=next_start_loc),1,0)) as profit_rides
from table1
group by id
order by 1;

-- self join 
with drivers_1 as 
(
select *,row_number() over(partition by id order by start_time) as rn
from drivers
) 
select t1.id,count(*) as total_count,count(t2.id) as profit_id
from drivers_1 as t1
left join drivers_1 as t2
on (t1.id=t2.id) and (t1.end_loc=t2.start_loc) and (t2.rn=t1.rn+1)
group by t1.id