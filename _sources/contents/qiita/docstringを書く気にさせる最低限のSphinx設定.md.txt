# docstringを書く気にさせる最低限のSphinx設定
- 忙しいとドキュメントを書かなくなってしまう
- あとで調べているときに後悔する
- sphinx-apidocを使って簡単にドキュメント作成をする

## version
```bash
sphinx-apidoc --version
Sphinx (sphinx-apidoc) 1.3.1
```

## 雛形作成
```bash
sphinx-apidoc -F -o docs/ source_dir/
```

##ドキュメント作成
```bat
cd docs
make.bat html
```

### 再度作成
```bat
make.bat clean
make.bat html
```

## ビルド時の各種設定
docs/conf.pyを修正

### 言語
仕事用のときの日本語設定

```python3
language = 'ja'
```

### テーマ
```python3
# 真っ白、ファイル生成時のデフォルト
html_theme = 'alabaster'

# python2.xっぽいドキュメント
html_theme = 'sphinxdoc'

# よく見る薄い紺？のあれ(これにした
html_theme = 'default'
```

### その他
検索用

```
# Language to be used for generating the HTML full-text search index.
html_search_language = 'ja'
```
