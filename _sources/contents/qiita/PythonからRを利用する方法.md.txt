# PythonからRを利用する方法
何番煎じか分からないけど、PythonからRを利用する方法

## pyper
### install
```bash
# http://d.hatena.ne.jp/dichika/20130213/1360718736
# http://qiita.com/ynakayama/items/f84dc659f1337d71dd9e
# http://nekopuni.holy.jp/2014/12/rpythonr%E3%81%A8python%E3%81%AE%E9%80%A3%E6%90%BA/

conda search rpy2
Fetching package metadata: ....
Using Anaconda Cloud api site https://api.anaconda.org

conda search pyper
Fetching package metadata: ....
Using Anaconda Cloud api site https://api.anaconda.org

pip search pyper
PypeR             - A python interface to R lanugage

pip install pyper
Collecting pyper
  Downloading PypeR-1.1.2.tar.gz
```

### example
```py3
import pandas as pd
import pyper
import os


# r session作成と変数への代入
r = pyper.R(use_pandas = "True")
r.assign("r_data", pd.read_csv("iris.data.csv"))

# Rのコードから実行
print(r("summary(r_data)"))

# Rのsourceを使ってファイルから評価
r_source_file = "example.R"
image_file_name = "image.png"
r_source = """library(dplyr)
png("{0}", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
pairs(select(r_data, c(-Name)))
# dev -> device
dev.off()
""".format(image_file_name)

with open(r_source_file, "w") as f:
    f.write(r_source)
print(r("source(file='{0}')".format(r_source_file)))
os.remove(r_source_file)

from IPython.core.display import Image
Image(image_file_name)
# or
import PIL
PIL.Image.open(image_file_name)

# os.remove(image_file_name)
```

## Rだけで簡潔することipython系でもっと楽に書きたい
- [ipython notebook R cell magic as a python function](http://stackoverflow.com/questions/27727833/ipython-notebook-r-cell-magic-as-a-python-function)
- Rのコードを素直に書くだけで良い
- ただしrpy2を使うので雑に使って捨てる前提

```py3
# pip install rpy2
import rpy2
%load_ext rpy2.ipython
py_variable = 1
```

```R
%R head(iris)
```

DataFrameの出力はHTML Tableになっている

```R
%%R -i py_variable
print(py_variable)
my.summary <- function (df) {
    return(summary(df))
}
my.summary(iris)
```

pyperのように文字列でないので、printしなくてよい
