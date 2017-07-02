## sqlserver2014から移行前提のメモ

- with使える
- convert(date, column) が使えなかった
- 代わりに cast(column as date) or column::date
- dateadd, datediff は使えた
- explain 使える


### 変数利用
- declare @varname type = value が使えない(t-sqlなので当たり前)
- 使えない＋下記構文より、定型クエリの微調整がめんどうだった

```prepared_statement.sql
prepare prep_select_plan (int, varchar) 
as 
select
  *
  , $2 as myvar 
from
  table_name
where id = $1;
execute prep_select_plan (2, 'aa');
execute prep_select_plan (3, 'bb');
deallocate prep_select_plan;
```

### 一時テーブル
- #になれたせいか、とても面倒に感じた
- global一時テーブル##table_name に似たものは未調査

```temporary_table.sql
create temporary table temp_table_name1 (id int, name varchar);

select *
into temporary table temp_table_name
from (
  select 1 as class, 2 as v1, 3 as v2
  union all select 1, 4, 5 
  union all select 2, 6, 7 
  union all select 2, 8, 9 
) t
```

### Window関数
- sqlserverにもあるけど今回初めて知った
- listagg within groupを初めて見た

```listagg.sql
select
  class
  , listagg(v1, ',') within group (order by null) as a
from temp_table_name
group by
  class
;
select
  listagg(v1, ',') within group (order by class desc) as a
  , count(1)
from temp_table_name
;
select
  class
  , listagg(v1, ',') within group (order by null) over () as a
from temp_table_name
;
select
  class
  , listagg(v1, ',') within group (order by class) over (partition by class) as a
from temp_table_name
```


## postgresqlとの比較

### copy
postgresqlにもある

### 連番テーブル
```generate_series.sql
-- カラムはgenerate_seriesになる
select
  *
from (select * from generate_series(1, 10)) as a
cross join (select * from generate_series(1, 10)) as b
```

### 配列
```array_access.sql
select
  ids
  , case when ids[0] is null then 'null!' else 'not null' end
  , ids[1]
  , ids[2]
  , ids[3]
from (select array[1, 2, 3] as ids) t
```

- sqlserverで使ったことない
- array_agg が使えなかった(縦->横)
- unnest が使えなかった(横->縦)

```array_agg.sql
select
  class
  , array_agg(v1)
from temp_table_name
group by
  class
```

```unnest.sql
select
  string
  , unnest(array[id1, id2, id3]) as id
from (
select
  'str' as string
  , '1' as id1
  , '2' as id2
  , '3' as id3
) as t
```

### json
- sqlserver2014にはなかった
- 2016から使えるらしい (https://blogs.msdn.microsoft.com/jocapc/2015/05/16/json-support-in-sql-server-2016/)

```json.sql
select 
  -- ↓使えなかった
  -- json_to_record('{"key1": "value1", "key2": 2}')
    json_extract_path_text('{"key1": {"nest_key": "nest_value"}, "key2": 2}', 'key1', 'nest_key')
  , json_extract_path_text('{"key1": {"nest_key": "nest_value"}, "key2": 2}', 'key1')
  , json_extract_path_text('{"key1": {"nest_key": "nest_value"}, "key2": 2}', 'key100')
  , json_extract_array_element_text('[1, 2, [3, 4], 5]', 2)
  , json_extract_array_element_text('[1, 2, [3, 4], 5]', 100)
  , json_array_length('[1, 2, [3, 4], 5]')
  --, json_array_length('{"1": 2, "[3, 4]": 5]') -- error
```

### udf
一覧はこれを見る 

```
select * 
from pg_proc
order by proname
```

- http://docs.aws.amazon.com/ja_jp/redshift/latest/dg/c_join_pg.html
- http://stackoverflow.com/questions/33083500/how-to-get-a-list-of-udfs-in-redshift
