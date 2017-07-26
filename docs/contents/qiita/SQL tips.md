# SQL tips
## テストのためのテーブル差分確認用のSQL
### なぜSQLで行うか
- exportしてから行うのはめんどう
- exportする場合、事前にsortする必要がある
- データ量が多くてexportもdiffとるのも大変

```sql
select "a-b", * from actual_table
except
select "a-b", * from expected_table
union all
select "b-a", * from expected_table
except
select "b-a", * from actual_table
```

## 横持ちを縦持ちに
逆はよくやるけど、こちらはあまりやらないので忘れてしまうためメモ

- よくある横持ちを縦持ちにするクエリ
- M人のN種類のサマった結果（M * N）の表を
- 種類別のレコードM * N行に変換する
- ただし、IDとサマった結果に加えて種類の列が追加される（M*N * 3）

```sql
create table yoko
(
	id int
	, a_cnt int
	, b_cnt int
	, c_cnt int
)
;
insert into yoko values
(1, 1, 2, 3)
, (2, 4, 5, 6)
, (3, 7, 8, 9)
;
create table names
(
	id int
	, name varchar
)
;
insert into names values
(1, 'a'), (2, 'b'), (3, 'c')
;
-- yoko to tate
select
	yoko.id
	, p.id
	, p.name
	, case
		when p.id = 1 then yoko.a_cnt
		when p.id = 2 then yoko.b_cnt
		when p.id = 3 then yoko.c_cnt
		else null
	end as cnt
from yoko
cross join names  as p
```

下記の各種cntをIDによって使うものを変えるだけ

| id | a_cnt | b_cnt | c_cnt | id | name |
|----|-------|-------|-------|----|------|
| 1 | 1 | 2 | 3 | 1 | a |
| 2 | 4 | 5 | 6 | 1 | a |
| 3 | 7 | 8 | 9 | 1 | a |
| 1 | 1 | 2 | 3 | 2 | b |
| 2 | 4 | 5 | 6 | 2 | b |
| 3 | 7 | 8 | 9 | 2 | b |
| 1 | 1 | 2 | 3 | 3 | c |
| 2 | 4 | 5 | 6 | 3 | c |
| 3 | 7 | 8 | 9 | 3 | c |

### pandas version
https://gist.github.com/ksomemo/bc9b336ab7e0aa604eae

## with 複数
```sql
with aaa as (
  select 1 as a
)
, bbb as (
  select a, 1 as b
  from aaa
)
select a, b, 1 as c
from bbb

-- a b c
-- 1 1 1
```
