use complex_sql;
create table if not exists stadium (
id int,
visit_date date,
no_of_people int
);
truncate table stadium;
insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);
select * from stadium;
/*
write a query to display the records which have 3 or more consecutive rows
with the amount of people more than 100(inclusive) each day
*/
with table1 as
(
select * ,row_number() over(order by visit_date) as rn,
(id-row_number() over(order by visit_date)) as diff
from stadium
where no_of_people>100
) 
select id, visit_date, no_of_people
from table1
where diff in
(
select diff
from table1
group by diff
having count(*)>=3
)