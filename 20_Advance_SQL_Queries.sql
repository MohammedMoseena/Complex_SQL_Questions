use complex_sql;
create table if not exists bms (seat_no int ,is_empty varchar(10));
truncate table bms;
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');
select * from bms;
/* 3 or more consecutive empty seats
method-1 --lead,lag
method-2 --Advance Aggregation
method-3 --analytical row number function 
*/
-- Method-1
select seat_no as consecutive_empty_seats
from
(
select * ,
lag(is_empty,1) over(order by seat_no) as prev_1,
lag(is_empty,2) over(order by seat_no) as prev_2,
lead(is_empty,1) over(order by seat_no) as next_1,
lead(is_empty,2) over(order by seat_no) as next_2
from bms) as t
where is_empty='Y' and 
((prev_1='Y' and prev_2='Y') or (prev_1='Y' and next_1='Y') or (next_1='Y' and next_2='Y'))
order by seat_no;

-- Method-2
with table2 as
(
select *,
sum(if((is_empty='Y'),1,0)) over(order by seat_no rows between 2 preceding and current row) as prev_2,
sum(if((is_empty='Y'),1,0)) over(order by seat_no rows between 1 preceding and 1 following ) as prev_next_1,
sum(if((is_empty='Y'),1,0)) over(order by seat_no rows between current row and 2 following) as next_2
from bms
)
select seat_no as consecutive_2
from table2
where (prev_2=3) or (prev_next_1=3) or (next_2=3);

-- Method-3
with table3 as
(
select * ,
row_number() over(order by seat_no) as rn,
(seat_no-row_number() over(order by seat_no)) as diff
from bms
where is_empty='Y'
),
cnt as 
(select diff,count(*) as freq
 from table3
group by diff
having count(*)>=3
)

select seat_no
from table3
where diff in (select diff from cnt);