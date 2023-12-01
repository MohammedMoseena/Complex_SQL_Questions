use complex_sql;
create table if not exists sales_1 (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

truncate table sales_1 ;
insert into sales_1  (product_id,period_start,period_end,average_daily_sales)values
(1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);
select * from sales_1 ;
-- product_id,report_year,total_amount
with recursive table1 as
( select min(period_start) as dates,max(period_end) as max_date
from sales_1
UNION ALL 
select date_add(dates,INTERVAL 1 DAY) as dates,max_date
from table1
where dates<max_date
)
select product_id,YEAR(dates) as reported_year,
sum(average_daily_sales) as total_sales
from table1
join sales_1 on dates between period_start and period_end
group by product_id,YEAR(dates)
order by product_id,dates

