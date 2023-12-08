use complex_sql;
CREATE TABLE if not exists int_orders(
 order_number int NOT NULL,
 order_date date NOT NULL,
 cust_id int NOT NULL,
 salesperson_id int NOT NULL,
 amount float NOT NULL
);
truncate table int_orders;
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (70, CAST('1998-05-06' AS Date), 9, 7, 150);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);

select * from int_orders;
/*Find the largest order by value for each salesperson and display order details
get the results without using sub-query,cte,window functions,temp tables*/
select io1.order_number,io1.order_date,io1.cust_id,io1.salesperson_id,io1.amount
from int_orders as io1
left join int_orders as io2
on io1.salesperson_id=io2.salesperson_id
group by io1.order_number,io1.order_date,io1.cust_id,io1.salesperson_id,io1.amount
having io1.amount>=max(io2.amount)
order by io1.order_number