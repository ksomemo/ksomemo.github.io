```py3
# 知らなかった一覧
# Series.to_frame
# Seriesにname付けられる
# concatでcolumnsをkeyで指定
# ↑そもそもDataFrameとdictで問題ないの忘れてた
import pandas as pd


s1 = pd.Series(range(5), name="a")
s2 = pd.Series(range(1, 6), name="b")
s3 = pd.Series(range(2, 7))
s4 = pd.Series(range(3, 8))

pd.concat([
    pd.concat(
        [
            pd.DataFrame(s1),
            s2.to_frame()
        ], axis=1
    ),
    pd.concat([s3, s4], keys=list("cd"), axis=1),
    pd.DataFrame({"e": s3, "f": s4})
], axis=1).head(1)


Out[1]:
	a	b	c	d	e	f
0	0	1	2	3	2	3
```
