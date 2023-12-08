use complex_sql;
create table if not exists tasks (
date_value date,
state varchar(10)
);
truncate table tasks;
insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success');

select * from tasks;

-- startdate,enddate,state

with table1 as
(
select t.*,row_number() over(partition by state order by date_value) as rn,
date_sub(t.date_value,INTERVAL row_number() over(partition by state order by date_value) DAY) as date_diff
from tasks as t
order by date_value
)

select min(date_value) as start_date,max(date_value) as end_date,state
from table1
group by date_diff,state



