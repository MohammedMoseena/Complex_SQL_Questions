create database if not exists complex_sql;
use complex_sql;
Create table if not exists Trips(id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));
Create table if not exists Users (users_id int, banned varchar(50), role varchar(50));
Truncate table Trips;
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');
Truncate table Users;
insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');

select * from Trips;
select * from Users;
/*
Write an SQL query to find the cancellation rate of requests unbanned users 
(bot clients and driver must not be banned) each day between "2013-10-01" and "2013-10-03"
Round cancellation rate to two decimal points.
The cancellation rate is computed by dividing the number of canceled(by client or driver)
requests with unbanned users by the total number of requests with unbanned users on that day.
*/


select request_at,(count(*)-(sum(if((t.status='completed'),1,0)))) as cancelled_trips,
count(*) as total_trips,
round((1-(sum(if((t.status='completed'),1,0))/count(*))),2)*100 as cancellation_rate
from Trips as t
join Users as u1 on (t.client_id=u1.users_id)
join Users as u2 on (t.driver_id=u2.users_id)
where (t.request_at between "2013-10-01" and "2013-10-03") and (u1.banned='No')
and (u2.banned='No')
group by request_at;


