- sympyまとめた
- 行列まとめたのは無いと思うたぶん
- githubにあげた
- ちょっと重いので分割したい

https://github.com/ksomemo/my_jupyter_notebooks/blob/master/python/sympy_sample.ipynb

```py3:sympy_matrix_symbol_subs.py
from sympy import Matrix,　MatrixSymbol
x = MatrixSymbol("x", 2, 2)
Matrix(x).subs([(x[0, 0], 2)])

⎡ 2   x₀₁⎤
⎢        ⎥
⎣x₁₀  x₁₁⎦
```
