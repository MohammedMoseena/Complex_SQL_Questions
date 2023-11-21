create database if not exists complex_sql;
use complex_sql;
drop table if exists customer_orders;
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
insert into customer_orders values
(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);

select * from customer_orders;
-- order_date,new_customers,repeat_customers
with first_visit_data as (
select customer_id,min(order_date) as first_visit_date
from customer_orders
group by customer_id
)

select co.order_date,sum(if((co.order_date=first_visit_date),1,0)) as new_customers,sum(if((co.order_date!=first_visit_date),1,0)) as repeat_customers,
sum(if((co.order_date=first_visit_date),co.order_amount,0)) as revenue_from_new_customers,sum(if((co.order_date!=first_visit_date),co.order_amount,0)) as revenue_from_repeat_customers
from  first_visit_data as fv
join customer_orders as co
on co.customer_id=fv.customer_id
group by co.order_date;

/*
METHOD-2(uSING WINDOW FUNCTION)
select order_date,sum(if((order_date=first_visit_date),1,0)) as new_customers,sum(if((order_date!=first_visit_date),1,0)) as repeat_customers,
sum(if((order_date=first_visit_date),order_amount,0)) as revenue_from_new_customers,sum(if((order_date!=first_visit_date),order_amount,0)) as revenue_from_repeat_customers
from 
(select co.*, (min(order_date)  over(partition by customer_id)) as first_visit_date from customer_orders as co) as t
group by order_date;
*/