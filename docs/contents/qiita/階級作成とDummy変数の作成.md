- いままでの階級作成は、dictを作ってmapさせていた
    - 右区間の開閉を指定できる
    - 数値の範囲を示す文字列を作成することでmapのようなことができる
- dummy変数便利、SQLを複雑にしないですむ
- おまけにのせたfactorizeは数値しか扱えないライブラリには便利そう
    - ただし、numpyとはnanの扱いが少し違うらしい

```python
import numpy as np
import pandas as pd
```

## 参考
```python
# http://pandas.pydata.org/pandas-docs/stable/generated/pandas.cut.html
# http://pandas.pydata.org/pandas-docs/stable/reshaping.html#computing-indicator-dummy-variables
```

## データ
```python
np.random.seed(0)
df_for_cut = pd.DataFrame(np.random.randint(1, 99, 1000), columns=["age"])
df_for_cut.tail()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>995</th>
      <td>36</td>
    </tr>
    <tr>
      <th>996</th>
      <td>89</td>
    </tr>
    <tr>
      <th>997</th>
      <td>50</td>
    </tr>
    <tr>
      <th>998</th>
      <td>80</td>
    </tr>
    <tr>
      <th>999</th>
      <td>85</td>
    </tr>
  </tbody>
</table>
</div>



## bin作成
```python
bins = list(range(0, 100+1, 10))
bins
 [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
```

## binのラベル
```python
bins_labels = [str(b) + " - " + str(b + 10 - 1) for b in bins[:-1]]
bins_labels

    ['0 - 9',
     '10 - 19',
     '20 - 29',
     '30 - 39',
     '40 - 49',
     '50 - 59',
     '60 - 69',
     '70 - 79',
     '80 - 89',
     '90 - 99']
```

```python
df_for_cut["age_group"] = pd.cut(df_for_cut.age, bins=bins)
df_for_cut["age_group_right"] = pd.cut(df_for_cut.age, bins=bins, right=False)
df_for_cut["age_group_label_F"] = pd.cut(df_for_cut.age, bins=bins, labels=False)
df_for_cut["age_group_labels"] = pd.cut(df_for_cut.age, bins=bins, labels=bins_labels)
df_for_cut.tail()
```

<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>age</th>
      <th>age_group</th>
      <th>age_group_right</th>
      <th>age_group_label_F</th>
      <th>age_group_labels</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>995</th>
      <td>36</td>
      <td>(30, 40]</td>
      <td>[30, 40)</td>
      <td>3</td>
      <td>30 - 39</td>
    </tr>
    <tr>
      <th>996</th>
      <td>89</td>
      <td>(80, 90]</td>
      <td>[80, 90)</td>
      <td>8</td>
      <td>80 - 89</td>
    </tr>
    <tr>
      <th>997</th>
      <td>50</td>
      <td>(40, 50]</td>
      <td>[50, 60)</td>
      <td>4</td>
      <td>40 - 49</td>
    </tr>
    <tr>
      <th>998</th>
      <td>80</td>
      <td>(70, 80]</td>
      <td>[80, 90)</td>
      <td>7</td>
      <td>70 - 79</td>
    </tr>
    <tr>
      <th>999</th>
      <td>85</td>
      <td>(80, 90]</td>
      <td>[80, 90)</td>
      <td>8</td>
      <td>80 - 89</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_for_cut.age_group.unique()

    [(40, 50], (60, 70], (0, 10], (80, 90], (20, 30], (30, 40], (70, 80], (10, 20], (50, 60], (90, 100]]
    Categories (10, object): [(0, 10] < (10, 20] < (20, 30] < (30, 40] ... (60, 70] < (70, 80] < (80, 90] < (90, 100]]
```

```python
df_for_cut.age_group_label_F.unique()

    array([4, 6, 0, 8, 2, 3, 7, 1, 5, 9])
```

pd.qcut(quantile cut) もあるが、こちらは分位数または分位のリストを指定してするものもある。

```python
qcuted_4 = pd.qcut(df_for_cut["age"], q=4)
qcuted_4.tail()

q = [0, .25, .5, .75, 1]
qcuted_list = pd.qcut(df_for_cut["age"], q=q)
qcuted_list.tail()
```

## Dummy変数
```python
dummies = pd.get_dummies(df_for_cut['age_group'], prefix='age_group')
df_for_cut_with_dummies = pd.concat([df_for_cut, dummies], axis=1)
df_for_cut_with_dummies.tail()
```

<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>age</th>
      <th>age_group</th>
      <th>age_group_right</th>
      <th>age_group_(0, 10]</th>
      <th>age_group_(10, 20]</th>
      <th>age_group_(20, 30]</th>
      <th>age_group_(30, 40]</th>
      <th>age_group_(40, 50]</th>
      <th>age_group_(50, 60]</th>
      <th>age_group_(60, 70]</th>
      <th>age_group_(70, 80]</th>
      <th>age_group_(80, 90]</th>
      <th>age_group_(90, 100]</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>995</th>
      <td>36</td>
      <td>(30, 40]</td>
      <td>[30, 40)</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>996</th>
      <td>89</td>
      <td>(80, 90]</td>
      <td>[80, 90)</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>997</th>
      <td>50</td>
      <td>(40, 50]</td>
      <td>[50, 60)</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>998</th>
      <td>80</td>
      <td>(70, 80]</td>
      <td>[80, 90)</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>999</th>
      <td>85</td>
      <td>(80, 90]</td>
      <td>[80, 90)</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>

```python
pd.get_dummies(pd.DataFrame({"a": list("AB"), "b": list("CD")}), prefix=list("ab"))

# Series
# prefixはない, split+expandをさらに加工する必要がなくなる
pd.Series(["a|b|c", "e|fg"]).str.get_dummies()
pd.Series(["a|b|c", "e|fg"]).str.split("|", expand=True)
```

<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a_A</th>
      <th>a_B</th>
      <th>b_C</th>
      <th>b_D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>

```python
factors = pd.Series(["B", np.nan, "a", np.nan, 123, 0.4, np.inf])
factors

    0      B
    1    NaN
    2      a
    3    NaN
    4    123
    5    0.4
    6    inf
    dtype: object
```

## おまけ
```python
factors.factorize()

    (array([ 0, -1,  1, -1,  2,  3,  4]),
     Index(['B', 'a', 123, 0.4, inf], dtype='object'))
```
