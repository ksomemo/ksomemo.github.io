# perceptronの可視化

[パーセプトロンの学習規則をPythonで実装](http://qiita.com/s-kiriki/items/b7e5b87e526153dc3611) を参考に可視化した

## いろんな関数
- 損失関数(loss) or 誤差関数(error)
    - ある学習手法の損失関数はxxxである
        - ヒンジ損失
        - etc.
- 目的関数
    - よくわかってない
    - 正則化項
        - perceptronの範囲を超えているけど、メモ
            - 過学習のために使うらしい
        - http://pandazx.hatenablog.com/entry/2014/07/11/115123
        - http://d.hatena.ne.jp/tkng/20090119/1232340992
        - https://ja.wikipedia.org/wiki/%E6%AD%A3%E5%89%87%E5%8C%96
        - http://tjo.hatenablog.com/entry/2015/03/03/190000
        - https://staff.aist.go.jp/s.akaho/kernel-html/node7.html
        - http://breakbee.hatenablog.jp/entry/2015/03/08/041411
        - https://nbviewer.jupyter.org/github/chezou/notebooks/blob/master/classification.ipynb
- 活性化関数(activation)
    - 出力に対して適用する
        - 出力は入力/bias・重みによる計算結果
        - step関数
        - シグモイド関数
        - etc.
        - 回帰の時は？
    - 閾値
    - perceptronにおいてはニューロンの発火を意味する

### 活性化関数
https://ja.wikipedia.org/wiki/%E6%B4%BB%E6%80%A7%E5%8C%96%E9%96%A2%E6%95%B0

## 層
- 入力層
    - biasの追加
- 隠れ層
    - 活性化関数
- 出力層
    - 活性化関数

各層における役割と関数を適切に考える

```
"""
- http://qiita.com/s-kiriki/items/b7e5b87e526153dc3611
- matplotlibのAnimationでやろうとしたけど、global変数の扱いがめんどうだった(class使えばいい気もするが)
- ipywidgets](https://github.com/ipython/ipywidgets) を採用した
- ipywidgetsの方が自分で値を調整しながら可視化できるので、勉強する身としては役に立つ(ただし、このように公開するときはAnimation GIFのほうがよい)
- オンライン機械学習としては、データ数を少しずつ増やす かつ データセットでの繰り返しを１回に抑えたほうがわかりやすいと思った
-
"""
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn import datasets
import ipywidgets

%matplotlib inline

def f(X, Y):
    @ipywidgets.interact(
        etas={'0.01': 0.01, '0.1': 0.1, '0.5': 0.5},
        with_bias=True,
        epoch=(1, 100, 1),
        end=(2,100, 2)
    )
    def plot(etas=0.1, with_bias=True, epoch=100, end=100):
        #bias = 1
        #eta = 0.1
        #train_x = np.c_[X, np.repeat(bias, 100)]
        #train_y = Y

        bias = 1 * with_bias
        eta = etas
        train_x = np.c_[X, np.repeat(bias, len(X))][:end]
        train_y = Y[:end]
        weight = np.zeros(train_x.shape[1])

        for i in range(epoch):
            for x, y in zip(train_x, train_y):
                weight = train(weight, x, y, eta)

        # ax1+bx2+c = 0
        # x2 = -(a/b)x1 -(c/b)
        x2 = -weight[0]/weight[1] * train_x[:, 0] -(weight[2]/weight[1])
        plt.plot(train_x[:,0], x2)
        plt.scatter(train_x[:, 0], train_x[:, 1], c=train_y)
    return plot
```

```py3
"""
- 線形分離できそうなもの２つとできないもので試した
- http://scikit-learn.org/stable/datasets/
"""

# Generate a random regression problem.
X, Y = datasets.make_regression(
    n_samples=100, n_features=2, n_informative=2, n_targets=1,
    bias=0.0, effective_rank=None, tail_strength=0.5, noise=1.0, shuffle=True, coef=False, random_state=0)
f(X, Y > 5)()


# Generate isotropic Gaussian blobs for clustering.
# datasets.make_blobs([n_samples, n_features, ...])
X_b, Y_b = datasets.make_blobs(
    n_samples=100, n_features=2, centers=2, cluster_std=1.0,
    center_box=(-10.0, 10.0), shuffle=True, random_state=100)
plt.scatter(X_b[:, 0], X_b[:, 1], c=Y_b, cmap=plt.cm.Paired)
f(X_b, Y_b)()


# http://scikit-learn.org/dev/auto_examples/gaussian_process/plot_gpc_xor.html
rng = np.random.RandomState(0)
X_xor = rng.randn(200, 2)
Y_xor = np.logical_xor(X_xor[:, 0] > 0, X_xor[:, 1] > 0)
f(X_xor, Y_xor)()


# Make a large circle containing a smaller circle in 2d.
X_circle, Y_circle = datasets.make_circles(n_samples=100, shuffle=True, noise=None, random_state=None, factor=0.8)
plt.scatter(X_circle[:, 0], X_circle[:, 1], c=Y_circle, cmap=plt.cm.Paired)
f(X_circle, Y_circle)()


# Make two interleaving half circles
X_moons, Y_moons = datasets.make_moons(n_samples=100, shuffle=True, noise=None, random_state=None)
plt.scatter(X_moons[:, 0], X_moons[:, 1], c=Y_moons, cmap=plt.cm.Paired)
f(X_moons, Y_moons)()
```
