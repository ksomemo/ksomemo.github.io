# pd.options.mode.chained_assignment
## Noneにして無視しないために
- http://pandas.pydata.org/pandas-docs/stable/indexing.html#why-does-assignment-fail-when-using-chained-indexing
- http://pandas.pydata.org/pandas-docs/stable/indexing.html#indexing-view-versus-copy

- DataFrameを使いまわさなければ良い
- 使いまわしたいとしても、copy()すればよい
- copyを使わずcopyするパターンを知る

## warningが発生するパターン
- DataFrame作成
- DataFrameから使用する特定カラムを抜き出して別のDataFrameとする
- そのDataFrameのカラムを使って新しいカラムを追加する

```py3
import seaborn as sns

iris = sns.load_dataset("iris")
iris2 = iris[["sepal_length", "sepal_width"]]#.copy()

# iris2 = iris[["sepal_length", "sepal_width"]].copy()
# iris2 = iris.loc[: , ("sepal_length", "sepal_width")]

iris2["lenght_2x"] = iris2["sepal_length"] * 2
```
