## 定型Import
```py3:import_snippet.py
import matplotlib as mpl
import matplotlib.pyplot as plt

#matplotlib.style.use("ggplot")
%matplotlib inline
```


## matplotlib
### 複数グラフ
```py3:matplotlib_複数グラフ.py
figure, axes = plt.subplots(3, 2, sharex="col", sharey="row")
df.plot(ax=axes[0][0], title="title")

## axes: ndarray
axes[0, 0].legend(bbox_to_anchor=(2, 2), ncol=3)
axes[0, 1].legend_.remove()
axes[0, 0].set_ylabel("y label")
axes[0, 0].set_ylim([0, 1])

plt.tight_layout()
```

### subplotsで作成された軸配列を１次元にする
```py3:matplotlib_flatten_axes.py
# N行 x M列 (2<=N,M)のグラフを描画する時2重ループになってめんどう
# subplotsの戻り値axesはndarrayなのでravel, flattenで1次に変換できる
import matplotlib.pyplot as plt

columns = [c for c in df.columns if c.startswith('y_')]
fig, axes = plt.subplots(2, len(columns) // 2, figsize=(len(columns) * 4, 4 * 2))
for c, ax in zip(columns, axes.flatten()):
    df.plot(x="x", y=c, ax=ax)
```

### 分類領域
[meshgridとcontourfを可視化して理解してみた](http://qiita.com/ksomemo/items/81c88378a1dffa5cbea7)


### 日本語font
1. ~\.ipython\profile_default に設定ファイルを作成しておく `ipython profile create`
1. C:\Windows\Fonts からフォントを選び
1. C:\Anaconda3\pkgs\matplotlib-1.4.3-np19py34_1\Lib\site-packages\matplotlib\mpl-data\fonts\ttf にコピーして
1. 設定ファイルにフォント設定を追加する

```py3:ipython_kernel_config.py
c.InlineBackend.rc = {
    'font.family': 'meiryo',
}
```

```py3:matplotlib_font_manager.py
iimport matplotlib.font_manager as fm

# 現在フォント
matplotlib.rcParams.get('font.family')
prop = fm.FontProperties(fname="ttc or ttf")
# これをplot時に渡す（めんどう
```

- 設定ファイルではWindowsの場合うまくいかなかった
- ttc直接指定の場合はうまくいく
- Windowsの場合、ttcをttfに分解して設定ファイルにて指定すれば良い？

## 利用可能なフォント一覧
```py3:matplotlib_find_system_fonts.py
import matplotlib.font_manager as fm
font_files = pd.DataFrame(fm.findSystemFonts(), columns=list("a"))
font_files.head()
```

### mac
```bash:matplotlib_font_setting.sh
#Font Book.appでフォントファイルを見つけて中身を確認する
#Go2ShellHelper.appとかあると便利
find `pyenv prefix` -name matplotlib
cd 上記で見つけたmatplotlibのディレクトリ/mpl-data/
cp matplotlibrc ~/.matplotlib #にテンプレートとしてCopy
#font.family : 日本語可能フォント名と修正
cp font_file.ttf matplotlibのディレクトリ/mpl-data/fonts/
```
