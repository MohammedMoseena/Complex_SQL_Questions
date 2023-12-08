-- customer retention and customer churn metrices
-- customer retention
/*Customer retention refers to a companys ability to turn customers into repeat customers
and prevent them from switching to a competitor.
It indicates whether your product and the quality of your service please your 
existing customers 
reward programs(credit card companies)
Wallet cash back(paytm/gpay)
Zomato pro/swiggy super
retention period(depends on campany but here assume one month
*/
use complex_sql;
create table if not exists transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
truncate table transactions;
insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;
select * from transactions;
-- Retention Customers
select MONTHNAME(this_month.order_date) as 'Month',count(distinct last_month.cust_id) as retention_customer_count
from transactions as this_month
left join  transactions as last_month
on (this_month.cust_id=last_month.cust_id) and 
(MONTH(this_month.order_date)= MONTH(last_month.order_date) + 1)
group by MONTHNAME(this_month.order_date);

-- Churn customers
select *
from transactions as this_month
left join transactions as  last_month
on (this_month.cust_id=last_month.cust_id) and 
(month(this_month.order_date)-month(last_month.order_date)=1)


