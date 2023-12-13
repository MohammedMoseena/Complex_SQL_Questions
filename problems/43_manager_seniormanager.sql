use complex_sql;
create table if not exists emp_1(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);
truncate table emp_1;
insert into emp_1 values (1,'Ankit',100,10000,4,39);
insert into emp_1 values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp_1 values (3, 'Vikas', 100, 12000,4,37);
insert into emp_1 values (4, 'Rohit', 100, 14000, 2, 16);
insert into emp_1 values (5, 'Mudit', 200, 20000, 6,55);
insert into emp_1 values (6, 'Agam', 200, 12000,2, 14);
insert into emp_1 values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp_1 values (8, 'Ashish', 200,5000,2,12);
insert into emp_1 values (9, 'Mukesh',300,6000,6,51);
insert into emp_1 values (10, 'Rakesh',500,7000,6,50);
select * from emp_1;
select e1.emp_id,e1.emp_name,m.emp_name as manager,sm.emp_name as senior_manager
from emp_1 as e1
left join emp_1 as m on m.emp_id=e1.manager_id 
left join emp_1 as sm on m.manager_id =sm.emp_id
