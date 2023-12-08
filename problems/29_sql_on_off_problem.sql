use complex_sql;
create table if not exists  event_status
(
event_time varchar(10),
status varchar(10)
);
truncate table event_status;
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');
select * from event_status;
select min(event_time) as login_time,max(event_time) as logout_time,
(count(*)-1) as cnt
from
(
select *,sum(case when (status='on' and prev_status='off') then 1 else 0 end) over(order by event_time) as group_key
from
(
select *,
lag(status,1,'on') over(order by event_time) as prev_status
from event_status
) as t
) as t2
group by group_key

