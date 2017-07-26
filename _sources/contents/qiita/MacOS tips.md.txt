# MacOS tips
## keys
MacOS modifier keys:
⌘: Command
⌃: Control
⌥: Option
⇧: Shift
↩: Return
␣: Space
⇥: Tab

## M-f でƒが入力されないようにする
¥　から \ に変更したので、これも変更する

## why
- termianlで次の単語にすばやく移動したい
- C-[ f はめんどう

## change on iterm2
1. preferences
2. profiles
3. keys
4. Left option key acts as ESC+

## 感想
しあわせ

## MACでのls -l で表示される@マーク(メタデータ)
### 扱うためのコマンド
```bash
man xattr

NAME
     xattr -- display and manipulate extended attributes

SYNOPSIS
     xattr [-lrsvx] file ...
     xattr -d [-rsv] attr_name file ...
     ...
```

## やってみた
```bash
# 何がついているか見る
xattr file
file: com.apple.quarantine

xattr file.zip
file.zip: com.apple.metadata:kMDItemWhereFroms

# 指定して取り除く
xattr -d com.apple.quarantine file
# xattr -d com.apple.metadata file.zip
xattr -d com.apple.metadata:kMDItemWhereFroms file.zip
```

## gnu timeをbrew install
### 目的
* プログラムで使用したメモリ量を計測する
* timeで測れる

### time
shellで用意されたものなので違う

### /usr/bin/time
* gnu-timeとは違う
* -f "%M KB" が使えない

### brew install gnu-time
* してもtimeはshellで予約されているものから変わらない
* gtimeとして登録されている
* gtimeにaliasつけると忘れた時に大変そうなのでメモしておいた

## yen to backslash on Mac
### default
|input|output|
|-----|------|
|¥  |¥|
|M-¥|\|

### ¥キーで入力する文字の設定
- keyboard setting -> 入力ソース から変更
- Google日本語入力でも同様に設定できる

### 変更後の¥の入力
|input|output|
|-----|------|
|M-y         |¥|
|えん(IME変換)|¥|


## 他記事のリンク
### [install mactex into yosemite](http://qiita.com/ksomemo/items/1fa9388d195bec91f356)
