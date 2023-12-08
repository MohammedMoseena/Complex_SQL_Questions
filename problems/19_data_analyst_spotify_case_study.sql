use complex_sql;
CREATE table if not exists activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
truncate table activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');
select * from activity;

/*Question 1:find total actve users each day
*/
select event_date,count(distinct user_id) as total_active_users
from activity
group by event_date;

/*Question 2:find total actve users each week
*/
select  week(event_date) as `week`,count(distinct user_id) as total_active_users
from activity
group by week(event_date);

/*Question-3:Data wise total number of users who made the purchase same day they 
installed the app
*/
-- method-1
select event_date,count(distinct t.new_user_id) as no_of_users_same_day_purchase
from (
select user_id,event_date,
case
when count(distinct event_name)<2 then null
else user_id 
end as new_user_id 
from activity
group by user_id,event_date) as t
group by event_date;
/* 
METHOD-2
select a1.event_date,count(distinct a2.user_id) as no_of_users_same_day_purchase
from activity as a1
left join activity as a2
on (a1.user_id=a2.user_id) and (a1.event_name='app-installed' and a2.event_name='app-purchase')
and (a1.event_date=a2.event_date)
group by a1.event_date
*/
/*Question-4:Percentage of paid users in India,USA and any other country should be tagged
*/
select
case when country in ('India','USA') then country
else 'other'
end as new_country,
round((count(distinct user_id)*100/(select count(distinct user_id) from activity where event_name='app-purchase')),2)  as no_users_purchased
from activity
where event_name='app-purchase'
group by (case when country in ('India','USA') then country
else 'other'
end);


select 
a1.event_date,count(distinct a2.user_id) as no_of_users_same_day_purchase
from activity as a1
left join activity as a2
on (a1.user_id=a2.user_id) and (a2.event_name='app-installed' and a1.event_name='app-purchase')
and (a1.event_date=date_add(a2.event_date,INTERVAL 1 DAY))
group by a1.event_date
