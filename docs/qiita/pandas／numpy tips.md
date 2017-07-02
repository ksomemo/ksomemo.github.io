学んだことまとめ

## 定型Import
```py3:import_snippet.py
import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

matplotlib.style.use("ggplot")
%matplotlib inline
```

- numpyもcrosstab時にsumする場合などに使うのでImportしておく
- seabornまだ使ってない -> よく使うようになった
    - matplotlibでどれだけめんどうかを把握した上で使う方がいい

## numpy
### one value
```py3:numpy_array.py
# 配列確保
np.zeros

# すべて1
np.ones

# np.full ?
```

### range
実験用データ, モデルのplotなど)

```py3:numpy_range.py
# rangeとほぼ同様
np.arange

# N分割用
np.linspace

# 各分布に対応
# np.random.rand系
```

### mean / average
- meanは、算術平均
- averageは、重みを付けられる

### ravel / flatten
- ravelは、参照を維持
- flattenは、copy

### .T, transpose
どちらも参照を維持しているので、　.Tでよい

### 結合
[ndarrayの結合](http://qiita.com/ksomemo/items/2f0ce6a88e619db0beef)

### vector同士のmax/min
```py3:numpy_vector同士のmaxとmin.py
np.maximum([1,4],[3,2])
array([3, 4])

np.minimum([1,4],[3,2])
array([1, 2])
```

### 繰り返し
```py3:numpy_繰り返しとおまけ.py
x = np.array([[1,2],[3,4]])
x
array([[1, 2],
       [3, 4]])

np.repeat(x, 3, axis=0)
array([[1, 2],
       [1, 2],
       [1, 2],
       [3, 4],
       [3, 4],
       [3, 4]])

np.repeat(x, 3, axis=1)
array([[1, 1, 1, 2, 2, 2],
       [3, 3, 3, 4, 4, 4]])

# flatten
np.repeat(x, 3, axis=None)
array([1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4])

# scalar
np.repeat(1, 3)
array([1, 1, 1])

## おまけ
import itertools
rep = itertools.repeat(1, 3)
rep
repeat(1, 3)

list(rep)
[1, 1, 1]

rep
repeat(1, 0)

# ∞
rep = itertools.repeat(1)
repeat(1)

list(itertools.islice(rep, 4))
[1, 1, 1, 1]

list(itertools.islice(rep, 2))
[1, 1]

rep
repeat(1)
```

### 実部/虚部と随伴行列
```
A = np.array([[1, -1-1j],[1+1j,1j]])
A
array([[ 1.+0.j, -1.-1.j],
       [ 1.+1.j,  0.+1.j]])

# 転置して虚部の反転
A.real.T + -1j*A.imag.T
array([[ 1.+0.j,  1.-1.j],
       [-1.+1.j,  0.-1.j]])
```

### 三角行列
```
mat_for_tri = np.arange(1, 12+1).reshape(4, 3)
np.tril(mat_for_tri) # lower
np.triu(mat_for_tri) # upper
```

### TODO: 行列分解
#### 固有値分解
```
# numpyの場合、素直に共分散行列を求める(行ごと)
# pandas/Rの場合、勝手に特徴量(列ごと)に対する共分散行列

from sklearn.datasets import load_iris
iris = load_iris()
iris_cov = np.cov(iris.data.T) # default ddof: 1, N-1での共分散
eig_val, eig_vec = np.linalg.eig(iris_cov)
iris_cov = eig_vec @ np.diag(eig_val) @ eig_vec.T
```

#### LU分解
#### QR分解
#### 特異値分解

### [numpy で 鶴亀算 とndarrayのmethod確認しようとして消耗したおまけ](http://qiita.com/ksomemo/items/87ad66a8f4f73e33d645)
逆行列とdot, solveの関係

### 対角行列
```py3:numpy_diag.py
# 1-d: の場合、対角行列を作る
np.diag([2,3])
array([[2, 0],
       [0, 3]])

# 2-d: の場合、対角要素を抜き出す(return 1-d)
```

#### 単位行列
```py3:numpy_eye.py
np.eye(2) or np.identity(2)
array([[ 1.,  0.],
       [ 0.,  1.]])

# np.eyeは単位行列に限らない
```

### [numpyでk-meansを実装したときに使ったもの(Debug込み)](http://qiita.com/ksomemo/items/35e872d734d75710cfef)
- np.argmin
    - 最小となる値にIndex
- np.linalg.norm
    - ユークリッド距離
- np.random.choice
    - あるリストからの選択
- np.all
    - すべてがTrueであるか

### 値をindexにしたCounter
```py3:numpy_bincount.py
np.bincount([1,2,2,4])
# index:0 based to max value
# value:indexの値が現れた回数
# => array([0, 1, 2, 0, 1])
```

### apply axis 0/1
```py3:numpy_apply_along_axis.py
# each columns, max values
np.apply_along_axis(lambda x: max(x), 0, iris.values[:, [0,1,2,3]])

#  each rows, max values
np.apply_along_axis(lambda x: max(x), 1, iris.values[:, [0,1,2,3]])
```

### other
- np.nansum,nanmean, etc.
    - NA対応
    - pandasはdefault
- `np.diff(x, n=2)` は2回np.diffする意味
    - `pd.Series.diff(periods=2)`とは違う

## pandas
### カンマ区切り数値
```py3:pandas_read_csv_thausans.py
import pandas as pd
import io
table_text = """
a b c
1 10,000 1,000,000
"""
pd.read_csv(io.StringIO(table_text), sep=" ", thousands=",")
```

### DataFrameのrow をIndex指定して削除
```py3:pandas_drop_index.py
# df.pivot_tableやpd.crosstabのmargin片方だけ欲しいときに
df.drop("All")
df.drop("All", axis=1)
```

### access cell (row/col)
```py3:pandas_access_cell.py
# pythonのset/getに関わるmagic methodで対応している
df.iloc[0, "column"]
```

### filter rows
```py3:pandas_filter_rows.py
(df.loc[indexer, columns]
   .[lambda d: d.column1 == "a"]
   .pipe(lambda d: d[d.column2.notnull()])
```

### filter columns
```py3:pandas_filter_columns.py
# 以下`axis=1`で列に対して行った場合
# 行に対して行う場合は、grouping後などにやりそう（やったことない

import seaborn as sns

iris = sns.load_dataset("iris")
iris.filter(items=["sepal_length", "species"], axis=1)
# `iris[["sepal_length", "species"]]` と同じだが、keyになくてもエラーにならない

iris.filter(like="petal", axis=1)
# `iris[:, iris.columns.str.contains("petal")]` と同じ

iris.filter(regex="th$", axis=1)
# `iris[:, iris.columns.str.contains("th$")]` と同じ
```

### filter group
```py3:pandas_filter_groupby.py
# GroupByオブジェクトのfilterはDataFrameオブジェクトとは違う
# SQLにおけるhavingでのfilteringに似ているが、返ってくるに値はDataFrame
df = pd.DataFrame(dict(a=list("aabbbcc"), b=range(7)))
df.groupby("a").filter(lambda x: x.shape[0] < 3)
# => DataFrame.shape = (4, 2)
```

### 代入のMethod
- df.assign(column=series)
- method chainとして
- ただし順番を気にする場合は１つずつ or 昇順に問題がない場合

### group化後のungroup(multi index -> index)
```py3:pandas_groupby_after_reset_index.py
# reset_index前提ならば
assert df.groupby(columns).sum().reset_index() == \
       df.groupby(columns, as_index=False).sum()
```

### date range
#### 月ごとのrange
- `pd.date_range(start_date, end_date, freq="MS")`
- datetutilより簡単に扱えるので、分析絡むプロジェクトならいいと思う
- 逆にPython web applicationだとpandasなさそう

#### 過去N日
- pd.rangeのstartは必須ではない
- endとperiodsを指定してあげればよい

### 結合
#### 縦
```py3:pandas_concat_row.py
pd.concat(df_list, ingnore_index=True)`
```

正直、あまり使わないと思うけどメモ

##### append
DataFrameにしないと(indexがないと)index error

```py3:pandas_append_df_dict_series.py
df = pd.DataFrame([range(3), range(2)])
s = df.sum()
df = df.append({0:0,1:2,2:2}, ignore_index=True)
df = df.append(s, ignore_index=True)
df = df.append(pd.DataFrame({'sum': s}).T)
df.append()
```

<pre>
     0  1  2
0    0  1  2
1    0  1  NaN
2    0  2  2
3    0  2  2
sum  0  2  2
</pre>

#### 横結合
```py3:pandas_concat_column.py
# わざわざmergeする必要ないとき
# dummy作ったあとのmergeなど
# df_listの一部がset_indexしているとき、indexが合わないと期待する動きにならない
pd.concat(df_list, axis=1)
```

#### join
by index

#### merge
by column

### 欠損値
#### fillna
```py3:pandas_fillna.py
# 基本scalar
# padの際のbackfillなどを指定できる
# 固定値ではなく、Seriesでも埋められる
# 例:full outer joinしたあとの結合keyを３パターン残す
# 片方それぞれにあるもの２パターン、両方にあるもの１パターン

df_all = df1.merge(df2, how="outer", left_on="key1", right_on="key2")
df_all["key_all"] = df_all["key1"].fillna(df_all["key2"])
```

#### groupby
- nanはgroupから取り除かれる
- 知らないとハマる, 実装上難しいらしい
- 対処法は、区別できる値でfillしておく

#### interpolate
- http://pandas.pydata.org/pandas-docs/stable/missing_data.html にあった
- DataFrame/Seriesのinterpolateを調べる
    - いろんなmethodを指定できる
    - scipyのinterpolateを使うmethodもある
    - https://github.com/pydata/pandas/blob/v0.17.1/pandas/core/generic.py#L3121
http://docs.scipy.org/doc/scipy/reference/tutorial/interpolate.html
- https://github.com/pydata/pandas/blob/99bf170ff326b716810f7012e3effdcb611b6e7e/doc/source/whatsnew/v0.12.0.txt#L110
- 一度duplicatedになって、0.13.0で復活している

### describeのpercentile
http://pandas.pydata.org/pandas-docs/version/0.18.0/generated/pandas.DataFrame.describe.html を見ていたら、ふだん出力されないcategoryと4分位のみの部分を変更できるようなのでメモ

```py3:pandas_desc_detail.py
iris_pandas_url = "https://raw.githubusercontent.com/pydata/pandas/master/doc/data/iris.data"
iris = pd.read_csv(iris_pandas_url)
percentiles = np.linspace(0.1, 0.9, 9)
# 0, 1 はmin/maxなので不要
iris.describe(include="all", percentiles=percentiles).T
```

### add suffix/prefix to columns
```py3:pandas_add_prefix_suffix.py
# https://gist.github.com/ksomemo/20e41f8cd4dad077a2b33c1d914f952d
import seaborn as sns
(sns.load_dataset("iris")
    .add_prefix("prefix_")
    .groupby("prefix_species")
    .mean()
    .add_suffix("_mean"))
```

### series
#### 文字列系Utilityを扱う
- series.str.method
- series.dt.method は0.17から
    - DateTimeIndexはdt経由ではなく直接なので混同しないこと
- window functionも0.18.1から

### 構成比率を見る時の定型
```py3:pandas_normalization.py
# ただし正の数に対して
df.div(df.sum(axis=1), axis=0).plot(kind="bar", stacked=True)
```

### masking
- maskは条件に合うものをmask
- whereは条件に合わないものをmask
    - `np.where`はRのifelseに似ている
    - がpandasではmethod一発ではできない
    - 一旦埋めておく, そのあとに`series.where`でmaskする

### others
- 変化率
    - (nth - (n-1)th) / (n-1)th, shiftだと簡潔に表せそうだが
    - series.pct_change というmethodがある
- 自己相関
    - series.corr(series.shift())
- 上限下限の設定
    - `pd.Series(range(4)).clip(lower=1, upper=2)  == pd.Series([1,1,2,2])`
    - 0,1,2,3 to 1,1,2,2
- [ランダムデータと正規化・標準化](http://qiita.com/ksomemo/items/ff0cbe63455f70bdf751)
- [階級作成とDummy変数の作成](http://qiita.com/ksomemo/items/f658742a18ad804caa5f)
