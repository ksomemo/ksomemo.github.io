またHaskell熱が出てきたので環境を整えてみた

前の環境から最近の環境の流れは以下のとおりらしい

- CabalとCabal hell
- 辛いのでSandbox
- 最近はStack

整えてはみたんだけど、自分の都合上、最終的にはGlobal環境使いまくりになっているのでメモ程度にする

## 参考
- http://qiita.com/tanakh/items/6866d0f570d0547df026
- http://takafumi-s.hatenablog.com/entry/2015/10/20/194555

## 環境
- MacBookAir
- Yosemite

## stack install 概要
参考通り

## install ghc-mod
ここでつまづいたので、参考1番目の通りにしてみる

- unpackしてソース持ってくる
- init
  - 参考でサブディレクトリを無視しているのは、ghc-modのtest配下にcabalファイルがあるから
- build


### インストールしたバイナリへのPATH
~/.local/bin にコピーされるので通しておく

build後にPATHを通すと書いてあったが、2番目の参考より、install はbuild + copy なので、installコマンドを実行しておく

通したPATHにghc-mod, ghc-modiが存在していた


## コマンド

### stack
```bash:brew_install_stack.sh
#brew update
brew install haskell-stack
```

```bash:stack_bin_path.sh
export PATH=~/.local/bin:$PATH
```

### Haskell packages
```bash:install_haskell_packages.sh
# LTSな環境でインストール
stack new projectname
cd projectname
stack setup
stack install stylish-haskell
stack install hlint

# Nightlyであることは気にせずインストール
cd ..
stack unpack ghc-mod
cd ghc-mod-xxx
stack init --ignore-subdirs
stack build
stack install ghc-mod
```

### atom packages
```bash:install_atom_haskell_packages.sh
apm install language-haskell
apm install haskell-ghc-mod
apm install ide-haskell
apm install autocomplete-haskell
apm install linter
apm install linter-hlint 
```
