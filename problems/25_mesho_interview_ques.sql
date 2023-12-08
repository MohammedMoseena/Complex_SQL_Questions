use complex_sql;
create table if not exists products_1
(
product_id varchar(20) ,
cost int
);
truncate table products_1;
insert into products_1 values ('P1',200),('P2',300),('P3',500),('P4',800);

create table if not exists customer_budget
(
customer_id int,
budget int
);
truncate table customer_budget;
insert into customer_budget values (100,400),(200,800),(300,1500);

select * from products_1;
select * from customer_budget;

with table1 as
(
select p.*,sum(cost) over(order by cost) as running_cost
from products_1 as p
)
select  customer_id,group_concat(product_id) as list_products 
from customer_budget as c
left join table1 as t
on t.running_cost<c.budget
group by customer_id;