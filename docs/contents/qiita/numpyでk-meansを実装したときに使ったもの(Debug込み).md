# numpyでk-meansを実装したときに使ったもの(Debug込み)
## 概要
- KMeansをとりあえず実装した(irisの特定カラム用)
    - [gist](https://gist.github.com/ksomemo/cb24c8e070231a6b06b9960ba4163b38)
- 可視化には@ipywidgets.interact をパーセプトロンのときと同様に使った
    - Debug用の出力ON/OFFもできるようにした
- 簡単に実装できるのでぜひやってみるべき

## TODO
- 関数でなくsklearnのようにClassにする
- 可視化の際にCentroidsの動きもわかるようにする
- どのデータセットでも(N次元可変)対応できるようにする
- 距離関数に任意のものを差し込めるようにする
- EMアルゴリズムとの関係を記述する

## built-in
- round
    - (float, 2)を使って桁ので調整して表示

## numpy
- np.random.choice(data.index, n_cluster)
    - 各クラスタ中心決定
- np.linalg.norm(np.c_[col1 - center_x, col2 - center_y], axis=1)
    - ノルム
    - 差分計算後に使うことでユークリッド距離にする
    - `from scipy.spatial import distance` にはいろんな距離がある
    - ユークリッド距離 `distance.euclidean([0, 0], [1, 1])`
        - 遅いらしい(http://stackoverflow.com/questions/1401712/how-can-the-euclidean-distance-be-calculated-with-numpy)
- np.argmin([[各クラスタの中心との距離],[...]], axis=1)
    - クラスタ判定
- np.all(new_clusters == old_clusters)
    - クラスタ決定の終了判定
- np.sum(上記)
    - どれだけクラスタが安定しているか
- <del>np.where(new_clusters != old_clusters)</del>
    - どこが移動したか
- ary_x.mean(), ary_y.mean()
    - クラスタの中心移動

## collection
- Counter(1d-array)
    - 使えたので、各クラスタに属するデータ数を確認

## seaborn
- lmplot
    - クラスタ別のscatter plot
    - http://qiita.com/ksomemo/items/2ea2571434b25a6f70fd

## その他
実装中にsklearnを見て学んだこと

- `sklearn.cluster.KMeans(verbose=1)` で学習時の詳細経過表示
- 他でもoptionにある
- kmeans++を使っている
- Cythonを使っている
