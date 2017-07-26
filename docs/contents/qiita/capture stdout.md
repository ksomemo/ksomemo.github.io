# capture stdout in python

- helpの一部だけ見たくてcapture
- stream系あんまりわかってない
- stringIOに溜め込んでいるものに対するflushわかってない
- 一旦truncateしないとgetvalueしても前にcaptureしたものが残る

[ContextManagerとcontextlibいろいろ] を流用

capture_stdout.py

```py3
# http://docs.python.jp/3/library/io.html
# http://stackoverflow.com/questions/4330812/how-do-i-clear-a-stringio-object
import sys
import io
from contextlib import contextmanager

@contextmanager
def capture():
    _stdout = sys.stdout
    with io.StringIO() as strio:
        try:
            sys.stdout = strio
            yield strio
        finally:
            sys.stdout = _stdout


import pandas as pd

with capture() as c:
    print(c, c.closed)
    c.flush()
    c_log1 = c.getvalue()
    c.truncate()
    c_log2 = c.getvalue()
    c.truncate(0)
    help(pd.Period)
    help_doc = c.getvalue()

print("output")
print(c_log1.strip())
print(c_log2.strip())
print("\n".join(help_doc.splitlines()[:20]))
print(c.closed)

########
output
<_io.StringIO object at 0x11721ff78> False
<_io.StringIO object at 0x11721ff78> False
Help on class Period in module pandas._period:

class Period(builtins.object)
 |  Represents an period of time
 |
 |  Parameters
 |  ----------
 |  value : Period or compat.string_types, default None
 |      The time period represented (e.g., '4Q2005')
 |  freq : str, default None
 |      One of pandas period strings or corresponding objects
 |  year : int, default None
 |  month : int, default 1
 |  quarter : int, default None
 |  day : int, default 1
 |  hour : int, default 0
 |  minute : int, default 0
 |  second : int, default 0
 |
 |  Methods defined here:
True
```
