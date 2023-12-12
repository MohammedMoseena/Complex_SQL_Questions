use complex_sql;
create table if not exists students_1
(
student_id int,
student_name varchar(20)
);
truncate table students_1;
insert into students_1 values
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

create table if not exists exams_1
(
exam_id int,
student_id int,
score int);
truncate table exams_1;
insert into exams_1 values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);

select * from students_1;
select * from exams_1;
with table1 as
(
select *,min(score) over(partition by exam_id) as min_marks,
max(score) over(partition by exam_id) as max_marks,
case
when ((score!=min(score) over(partition by exam_id)) and (score!=max(score) over(partition by exam_id))) then 0
else 1
end as red_flag
from exams_1
)
select student_id as Quite_student_id,student_name as Quite_student_name
from students_1
where student_id in
(
select student_id 
from table1
group by student_id
having (min(red_flag)=0 and max(red_flag)=0)
)