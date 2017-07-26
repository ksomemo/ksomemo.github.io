# numpy で 鶴亀算 とndarrayのmethod確認しようとして消耗したおまけ
## 得られるもの
- 数式をNumpyで解決できる
- 数式苦手意識が少なくなる
- 進捗が生まれる

```py3
"""
x: 鶴, y: 亀 の数
x + y = 3
2x + 4y = 10

x, y = (1, 2)
"""
import numpy as np

a = np.array([[1, 1], [2, 4]])
b = np.array([[3], [10]])
print(a, "\n"*2, b)

[[1 1]
 [2 4]]

 [[ 3]
 [10]]

# ax = b -> 両辺にaの逆行列をかける -> x = (aの逆行列) * b
# http://docs.scipy.org/doc/numpy/reference/routines.linalg.html
np.linalg.inv(a).dot(b)

# https://www.python.org/dev/peps/pep-0465/
# http://docs.scipy.org/doc/numpy/reference/generated/numpy.matmul.html
np.linalg.inv(a) @ b

# numpy.matrix と np.array での operatorの機能の違い(違いを意識して使いたくないので、ndarrayだけでよさそう)
np.matrix(np.linalg.inv(a)) * b

# そもそもAPIとして用意されている
np.linalg.solve(a, b)
```

## おまけ
numpyのndarrayのmethod確認しようとして消耗した

```
?np.ndarray
  File:           ~/.pyenv/versions/anaconda3-2.5.0/lib/python3.5/site-packages/numpy/__init__.py

numpy/core/numeric.py
  from numpy.core import multiarray
  ndarray = multiarray.ndarray
  __all__ = [
      'newaxis', 'ndarray', 'flatiter', 'nditer', 'nested_iters', 'ufunc',

numpy/core/__init__.py
  from . import multiarray
  from .numeric import *

numpy/__init__.py
  from .core import *
```

- ndarrayで検索した結果、multiarrayからだと分かる
- core, module.__init__を通って使われてることが分かる
- けど、multiarray.pyがないのでgithub上で検索
- numpy/core/setup.py に multiarray moduleというコメンドとpathはsrcと推測される記述があった
- numpy/core/src/multiarray/ こっちが本体(ここまで)
