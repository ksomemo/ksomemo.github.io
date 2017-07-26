# unique count without distinct
```sql
-- sql server
with
tmp as (
	select
		uid
		, num
		--, count(distinct num) over (partition by uid)
		, dense_rank() over (
			partition by uid
			order by num
		) as _dense_rank
	from (
		select
			'a' as uid
			, 1 as num
		union all select 'a' , 1
		union all select 'a' , 3
		union all select 'b' , 1
		union all select 'b' , 1
		union all select 'b' , 1
		union all select 'b' , 3
		union all select 'b' , 3
		union all select 'b' , 5
	) as v
)
select
	*
	, max(_dense_rank) over (
		partition by uid
	) as uniq_count_window
from tmp
```
