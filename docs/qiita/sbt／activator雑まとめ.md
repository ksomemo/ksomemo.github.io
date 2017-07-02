
## references
- http://www.scala-sbt.org/0.13/docs/index.html
- http://www.scala-sbt.org/0.13/docs/ja/index.html
- http://www.typesafe.com/activator/docs

## environment
- yosemite
- homebrew

## install sbt
```
brew install sbt
```

## help
```
sbt -h
```

## バッチモード
- サブコマンドではなかった
- Makeに似ている
- sbt clean compile "testOnly TestA TestB"
  - clean
  - compile
  - testOnly TestA TestB
- という順番に実行
- 最後は引数を指定している


よく使うコマンド
http://www.scala-sbt.org/0.13/docs/Command-Line-Reference.html

## 継続的ビルドとテスト
- コマンドの先頭に ~ をつける
- ~ compile

## ディレクトリ構造
```
target/
lib/
src/
  main/
    resource/
    scala/
    java/
  test/
    resource/
    scala/
    java/
build.sbt
project/
  target/
  build.properties
  project/
    ...
```

後述する activatorでテンプレートから作成できる

### target
build時に生成されるファイルの出力場所

- コンパイルされたクラスファイル
- パッケージ化された jar ファイル
- managed 配下のファイル/キャッシュとドキュメンテーション?

そのため無視しておく

```.gitignore
target/
```

### project/build.properties
- sbtのversion指定
- バイナリー互換を気にしないため
- ここ、スクリプト言語出身だとあんまりピンとこない

```build.properties
sbt.version=0.1x.x
```

### build.sbt

ビルド定義

- Setting[T] のリストを持った Project を定義
- Setting[T] は sbt が持つキーと値のペアの Map に作用する変換を表す
- Tは値の型である。

よくわからない

```scala:common_setting.scala
lazy val commonSettings = Seq(
  organization := "com.example",
  version := "0.1.0",
  scalaVersion := "2.11.4"
)

lazy val root = (project in file(".")).
  settings(commonSettings: _*).
  settings(
    name := "hello"
  )
// キーには := というメソッドがあり、
// このメソッドは Setting[T] を返す
```

### Key
- SettingKey[T]（設定系？）

その他、

- TaskKey[T] （副作用のあるサブコマンド系？）
- InputKey[T]
- もあるけど、気にしなくてよさそう

#### 組み込みのキー
Keys と呼ばれるオブジェクトのフィールド
build.sbt は、自動的に import sbt.Keys._ する

```auto_import_key.scala
import sbt._
import Process._
import Keys._
```

### library
http://www.scala-sbt.org/0.13/docs/ja/Library-Dependencies.html

lib/に.jarを入れてしまう方法があるけど、build.sbtに設定を書くほうがいいと思う

>
```scala
val derby = "org.apache.derby" % "derby" % "10.4.1.3"
settings(
  name := "hello",
  libraryDependencies += derby
)
libraryDependencies += groupID % artifactID % revision % configuration
val libraryDependencies = SettingKey[Seq[ModuleID]]("library-dependencies", "Declares managed dependencies.")
/*
% メソッドは、文字列から ModuleID オブジェクトを作るので、君はその ModuleID を libraryDependencies に追加するだけでいい。
もちろん ++= を使って依存ライブラリのリストを一度に追加することもできる
*/
```

### multi project
http://www.scala-sbt.org/0.13/docs/ja/Multi-Project.html

最初は気にしなくていいと思うけど、下記一番上がどう展開されるかは知っておくとよさそう

>
```scala
lazy val util = project
lazy val util = project.in(file("util"))
lazy val core = project in file("core")
```

### plugins
http://www.scala-sbt.org/0.13/docs/ja/Using-Plugins.html

- IDEのPluginを聞いたことがある
- ほかにも便利なのありそう

## activator
- sbtのSuperSet
- つまり、sbtの機能を全て持っていて追加機能がある

```
brew install typesafe-activator
```

### Sub-commands
```
activator ui
# activator -Dhttp.port=9999 -J-Xmx1g ui

Open the project in the UI if executed from an existing project
directory, otherwise open a project-creation UI.
```

```
activator new [project-name] [template-name]

Create a new project, prompting for project-name if missing and helping you
find a template if template-name is not provided.
```

```
activator list-templates

Fetch the latest template list and print it to the console.
```
