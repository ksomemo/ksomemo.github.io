# sympyまとめた
- 行列まとめたのは無いと思うたぶん
- githubにあげた
- ちょっと重いので分割したい

<https://github.com/ksomemo/ksomemo.github.io/blob/master/docs/contents/notebooks/sympy/sympy_sample.ipynb>

```py3
from sympy import Matrix,　MatrixSymbol
x = MatrixSymbol("x", 2, 2)
Matrix(x).subs([(x[0, 0], 2)])

# ⎡ 2   x₀₁⎤
# ⎢        ⎥
# ⎣x₁₀  x₁₁⎦
```
