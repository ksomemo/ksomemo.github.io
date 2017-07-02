- PairGridを使えば散布図以外もplot可能
- 対角線、上三角、下三角、上下三角と必要な部分にplot可能
- plotしてみた(todo:url)
    - 今回の用途では正直微妙
    - hueを指定するとhueごとにplotされる
    - よって、今回の場合の相関係数がhueごとに計算され、しかも描画されて使えない
    - heatmapとは相性が悪い
        - もともと、散布図ではデータ量が多くて時間がかかりすぎているための対処
        - もっとよい可視化方法見つけたい(もしくはpercentileなどのセグメント化)

## ためになったこと
- 現在の軸を取得できることを覚えた
- それに対して文字を残すことを覚えた
- 他のGridも便利だった
    - https://stanford.edu/~mwaskom/software/seaborn/generated/seaborn.FacetGrid.html
        - http://qiita.com/hik0107/items/865b75ae486728cb0006
    - https://stanford.edu/~mwaskom/software/seaborn/generated/seaborn.JointGrid.html


```
dummy
```
