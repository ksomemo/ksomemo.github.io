# sessionize with pandas memo
```py3
import pandas as pd
import numpy as np

# 閲覧時間
# セッションごとの各閲覧の間隔
sort_columns = ['session_id', 'view_datetime']
sorted_logs = training_logs.sort(sort_columns)

# Don't merge, add columns and shifted logs
use_shift_columns = ['shift_' + c for c in sort_columns]
sorted_logs[use_shift_columns] = sorted_logs.shift(-1)[sort_columns]

sorted_logs['view_time_diff'] = np.where(
    is_same_session,
    (sorted_logs['shift_view_datetime'] - sorted_logs['view_datetime']),
    np.timedelta64(0))

# あとは、GroupingなどしてSummarize
```
