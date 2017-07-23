
## 参考書
* 飛行機本
* 要所ですごいErlangを見る予定

## 環境構築
https://gist.github.com/ksomemo/b3db01e8233a03836e7a にまとめた

* kerlを使ったバージョン管理
* ビルド用のrebarは後述

## エディタ
* IntellijIDEA + Erlang plugin
* pluginインストール後、Erlang External Toolsでのrebar設定

## ディレクトリ構造
* http://www.erlang.org/doc/design_principles/applications.html#app_dir
* 上記のURLに記載されている各ディレクトリ内の構造の詳細は不明
* src,ebinは後述のrebarで作成できる
* priv,includeよくわかっていない
* testは必須ではないが、後述のrebarでテストを実行する際の対象を格納しておく
* docは、後述のrebar(rebar doc)によってhtml documentが作成される

## rebar

便利なコマンドが充実している

* ひな形作成(srcディレクトリに作成)
* complile(ebinディレクトリに作成)
* test(UnitTest/QuickCheckも)
* document
* 依存管理用
* etc.(https://github.com/rebar/rebar/wiki)

### インストール
```
cd ~/erlang/ # kerlで作ったディレクトリなのでなんとなく
git clone git://github.com/rebar/rebar.git
cd rebar
./bootstrap # ここでエラー
```

* bootstrapの先頭に記載されているところで落ちていた
* !/usr/bin/env escript
* ターミナルの別タブで作業をしたためErlangのactivateをしていなかったので.zshrcに応急処理で突っ込んだ orz
* . ~/erlang/r16b03-1/activate
* escriptを使うとErlangファイルをスクリプトとして実行できる

作成されたrebar をPATHが通っているところに移動し、rebar(とバージョン管理ツールkerl)をcommit対象外にしておいた


## おわり
* 環境構築できた
* ビルドツール入れたので今後はこれを調べれば良さそう
* あとは基礎から頑張る
