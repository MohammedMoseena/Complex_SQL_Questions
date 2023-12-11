use complex_sql;

ALTER TABLE cricket
MODIFY COLUMN Innings int;
ALTER TABLE cricket
MODIFY COLUMN Runs int;
ALTER TABLE cricket
MODIFY COLUMN Balls_faced int;
ALTER TABLE cricket
MODIFY COLUMN strike_rate int;

select * from cricket;
-- find sachin's milestones
with table1 as
(
select `Match`,Innings,Runs,
sum(Runs) over(order by `Match`) as rolling_sum
from cricket
),
table2 as 
(
select 1 as milestone_number,1000 as milestone_runs
union all
select 2 as milestone_number,5000 as milestone_runs
union all
select 3 as milestone_number,10000 as milestone_runs
union all
select 4 as milestone_number,15000 as milestone_runs
)
select milestone_number,milestone_runs,
min(t1.`Match`) as milestone_match,min(t1.Innings) as milestone_innings
from table1 as t1
join table2 as t2
on rolling_sum>=milestone_runs
group by milestone_number,milestone_runs