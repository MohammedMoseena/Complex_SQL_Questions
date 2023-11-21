create database if not exists complex_sql;
use complex_sql;
drop table if exists icc_world_cup;
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

-- Team_Name,Matches_played,no_of_wins,no_of_losses

select Team_1
from icc_world_cup 
union
select Team_2
from icc_world_cup 