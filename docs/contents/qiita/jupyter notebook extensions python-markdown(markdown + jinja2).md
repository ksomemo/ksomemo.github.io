# jupyter notebook extensions python-markdown(markdown + jinja2)
## 動機
- jupyter便利だけど、markdown部分にpython使えないかなー
- あった

## notebook-extensions python-markdown
- https://github.com/ipython-contrib/IPython-notebook-extensions/wiki/python-markdown
- https://github.com/ipython/ipython/issues/2958
- https://github.com/jupyter/notebook/issues/1098
- Jinja2形式のTemplateでpythonの変数を展開できる
    - 使いたい変数を事前に定義
    - markdown部分にてJinja2扱うようにする

## notebook-extensions wiki
https://github.com/ipython-contrib/IPython-notebook-extensions/wiki

pip-install-notebook-extensions.sh

```bash
# https://github.com/ipython-contrib/IPython-notebook-extensions/wiki/python-markdown
# https://github.com/ipython-contrib/IPython-notebook-extensions

pip install https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip
# or git clone a && cd a && pip install -e .
pip freeze | grep nbextensions
Python-contrib-nbextensions===alpha

jupyter notebook
# http://localhost:8889/nbextensions
```

## nbextensions
- いろんなExtensionがある
- チェックすると使えるようになる
- https://github.com/ipython-contrib/IPython-notebook-extensions/tree/master/nbextensions にあるものが使える
- localで、このディレクトリの下にextensionを追加して拡張できるらしい

## NbExtensions menu item
- nbextensionsの画面を見るためにURLを覚えておくのは面倒なのでチェックする
- notebookのEdit MenuにnbextensionsへのLinkがある
- ただし、http://localhost:8889/tree からは行けないので面倒

## 必須
### NbExtensions menu item
説明したとおり

### Table of Contents (2)
見出しの目次化

## あるとよい
### Equation Auto Numbering
- latex数式にちょっと一手間加えると番号を追加
- なんども実行するとIncrementされる

### datestamper
datetimeの文字列表現を挿入

### Gist-it
gistにupload

### Hide input/Hide input all
source codeを隠したり表示したり、Outputは表示したまま

### zenmode
- menuが消える
- 背景が変わるので、真っ白よりいい

### ExecuteTime
- 実行時間の表記
- 遅い処理のベンチマークテストするほどでない時の計測

## 便利だけどちょっと残念
### highlighter
- 背景の色付け
- 文字の色付けが欲しい

### Help panel
- Helpを右に固定する
- 慣れていないうちには便利
- だけど、HelpのDesignが変わったせいか固定できない?

### Search-Replace
- Replaceできる
- 動きが微妙

## 人に依りそう
- Toggle all line numbers
- Ruler(default:78 chars)

## なくて問題なし
- Launch QTConsole
- Comment/Uncomment Hotkey(元からあるC-/)
