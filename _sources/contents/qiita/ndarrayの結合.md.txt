
http://qiita.com/ksomemo/items/81c88378a1dffa5cbea7 の続き

```py3:numpy_concat.py
import numpy as np
import pandas as pd

"""
scikit-learnの勉強中によく出てくるnumpyの操作
行方向もあると思いを探したら存在した
methodとしてあると思い探したら存在した
"""

# http://docs.scipy.org/doc/numpy-1.10.0/reference/generated/numpy.c_.html
# http://docs.scipy.org/doc/numpy-1.10.0/reference/generated/numpy.r_.html
# http://docs.scipy.org/doc/numpy-1.10.0/reference/generated/numpy.concatenate.html

ar1 = np.array(range(6)).reshape(2, 3)
ar2 = np.array(range(1, 7)).reshape(2, 3)

# c:column, r:row
c_ = np.c_[ar1, ar2]
r_ = np.r_[ar1, ar2]
concat_r = np.concatenate([ar1, ar2])
concat_c = np.concatenate([ar1, ar2], axis=1)

pd.DataFrame(c_)

	0	1	2	3	4	5
0	0	1	2	1	2	3
1	3	4	5	4	5	6

pd.DataFrame(r_)

	0	1	2
0	0	1	2
1	3	4	5
2	1	2	3
3	4	5	6


(pd.DataFrame(r_) == pd.DataFrame(concat_r)).all().sum() == 3
(pd.DataFrame(c_) == pd.DataFrame(concat_c)).all().sum() == 6
```
