## 前提
- mac
- brewで環境設定
- たいてい、readlineのversionが合わないとエラーになる
    - 利用しているものを`brew reinstall xxx`でreadlineのversionをあわせる
    - readlineそのもの
    - gnuplot

# R
installしたあと、どうなっているのか気になったのでメモ

- condaから
- Rから

## condaから

### 長くなるのでまとめ
- Python知っている人がRの構文を初めて試す環境としては便利そう
- ただし、install.packages()のrepo指定が面倒
- R関連のuninstallが面倒なので、newenvで試すのを薦める…
- Plotするための設定やインストール等、はまるらしい（既にR環境を整えているので問題なくできた）

### インストールとChannelについて
```bash
# conda install -c r r-essentials
conda create -n my-r-env -c r r-essentials
-c CHANNEL, --channel CHANNEL

Additional channel to search for packages. 
These are URLs searched in the order they are given
(including file:// for local directories). 
Then, the defaults or channels from .condarc are searched
(unless --override-channels is given). 
You can use 'defaults' to get the default packages for conda, 
and 'system' to get the system packages, 
which also takes .condarc into account. 
You can also use any name and the .condarc channel_alias value will be prepended. 
The default channel_alias is http://conda.anaconda.org/.
```

### Kernelの設定
```bash
cat ~/.pyenv/versions/miniconda3-3.9.1/share/jupyter/kernels/ir/kernel.json
{"argv": ["R", "--slave", "-e", "IRkernel::main()", "--args", "{connection_file}"],
 "display_name":"R",
 "language":"R"
}
```

### package(conda)
```bash
ls ~/.pyenv/versions/miniconda3-3.9.1/pkgs/ | grep r3 | head
r-assertthat-0.1-r3.2.2_2
r-assertthat-0.1-r3.2.2_2.tar.bz2
r-base64enc-0.1_3-r3.2.2_0
r-base64enc-0.1_3-r3.2.2_0.tar.bz2
r-bh-1.58.0_1-r3.2.2_0
r-bh-1.58.0_1-r3.2.2_0.tar.bz2
r-bitops-1.0_6-r3.2.2_2
r-bitops-1.0_6-r3.2.2_2.tar.bz2
r-boot-1.3_17-r3.2.2_0
r-boot-1.3_17-r3.2.2_0.tar.bz2
```

### jupyter notebookからPackageのInstall
```r
jupyter notebook
# select R kernel
# 今回のRでinstallされたPackageを読み込んでみる
library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()
# plotともに問題なし

# 元のRでinstallしたPackageを読み込んでみる
library(devtools)
Error in library(devtools): there is no package called ‘devtools’

# https://cran.r-project.org/web/packages/available_packages_by_name.html
# から適当に今回のRでインストール

# 失敗
install.packages("A3")
Error in contrib.url(repos, type): trying to use CRAN without setting a mirror

# repo指定
install.packages("A3", repos = "http://cran.r-project.org")
also installing the dependency ‘pbapply’


The downloaded source packages are in
	‘/private/var/folders/zl/rlmkmk5d3vv_jb8397gd61900000gn/T/RtmpufR4m3/downloaded_packages’
Updating HTML index of packages in '.Library'
Making 'packages.html' ... done

# required パッケージが標準エラー出力される
library(A3)
Loading required package: xtable
Loading required package: pbapply

# 当たり前だけど元のRでは失敗
library(A3)
library(A3) でエラー:  ‘A3’ という名前のパッケージはありません 
```

