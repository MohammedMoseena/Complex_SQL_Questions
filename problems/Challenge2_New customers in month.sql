create database if not exists complex_sql;
use complex_sql;
drop table if exists sales;

CREATE TABLE sales 
(
 order_date date,
 customer VARCHAR(512),
 qty INT
);

INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C1', '20');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C2', '30');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C1', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C3', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C5', '19');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C4', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C3', '13');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C5', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C6', '10');

select * from sales;

select  order_date_1 as Month,sum(if((t.first_order_date=t.order_date_1),1,0)) as new_customers_count
from 
(select  date_format(order_date,'%Y-%m') as order_date_1,s.customer,
min(date_format(order_date,'%Y-%m')) over(partition by s.customer) as first_order_date
from sales as s)
as t
group by order_date_1
order by 1;

