use complex_sql;
CREATE TABLE if not exists STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);
truncate table STORES;
INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);
select * from STORES;
-- Find Missing Quarter

-- Method-1(Aggregation)
select Store,
concat('Q',cast(((10-sum(cast((right(`Quarter`,1)) as unsigned)))) as CHAR)) as missing_quarter 
from STORES
group by Store;

-- Method-2(recursive cte)
with recursive table1 as 
(
select distinct Store,1 as q_no from STORES
union all
select Store,(q_no+1)
from table1
where q_no<4
)
, table2 as (
select Store,concat('Q',cast(q_no as char)) as new_Quarter
from table1
)
select t.Store as Store,t.new_Quarter as missing_Quarter
from table2 as t
left join STORES as s
on (t.new_Quarter=s.Quarter) and (t.Store=s.Store)
where s.Quarter is NULL
order by t.Store;

-- Method-3(cross join)
with table3 as
(
select distinct s1.Store,s2.Quarter as new_Quarter
from STORES as s1,STORES as s2
order by s1.Store,s2.Quarter
)
select t.Store as Store,t.new_Quarter as missing_Quarter
from table3 as t
left join STORES as s
on (t.new_Quarter=s.Quarter) and (t.Store=s.Store)
where s.Quarter is NULL
order by t.Store;



