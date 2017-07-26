# data frame to dict(key=list)
## 動機
- http://qiita.com/haru1977/items/a8bbd177feed148c2eaa
- 最終アウトプットフォーマットを見たときに、使いそうな形だったので試してみた
    - `dict(key=list)`
- ndarrayのデータ量を増やした時のパフォーマンスも見てみた
    - vectorizeした方法のほうがデータ量が増えたときに良いと思ったため
    - 重複レコードができるとuniqにしないとアウトプットがあわない
    - けど頻度を使いたいときはlistの方がいいだろうし気にしないことにした

df_to_dict_like.py

```python3
# beign: original
import pandas as pd
from collections import defaultdict
df = pd.DataFrame({
    'id':['a','a','b','b','c',],
    'shouhin':['x', 'y', 'y','z', 'x']
})
def to_dict(df):
    tempdic = defaultdict(dict)
    for d in df.values:
        tempdic[d[0]][d[1]] = 1.0
    return {k: tempdic[k].keys() for k in tempdic}
    # 2.x?, 3.x: list(t[k].keys())
# end

def to_dict2(df):
    return df.groupby("id")["shouhin"].apply(lambda x: list(x)).to_dict()

# 2.shape => (500, 2)
# 3.shape => (50000, 2)
# 4.shape => (500000, 2)
df2 = pd.concat(df.copy() for _ in range(100))
df3 = pd.concat(df.copy() for _ in range(10000))
df4 = pd.concat(df.copy() for _ in range(100000))

%timeit to_dict(df)
10000 loops, best of 3: 27.2 µs per loop

%timeit to_dict2(df)
1000 loops, best of 3: 1.16 ms per loop

%timeit to_dict(df2)
1000 loops, best of 3: 247 µs per loop

%timeit to_dict2(df2)
1000 loops, best of 3: 1.27 ms per loop

# ここからパフォーマンス逆転
%timeit to_dict(df3)
10 loops, best of 3: 22.2 ms per loop

%timeit to_dict2(df3)
100 loops, best of 3: 6.84 ms per loop

%timeit to_dict(df4)
1 loop, best of 3: 222 ms per loop

%timeit to_dict2(df4)
10 loops, best of 3: 62.2 ms per loop

# to dataframe
pd.concat(
    (pd.DataFrame(dict(id=k, shouhin=v))
     for k, v in to_dict2(df).items()),
    ignore_index=True)
```
