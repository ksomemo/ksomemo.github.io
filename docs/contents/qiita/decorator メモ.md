```0_summary.md
- decoratorの復習
- wrapsってなに？
- その効果
```

```py3:mywrap.py
from functools import (
    wraps,
    update_wrapper
)

# http://docs.python.jp/3.5/library/functools.html#functools.update_wrapper

def decorator_nowraps(f):
    def wrapper(*args, **kwds):
        print('decorated func nowarps')
        return f(*args, **kwds)
    return wrapper


def decorator_wraps(f):
    @wraps(f)
    def wrapper(*args, **kwds):
        print('decorated fun wraps')
        return f(*args, **kwds)
    return wrapper


def decorator_update_wrapper(f):
    def wrapper(*args, **kwds):
        print('decorated func wraps and update')
        return f(*args, **kwds)
    return update_wrapper(wrapper, wrapped=f)


@decorator_nowraps
def example1():
    """Docstr ex1"""
    print('example1')
    

@decorator_wraps
def example2():
    """Docstr ex2"""
    print('ex2')

    
@decorator_update_wrapper
def example3():
    """Docstr ex3"""
    print('ex3')
```
