# python packageでのz-score
## 動機とまとめ
- pandasでzsore method見ないなと調べていた
- あるけどAttributeErrorになった
- numpy/scipyから探してみたらあった
- series自力計算との違いを確かめてみた
- pandasのstdは不偏のほうだった

## おまけ
途中、scipy.statsが急に使えなくなったので、updateやpyenv rehashして復旧させた

<https://gist.github.com/ksomemo/efba1e4eafe28298d572>

## code
```py3
import pandas as pd
import numpy as np
import scipy as sp
import seaborn as sns
import matplotlib.pyplot as plt

%matplotlib inline

# pd.stats.misc.zscore AttributeError

df = pd.DataFrame({"n": range(10)})
df = df.assign(
    sp_z=sp.stats.zscore(df["n"]),
    ddof_t_z=(df["n"] - df["n"].mean()) / df["n"].std(),
    ddof_f_z=(df["n"] - df["n"].mean()) / df["n"].std(ddof=False)
)
# degrees of freedom
# http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.std.html

print(df.min())
print(df.max())

df.plot(subplots=True, figsize=(10, 4), layout=(1, 4))
plt.tight_layout()
```
