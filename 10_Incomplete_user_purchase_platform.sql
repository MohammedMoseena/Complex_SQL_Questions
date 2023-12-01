/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/
use complex_sql;

create table if not exists spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);
truncate table spending;
insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

select * from spending;
-- spend_date,platform,total_amount,total_users
with table2 as
(
select spend_date,user_id,sum(amount) as amount,max(platform) as platform
from spending
group by user_id,spend_date
having count(*)=1
UNION
select spend_date,user_id,sum(amount) as amount,'both' as platform
from spending
group by user_id,spend_date
having count(*)=2
),table1 as
(
select 'mobile' as platform
union all 
select 'desktop' as platform
union all 
select 'both' as platform
)


select table2.*,table1.platform as p2
from table2 
right join table1 
on table1.platform=table2.platform
order by spend_date,user_id;
