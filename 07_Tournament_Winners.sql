use complex_sql;
create table if not exists players
(player_id int,
group_id int);
truncate table players;
insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table if not exists matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);
truncate table matches;
insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

select * from players;
select * from matches;

with table1 as 
(
select m1.first_player as player,m1.first_score as score
from matches as m1
union all
select m2.second_player as player,m2.second_score as score
from matches as m2
),
table2 as
(
select t1.player as player_id,p.group_id,sum(score) as total_score,
row_number() over(partition by p.group_id order by sum(score) desc,p.player_id asc) as rn
from table1 as t1
join players as p
on t1.player=p.player_id
group by p.group_id,t1.player
)
select group_id,player_id,total_score
from table2
where rn=1;