### defaultでインストールされるパッケージ
```bash
find ~/.pyenv/versions/miniconda3-3.9.1/ -name "*ggplot*"

/Users/xxx/.pyenv/versions/miniconda3-3.9.1//conda-meta/r-ggplot2-1.0.1-r3.2.2_0.json
/Users/xxx/.pyenv/versions/miniconda3-3.9.1//lib/python3.4/site-packages/matplotlib/mpl-data/stylelib/ggplot.mplstyle
/Users/xxx/.pyenv/versions/miniconda3-3.9.1//lib/R/library/ggplot2
.
.
/Users/xxx/.pyenv/versions/miniconda3-3.9.1//lib/R/library/ggplot2/R/ggplot2.rdx
/Users/xxx/.pyenv/versions/miniconda3-3.9.1//pkgs/matplotlib-1.4.3-np19py34_2/lib/python3.4/site-packages/matplotlib/mpl-data/stylelib/ggplot.mplstyle
/Users/xxx/.pyenv/versions/miniconda3-3.9.1//pkgs/matplotlib-1.5.0-np110py34_0/lib/python3.4/site-packages/matplotlib/mpl-data/stylelib/ggplot.mplstyle
/Users/xxx/.pyenv/versions/miniconda3-3.9.1//pkgs/r-ggplot2-1.0.1-r3.2.2_0
/Users/xxx/.pyenv/versions/miniconda3-3.9.1//pkgs/r-ggplot2-1.0.1-r3.2.2_0/lib/R/library/ggplot2
.
.
/Users/xxx/.pyenv/versions/miniconda3-3.9.1//pkgs/r-ggplot2-1.0.1-r3.2.2_0.tar.bz2
```

### notebookからInstallしたPackageの場所
```bash
ls ~/.pyenv/versions/miniconda3-3.9.1/lib/R/library/ | grep -i A3
A3
ls ~/.pyenv/versions/miniconda3-3.9.1/pkgs | grep -i A3
(empty...)
```

### condaでインストールしてみる
```bash
conda install -c r r-A3
Fetching package metadata: ......
Error: No packages found in current osx-64 channels matching: r-a3

You can search for this package on anaconda.org with

    anaconda search -t conda r-a3

You may need to install the anaconda-client command line client with

    conda install anaconda-client
```

## anaconda clientのInstall
```
conda install anaconda-client
```

## anaconda client usage
```bash
anaconda
usage: anaconda [-h] [--show-traceback] [--hide-traceback] [-v] [-q] [--color]
                [--no-color] [-V] [-t TOKEN] [-s SITE]
                ...
anaconda: error: A sub command must be given. To show all available sub commands, run:

	 anaconda -h
```

### anaconda search
```bash
anaconda search -h
usage: anaconda search [-h] [-t {conda,pypi}] name

Search Anaconda Cloud

positional arguments:
  name                  Search string

optional arguments:
  -h, --help            show this help message and exit
  -t {conda,pypi}, --package-type {conda,pypi}
                        only search for packages of this type

Search Anaconda Cloud for packages
```

### A3のsearch
```bash
anaconda search -t conda r-a3
Using Anaconda Cloud api site https://api.anaconda.org
Run 'anaconda show <USER/PACKAGE>' to get more details:
No packages found
     Name                      |  Version | Package Types   | Platforms
     ------------------------- |   ------ | --------------- | ---------------
Found 0 packages
```

### 確実に存在するもので試す
```
anaconda search -t conda r-essentials
Using Anaconda Cloud api site https://api.anaconda.org
Run 'anaconda show <USER/PACKAGE>' to get more details:
Packages:
     Name                      |  Version | Package Types   | Platforms
     ------------------------- |   ------ | --------------- | ---------------
     asmeurer/r-essentials     |      1.1 | conda           | linux-64, win-32, win-64, linux-32, osx-64
                                          : Some essential packages for working with R
     r/r-essentials            |      1.1 | conda           | linux-64, win-32, win-64, linux-32, osx-64
                                          : Some essential packages for working with R
     rgrout/r-essentials       |          | conda           | linux-64, linux-32, osx-64
                                          : Some essential packages for working with R
Found 3 packages
```

### R関連削除
```bash
conda list | awk '$4=="r" {print $1}' | xargs conda uninstall
find ~/.pyenv/versions/miniconda3-3.9.1/ -name R | xargs rm -rf
# 以下消えてた
~/.pyenv/versions/miniconda3-3.9.1/bin/R 
~/.pyenv/versions/miniconda3-3.9.1/share/jupyter/kernels/ir/kernel.json
```

