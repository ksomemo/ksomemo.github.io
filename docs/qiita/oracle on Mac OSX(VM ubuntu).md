## 概要
Mac OSXのGuest OSでOracle XEを準備して, Host OSから扱えるようにする

## Oracle database
- アカウントが必要なので無い場合は作成
- http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html から Oracle Database Express Edition 11g Release 2 for Linux x64 をダウンロード
- 今回は http://download.oracle.com/otn/linux/oracle11g/xe/oracle-xe-11.2.0-1.0.x86_64.rpm.zip を利用

## Vagrant
- Oracle VM等のvirtual machineをコマンドラインから操作できる＋α
- 手作業による動作ミスを防ぐために利用する
- 今回はOracle Virtual Box を利用するのでinstallしていなければinstall

### Download
https://www.vagrantup.com/downloads.html

### VagrantFile
- Vagrant用の設定ファイル
- 共有フォルダの指定やOSのリソース設定を記載して反映できる

Mac OSX上のubuntu VMにOracleをinstallするVagratFileを提供しているrepositoryがあるので、それを利用する

- https://github.com/hilverd/vagrant-ubuntu-oracle-xe
- gitが必要なのでinstallしておくこと(なくてもいけるけど、今後のためにinstall)

## VMの準備
```bash:prepare_vm.sh
# 作業フォルダ名は自由に
mkdir -p /path/to/vagrant-oracle-xe-11-vm && cd $_

git clone git@github.com:hilverd/vagrant-ubuntu-oracle-xe.git
cd vagrant-ubuntu-oracle-xe

# VagrantFileの修正
vim VagrantFile
# timezone, flyway部分不要のため削除やコメントアウト
# sed -e '32d' -e '54d' VagrantFile

# downloadしておいたoracle fileを移動
mv ~/Downloads/oracle-xe-11.2.0-1.0.x86_64.rpm.zip modules/oracle/files/

# virtual box のguest addition用plugin
vagrant plugin install vagrant-vbguest

vagrant up
# mountできなくてError
# Virtualbox Guest Additionsをinstallできているが
# Install時では反映されない?のでreloadで対処
vagrant reload
```

## Oracle Instant Client Package 
http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html からダウンロード

今回は、Version 11.2.0.4.0 (64-bit)

- instantclient-basic-macos.x64-11.2.0.4.0.zip (62,794,903 bytes)
  -	Instant Client Package - Basic: All files required to run OCI, OCCI, and JDBC-OCI applications 
- instantclient-sqlplus-macos.x64-11.2.0.4.0.zip (884,608 bytes)
  - SQL*Plus: Additional libraries and executable for running SQL*Plus with Instant Client
- instantclient-sdk-macos.x64-11.2.0.4.0.zip (651,903 bytes)  
  - SDK: Additional header files and an example makefile for developing Oracle applications with Instant Client


### SQLPlusの準備
- マニュアルどおりにやったけどうまくいかなかったので、下記を参考にした
- あるディレクトリだけで完結するので環境汚染にならない

https://blog.caseylucas.com/2013/03/03/oracle-sqlplus-and-instant-client-on-mac-osx-without-dyld_library_path/

```bash:prepare_sqlplus.sh
cd ..
mv ~/Downloads/instantclient-*.zip .
# DLファイルの@を消してあげる
sudo xattr -c *
unzip instantclient-basic-macos.x64-11.2.0.4.0.zip
unzip instantclient-sqlplus-macos.x64-11.2.0.4.0.zip
cd instantclient_11_2

cat <<EOF > changeOracleLibs.sh
#!/bin/sh
# script to change the dynamic lib paths and ids for oracle instant client
# exes and libs

# proces all the executable files in this directory
find . -maxdepth 1 -type f \( -perm -1 -o \( -perm -10 -o -perm -100 \) \) -print | while read exe
do
    echo adjusting executable $exe
    baseexe=\`basename \$exe\`
    otool -L $exe | awk '/oracle/ {print $1}' | while read lib
    do
        echo adjusting lib $lib
        baselib=\`basename \$lib\`
        if [ "$baseexe" = "$baselib" ]
        then
            echo changing id to $baselib for $exe
            install_name_tool -id $baselib $exe
        else
            echo changing path id for $lib in $exe
            install_name_tool -change $lib @executable_path/$baselib $exe
        fi
    done
done
EOF
chmod +x changeOracleLibs.sh
sudo changeOracleLibs.sh
# 必要あればPATH通してexportしておく
# export PATH=`pwd`:$PATH

# READMEどおり、 下記で接続可能だったが、あまりにも使いにくい…
sqlplus system/manager@//localhost:1521/XE
```

## GUI(SQL Developer)
- http://www.oracle.com/technetwork/jp/developer-tools/sql-developer/downloads/index.html
- 接続から、system/manager, サービス:XEで接続可能
- Editor, schema, table, Export等可能

## まとめ
- VM上のLinuxでoracle用意
- Vagrantでport forward設定
- 用意してあるVagrantFileで楽をした
    - 中でPuppet使ってるのでいつか使えなくなるかもしれない
    - 本来はservice設定等を自力で行う
- SQL Developer便利
    - sqlplusいらなかったかもしれない
    - と思ったが、sqlldrというImport用utilityを使えない
        - GUIからではInsertになり、とても遅い
        - 共有フォルダにファイルを用意し、`vagrant ssh` からでも可能？
