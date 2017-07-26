# pandas window function関連と0.18.1の機能試した(+条件付きgroupby集計
## window function code

- window functionを試した
- rollingを使った移動系集計
- transformを使ったWindow function
    - window内全体に同じ結果
    - 累積や移動系の集計

```py3
import pandas as pd
import seaborn as sns


# http://pandas.pydata.org/pandas-docs/version/0.18.1/whatsnew.html
iris = sns.load_dataset("iris")
iris = pd.concat([iris.head(3), iris.ix[50:52], iris.ix[100:102]]).reset_index(drop=True)

res = pd.concat([
        iris.sepal_length,
        iris.sepal_length.shift(),
        iris.sepal_length.shift(periods=-1),
        iris.sepal_length.cumsum(),
        iris.sepal_length.rolling(window=3).sum(),
        iris.sepal_length.rolling(window=3, center=True).sum(),
        iris.sepal_length.rolling(window=4, center=True).sum(),
        iris.sepal_length.expanding().sum(),
        iris.groupby("species")["sepal_length"].transform(np.sum),
        iris.groupby("species")["sepal_length"].transform(pd.Series.cumsum),
        iris.groupby("species").apply(lambda x: x.expanding().sepal_length.sum()).reset_index(drop=True),
        iris.groupby("species").expanding().sepal_length.sum().reset_index(level=0, drop=True),
        iris.groupby("species").sepal_length.shift(),
        iris.groupby("species").sepal_length.shift(periods=-1),
    ], axis=1)
res.columns = [
    "default",
    "shift_down",
    "shift_up",
    "cumsum",
    "roll3_sum",
    "roll3_sum_c",
    "roll4_sum_c", # 偶数の場合, どの範囲になるかの確認のため
    "ex_sum",      # cumsum
    "trans_sum",   # SQL Window関数におけるGroup内すべてと同様
    "trans_cumsum",# group内cumsum
    "g_ex_old_sum",
    "g_ex_sum",    # group内cumsum
    "g_shift_down",# group内shift
    "g_shift_up",
]

import tabulate
print(tabulate.tabulate(res, headers="keys", tablefmt="pipe"))
res
```

### window functionの結果
|    |   default |   shift_down |   shift_up |   cumsum |   roll3_sum |   roll3_sum_c |   roll4_sum_c |   ex_sum |   trans_sum |   trans_cumsum |   g_ex_old_sum |   g_ex_sum |   g_shift_down |   g_shift_up |
|---:|----------:|-------------:|-----------:|---------:|------------:|--------------:|--------------:|---------:|------------:|---------------:|---------------:|-----------:|---------------:|-------------:|
|  0 |       5.1 |        nan   |        4.9 |      5.1 |       nan   |         nan   |         nan   |      5.1 |        14.7 |            5.1 |            5.1 |        5.1 |          nan   |          4.9 |
|  1 |       4.9 |          5.1 |        4.7 |     10   |       nan   |          14.7 |         nan   |     10   |        14.7 |           10   |           10   |       10   |            5.1 |          4.7 |
|  2 |       4.7 |          4.9 |        7   |     14.7 |        14.7 |          16.6 |          21.7 |     14.7 |        14.7 |           14.7 |           14.7 |       14.7 |            4.9 |        nan   |
|  3 |       7   |          4.7 |        6.4 |     21.7 |        16.6 |          18.1 |          23   |     21.7 |        20.3 |            7   |            7   |        7   |          nan   |          6.4 |
|  4 |       6.4 |          7   |        6.9 |     28.1 |        18.1 |          20.3 |          25   |     28.1 |        20.3 |           13.4 |           13.4 |       13.4 |            7   |          6.9 |
|  5 |       6.9 |          6.4 |        6.3 |     35   |        20.3 |          19.6 |          26.6 |     35   |        20.3 |           20.3 |           20.3 |       20.3 |            6.4 |        nan   |
|  6 |       6.3 |          6.9 |        5.8 |     41.3 |        19.6 |          19   |          25.4 |     41.3 |        19.2 |            6.3 |            6.3 |        6.3 |          nan   |          5.8 |
|  7 |       5.8 |          6.3 |        7.1 |     47.1 |        19   |          19.2 |          26.1 |     47.1 |        19.2 |           12.1 |           12.1 |       12.1 |            6.3 |          7.1 |
|  8 |       7.1 |          5.8 |      nan   |     54.2 |        19.2 |         nan   |         nan   |     54.2 |        19.2 |           19.2 |           19.2 |       19.2 |            5.8 |        nan   |

