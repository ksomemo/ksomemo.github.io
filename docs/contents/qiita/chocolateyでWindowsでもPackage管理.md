# chocolateyでWindowsでもPackage管理

## chocolatey
Windows用ソフトウェアのパッケージ管理ツール

## chocolateyのインストール
chocolatey_install.bat

```bat
@echo off
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

pause
```

## command
```
choco --help
```

## パッケージ（Windowsソフトウェア）のインストール
### インストールできる一覧
```
choco list
clist atom
```

ただし、めちゃくちゃ時間かかるのでlistのあとにパッケージ名を指定したほうがよい

```
choco install curl
cinst winmerge
cinst atom --version 1.0.7
```

必要であれば管理者としてインストールする

### パッケージ一覧を指定してインストール
後述の設定ファイルからもインストールするパッケージを指定できる

`cinst packages.config`

## 設定ファイル
packages.configというXMLの設定ファイル

packages_sample.config

```xml
<?xml version="1.0"?>
<packages>
    <package id="curl" />
    <package id="wget" />
</packages>
```

idはパッケージ名

## インストール済みのパッケージ一覧
```
clist -l
```

lはLocalOnlyの略です

## GUI

### インストール
```
cinst ChocolateyGUI
```

- GUIがあるらしく、下記でインストールしようとしたらできなかった。
- しかし、再起動後にコマンドプロンプトを管理者として実行後に再度実行したらインストールできた
- 結論、後述するがあまり使わないと思う

### 実行
スタートメニューから実行できる。

### インストール済みパッケージ一覧
左のThisPCを選択すると、一覧が表示される。

- パッケージ名をダブルクリックすると、詳細画面が表示される
- 右下に再インストールとアンインストールボタンがある

### インストール可能パッケージの検索
左のChocolateyを選択すると、インストール可能パッケージ一覧が表示される。

- Searchの隣にあるテキストボックスにキーワードを入力すると、そのパッケージに限定される
- All Versions, Include Prereleaseチェックボックスにチェックを入れると表示されるバージョンが増える
- NAME,VERSION,VERSION DOWNLOADSのバーをクリックすると、ソート可能

### インストール
試しにMySQL(CommunityServer)5.6.26をインストールしてみた。

Dependenciesに 7zip.commandlineが表示されていたが、右下にインストールボタンがあったのクリックしてみたが、成功・失敗についての情報がわからないのでPowerShellなどから実行したほうが良いと思った

### インストール済みパッケージ一覧のExport
ThisPCを選択し、右上のExportからExportできる。

しかも、`clist -l`で表示した時と違ってXMLとして出力される。

packages_export.config

```xml
<?xml version="1.0" encoding="utf-8"?>
<packages>
  <package id="Atom" version="1.0.7" />
  <package id="ChocolateyGUI" version="0.13.1" />
  <package id="curl" version="7.28.1" />
  <package id="PowerShell" version="4.0.20141001" />
  <package id="winmerge" version="2.14.0" />
</packages>
```

## まとめ
- chocolatey便利
- GUIはinstallには使わないほうがよさそう
- package.configをExportしてバージョン管理