## Rから
めちゃくちゃ簡単

```markdown
- https://github.com/IRkernel/IRkernel
- http://irkernel.github.io/
```

### install requirements
```r
install.packages(c('rzmq','repr','IRkernel','IRdisplay'),
                 repos = c('http://irkernel.github.io/', getOption('repos')))
```

### IRkernel setting
```r
IRkernel::installspec()
 if (is.na(a)) return(-1L) でエラー:  引数の長さが 0 です 
 追加情報:  警告メッセージ: 
 命令 ''ipython' --version 2>/dev/null' の実行は状態 126 を持ちました  

# RStudioで失敗したのでitermからR実行
IRkernel::installspec()
[InstallKernelSpec] Installed kernelspec ir in /Users/xxx/Library/Jupyter/kernels/ir

cat ~/Library/Jupyter/kernels/ir/kernel.json                                                                (git)-[master]
{
  "argv": ["/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/bin/R", "--slave",   {connection_file}"],
  "display_name": "R",
  "language": "R"
}
```

### run notebook
```
jupyter notebook
# select kernel 
New > R
library(devtools) # success
library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()
```

---
# octave

install octave

## coursera用のoctave
windowsだとMATLABを、Macならこれをと言われてちょっと調べてみた

- よく名前聞いていたけど触ったことがなかった
- 無料じゃないと勝手に思ってた
- 有料だと知っていたMATLABの互換性がある（完全ではないっぽい

## install
```sh:install_octave.sh
brew tap homebrew/science
brew install octave
```

```text:dependencies.txt
- qscintilla2
- gnuplot
- tbb
- suite-sparse
- veclibfort
- arpack
- fftw
- glpk
- gl2ps
- graphicsmagick
- szip
- hdf
  - hdf5
  - qhull
  - qrupdate
  - jbig2dec
  - ghostscript
  - epstool
  - imagemagick
  - pstoedit
```

## 警告
```text:warning.txt
Warning: gnuplot dependency libtiff was built with a different C++ standard
library (libstdc++ from gcc). This may cause problems at runtime.

Warning: pstoedit dependency libtiff was built with a different C++ standard
library (libstdc++ from gcc). This may cause problems at runtime.

Warning: octave dependency libtiff was built with a different C++ standard
library (libstdc++ from gcc). This may cause problems at runtime.
```

```text:caveats.txt
==> Caveats

gnuplot's Qt terminal is supported by default with the Octave GUI.
Use other gnuplot graphics terminals by setting the environment variable
GNUTERM in ~/.octaverc, and building gnuplot with the matching options.

  setenv('GNUTERM','qt')    # Default graphics terminal with Octave GUI
  setenv('GNUTERM','x11')   # Requires XQuartz; install gnuplot --with-x
  setenv('GNUTERM','wxt')   # wxWidgets/pango; install gnuplot --wx
  setenv('GNUTERM','aqua')  # Requires AquaTerm; install gnuplot --with-aquaterm

  You may also set this variable from within Octave.


The Octave GUI is experimental and not enabled by default. To use it,
use the command-line argument "--force-gui"; e.g.,
    octave --force-gui
```

## 起動用のipython kernel
octaveコマンドからREPLによるプログラミングをできるようだけど、KernelについてはPythonしか使っていなかったので、その勉強も込めてインストール。

```sh:pip_search_kernel.sh
pip search _kernel
octave_kernel           - An Octave kernel for Jupyter/IPython
bash_kernel             - A bash kernel for Jupyter
xonsh_kernel            - An Xonsh kernel for Jupyter/IPython
matlab_kernel           - A Matlab kernel for Jupyter/IPython
scilab_kernel           - A Scilab kernel for IPython
r2_kernel               - An R wrapper kernel for IPython
hy_kernel               - A hy kernel for IPython
redis_kernel            - A redis kernel for IPython
jupyter_kernel_test     - Machinery for testing Jupyter kernels via the messaging protocol.
```

