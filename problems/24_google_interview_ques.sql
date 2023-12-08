use complex_sql;
create table if not exists company_users 
(
company_id int,
user_id int,
language varchar(20)
);
truncate table company_users;
insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

select * from company_users;
-- find companies who have atleast 2 users who speaks english and german both the language
with table1 as 
(
select user_id
from company_users as c
where language in ('English','German')
group by user_id
having (count(distinct language)=2)
)

select company_id
from company_users
where user_id in (select * from table1)
group by company_id
having count(distinct user_id)>=2

