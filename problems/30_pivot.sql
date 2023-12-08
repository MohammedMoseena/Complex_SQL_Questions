use complex_sql;
create table if not exists players_location
(
name varchar(20),
city varchar(20)
);
truncate table  players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

select * from players_location;
select rn,
max(case when city='Bangalore' then name end) as Bangalore,
max(case when city='Delhi' then name end) as Delhi,
max(case when city='Mumbai' then name end) as Mumbai
from (
select *,row_number() over(partition by city order by name asc) as rn
from players_location
) as t
group by rn