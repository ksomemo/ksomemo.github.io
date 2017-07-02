context過敏症なのか、調べてた

```py3:pd_option_context.py
import numpy as np
import pandas as pd
import string


df_wide = pd.DataFrame(
    np.random.random_integers(1, size=(1, len(string.ascii_letters))),
    columns=list(string.ascii_letters))

with pd.option_context('display.max_columns', 10):
    print(pd.options.display.max_columns)
    print(df_wide)

print(pd.options.display.max_columns)
print(df_wide)

#
10
   a  b  c  d  e ...  V  W  X  Y  Z
0  1  1  1  1  1 ...  1  1  1  1  1

[1 rows x 52 columns]
20
   a  b  c  d  e  f  g  h  i  j ...  Q  R  S  T  U  V  W  X  Y  Z
0  1  1  1  1  1  1  1  1  1  1 ...  1  1  1  1  1  1  1  1  1  1

[1 rows x 52 columns]
```
