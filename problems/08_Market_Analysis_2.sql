use complex_sql;

create table if not exists users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));
truncate table users;
 create table if not exists orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );
truncate table orders;
 create table if not exists items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );
truncate table items;

 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);
 
select * from users;
select * from items;
select * from orders;



with table1 as
(
select seller_id,item_id
from
(select seller_id,item_id,
row_number() over(partition by seller_id order by order_date) as rn
from orders
) as t
where rn=2
)
select u.users_id as seller_id,if((u.`role`=i.item_brand),'Yes','No') as second_item_favorite_brand
from table1 as t1
right join users as u on u.users_id=t1.seller_id
left join items as i on i.item_id=t1.item_id
order by seller_id;


