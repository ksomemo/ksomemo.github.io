
## decision tree の hyper parameter
```py3:grid_search_scores.py
import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.cross_validation import KFold
from sklearn.grid_search import GridSearchCV


clf = DecisionTreeClassifier(criterion='entropy', max_depth=2, min_samples_leaf=2)

param_grid = {'max_depth': [2, 3, 4, 5], 'min_samples_leaf': [2, 3, 4, 5]}
cv = KFold(len(y), 5, shuffle=True, random_state=0)

grid_search = GridSearchCV(clf, param_grid, cv=cv, n_jobs=-1, verbose=1)
grid_search.fit(X, y)

grid_search.best_score_, grid_search.best_params_
grid_search.grid_scores_

[mean: 0.76880, std: 0.02381, params: {'max_depth': 2, 'min_samples_leaf': 2},
 mean: 0.76880, std: 0.02381, params: {'max_depth': 2, 'min_samples_leaf': 3},
 mean: 0.76880, std: 0.02381, params: {'max_depth': 2, 'min_samples_leaf': 4},
 mean: 0.76880, std: 0.02381, params: {'max_depth': 2, 'min_samples_leaf': 5},
 mean: 0.80471, std: 0.01474, params: {'max_depth': 3, 'min_samples_leaf': 2},
...
]
```

## pandas.Series.applyでDataFrameを返す
dictのlistを見たら、DataFrameで包んで見やすくしたくなるのでやってみた

### 問題点
flatじゃないので、paramsのcolumnにdictが入っていて見づらい

### 解決までの流れ
- Series.apply の documentに特に記載がなかった
- SeriesからDataFrameといえば、 `pandas.Series.str.split("sep", expand=True)` . 探してみるも自分のpandas core力が低くて断念
- pandas committer のblogにapply時にSeriesで返すとよいと書いてあった
- applyのcodeを見てみるとSeriesの場合にDataFrameで包んで返しているところがあった

```py3:a.py
gs_df = pd.DataFrame(grid_search.grid_scores_)
#pd.DataFrame(gs_df.parameters)
params_df = gs_df.parameters.apply(
    lambda p: pd.Series(list(p.values()), p.keys()))
# listにしないとtupleで返ってくる
pd.concat([
    gs_df.drop(["parameters", "cv_validation_scores"], axis=1),
    params_df
], axis=1).head()

	mean_validation_score	max_depth	min_samples_leaf
0	0.768799	2	2
1	0.768799	2	3
```

### 参考
- https://github.com/pydata/pandas/blob/e1aa2d94b416ee31da705b186facc707710671e6/pandas/core/strings.py#L1365
- https://github.com/pydata/pandas/blob/5e11243a11cf09007f774b3605e32ee8aa3f9592/pandas/core/series.py#L2197
- http://sinhrks.hatenablog.com/entry/2015/06/18/221747
