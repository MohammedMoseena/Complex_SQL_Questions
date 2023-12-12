use complex_sql;
create table if not exists Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);
truncate table Ameriprise_LLC;
insert into Ameriprise_LLC values
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');

select * from Ameriprise_LLC;
with table1 as
(
select teamID
from Ameriprise_LLC
where Criteria1='Y' and Criteria2='Y'
group by teamID
having count(memberID)>=2
)

select 
* , 
case
when (a.Criteria1='Y' and a.Criteria2='Y' and a.teamID in (select * from table1)) then 'Y'
else 'N'
end as Qualify_for_program
from Ameriprise_LLC as a;
