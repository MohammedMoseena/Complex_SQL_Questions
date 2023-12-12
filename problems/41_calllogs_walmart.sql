use complex_sql;
create table if not exists phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);
truncate table phonelog;
insert into phonelog(Callerid, Recipientid, Datecalled) values
(1, 2, '2019-01-01 09:00:00.000'),
(1, 3, '2019-01-01 17:00:00.000'),
(1, 4, '2019-01-01 23:00:00.000'),
(2, 5, '2019-07-05 09:00:00.000'),
(2, 3, '2019-07-05 17:00:00.000'),
(2, 3, '2019-07-05 17:20:00.000'),
(2, 5, '2019-07-05 23:00:00.000'),
(2, 3, '2019-08-01 09:00:00.000'),
(2, 3, '2019-08-01 17:00:00.000'),
(2, 5, '2019-08-01 19:30:00.000'),
(2, 4, '2019-08-02 09:00:00.000'),
(2, 5, '2019-08-02 10:00:00.000'),
(2, 5, '2019-08-02 10:45:00.000'),
(2, 4, '2019-08-02 11:00:00.000');
select * from phonelog;
with table1 as
(
select Callerid,date(Datecalled) as onlydate,min(Datecalled) as first_call,max(Datecalled) as last_call
from phonelog
group by Callerid,date(Datecalled)
)
select t1.Callerid,t1.onlydate,t1.first_call,t1.last_call,
p1.Recipientid as first_Recipientid,
p2.Recipientid as last_Recipientid
from table1 as t1
inner join phonelog as p1 on (p1.Callerid=t1.Callerid) and (p1.Datecalled=t1.first_call)
inner join phonelog as p2 on (p2.Callerid=t1.Callerid) and (p2.Datecalled=t1.last_call)
where p1.Recipientid=p2.Recipientid;