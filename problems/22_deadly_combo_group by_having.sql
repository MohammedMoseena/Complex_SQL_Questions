use complex_sql;
create table if not exists exams (student_id int, subject varchar(20), marks int);
truncate table exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

select * from exams;
-- Find students who got same marks in chemistry and physics
select student_id
from exams
where `subject` in ('Chemistry','Physics')
group by student_id
having (count(distinct `subject`)=2) and (count(distinct `marks`)=1);