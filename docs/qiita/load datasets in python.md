
```txt:0_load_datasets_in_python.txt
title
```

```py3:preimport.py
import pandas as pd
import sklearn
import statsmodels

import matplotlib.pyplot as plt
%matplotlib inline
```

```datasets.md
## data sets
- statsmodelsの関数からRのデータセットを用いる方法
    - http://vincentarelbundock.github.io/Rdatasets/datasets.html
- scikit learnで提供されているデータセット
    - 見やすいようにPandasで加工
    - http://scikit-learn.org/stable/datasets/#toy-datasets
```


```py3:dataset_statsmodels.py
import statsmodels.api as sm
duncan_prestige = sm.datasets.get_rdataset("Duncan", "car")
duncan_prestige.data.head()
```

```dataset_statsmodels.txt
	type	income	education	prestige
accountant	prof	62	86	82
pilot	prof	72	76	83
architect	prof	75	92	90
author	prof	55	90	76
chemist	prof	64	86	90
```

```py3:dataset_sklearn.py
# https://github.com/scikit-learn/scikit-learn/blob/master/sklearn/datasets/base.py
from sklearn import datasets
iris = datasets.load_iris()
iris_data = pd.DataFrame(iris.data, columns=iris.feature_names)
iris_data["target"] = pd.Series(iris.target)
iris_data["target"] = iris_data["target"].apply(lambda x: iris.target_names[x])
iris_data.head()
```

```dataset_sklearn.txt
	sepal length (cm)	sepal width (cm)	petal length (cm)	petal width (cm)	target
0	5.1	3.5	1.4	0.2	setosa
1	4.9	3.0	1.4	0.2	setosa
2	4.7	3.2	1.3	0.2	setosa
3	4.6	3.1	1.5	0.2	setosa
4	5.0	3.6	1.4	0.2	setosa
```
