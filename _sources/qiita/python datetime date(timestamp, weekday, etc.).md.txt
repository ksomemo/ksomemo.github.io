```py3:datetime_datetime.py
import datetime
dt = datetime.datetime.now()
timestamp = dt.timestamp()
datetime.datetime.fromtimestamp(timestamp)
datetime.datetime(2016, 1, 28, 0, 0)

dt.utctimetuple()
time.struct_time(tm_year=2016, tm_mon=1, tm_mday=28, tm_hour=0, tm_min=0, tm_
sec=0, tm_wday=3, tm_yday=28, tm_isdst=0)

dt.timetuple()
time.struct_time(tm_year=2016, tm_mon=1, tm_mday=28, tm_hour=0, tm_min=0, tm_
sec=0, tm_wday=3, tm_yday=28, tm_isdst=-1)
```

```py3:datetime_date.py
date = datetime.date.today()
# print(date.timestamp()) # error
datetime.datetime(date.year, date.month, date.day)

date.ctime()
'Fri Jan 28 00:00:00 2016'

dateutil.parser.parse でparseできる

date.toordinal()
735991
予測的グレゴリオ暦における日付序数
1 年の 1 月 1 日が序数 1

datetime.date.fromordinal(date.toordinal())

date.isocalendar()
(2016, 4, 5)
(ISO 年、ISO 週番号、ISO 曜日)

date.weekday()
月曜日を 0、日曜日を 6

date.isoweekday()
月曜日を 1,日曜日を 7
```
