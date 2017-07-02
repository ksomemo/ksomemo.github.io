- 忙しいとドキュメントを書かなくなってしまう
- あとで調べているときに後悔する
- sphinx-apidocを使って簡単にドキュメント作成をする

## version
```bash:sphinx-apidoc-version.sh
sphinx-apidoc --version
Sphinx (sphinx-apidoc) 1.3.1
```

## 雛形作成
```bash:create-template-quickstart.sh
sphinx-apidoc -F -o docs/ source_dir/
```

##ドキュメント作成
```bat:makehtml.bat
cd docs
make.bat html
```

### 再度作成
```bat:clean-and-makehtml.bat
make.bat clean
make.bat html
```

## ビルド時の各種設定
```text:conf-file-name.txt
docs/conf.pyを修正
```

### 言語
仕事用のときの日本語設定

```py3:conf_language.py
language = 'ja'
```

### テーマ
```py3:conf_theme.py
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
