
[データサイエンティストに向けたコーディング環境Jupyter Notebookの勧め](http://qiita.com/y__sama/items/17aedf0c05187edd61c3) で紹介されていたnotebook内の全文検索を試してみたかった。

## いきなりだけどまとめ
全文検索以外にもいろいろあるけど、全文検索が一番使える

## repogitory and pypi
- https://github.com/jupyter-incubator/contentmanagement
- https://pypi.python.org/pypi/jupyter_cms

## install

```
pip install jupyter_cms
Collecting jupyter-cms
  Downloading jupyter_cms-0.4.0.tar.gz
Collecting whoosh<3.0,>=2.7.0 (from jupyter-cms)
  Downloading Whoosh-2.7.3.zip (1.1MB)
```

### Whoosh
- https://pypi.python.org/pypi/Whoosh/
- [Python純正の全文検索ライブラリ、Whooshを使ってみた](http://d.hatena.ne.jp/rudi/20110420/1303307332)

### extensionとしてのinstallと有効化
```
% jupyter cms install --user --symlink --overwrite
[ExtensionInstallApp] Installing jupyter_cms JS notebook extensions
symlink /Users/xxx/Library/Jupyter/nbextensions/jupyter_cms 
-> /Users/xxx/.pyenv/versions/anaconda3-2.5.0/lib/python3.5/site-packages/jupyter_cms/nbextension

% jupyter cms activate
% jupyter cms help
% jupyter cms install --help-all

# 以下、RISEと同じ場所に置こうとして、extensionが起動しなかったメモ
# とsymlink削除(-rfは危ないのでやめよう)
% jupyter cms install --symlink --overwrite --nbextensions=~/.local/share/jupyter/nbextension
% rm /Users/xxx/Library/Jupyter/nbextensions/jupyter_cms

```

## 全文検索
の前に

- モジュール名の変更
  - https://github.com/jupyter-incubator/contentmanagement/commit/6045d4ef0e0d38c7cb38ea9f231333d950ddae95
- 0.4.0のチュートリアル
  - https://github.com/jupyter-incubator/contentmanagement/blob/b7d34b3c4aeab1f7cfa06323b6741080b54f62b5/etc/notebooks/cookbooks_demo/use_cookbooks.ipynb
  - チュートリアルの変更(load_extの変更)
    - https://github.com/jupyter-incubator/contentmanagement/commit/b7d34b3c4aeab1f7cfa06323b6741080b54f62b5#diff-f0a4308977e69922b3419d67f5b5bdb2L11


## その他デフォルトでできること
- Table of Contents(TOC)の表示
- ファイルのDrag & Dropによるアップロード
- 他のnotebookのセルをimport
- 他のnotebookのセルを関数として利用

## 試してみた感想
- TOCは http://qiita.com/ksomemo/items/ba0f24daae2276ffd9b2 でも紹介したとおり、他のextensionにあるのでいらない
- アップロードはmdとjsonはできなかったが、TSVはアップロードできた

### 他のnotebookのセルをimport
- セルに`#<help>`コメント, `#<help:name>`でhelp method/name methodを使えるようになる
- 上記methodを実行すると、他のnotebookのセルをimportできる(このときにセルの選択が固まる…)
- 実際にそのセルを現在のnotebookで使うときには%injectを使う
- コメントめんどう

### 他のnotebookのセルを関数として利用
- セルに`# <api>`コメントを書くと、notebook読み込み時に実行される
- 関数定義しておくと、その関数がnotebookのmethodとして定義される
- こちらは問題なく動作した
- こちらもコメントめんどう
