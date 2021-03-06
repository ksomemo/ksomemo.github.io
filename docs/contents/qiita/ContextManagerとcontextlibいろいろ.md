# ContextManagerとcontextlibいろいろ
## links
- http://docs.python.jp/3/library/stdtypes.html#typecontextmanager
- http://docs.python.jp/3/library/contextlib.html#module-contextlib

my_context_manager.py

```python3
"""context manager としての動きの確認"""
class MyContextManager(object):
    def __enter__(self):
        print("enter")

    def __exit__(self, exc_type, exc_value, traceback):
        print("exit", exc_type, exc_value, traceback)

with MyContextManager():
    print("do someting")
# enter
# do something
# (exit, None, None, None)

with MyContextManager():
    print("do someting")
    raise Exception("in with")
# (exit, <type 'exceptions.Exception'>, Exception("in with",), <tracekback object at 0x106471d88>)
# Traceback (xxxxx...
```

using_mycm_as_decorator.py

```python3
from contextlib import ContextDecorator


class MyCmDecorator(MyContextManager, ContextDecorator):
    pass

@MyCmDecorator()
def decorated():
    print("decorated")

decorated()
# enter
# decorated
# exit: None None None
```


contextlib_context_manager.py

```python3
"""generator functionをenter/exitに対応させるdecorator"""
from contextlib import contextmanager


@contextmanager
def cm1():
    print("front")
    yield
    print("back")


@contextmanager
def cm2():
    try:
        print("front")
        yield
    finally:
        print("back")

with cm1():
    print("do something")
    raise Exception("cm1")

with cm2():
    print("do something")
    raise Exception("cm2")
# 前者ではbackは表示されないので、完全にcontext managerとしての動きはしてない?
```

contextlib_closing.py

```python3
"""auto closing"""
from contextlib import closing


class Close(object):
    def close(self):
        print("close")


with closing(Close()) as c:
    pass
# => close
```


contextlib_suppress_py34.py

```python3
"""指定したErrorを無視するようになる"""
from contextlib import suppress


with suppress(NameError, ImportError):
    print("call not defined variable")
    a = 1
    import ababa
    print("after")

with suppress(NameError, ImportError):
    a = 1
    print("not exists module")
    import ababa
    print("after")

with suppress(ImportError):
    print("different error")
    b
    print("after")

# NameErrorは表示されず、with内の処理は継続されない
# Error指定を増やした結果、ImportErrorは表示されず、with内の処理は継続されない
# b に関するNameError が発生する
```
