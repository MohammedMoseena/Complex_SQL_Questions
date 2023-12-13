use complex_sql;
create table if not exists transactions_1(
transaction_id int,
`type` varchar(20),
amount float,
transaction_date timestamp
);
truncate table transactions_1;
insert into transactions_1 values (19153,'deposit',65.90,'2022-07-10 10:00:00');
insert into transactions_1 values (53151,'deposit',178.55,'2022-07-08 10:00:00');
insert into transactions_1 values (29776,'withdrawal',25.90,'2022-07-08 10:00:00');
insert into transactions_1 values (16461,'withdrawal',45.99,'2022-07-08 10:00:00');
insert into transactions_1 values (77134,'deposit',32.60,'2022-07-10 10:00:00');
select * from transactions_1;
with table1 as
(
select date(transaction_date) as transaction_date,
sum(case when type='withdrawal' then amount*-1 else amount end) as total_sum_day
from transactions_1
group by 1
)
select transaction_date,
round(sum(total_sum_day) over(partition by month(transaction_date) order by transaction_date rows between unbounded preceding and current row ),2) as balance
from table1