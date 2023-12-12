use complex_sql;
create table if not exists brands 
(
category varchar(20),
brand_name varchar(20)
);
truncate table brands;
insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');
select * from brands;

with table1 as
(
select * ,row_number() over(order by (select null)) as rn
from brands
),
table2 as
(
select *,lead(rn,1,9999) over(order by rn) as next_one
from table1
where category is not null
)
select t2.category as category,t1.brand_name as brand_name
from table1 as t1
join table2 as t2
on t1.rn between t2.rn and (t2.next_one-1);