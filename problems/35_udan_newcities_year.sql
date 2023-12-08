use complex_sql;
create table if not exists business_city (
business_date date,
city_id int
);
truncate table business_city;
insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);
select * from business_city;

-- method-1
with table1 as
(select YEAR(business_date) as `year`,city_id
from business_city
)
select t1.`year`,sum(if(((t2.`year` is null) and (t2.city_id is null)),1,0)) as new_cities
from table1 as t1
left join table1 as t2
on (t1.`year`>t2.`year`) and (t1.city_id=t2.city_id)
group by t1.`year`;







-- method-2

select YEAR(business_date) as `year`,
sum(if(( first_date=business_date),1,0)) as new_cities
from(
select *,min(business_date) over(partition by city_id) as first_date
from business_city
) as t

group by YEAR(business_date);

