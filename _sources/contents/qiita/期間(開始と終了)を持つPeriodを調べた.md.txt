## 動機
- [pandas offset aliasまとめ](http://qiita.com/ksomemo/items/cc6f91c70265b0d776ad)　を書いた時に時系列系でpd.period_rangeというものを見た
- DatetimeIndexとの違いがぱっと見でよくわからないので調べた
- 途中で出てくるPeriod Class のhelpは[capture stdout](http://qiita.com/ksomemo/items/3d148f05b3a640d07412)で調べたとおり
- documentation: http://pandas.pydata.org/pandas-docs/stable/timeseries.html#period

## まとめ
- periodの名のとおり期間(開始と終了)を持つ
- 日次だとあまり意味がないけど、月次や４半期などはAliasから作成できるので便利そう

## code
```py3:period_range.py
import pandas as pd

# module
pd.period_range
<function pandas.tseries.period.period_range>

# result
pindex = pd.period_range(start="2016-03-01", end="2016-03-31")
pindex
PeriodIndex(['2016-03-01', '2016-03-02', '2016-03-03', '2016-03-04',
             '2016-03-05', '2016-03-06', '2016-03-07', '2016-03-08',
             '2016-03-09', '2016-03-10', '2016-03-11', '2016-03-12',
             '2016-03-13', '2016-03-14', '2016-03-15', '2016-03-16',
             '2016-03-17', '2016-03-18', '2016-03-19', '2016-03-20',
             '2016-03-21', '2016-03-22', '2016-03-23', '2016-03-24',
             '2016-03-25', '2016-03-26', '2016-03-27', '2016-03-28',
             '2016-03-29', '2016-03-30', '2016-03-31'],
            dtype='int64', freq='D')


# element type
pindex[0], type(pindex[0])
(Period('2016-03-01', 'D'), pandas._period.Period)
# pd.Period も pandas._period.Period

# instance
pd.Period(year=2016, month=3, day=6, freq="D")
# or period = period = pd.Period("2016-03-06")
period
Period('2016-03-06', 'D')

# period start and end
period.start_time, period.end_time
(Timestamp('2016-03-06 00:00:00'), Timestamp('2016-03-06 23:59:59.999999999'))

# compare with a datetime
import datetime
dt_start = datetime.datetime(2016, 3, 6)
dt_end = datetime.datetime(2016, 3, 6, 23, 59, 59)
[
    period.start_time <  dt_start <= period.end_time,
    period.start_time <= dt_start <= period.end_time,
    period.start_time <= dt_end   <= period.end_time,
    period.start_time <= dt_end   <  period.end_time,
]
[False, True, True, True]


# おまけ periodがなかったらstartだけでなくendを自力で作る
date_range = pd.date_range("2016-03-01", periods=31)
end_exclude = date_range.shift(1)
date_df = pd.DataFrame({
    "start_date": date_range,
     "end_exclude": end_exclude
})
date_df.tail()

end_exclude	start_date
26	2016-03-28	2016-03-27
27	2016-03-29	2016-03-28
28	2016-03-30	2016-03-29
29	2016-03-31	2016-03-30
30	2016-04-01	2016-03-31
```
