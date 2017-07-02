- matplotlibの設定一覧
- 上記の設定を一時的に適用できるcontext manager
- mosaic plot というクロス集計結果の割合の可視化
- plot結果を解像度指定して画像として保存

```mosaic_plot.py
%matplotlib inline

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


iris = sns.load_dataset("iris")
iris_copy = iris.copy()
iris_copy["sepal_length_round"] = iris_copy.sepal_length.round()

# http://matplotlib.org/users/customizing.html
plot_context = {
    'figure.figsize': (10, 8),
    'font.size': 18,
    'font.stretch': 18,
    'figure.dpi': 100,
    'axes.labelsize': 18,
    'axes.titlesize': 20,
    'xtick.labelsize': 15,
    'ytick.labelsize': 20,
    'legend.fontsize': 15,
    'lines.markersize': 15,
}
# それっぽいものがあるかは下記で調べた
{k for k in plt.rcParams.keys() if "text" in k} | {k for k in plt.rcParams.keys() if "size" in k}

# http://statsmodels.sourceforge.net/stable/generated/statsmodels.graphics.mosaicplot.mosaic.html
from statsmodels.graphics.mosaicplot import mosaic
with plt.rc_context(plot_context):
    fig, rects = mosaic(iris_copy, ["sepal_length_round", "species"], gap=0.01)
    plt.savefig("mosaic_cm.png", dpi=200)

# 結果のDataFrame Indexが示す値は何か書いてない…
# 0, 1, : ??
# 2: 横軸を全体とした時の構成比率
# 3: 各横軸内での構成比率
pd.DataFrame(rects)

# 各IndexでのPlot
fig, axes = plt.subplots(1, 2, figsize=(10, 5))
index = ["sepal_length_round", "species"]
mosaic(iris_copy, index, gap=0.01, ax=axes[0])
mosaic(iris_copy, index[::-1], gap=0.01, ax=axes[1])
plt.tight_layout()
```

<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th colspan="3" halign="left">5.0</th>
      <th colspan="3" halign="left">4.0</th>
      <th colspan="3" halign="left">6.0</th>
      <th colspan="3" halign="left">7.0</th>
      <th colspan="3" halign="left">8.0</th>
    </tr>
    <tr>
      <th></th>
      <th>setosa</th>
      <th>versicolor</th>
      <th>virginica</th>
      <th>setosa</th>
      <th>versicolor</th>
      <th>virginica</th>
      <th>setosa</th>
      <th>versicolor</th>
      <th>virginica</th>
      <th>setosa</th>
      <th>versicolor</th>
      <th>virginica</th>
      <th>setosa</th>
      <th>versicolor</th>
      <th>virginica</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.310897</td>
      <td>0.310897</td>
      <td>0.310897</td>
      <td>0.352564</td>
      <td>0.352564</td>
      <td>0.352564</td>
      <td>0.798077</td>
      <td>0.798077</td>
      <td>0.798077</td>
      <td>0.961538</td>
      <td>0.961538</td>
      <td>0.961538</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.000000</td>
      <td>0.846445</td>
      <td>0.979003</td>
      <td>0.000000</td>
      <td>0.993421</td>
      <td>1.000000</td>
      <td>0.000000</td>
      <td>0.079141</td>
      <td>0.608166</td>
      <td>0.000000</td>
      <td>0.006579</td>
      <td>0.342105</td>
      <td>0.000000</td>
      <td>0.006579</td>
      <td>0.013158</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.301282</td>
      <td>0.301282</td>
      <td>0.301282</td>
      <td>0.032051</td>
      <td>0.032051</td>
      <td>0.032051</td>
      <td>0.435897</td>
      <td>0.435897</td>
      <td>0.435897</td>
      <td>0.153846</td>
      <td>0.153846</td>
      <td>0.153846</td>
      <td>0.038462</td>
      <td>0.038462</td>
      <td>0.038462</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.839866</td>
      <td>0.125980</td>
      <td>0.020997</td>
      <td>0.986842</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.072562</td>
      <td>0.522446</td>
      <td>0.391834</td>
      <td>0.000000</td>
      <td>0.328947</td>
      <td>0.657895</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.986842</td>
    </tr>
  </tbody>
</table>
