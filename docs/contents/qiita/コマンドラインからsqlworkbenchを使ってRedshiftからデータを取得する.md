# コマンドラインからsqlworkbenchを使ってRedshiftからデータを取得する
## DBへのアクセス経路
local -> 踏み台サーバー -> Redshift

## いきなりまとめ
- port forwardを理解していなかった
- ので、sqlworkbenchをコマンドラインを使うべきだと思い込んでいた
- しかし使う必要はなかった

## 環境
- Windows 7 64bit
- Workbench-Build118
- teraterm

## 接続profileの作成
sqlworkbenchを開いて、Select Connection Profile画面で作成する

下記情報を入力し、Profile名を付けておく

- Driver(Driver File選択)
- URL
- Username
- Password


## Driver
http://docs.aws.amazon.com/ja_jp/redshift/latest/mgmt/configure-jdbc-connection.html#download-jdbc-driver を参考にして、Driverのダウンロードし、クラス名をメモしておく

今回は以下のようにした

- https://s3.amazonaws.com/redshift-downloads/drivers/RedshiftJDBC41-1.1.13.1013.jar
- com.amazon.redshift.jdbc41.Driver
- Workbenchのフォルダに上記Driverを格納する


## URL
- jdbc:redshift://エンドポイント:ポート/dbname
- 踏み台サーバーを経由」するので
- jdbc:redshift://127.0.0.1:local_port/dbname

本来のアクセス先（エンドポイント）の情報は、https://console.aws.amazon.com/redshift/ を参照

## port forward

### 鍵準備

- 公開鍵作成
- 踏み台サーバーに.ssh/authorized_keysとしてアップロード(600)
- 秘密鍵作成

### 踏み台サーバーに接続
teraterm のマクロで

```
踏み台host:port
    /ssh
    /auth=publickey
    /user=username
    /passwd=pass
    /keyfile=/path/to/秘密鍵
    /ssh-Llocalhost:local_port:endpoint:ep_port
```

- 踏み台サーバーに公開鍵認証
- localhost:localport にアクセスすると
- Redshiftにアクセスすることになる

### 参考
- http://blue-red.ddo.jp/~ao/wiki/wiki.cgi?page=SSH%A4%CB%A4%E8%A4%EB%A5%DD%A1%BC%A5%C8%A5%D5%A5%A9%A5%EF%A1%BC%A5%C7%A5%A3%A5%F3%A5%B0
- http://halyou.blog84.fc2.com/blog-entry-1004.html


### GUIとして便利なoption

- Remenber DbExplorer Schema
- Separate connection per tab

仕方なく Save passowrd


## SQL実行
`cd  "/path/to/Workbench-dir"`

```sql
-- WbExport -file=export.tsv -type=text -delimiter=\t -encoding=UTF8;
SELECT *
FROM table_name
```

without_profile.bat

```bat
java -jar sqlworkbench.jar
    -url=url
    -driver=class_name
    -username=user
    -password=pass
    -driverjar=/path/to/driver.jar
    -command
    -displayResult=true
    -showTiming=true
    -printStatements
    -script='/path/to/script.sql'
```

with_profile.bat

```bat
java -jar sqlworkbench.jar
    -profile='profile_name'
    -script='/path/to/script.sql'
```

## sqlworkbench manual
http://www.sql-workbench.net/manual/workbench-manual.html

### profile
- http://www.sql-workbench.net/manual/using-scripting.html
- http://www.sql-workbench.net/manual/commandline.html#commandline-connect-profile

### WbExport
- http://www.sql-workbench.net/manual/wb-commands.html
- http://www.sql-workbench.net/manual/command-export.html
- http://stackoverflow.com/questions/20643052/using-wbexport-and-wbinclude-commands-in-sql-workbench-batch-mode
