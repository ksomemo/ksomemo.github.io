# ファイルをN行に分割する
## いままで
for と下記を使ってわざわざめんどうなことをしていた

- sed
- awk(NR)
- pandas.DataFrameをilocとlen(df), floor/ceilを使ってindexぶつ切り

### awk
```bash
# 今まで
# wc -lと分割行数より分割数を決めて、forとawkとNR使って分割していたけど、もっと便利なのがあった。
# awkだけでも便利にできる。分割数ではなく、最初の行数がファイル名に含まれるようにしてある。

awk 'NR%1000000==1 {filename="prefix_" sprintf("%07d", NR)} {print > filename}' file.txt
```

## split
https://www.gnu.org/software/coreutils/manual/html_node/split-invocation.html

### example
```bash
seq 3000 | ¥
    split -d -l 1000 --additional-suffix=.log--filter='gzip > $FILE.gz' - seq
```

- seqは適当なデータ作成用
- -dでsuffixを連番にする(指定しないとalphabet)
- -lで行数指定
    - サイズ指定のオプションもある
- 拡張子がほしいときに追加suffix
- filterで追加処理
    - `$FILE` はprefix,連番,suffix
- `-` は標準入力なのでファイル指定したいときはここ
- seqはprefix

### おまけ
gzipからの場合zcat通すと便利で楽

```bash
seq 3000 | gzip -f | zcat |
```


## pandasの場合
### numpy.split
```python3
import numpy as np
import pandas as pd
import seaborn as sns


iris = sns.load_dataset("iris")
chunks = np.split(iris, 50)

chunks[0] # index:0-2
chunks[-1] # index: 147-149
# => 150 / 50 = 3
```

### groupby
割り切れないときに困る＋楽。groupby/Grouper便利

```python3
for g, df in iris.groupby(iris.index // 33):
    df.to_csv(f"{g}.csv")
```

### read_csv
読み込み前

```python3
chunks = pd.read_csv("https://raw.github.com/pydata/pandas/master/pandas/tests/data/iris.csv", chunksize=33)
iris = pd.concat(chunks, ignore_index=True)
```
