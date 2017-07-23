## formula
- Rのあれ(y ~ x1 + x2)
- patsyというpydata提供のpackage
- statsmodelsにformulaあったなぁと調べたら、これだった

## patsy
- http://patsy.readthedocs.org/en/latest/
- https://github.com/pydata/patsy

## やってみた
- http://patsy.readthedocs.org/en/latest/formulas.html
- http://patsy.readthedocs.org/en/latest/categorical-coding.html

```py3:df_ex.py
import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
plt.style.use('ggplot')
%matplotlib inline


df_ex = pd.DataFrame(
    {
        "a": np.random.randint(0, 3+1, 50),
        "b": range(50),
        "c": list("abcde") * 10,
        "y": np.random.randint(0, 1+1, 50)
    }
)
```

```py3:dmatrices_dot.py
patsy.dmatrices("y ~ .", df_ex, return_type="dataframe")

  File "<unknown>", line 1
    .
    ^
SyntaxError: invalid syntax
```


- .で全ての変数を使うことはできなかった
- 全部入力して使用＋数値をカテゴリ変数として扱ってみた

```py3:dmatrices.py
outcome, predictors = patsy.dmatrices("y ~ C(a) + b + c + d",  df_ex, return_type="dataframe")
pd.concat([predictors, outcome], axis=1).head()

	Intercept	C(a)[T.1]	C(a)[T.2]	C(a)[T.3]	c[T.b]	c[T.c]	c[T.d]	c[T.e]	d[T.True]	b	y
0	1	0	0	0	0	0	0	0	0	0	1
1	1	1	0	0	1	0	0	0	1	1	0
2	1	0	1	0	0	1	0	0	0	2	1
3	1	0	1	0	0	0	1	0	1	3	1
4	1	1	0	0	0	0	0	1	0	4	0
```

- 文字列とbooleanはカテゴリ変数として扱われている
- カテゴリ変数として扱った数値は意図したとおりになっている
- ただの数値は、数値として扱われている
- ここでは２値分類するという設定のもとyを目的変数にしているが、多値分類の場合outcomeの変数が2つ以上になるのでどうするのかわかってない
- たぶん機械学習方面のライブラリに詳しくないから混乱している気がする
- あとは学習と評価なので、scikit-learnとかに任せる
