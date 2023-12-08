use complex_sql;
create table if not exists  billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
truncate table  billings;
insert into billings values
('Sachin',str_to_date('01-JAN-1990','%d-%b-%Y'),25)
,('Sehwag' ,str_to_date('01-JAN-1989','%d-%b-%Y'), 15)
,('Dhoni' ,str_to_date('01-JAN-1989','%d-%b-%Y'), 20)
,('Sachin' ,str_to_date('05-Feb-1991','%d-%b-%Y'), 30)
;

create table if not exists  HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
truncate table HoursWorked;
insert into HoursWorked values
('Sachin', str_to_date('01-JUL-1990','%d-%b-%Y') ,3)
,('Sachin',str_to_date('01-AUG-1990','%d-%b-%Y') , 5)
,('Sehwag',str_to_date('01-JUL-1990','%d-%b-%Y'), 2)
,('Sachin',str_to_date('01-JUL-1991','%d-%b-%Y'), 4);
select * from billings;
select * from HoursWorked;
with table1 as 
(
select b.emp_name,b.bill_date as start_date,
lead(date_sub(bill_date,INTERVAL 1 DAY),1,'9999-01-01') over(partition by emp_name order by bill_date) as end_date,
b.bill_rate
from billings as b
)
select h.emp_name,sum(h.bill_hrs*t.bill_rate) as total_charges
from HoursWorked as h
join table1 as t
on (h.emp_name=t.emp_name) and (h.work_date between t.start_date and t.end_date)
group by h.emp_name;

