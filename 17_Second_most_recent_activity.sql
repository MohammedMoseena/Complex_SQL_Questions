use complex_sql;
create table if not exists UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);
truncate table UserActivity;
insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');
select * from UserActivity;
with table1 as
(
select u.*,count(*)  over(partition by username ) as total_activities_user,
row_number() over(partition by username order by startDate desc) as rn
from UserActivity as u
)
select t.username,t.activity,t.startDate,t.endDate
from table1 as t
where t.rn=2 or t.total_activities_user=1;