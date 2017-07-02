
```py3:lmplot-fit_reg=scatter.py
"""
https://stanford.edu/~mwaskom/software/seaborn/generated/seaborn.lmplot.html
scatter plotだけを実現したいけど、おまけが邪魔だったので非表示にした
"""
import seaborn as sns


iris = sns.load_dataset("iris")
sns.lmplot(data=iris, x="sepal_length", y="sepal_width", hue="species", fit_reg=False)
```
