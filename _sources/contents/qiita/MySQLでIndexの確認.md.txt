```sql
show index from xxx
```

では単一テーブルだけしか調べられず面倒なので、

```sql
select *
from information_schema.STATISTICS
where TABLE_SCHEMA like '%xxxx%'
and INDEX_NAME <> 'PRIMARY'
order by TABLE_SCHEMA, TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX
```

information_schemaを使用して柔軟に調べられるようにする。