## 条件付きgroupby集計
- 今回の例は`sum(case when x % 2 = 0 then x else 0 end)`
- havingは集計後のfilteringなので違う

```py3
df = pd.DataFrame(
    {
        "type": list("aaaabbbbcccc"),
        "v": range(12),
    }
)
print(df.groupby("type")["v"].apply(lambda x: x[x%2==0].sum()))
"""
type
a     2
b    10
c    18
Name: v, dtype: int64
"""

def _t(x):
    x[x%2!=0] = 0
    return x.cumsum()

conditional_df = pd.concat(
    [
        df,
        df["v"].apply(lambda x: x if x%2==0 else 0),
        df["v"].apply(lambda x: x if x%2==0 else 0).cumsum(),
        df.groupby("type")["v"].transform(lambda x: x[x%2==0].sum()),
        df.groupby("type")["v"].transform(lambda x: x[x%2==0].cumsum()),
        df.groupby("type")["v"].transform(_t),
    ], axis=1)
conditional_df.columns = ["type", "v", "奇数は0(以後同様に0)", "cumsum", "group sum",  "group cumsum(期待値と異なる)", "group cumsum"]
conditional_df
```

### 結果
|    | type   |   v |   奇数は0(以後同様に0) |   cumsum |   group sum |   group cumsum(期待値と異なる) |   group cumsum |
|---:|:-------|----:|---------------:|---------:|------------:|------------------------:|---------------:|
|  0 | a      |   0 |              0 |        0 |           2 |                       0 |              0 |
|  1 | a      |   1 |              0 |        0 |           2 |                       2 |              0 |
|  2 | a      |   2 |              2 |        2 |           2 |                       0 |              2 |
|  3 | a      |   3 |              0 |        2 |           2 |                       2 |              2 |
|  4 | b      |   4 |              4 |        6 |          10 |                       4 |              4 |
|  5 | b      |   5 |              0 |        6 |          10 |                      10 |              4 |
|  6 | b      |   6 |              6 |       12 |          10 |                       4 |             10 |
|  7 | b      |   7 |              0 |       12 |          10 |                      10 |             10 |
|  8 | c      |   8 |              8 |       20 |          18 |                       8 |              8 |
|  9 | c      |   9 |              0 |       20 |          18 |                      18 |              8 |
| 10 | c      |  10 |             10 |       30 |          18 |                       8 |             18 |
| 11 | c      |  11 |              0 |       30 |          18 |                      18 |             18 |

## おまけranking
```py3
s = pd.Series([1,2,2,3,4])
rank_df = pd.DataFrame().assign(value=s)
rank_df = rank_df.assign(
    default=s.rank(),
    first_rank=s.rank(method="first"),
    dense=s.rank(method="dense"),
    min_rank=s.rank(method="min"),
    max_rank=s.rank(method="max")
).astype(int)

import tabulate
print(tabulate.tabulate(rank_df, headers="keys", tablefmt="pipe"))
rank_df
# 一度に複数assignすると下記のようにカラムは名前のsort順になる
# => dictからDataFrameを作ったときと同じ
```

|    |   value |   default |   dense |   first_rank |   max_rank |   min_rank |
|---:|--------:|----------:|--------:|-------------:|-----------:|-----------:|
|  0 |       1 |         1 |       1 |            1 |          1 |          1 |
|  1 |       2 |         2 |       2 |            2 |          3 |          2 |
|  2 |       2 |         2 |       2 |            3 |          3 |          2 |
|  3 |       3 |         4 |       3 |            4 |          4 |          4 |
|  4 |       4 |         5 |       4 |            5 |          5 |          5 |
