```py3
import numpy as np
import pandas as pd


np.random.seed(0)
sales = pd.DataFrame({
    "sale" :np.random.randint(10, high=15, size=24),
}, index=pd.date_range("2015-01-01", "2016-12-01", freq="MS"))

sales["cumsum_12month"] = sales["sale"].rolling(window=12).sum()
sales["2016_cumsum"] = sales["2016-01-01":]["sale"].cumsum()
sales.plot()
sales
```

![z chart](z_chart.png)

rder="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>sale</th>
      <th>cumsum_12month</th>
      <th>2016_cumsum</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2015-01-01</th>
      <td>14</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-02-01</th>
      <td>10</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-03-01</th>
      <td>13</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-04-01</th>
      <td>13</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-05-01</th>
      <td>13</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-06-01</th>
      <td>11</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-07-01</th>
      <td>13</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-08-01</th>
      <td>12</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-09-01</th>
      <td>14</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-10-01</th>
      <td>10</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-11-01</th>
      <td>10</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2015-12-01</th>
      <td>14</td>
      <td>147.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2016-01-01</th>
      <td>12</td>
      <td>145.0</td>
      <td>12.0</td>
    </tr>
    <tr>
      <th>2016-02-01</th>
      <td>11</td>
      <td>146.0</td>
      <td>23.0</td>
    </tr>
    <tr>
      <th>2016-03-01</th>
      <td>10</td>
      <td>143.0</td>
      <td>33.0</td>
    </tr>
    <tr>
      <th>2016-04-01</th>
      <td>11</td>
      <td>141.0</td>
      <td>44.0</td>
    </tr>
    <tr>
      <th>2016-05-01</th>
      <td>11</td>
      <td>139.0</td>
      <td>55.0</td>
    </tr>
    <tr>
      <th>2016-06-01</th>
      <td>10</td>
      <td>138.0</td>
      <td>65.0</td>
    </tr>
    <tr>
      <th>2016-07-01</th>
      <td>11</td>
      <td>136.0</td>
      <td>76.0</td>
    </tr>
    <tr>
      <th>2016-08-01</th>
      <td>14</td>
      <td>138.0</td>
      <td>90.0</td>
    </tr>
    <tr>
      <th>2016-09-01</th>
      <td>13</td>
      <td>137.0</td>
      <td>103.0</td>
    </tr>
    <tr>
      <th>2016-10-01</th>
      <td>10</td>
      <td>137.0</td>
      <td>113.0</td>
    </tr>
    <tr>
      <th>2016-11-01</th>
      <td>13</td>
      <td>140.0</td>
      <td>126.0</td>
    </tr>
    <tr>
      <th>2016-12-01</th>
      <td>10</td>
      <td>136.0</td>
      <td>136.0</td>
    </tr>
  </tbody>
</table>


