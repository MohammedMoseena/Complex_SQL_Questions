use complex_sql;
create table if not exists orders_1
(
order_id int,
customer_id int,
product_id int
);
truncate table orders_1;
insert into orders_1 VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table if not exists products (
id int,
name varchar(10)
);
truncate table products;
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');
select * from orders_1;
select * from products;
select concat(p1.`name`,' ',p2.`name`) as pair,count(*) as purchase_freq
from orders_1 as o1
join orders_1 as o2
on (o1.order_id=o2.order_id) 
and (o1.product_id<o2.product_id) 
join products as p1 on (o1.product_id=p1.id) 
join products as p2 on (o2.product_id=p2.id) 
group by p1.`name`,p2.`name`

