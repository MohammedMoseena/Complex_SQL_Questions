use complex_sql;
CREATE TABLE if not exists students(
 studentid int NULL,
 studentname nvarchar(255) NULL,
 subject nvarchar (255) NULL,
 marks int NULL,
 testid int NULL,
 testdate date NULL
);
truncate table students;
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');
select * from students;
-- list of the students who scored  above the average marks in each subject

select studentname,subject
from(
select *,avg(marks) over(partition by subject) as avg_marks
from students) as t
where t.marks>t.avg_marks;

-- Percentage of students who score more than 90 in atleast one subject amogst total students
select   
count(distinct case when marks>90 then studentid else null end)*100/(select count(distinct studentid) from students) as perc_stud_scored_morethan90_atleast_one_sub
from students;


-- second highest and second lowest marks for each subject
select subject,max(second_highest) as second_highest,max(second_lowest) as second_lowest
from
(select subject,
case when desc_order=2 then marks else null end as second_highest,
case when asc_order=2 then marks else null end as second_lowest
from
(
select subject,marks,
rank()  over(partition by subject order by marks desc) as desc_order,
rank()  over(partition by subject order by marks) as asc_order
from students
) as t
) as t2
group by subject;

select studentid,studentname,subject,marks,testdate,
lag(marks) over(partition by studentid order by testdate) as prev_date,
case
when ((marks>lag(marks) over(partition by studentid order by testdate))) then 'increased'
when((marks<lag(marks) over(partition by studentid order by testdate))) then 'decreased'
else null
end as status
from students

