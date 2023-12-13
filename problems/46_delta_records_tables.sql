use complex_sql;
create table if not exists tbl_orders (
order_id integer,
order_date date
);
create table if not exists tbl_orders_copy like tbl_orders;
truncate table tbl_orders;
truncate table tbl_orders_copy;
insert into tbl_orders values (1,'2022-10-21'),(2,'2022-10-22'),
(3,'2022-10-25'),(4,'2022-10-25');
insert into tbl_orders_copy select * from tbl_orders;

select * from tbl_orders;
insert into tbl_orders
values (5,'2022-10-26'),(6,'2022-10-26');
delete from tbl_orders where order_id=1;
select * from tbl_orders_copy;
select * from tbl_orders;