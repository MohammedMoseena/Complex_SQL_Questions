select * from tbl_orders_copy;
select * from tbl_orders;
with table1 as
(
select present.order_id as present_order_id,past.order_id as past_order_id
from tbl_orders as present
left join tbl_orders_copy as past on present.order_id=past.order_id
union
select present.order_id as present_order_id,past.order_id as past_order_id
from tbl_orders as present
right join tbl_orders_copy as past on present.order_id=past.order_id
)
select coalesce(present_order_id,past_order_id) as order_id,
case when past_order_id is null then 'I'
else 'D'
end as flag
from table1
where (present_order_id is null) or (past_order_id is null)
order by 1;
