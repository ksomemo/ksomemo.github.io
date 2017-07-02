## date_range
### dateutil
```py3:datetime_range.py
from dateutil import (
    rrule,
    parser
)

start_date = parser.parse('2015-11-01')
end_date = parser.parse('2015-11-05')

list(rrule.rrule(rrule.DAILY, dtstart=start_date, until=end_date))
```

### pandas
- 入っているなら日付Parseや間隔(offset)およびが便利なのでこちら
- http://pandas.pydata.org/pandas-docs/stable/generated/pandas.date_range.html
- 日本語日付を扱うならjapandasが便利
    - https://gist.github.com/ksomemo/34c0e447d12376b87d1602a1558af390

## pandas offset aliasまとめ
- http://pandas.pydata.org/pandas-docs/stable/timeseries.html#offset-aliases
- 見づらいので整形した
- http://www.tablesgenerator.com/markdown_tables で整形した

| Alias | business | custom business(experimental) | Description   |
|-------|----------|-------------------------------|---------------|
| D     | B        | C                             | calendar day  |
| W     |          |                               | weekly        |
| M     | BM       | CBM                           | month end     |
| MS    | BMS      | CBMS                          | month start   |
| Q     | BQ       |                               | quarter end   |
| QS    | BQS      |                               | quarter start |
| A     | BA       |                               | year end      |
| AS    | BAS      |                               | year start    |
| H     |          |                               | hourly        |
| T,min |          |                               | minutely      |
| S     |          |                               | secondly      |
| L,ms  |          |                               | milliseonds   |
| U,us  |          |                               | microseconds  |
| N     |          |                               | nanoseconds   |

### よく使う月末月初の日付を求める
- pd.offsets.MonthEndを使って求める
- pd.offsets.MonthBeginは使う必要なかった
    - http://docs.python.jp/3/library/datetime.html#datetime.datetime.replace

```datetime_replace.py
# pandas.Timestampのまま返ってくる
dt.replace(year=2000, month=10, day=1, hour=2, minute=3, second=4, microsecond=123456)
Timestamp('2000-10-01 02:03:04.123456')
```

```pandas_offsets.py
"""
(月初/中/末)日付 × 月末offset(0, 1) × (加算減算)の組合せのうち、
どれを行えば求められるか
"""
import pandas as pd
from operator import add, sub
from itertools import product
import io


dt = pd.to_datetime("20161111").date()
dtb = pd.to_datetime("20161101").date()
dte = pd.to_datetime("20161130").date()
dts = [dt, dtb, dte]

#mb = pd.offsets.MonthBegin()
#mb0 = pd.offsets.MonthBegin(0)
me = pd.offsets.MonthEnd()
me0 = pd.offsets.MonthEnd(0)
ms = me, me0

ops = [add, sub]

expected_values = {
  mb.__class__.__name__: "2016-11-01",
  me.__class__.__name__: "2016-11-30",
}

# ipython上で確認していた+ファイルに出力するとゴミが溜まるので
# StringIO,print sep=tab, seekで元に戻すで対応してDataFrameに出力
with io.StringIO() as sio:
    for d, m, op in product(dts, ms, ops):
        print(d, op.__name__, m, op(d, m).date(),
              sep="\t", file=sio)
    sio.seek(0)
    df = pd.read_table(sio, names=["date", "operator", "offset", "result"])

df["correct"] = df["result"] == "2016-11-30"
df.pivot_table(index=["offset", "operator"],
               columns="correct", values="result", aggfunc=len)
```

#### 結果
- 月末はMonthBegin(0)を使えば加減どちらでもよい
- 意味としては足したほうがわかりやすい

```pandas_offsets_result.txt
correct                   False  True
offset          operator
<0 * MonthEnds> add         NaN    3.0
                sub         NaN    3.0
<MonthEnd>      add         1.0    2.0
                sub         3.0    NaN
```
