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
select *
from transactions as t1
left join transactions as t2
on (t1.cust_id=t2.cust_id) and (month(t1.order_date)=1+month(t2.order_date));

select monthname((t1.order_date)) as `Month`,
count(distinct t2.cust_id) as retention_customers_count
from transactions as t1
left join transactions as t2
on (t1.cust_id=t2.cust_id) and (month(t1.order_date)=1+month(t2.order_date))
group by monthname(t1.order_date)
-- having min(month(t1.order_date))>(select min(month(order_date)) from transactions);

/*
(select count(distinct cust_id)  from transactions) as total_customers,
sum(if((t2.cust_id is not null),1,0)) as retained_customers_count,
(((select count(distinct cust_id)  from transactions)-sum(if((t2.cust_id is not null),1,0))))as churn_customers_count,
round((sum(if((t2.cust_id is not null),1,0))/count(distinct t1.cust_id))*100,2) as retention_rate,
round(100-(sum(if((t2.cust_id is not null),1,0))/count(distinct t1.cust_id))*100,2) as churn_rate



*/