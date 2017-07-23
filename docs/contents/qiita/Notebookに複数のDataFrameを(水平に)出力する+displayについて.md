## 調べた結果
- core.displayのDisplayObjectを使ったものは出力できる
    - dataframeだけでなくいろいろなものを出力できる
    - 出力はOutではなく、print等の出力領域に表示される
- core.displayより直下のdisplay moduleは便利なものを含んでいる
    - YoutubeやIFrame便利そう
- _repr_html_ を実装しているclassのinstanceは、このmethodが呼ばれ結果はhtmlとして解釈される
    - Python DataScience Handbookのipynbを見ていたら書いてあった
    - ipythonのrepositoryにsampleがあった
    - pandas.DataFrameにはもちろん実装してあった(実際の処理はto_html)

```display_multiple_df_as_html.py
import pandas as pd
import IPython.core.display as display
import IPython.display
"""
↑
from IPython.core.display import *
from IPython.lib.display import *

lib.display includes 
__all__ = ['Audio', 'IFrame', 'YouTubeVideo', 'VimeoVideo', 'ScribdDocument',
           'FileLink', 'FileLinks']
"""

df = pd.DataFrame(dict(a=range(4)))

print("index: 0 (print)")
IPython.display.display(df[0:1])

print("index: 1 (print)")
display.display(df[1:2])

print("index: 2 (print)")
display.display_html(df[2:3])

print("index: 3 (Out to Cell)")
df[3:]
```

```horizontal_display.py
class HorizontalDisplay:
    def __init__(self, *args):
        self.args = args

    def _repr_html_(self):
        template = '<div style="float: left; padding: 10px;">{0}</div>'
        return "\n".join(template.format(arg._repr_html_())
                         for arg in self.args)
# print
display(HorizontalDisplay(df, df))
# output
HorizontalDisplay(df, df)
```

## 参考
- http://stackoverflow.com/questions/34398054/ipython-notebook-cell-multiple-outputs
- http://stackoverflow.com/questions/36719812/pandas-how-to-reference-and-print-multiple-dataframes-as-html-tables
- http://stackoverflow.com/questions/26873127/show-dataframe-as-table-in-ipython-notebook/29665452#29665452
- http://qiita.com/mokemokechicken/items/98564e4a6a8963b2a6e2
    - subplots使わない複数グラフ出力
- https://github.com/ipython/ipython/blob/41bc8e5ec492820b32f60122dd178300f7e01240/examples/IPython%20Kernel/Custom%20Display%20Logic.ipynb
- http://nbviewer.jupyter.org/github/jakevdp/PythonDataScienceHandbook/blob/master/notebooks/03.06-Concat-And-Append.ipynb
