```py3
# https://twitter.com/ksomemo/status/730296410868985856
import pandas as pd
import numpy as np


df = pd.DataFrame({"date_range": pd.date_range("2016-05-01", "2016-05-02")})
df["date_range_str"] = df.date_range.copy().dt.strftime("%Y-%m-%d")
df["date_range_str_nan"] = df.date_range_str.copy()
df.loc[0, "date_range_str_nan"] = np.nan
df

date_range	date_range_str	date_range_str_nan
0	2016-05-01	2016-05-01	NaN
1	2016-05-02	2016-05-02	2016-05-02


df.info()

<class 'pandas.core.frame.DataFrame'>
RangeIndex: 2 entries, 0 to 1
Data columns (total 3 columns):
date_range            2 non-null datetime64[ns]
date_range_str        2 non-null object
date_range_str_nan    1 non-null object
dtypes: datetime64[ns](1), object(2)


[
    hasattr(df.date_range, "dt"),
    hasattr(df.date_range, "str"),
    hasattr(df.date_range_str, "dt"),
    hasattr(df.date_range_str, "str"),
]

[True, False, False, True]



pd.to_datetime(df.date_range_str)
0   2016-05-01
1   2016-05-02
Name: date_range_str, dtype: datetime64[ns]



pd.to_datetime(df.date_range_str_nan)
0          NaT
1   2016-05-02
Name: date_range_str_nan, dtype: datetime64[ns]

df.date_range_str.astype("datetime64")
0   2016-05-01
1   2016-05-02
Name: date_range_str, dtype: datetime64[ns]



try:
    df.date_range_str_nan.astype("datetime64")
except Exception as e:
    print(e)
Could not convert object to NumPy datetime



import tempfile
f = tempfile.NamedTemporaryFile()
df.to_csv(f.name, index=False)
df_temp = pd.read_csv(f.name, parse_dates=list(df.columns))
df_temp
​
date_range	date_range_str	date_range_str_nan
0	2016-05-01	2016-05-01	NaT
1	2016-05-02	2016-05-02	2016-05-02



df_temp.info()
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 2 entries, 0 to 1
Data columns (total 3 columns):
date_range            2 non-null datetime64[ns]
date_range_str        2 non-null datetime64[ns]
date_range_str_nan    1 non-null datetime64[ns]
dtypes: datetime64[ns](3)
memory usage: 128.0 bytes

```
