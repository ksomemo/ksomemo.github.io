# ipythonで使っているtimeitをpython code内で使ってみた
## timeit

```py3
import sys

codes = [
    ("l = list(range(10000000))", "1 in l"),
    ("l = list(range(100))", "100 in l"),  # 意図的にサイズダウン
    ("s = set(range(10000000))",  "10000000 in s"),
    ("d = {i: 1 for i in range(10000000)}", "10000000 in d"),
]

for setup_code, statement_code in codes:
  print(timeit.timeit(setup=setup_code, stmt=statement_code),
        (setup_code, statement_code))

"""
# µs
0.07022977503947914 ('l = list(range(10000000))', '1 in l')
2.2378561249934137 ('l = list(range(100))', '100 in l')
0.05731910699978471 ('s = set(range(10000000))', '10000000 in s')
0.05893953307531774 ('d = {i: 1 for i in range(10000000)}', '10000000 in d')
"""
```

## ipythonで
listに関してどうなるか試したら、余計にわからなくなった

```py3
ipython

In [83]: %%timeit l = list(range(100))
   ....: 100 in l
   ....:
100000 loops, best of 3: 2.19 µs per loop

In [84]: %timeit 100 in range(100)
1000000 loops, best of 3: 479 ns per loop

In [85]: %timeit 100 in list(range(100))
100000 loops, best of 3: 4.53 µs per loop

In [86]: %timeit 10000000 in list(range(10000000))
1 loops, best of 3: 734 ms per loop

In [87]: %%timeit l = list(range(10000000))
   ....: 10000000 in l
   ....:
1 loops, best of 3: 222 ms per loop
```

## おまけ
範囲をめちゃくちゃ増やそうとしたけど、多すぎた

```py3
import sys

# py3 maxint -> maxsize
# PEP 237 -- Unifying Long Integers and Integers
print("sys.maxsize is ", sys.maxsize)
# => sys.maxsize is  9223372036854775807
```
