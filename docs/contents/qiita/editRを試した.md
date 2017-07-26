# editR試した
> [QiitaはTwitterのツイートを埋め込める](http://qiita.com/yyu/items/d7483b63f701ae1d1c50)

## Twitterで教えてもらった
<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/ksomemo">@ksomemo</a> Rmdを切り離して編集しながらプレビューできる <a href="https://t.co/9X9RCly80p">https://t.co/9X9RCly80p</a> というのがあります</p>&mdash; ホクのうむ (@u_ribo) <a href="https://twitter.com/u_ribo/status/685406431059677184">2016年1月8日</a></blockquote>

## 概要
- https://github.com/swarm-lab/editR
- Shinyを使ったRmd Editor
- markdownがリアルタイムに反映される

## install
```R
install.packages("devtools")
library(devtools)

devtools::install_github("trestletech/shinyAce")
devtools::install_github("swarm-lab/editR")
library(editR)
```

## 操作の流れ
- editR()で新規ファイルを作成
- Listening on http://127.0.0.1:6474
- Rのcodeもリアルタイムに反映される
- WebBrowserで http://127.0.0.1:6474/ にアクセスすると、そのまま編集できる

- File Menuからダイアログを開き、保存できる
- RStudioのProjectのRootに、editRsample.Rmdで保存しておいた
- editR("./editRsample.Rmd")で開ける
- File MenuからRender fileでHTMLを出力できた


