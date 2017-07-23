
## 動機
２つのDataFrameを比較して正しいことを確認する機会があった

## 準備
```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

%matplotlib inline
```

## NAを含むDataFrameを作成


```python
np.random.seed(0)
df = pd.DataFrame(np.random.random_integers(1, 4, size=(3, 4)), columns=list("abcde"))
df["c"] = np.nan
other = df.copy()
df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
      <th>d</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>4</td>
      <td>NaN</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4</td>
      <td>4</td>
      <td>NaN</td>
      <td>4</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>4</td>
      <td>NaN</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>



## 各要素が等しいか, DataFrame同士が等しいかを確認


```python
df == other
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
      <th>d</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>True</td>
      <td>True</td>
      <td>False</td>
      <td>True</td>
    </tr>
    <tr>
      <th>1</th>
      <td>True</td>
      <td>True</td>
      <td>False</td>
      <td>True</td>
    </tr>
    <tr>
      <th>2</th>
      <td>True</td>
      <td>True</td>
      <td>False</td>
      <td>True</td>
    </tr>
  </tbody>
</table>
</div>




```python
np.nan == np.nan, np.nan != np.nan
```




    (False, True)




```python
df.equals(other)
```




    True




NA同士は等しくない(SQLにおけるNULL)が、DataFrameとしては等しい

## 等しくない場合、どこが等しくないかを確認する

- NAを特定の文字列にし、要素の比較をしたときに等しくなるようにする
- DataFrame同士が等しくないようにするため、otherを変更する


```python
df = df.fillna("NA String")
other = other.fillna("NA String")
other["a"] = 4
other.iloc[0, 1] = 100
other
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
      <th>d</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>4</td>
      <td>100</td>
      <td>NA String</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4</td>
      <td>4</td>
      <td>NA String</td>
      <td>4</td>
    </tr>
    <tr>
      <th>2</th>
      <td>4</td>
      <td>4</td>
      <td>NA String</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>




```python
# == の method version
eq = df.eq(other)
eq
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
      <th>d</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>True</td>
    </tr>
    <tr>
      <th>1</th>
      <td>True</td>
      <td>True</td>
      <td>True</td>
      <td>True</td>
    </tr>
    <tr>
      <th>2</th>
      <td>False</td>
      <td>True</td>
      <td>True</td>
      <td>True</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.equals(other)
```




    False



- NAであった要素は等しくなっている
- 変更をしたため、DataFrameとしては等しくない

## 等しくないColumnとIndexの特定およびどれくらい等しいか

要素比較結果のDataFrameに対してallをColumnとIndex方向の両方に適用して特定する


```python
pd.DataFrame(eq.all(axis=1))
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>True</td>
    </tr>
    <tr>
      <th>2</th>
      <td>False</td>
    </tr>
  </tbody>
</table>
</div>




```python
pd.DataFrame(eq.all()).T
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
      <th>d</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>True</td>
    </tr>
  </tbody>
</table>
</div>




```python
pd.concat(
    [
        pd.DataFrame(eq.sum()).T,
        pd.DataFrame(eq.sum()).T / len(df)
    ]
, ignore_index=True)

```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
      <th>d</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.000000</td>
      <td>2.000000</td>
      <td>3</td>
      <td>3</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.333333</td>
      <td>0.666667</td>
      <td>1</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
print(pd.options.display.float_format)
with pd.option_context("display.float_format", "{:.2f}%".format):
    print(pd.DataFrame(eq.sum()).T / len(df) * 100)
```

    None
           a      b       c       d
    0 33.33% 66.67% 100.00% 100.00%
