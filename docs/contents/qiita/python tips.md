# python tips
## Pythonで0埋め文字列
```py3
# 方法がたくさんあってややこしいのでメモ。
[
  '{0:02d}'.format(1),
  '{0:0>2}'.format(1),
  '{0:0<2}'.format(1),
  format(1, '02'),
  '1'.zfill(2),
  '1'.rjust(2),
  '1'.ljust(2),
]
# => ['01', '01', '10', '01', '01', ' 1', '1 ']
```

## regexのmatchとsearchの違い
```py3
import re

regex = re.compile("a(.)c")
text1 = "abc"
text2 = "za-cd"
assert regex.match(text1).group(0) == text1
assert regex.match(text1).group(1) == "b"
assert regex.match(text2) is None
assert regex.search(text2).group(1) == "-"
```

## dateとtimeからdatetimeを作成する
```py3
import datetime


t = datetime.time(12, 59, 59)
date = datetime.date(2016, 3, 20)
dt = datetime.datetime.combine(date, t)
dt
# datetime.datetime(2016, 3, 20, 12, 59, 59)
```

## 三重クォートの最初の改行対応
```py3
print("""\
a
b
c
""")
```

## 継承クラスの確認
```py3
import inspect


class A: pass
class B(A): pass
class C(): pass
class D(C, B): pass

print(D.__bases__)
# (<class '__main__.C'>, <class '__main__.B'>)
# 定義しか表示されない

print(inspect.getmro(D))
# (<class '__main__.D'>, <class '__main__.C'>, <class '__main__.B'>, <class '__main__.A'>, <class 'object'>)
# 定義時の継承クラスを再帰的に表示してくれる
```

## raw string
```py3
# https://www.python.org/dev/peps/pep-0498/#raw-f-strings
new_line = "\n"
raw_new_line = r"\n"
'%r' % new_line, raw_new_line, repr(new_line), "{!r}".format(new_line)
```

## merge dict
```py3
import functools
import operator
import collections

a = {"a":1, "b":2}
b = {"a":3, "c":2}

# dict
dict(a, **b)
{'a': 3, 'b': 2, 'c': 2}

# dict, reduce
functools.reduce(operator.add, [1,2,3])
6

functools.reduce(lambda x, y: dict(x, **y), [a, b])
{'a': 3, 'b': 2, 'c': 2}

functools.reduce(lambda x, y: dict(x, **y), [b, a])
{'a': 1, 'b': 2, 'c': 2}

# あとで詳しく見る
cm1 = collections.ChainMap(a, b)
cm2 = collections.ChainMap(b, a)

cm1
ChainMap({'b': 2, 'a': 1}, {'c': 2, 'a': 3})

cm2
ChainMap({'c': 2, 'a': 3}, {'b': 2, 'a': 1})

cm1["a"]
1

cm2["a"]
3
```

## error traceback
```py3
import traceback

try:
   do_something()
except:
   f = logger.error or print
   f(traceback.format_exc())
```

## Python Append library path and Absolute path
```py3
import os
import sys

# library path
# Absolute path
sys.path.append(os.path.abspath(os.path.dirname(__file__) + '/..'))
```

## PythonでYAMLを読み込む
```py3
import yaml

FILE_PATH = "example.yaml"
CONTENT = """host: xxx.yyy.com
port: 22
user: who
"""

with open(FILE_PATH, "w") as f:
    f.write(CONTENT)

with open(FILE_PATH) as f:
    print(yaml.load(f))

# {'host': 'xxx.yyy.com', 'port': 22, 'user': who}
```

## カウントダウンのためのstdoutの上書き
```py3
import time

for i in range(12)[::-1]:
    # end is not \r
    # when end is \r, output is 12 -> 11 -> 10 -> 90 -> 80
    print(i, "\r", end="")
    time.sleep(0.1)
print("")
print("finished")
```

## date or datetime の月差分
```py3
# 正直python関係ない
# 年は12進数の2桁目, 月は1桁目のように思えば良い
def f(d1, d2):
   diff_year = d1.year - d2.year
   diff_month = d1.month - d2.month
   return (diff_year * 12) + diff_month
)
```

## pythonでclipboard操作
```py3
"""
- package探したらあった
- 2017年になってもメンテされてた
- https://pypi.python.org/pypi/pyperclip
- https://github.com/asweigart/pyperclip

pip install pyperclip
# anaconda search -t conda pyperclip
# では同じ名前のpackageはあるが、作者が違っていた
"""
import pyperclip

pyperclip.copy("text")
pyperclip.paste()
```

## 他記事のリンク
### [decorator メモ](http://qiita.com/ksomemo/items/3d15c30eda8c72aa4359)

### iterator
https://gist.github.com/ksomemo/47696bc73bb82d5e4432

### [pythonでxml操作](http://qiita.com/ksomemo/items/ddbc063a3113227dc1a3)
