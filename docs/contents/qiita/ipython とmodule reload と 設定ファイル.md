# ipython とmodule reload と 設定ファイル
## 手順

1. モジュール作成
2. ipythonを起動してimport, 関数実行
3. モジュール修正
4. モジュールファイル確認
5. 再びimport(importされない->すでに名前空間に存在する)
6. reload(2to3)
7. 自動reload設定
8. モジュール修正
9. 関数実行(自動リロードされる)

## コードと入力内容

py_module.py

```python3
print("hello")

def hello(msg='world'):
     print('hello ', msg)
```

## ipython入力
```ipython

In [1]: import py_module
hello

In [2]: py_module.hello()
hello world
```

## py_module.pyを変更
```python3
print('hello world')

def hello(msg='world !!!'):
     print('hello', msg)
```

```ipython
In [3]: %pfile py_module
print('hello world')
```

```py3
def hello(msg='world !!!'):
    print('hello', msg)
```

```ipython
In [4]: import py_module

In [5]: py_module.hello()
hello world
```

```ipython
In [6]: reload(py_module)
---------------------------------------------------------------------------
NameError                                 Traceback (most recent call last)
<ipython-input-5-63b0f6961993> in <module>()
----> 1 reload(py_module)

NameError: name 'reload' is not defined

In [7]: import imp

In [8]: imp.reload(py_module)
hello world
Out[8]: <module 'py_module' from '/Users/xxx/test/python/py_module.py'>

In [9]: py_module.hello()
hello world !!!

In [10]: %load_ext autoreload

In [11]: %autoreload 2
```

py_module.pyを変更

```python3
print('hello world !!!')

def hello(msg='world !!! ???'):
    print('hello', msg)
```

```ipython
In [9]: py_module.hello()
hello world !!!
hello world !!! ???
```

## 設定ファイル
設定ファイルを作って、この投稿を毎回見なくても大丈夫にした。

```shell-session
ipython profile create

[ProfileCreate] Generating default config file: 'C:\\Users\\xxx\\.ipython\\profile_default\\ipython_config.py'
[ProfileCreate] Generating default config file: 'C:\\Users\\xxx\\.ipython\\profile_default\\ipython_qtconsole_config.py'
[ProfileCreate] Generating default config file: 'C:\\Users\\xxx\\.ipython\\profile_default\\ipython_notebook_config.py'
[ProfileCreate] Generating default config file: 'C:\\Users\\xxx\\.ipython\\profile_default\\ipython_nbconvert_config.py'
```

ipython_config.py

```python3
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']
```
