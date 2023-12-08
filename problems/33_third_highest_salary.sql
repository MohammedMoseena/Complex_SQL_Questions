use complex_sql;
CREATE TABLE if not exists  emp(
 emp_id int NULL,
 emp_name varchar(50) NULL,
 salary int NULL,
 manager_id int NULL,
 emp_age int NULL,
 dep_id int NULL,
 dep_name varchar(20) NULL,
 gender varchar(10) NULL
);
truncate table emp;
insert into emp values(1,'Ankit',14300,4,39,100,'Analytics','Female');
insert into emp values(2,'Mohit',14000,5,48,200,'IT','Male');
insert into emp values(3,'Vikas',12100,4,37,100,'Analytics','Female');
insert into emp values(4,'Rohit',7260,2,16,100,'Analytics','Female');
insert into emp values(5,'Mudit',15000,6,55,200,'IT','Male');
insert into emp values(6,'Agam',15600,2,14,200,'IT','Male');
insert into emp values(7,'Sanjay',12000,2,13,200,'IT','Male');
insert into emp values(8,'Ashish',7200,2,12,200,'IT','Male');
insert into emp values(9,'Mukesh',7000,6,51,300,'HR','Male');
insert into emp values(10,'Rakesh',8000,6,50,300,'HR','Male');
insert into emp values(11,'Akhil',4000,1,31,500,'Ops','Male');
select * from emp;
select emp_id, emp_name, salary, dep_id, dep_name
from (
select * ,rank() over(partition by dep_id order by salary desc) as rn
from emp
) as t
where rn=3 or 
(dep_id,salary) in
(select dep_id,min(salary)
from emp
group by dep_id
having count(*)<3
);

-- Method-2
with table1 as
(
select * ,rank() over(partition by dep_id order by salary desc) as rn,
count(*) over(partition by dep_id) as total_count
from emp
)
select emp_id, emp_name, salary, dep_id, dep_name
from table1
where rn=3 or (total_count<3 and rn=total_count);