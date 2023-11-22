create database if not exists complex_sql;
use complex_sql;
drop table if exists flights;
CREATE TABLE flights 
(
 cid VARCHAR(512),
 fid VARCHAR(512),
 origin VARCHAR(512),
 Destination VARCHAR(512)
);

INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f1', 'Del', 'Hyd');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f2', 'Hyd', 'Blr');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f3', 'Mum', 'Agra');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f4', 'Agra', 'Kol');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('3', 'f5', 'AP', 'Tel');

select * from flights;



with table1 as
(
select f.*,row_number() over(partition by cid order by fid asc) as origin_order,
row_number() over(partition by cid order by fid desc) as Destination_order
from flights as f
)
select t1.cid,t1.origin,t2.Destination
from table1 as t1
join table1 as t2
on (t1.cid=t2.cid) and (t1.origin_order=1) and (t2.Destination_order=1)