```sh:pip_install_octave.sh
pip install octave_kernel
# kernel設定が追加されている
python -m octave_kernel.install
```

言語が少ないなーと思っていたら、各言語のパッケージ管理ツールからインストールするものもあるようだった。
https://github.com/ipython/ipython/wiki/IPython-kernels-for-other-languages

- Rではinstall.packages
- phpではComposer
- Rubyではgem

のようにPythonだけでは完結しない

## ipython notobook
右上のNEWにPythonに加えて、octaveが追加されていた

## まとめ
- octaveは無料
- MATLABと互換性がある
- Install簡単だった
- ipython notebookから使えるになってOutputしやすくなった
- MATLABを使う本を読んでもいいなと思うようになった

---

# Hasklell
note:IHaskell (jupyter + Haskell)

```env_ihaskell.sh
# https://remusao.github.io/install-ihaskell-on-ubuntu-1404-with-stack.html

# Haskell setup
brew install stack
stack setup

# alias using stack
export PATH=~/.local/bin:$PATH # stack etc
# Haskell
# export PATH=~/.cabal/bin:$PATH
if which stack > /dev/null; then
     alias ghc="stack ghc --"
     alias ghci="stack ghci"
     alias runghc="stack runghc --"
     alias runhaskell="stack runghc --"
fi

# setupy ihaskell
stack build ihaskell
stack exce ihaskell -- install

# いちいちstackを経由をめんどうだと思って使わない場合
jupyter notebook # then new Haskell notebook
# -> shelly did not find ghc-pkg in the PATH:
# The following target packages were not found: ghc-pkg
# -> alias ghc-pkg="stack exec ghc-pkg --" しても同じ

# ok, 参考URLコメントにもあった
stack exec jupyter -- notebook

# とりあえず下記を定義できて、do記法も使えた
add3 x y z =
    do
        let add2 = x + y
        add2 + z
add3 1 2 3
-- 6

# ghciのように扱えた
:t 1
1 :: forall a. Num a => a

:k Maybe
Maybe :: * -> *

# 型宣言もできた
add :: Int -> Int -> Int
add x y = x + y
add 1 2

# 拡張の追加とimportもできた
{-# LANGUAGE OverloadedStrings, ViewPatterns #-}
import qualified Data.Text.Lazy as T

# 入力を受け付けるプログラムはテキストボックスが出現してにゅうりょくできるようになる
# getContents だと止まらなくてkernel落とした
main = do
    line <- getLine
    putStr $ line ++ "!!"
```

---

# Scala
install jupyter-scala 
## 動機
本家・R・Octaveと分析関連のKernel以外を試してみたかった

## 身についたこと
- wgetでの出力指定
- xz圧縮と-Cによる解凍先指定
- kernel listの表示

## isntall
`bash -vxe 下記script`

```bash:install-jupyter-scala.sh
# https://github.com/alexarchambault/jupyter-scala
home_local=$(echo ~)/local
arc_dir=jupyter-scala_2.11.6-0.2.0-SNAPSHOT
arc_file=$arc_dir.tar.xz
url=https://oss.sonatype.org/content/repositories/snapshots/com/github/alexarchambault/jupyter/jupyter-scala-cli_2.11.6/0.2.0-SNAPSHOT/$arc_file

mkdir -p $home_local
wget -O $home_local/$arc_file $url
tar xJf $home_local/$arc_file -C $home_local/
cd $home_local/$arc_dir
./bin/jupyter-scala
jupyter kernelspec list
cd -
```

## 試した結果
- 初回の評価時はJVM関連のため？か遅い(下記の1.5sくらい)
- 二度目移行は `val a = 1; a` に500msくらい
- 最初ためした時、遅い時は2.6s くらいかかっていて謎だった…

### その後
- 急にperformance悪くなった
- 大したことしてないのにout of memory
- `export JVM_OPT="-Xmx1g"`して回避
- https://github.com/alexarchambault/jupyter-scala/issues/29

## kernel
https://github.com/ipython/ipython/wiki/IPython-kernels-for-other-languages
