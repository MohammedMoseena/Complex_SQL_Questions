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
-- Points tables for ICC tournament
select Team_name,count(*) as Matches_played,sum(win_flag) as no_of_wins,(count(*)-sum(win_flag)) as no_of_loss
from
(select Team_1 as Team_name,if(Winner=Team_1,1,0) as win_flag
from icc_world_cup 
union all 
select Team_2 as Team_name,if(Winner=Team_2,1,0) as win_flag
from icc_world_cup) as t
group by Team_name
order by 3 desc;