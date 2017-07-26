# java, scalaの環境を整えすぎようとして消耗したのでメモ
## scala環境
- scala
    - scalaenv
    - svm
- Java
    - jenv
- IntelliJ IDEA
    - plugin
        - scala
        - sbt
    - setting
        - JDK
        - ほかいろいろ
- gitignore
    - https://www.gitignore.io/api/scala
    - https://www.gitignore.io/api/sbt
    - https://www.gitignore.io/api/java
    - https://www.gitignore.io/api/intellij

## バージョン切り替え
いろいろ入れながら調べてみたけど、実はさほど必要ないらしい…（下記より）

http://d.hatena.ne.jp/xuwei/20140203/1391400111

### scalaenv
- rbenvを参考にしたらしい
- installできるversionが比較的新しい
- 作者は他にもsbt/play framework用のxenvを作っている

```shell-session
brew info scalaenv
scalaenv: stable 0.0.7, HEAD
https://github.com/mazgi/scalaenv
Not installed
From: https://github.com/Homebrew/homebrew/blob/master/Library/Formula/scalaenv.rb
==> Caveats
To use Homebrew's directories rather than ~/.scalaenv add to your profile:
  export SCALAENV_ROOT=/usr/local/var/scalaenv

To enable shims and autocompletion add to your profile:
  eval "$(scalaenv init -)"
```

### svm
- 昔のversionもinstallできる
- 上記の理由でこちらにした

```bash
git clone git@github.com:yuroyoro/svm.git ~/.svm
```

```bash
export SCALA_HOME=~/.svm/current/rt
export PATH=~/.svm:$PATH
export PATH=$SCALA_HOME/bin:$PATH
```

#### install
```bash
svm install 2.11.7
```

## jenv
- 現在java8がデフォルトになっていた
- 念のため、java7以下を使える環境を整えておきたかった

> It is based on rbenv.

とのこと

```shell-session
% brew install jenv
==> Downloading https://github.com/gcuisinier/jenv/archive/0.4.2.tar.gz
######################################################################## 100.0%
==> Caveats
To enable shims and autocompletion add to your profile:
  if which jenv > /dev/null; then eval "$(jenv init -)"; fi

To use Homebrew's directories rather than ~/.jenv add to your profile:
  export JENV_ROOT=/usr/local/opt/jenv
```

と上に書いてあったけど、下記設定にした

```bash
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
```

```bash
jenv add /System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
jenv add /Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/Home
```

### version
```shell-session
jenv versions

* system (set by $HOME/.jenv/version)
  1.6
  1.6.0.65
  1.7
  1.7.0.09
  1.8
  1.8.0.20
  oracle64-1.6.0.65
  oracle64-1.7.0.09
  oracle64-1.8.0.20
```

```bash
jenv shell 1.7
jenv rehash
```

- rehashによって1.7を参照するようになった
- けど、jdkの参照が変わらない…1.8のまま

この状態の時

- 2.7系はErrorになる
- 2.8系はErrorにならないが、REPLから帰ってこない
- 2.9系はwarning, reflect/AnnotatedElement.class is broken
- 2.10/11系は正常に動作する

### doctor
```shell-session
jenv doctor
[ERROR]	JAVA_HOME variable already set, scripts that use it directly could not use java version set by jenv
[OK]	Java binaries in path are jenv shims
[OK]	Jenv is correctly loaded
```

- JAVA_HOMEをみると1.8を指していた
- jenv javahomeを実行すると1.7を指している

初期化がうまくいってないのかなと思い、まずはevalしているinitを確認

```bash
export PATH="$HOME/.jenv/shims:${PATH}"
source "/usr/local/Cellar/jenv/0.4.2/libexec/libexec/../completions/jenv.zsh"
jenv rehash 2>/dev/null
export JENV_LOADED=1
unset JAVA_HOME
```

- unsetされているはずのJAVA_HOMEがなぜか表示されていることが分かった
- 念のため、zshrcに記載したinit前後にて出力すると、この時点ではJAVA_HOMEは空
- zshrcの一番最後で出力すると表示された
- shell起動後にevalすると問題ない
- scala2.7, jdk1.7でのREPL起動となり、問題なく動く

### gvm
Javaっぽい設定なにかあるかなと思ったらGVM(Groovy enVironment Manager)の直後でJAVA_HOMEが再設定されていた

```
[[ -s "${HOME}/.gvm/bin/gvm-init.sh" ]] && source "${HOME}/.gvm/bin/gvm-init.sh"
```

- Twitterでgolangのツールと名前変わってたなーと思い出した(The Software Development Kit Manager)
- Groovyは今後バージョン切り替えするほど使わないと思う
- 後述するpluginでインストールするか、グローバルにインストールしてもよさそう

ということでアンインストールして設定を消すことにした。下記でインストールしたっぽいのでそのまま削除

curl -s get.gvmtool.net | bash

JAVA_HOME系で消耗するの他にもありそう…。


## plugin
プラグインがあるらしいのでとりあえず見てみたら、

```shell-session
jenv plugins

ant
export
golo
gradle
grails
groovy
lein
maven
sbt
scala
springboot
```

- Scalaもあるし、sbtもあった…
- その他build系ツールもたくさんあり、gradleあるならgroovyも
- さらにClojureのleinまである充実さ

```shell-session
jenv enable-plugin
Usage: jenv enable-plugin <pluginName>

Activate a jEnv plugin
```

pluginを使うのはあとで試してみる

### 試してみた
```bash
for p in `jenv plugins`; do jenv enable-plugin $p; done
ll ~/.jenv/plugins/*/etc/jenv.d/exec/*.bash
# $pluginName-before.bash というファイル
ll ~/.jenv/plugins/*/etc/jenv.d/rehash/*.bash
```

- pluginsとして実行ファイルがインストールされるわけではなさそう
- 各種コマンド名に対するHook用のShellで、OPTION関連のExport
- よって、他でインストールする必要がある

#### Pluginの最有効化
sbtを `brew install sbt` でインストールしたあとに、実行するとエラーになった

```shell-session
sbt

No java installations was detected.
Please go to http://www.java.com/getjava/ and download
# sbt実行時にJAVA_HOMEが反映されていない問題
```

- packageが古かった(0.4.2)ので、0.4.3にあげた　(https://github.com/gcuisinier/jenv/pull/89/files のコミット)
- 再実行してもエラーになった
- $pluginName-before.bash のコミットが反映されていないのでPluginを最有効化したらコミットが反映されていた(disable-plugin -> enable-plugin)
- sbtも実行できるようになった

## まとめ
- バージョン切り替えさほど必要ないにしたがっていればよかった
- 消耗良くない
- とはいえ、Javaの切り替えを使えるようになったのはとても良いと思う
