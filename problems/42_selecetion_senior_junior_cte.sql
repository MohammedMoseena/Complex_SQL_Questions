use complex_sql;
create table if not exists candidates (
emp_id int,
experience varchar(20),
salary int
);
truncate table candidates;
insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);
SELECT @budget := 70000;
select * from candidates;
with table1 as
(
select *,
sum(salary) over(partition by experience order by salary asc rows between unbounded preceding and current row) as rolling_sum
from candidates),
seniors as
(
select *
from table1
where experience='Senior' and (rolling_sum<@budget)
)
select emp_id, experience, salary from seniors
union all
select emp_id, experience, salary
from table1
where experience='Junior' and (rolling_sum<=(@budget-(select sum(salary) from seniors)))



