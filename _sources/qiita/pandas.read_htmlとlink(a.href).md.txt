```description.md
## 動機
- データセットを探していた
- データセットの詳細と適用可能な解析方法の組合せを見やすくしたかった

## データセットまとめ
- http://d.hatena.ne.jp/hoxo_m/20120214/p1 のテーブル部分
- ２個目のテーブルが適用可能な手法とデータセットの対応表

## 問題点
テーブルの抽出といえばpandas.read_htmlであるが、データセットのダウンロードURLはリンク名しか取得できなかった

## 解決方法
- Scraping
- pyqueryがpython3対応されているとTwitterで見たので使ってみた
- jQueryのようにCSSセレクタで対象を見つけて取得
- https://gist.github.com/ksomemo/06e87d5cab6792c321de9027114503a4
```
