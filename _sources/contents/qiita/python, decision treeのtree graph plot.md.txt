# python, decision treeのtree graph plot
## 動機
- decision treeのtree plotのためにいろいろ調べた
- kerasで使うので久しぶりに調べた(2017-02-16)
- 平面で境界線のplotはmatplotlibで書くので、この記事を閉じてよい

## graphviz
- だいたいのライブラリで使ってるらしい
- つまりだいたいのライブラリがwrapper

```bash
brew install graphviz
```

## scikit-learnでdecision tree
- http://scikit-learn.org/stable/modules/tree.html
- http://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeClassifier.html

### plot用APIのWIP
https://github.com/scikit-learn/scikit-learn/pull/6380

## library
### pydot
- https://pypi.python.org/pypi/pydot
- https://pypi.python.org/pypi/pydot2/1.0.32
- https://pypi.python.org/pypi/pydot3
- https://pypi.python.org/pypi/pydot-ng

#### pydot2
- <del>上記でいろいろあげたけど、pydotを使うならこれでよさそう</del>
- pydotと同じ作者
- source codeは公開されているけどrepositoryがない？
- sklearnのexampleにも使われているが、開発継続されていない？
- python3でやってみたけど、エラー

```py3
from sklearn.externals.six import StringIO as SkStringIO
from IPython.display import Image
import pydot


dot_data = SkStringIO()
export_graphviz(
    tree_clf, out_file=dot_data,
    feature_names=X.columns,
    class_names=["0", "1"],
    filled=True, rounded=True,
    special_characters=True)
graph = pydot.graph_from_dot_data(dot_data.getvalue())
Image(graph.create_png())
```

#### pydot3
- kerasでvisualizationを試したときに使った
- python3で動いた
- forkではなくportしてcompatibleにしたcommitをしている
- いろいろあるrepositoryの中で一番直近に更新されている

#### pydot-ng
- pydotのrepositoryのhistoryを引き継いでいる個人repositoryをforkしたもの
- organizationになっている
- `import pydot_ng as pydot` としてmodule名の代用をしないといけないので既存moduleではだめっぽそう
    - https://github.com/fchollet/keras/commit/e5d3abdf09d8c281ca8817b6292a044673ba3007
    - kerasではこのmoduleを優先して(pydotとして)importしているのでこれでよい
    - なければpydotがimportされるのでpydot3でも大丈夫だった

### networkx
- http://pypi.python.org/pypi/networkx/
- GraphVizは必須ではなくOption

### PyGraphviz
- http://pygraphviz.github.io
- networkxと連携できる

### graphviz
- https://pypi.python.org/pypi/graphviz
- plot用APIのWIPではこれが使われていた
- こちらは問題なく動いた

```bash
pip install graphviz
```

#### graphviz_tree_plot.py
```py3
from sklearn.externals.six import StringIO as SkStringIO
from IPython.display import Image
import graphviz

def tree_plot(decision_tree, width=500, height=500, max_depth=None,
         feature_names=None, class_names=None, label='all',
         filled=False, leaves_parallel=False, impurity=True,
         node_ids=False, proportion=False, rotate=False,
         rounded=False, special_characters=False):
    in_memory_dot_file = SkStringIO()
    export_graphviz(
            decision_tree, out_file=in_memory_dot_file, max_depth=max_depth,
            feature_names=feature_names, class_names=class_names, label=label,
            filled=filled, leaves_parallel=leaves_parallel, impurity=impurity,
            node_ids=node_ids, proportion=proportion, rotate=rotate,
            rounded=rounded, special_characters=special_characters)
    src = graphviz.Source(in_memory_dot_file.getvalue())
    return Image(src.pipe(format='png'), height=height, width=width)

tree_plot(tree_clf,
    feature_names=X.columns,
    class_names=["d", "s"],
#    class_names={1: "s", 0: "d"},
    filled=True,
    rounded=True,
    special_characters=True
)
```

## 比較
http://plaza.rakuten.co.jp/kugutsushi/diary/200711080000/
