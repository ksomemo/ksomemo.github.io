# shell tips
## heredoc中でescape
```bash
# 単純に実行結果をredirectしてるのでescapeする必要がある
cat <<EOF > escape_heredoc.sh
echo \`whoami\` home is \$HOME
EOF

cat escape_heredoc.sh
echo `whoami` home is $HOME
```

## 一時的に環境変数を変更
```bash
echo $LANG         # ja_JP.UTF-8
       date        # 土  3 25 16:20:03 JST 2017
LANG=C date        # Sat Mar 25 16:20:18 JST 2017
echo $LANG         # ja_JP.UTF-8

LANG=C echo $LANG  # ja_JP.UTF-8 ?? builtin ??
echo 'echo $LANG' > test.sh && chmod +x test.sh

       ./test.sh   # ja_JP.UTF-8
LANG=C ./test.sh   # C
```

## gzip sample
```bash
gzip -V
gzip 1.6

gzip -dk data.gz # data
gzip -dc data.gz > data.tsv

gzip -k data.tsv # data.tsv.gz
gzip -c data.tsv > data.gz

gzip -l data.gz
       compressed        uncompressed  ratio uncompressed_name
          2250139            14046126  84.0% data
```

## oneliner: get-pip and install
```bash
# http://stackoverflow.com/questions/11369964/run-a-python-script-from-url-in-terminal

echo "import sys;print sys.version" | python
2.7.11+ (default, Apr 17 2016, 14:00:29)
[GCC 5.3.1 20160413]

# つまり下記で良い
wget -q -O- https://bootstrap.pypa.io/get-pip.py | python

# python でpip install, replから抜けたくない時などに
python -c "import pip; pip.main(['install', 'joblib'])"
```

## 日付時刻指定してファイル作成
```bash
# ファイル作成と、作成済みファイルの日時変更は覚えていたので、調べてみた

touch
usage:
touch [-A [-][[hh]mm]SS] [-acfhm] [-r file] [-t [[CC]YY]MMDDhhmm[.SS]] file ...

man touch

touch f1
touch -t "200012090123.45" f2
touch -t "202001010123.45" f3
```

## あるファイルより新しい時刻のファイルの検索
```bash
# 日付時刻指定してファイル作成で分かりやすくファイルを作成した後に
find . -newer f1
./f3
```

## wget with header
```bash
# and basic authorization
wget http://localhost:8080 \
    --header='field: value' \
    --header='field2: value2' \
    '--http-user=id' '--http-password=pass'
```

## curl basic auth
```bash
curl --user id:pass \
     -X POST \
     -d name=value
     "http://localhost:8080/"
```

## bash の dollar と mkdir and cd
```bash
# https://www.gnu.org/software/bash/manual/html_node/Variable-Index.html

mkdir -p foo/bar && cd $_
# 直近のパラメータになるのでちょうどいい
```

## 普段awkしか使わないのでcut のメモ
```bash
echo "1  2  3" | cut -d" " -f1,2,5
1  3
# delimiterの連続は考慮しない

echo "1  2  3" | awk       '{print $1 $2 $5}'
12
echo "1  2  3" | awk -F' ' '{print $1 $2 $5}'
12
```

## bashで桁の大きい数値文字列の作成
```bash
# 今回は20桁
# 10^18になるとオーバーフロー
# seqだけでも0埋め可能

DIGIT_18=$((10 ** 17))
FORMAT='No.%s\n'
for i in $(seq -w 1 1 30)
do
  num=${DIGIT_18}$i
  printf "${FORMAT}" $num
done
```

## expectを使った自動パスワード入力でのssh接続
```bash
#!/usr/bin/expect

set timeout 5
spawn ssh [lindex $argv 0]
expect "password:"
send "password\n"
send exit\n
interact
```

```bash
#!/bin/sh

expect -c "
 set timeout 5
 spawn ssh [lindex $argv 0]
 expect "password:"
 send "password\n"
 send exit\n
 interact
```

## 他記事のリンク
### [iconv and nkf](http://qiita.com/ksomemo/items/3faace1a175e20cf63dd)

### [改行の変換](http://qiita.com/ksomemo/items/ec50044912447636b3ce)

### [シェルでの変数に対する操作](http://qiita.com/ksomemo/items/9e5c354944bb6e1cf799)

### [awkの中でシェルで作成した変数を扱う](http://qiita.com/ksomemo/items/2e7389db84f8b416ad9f)

### [ファイルをN行に分割する](http://qiita.com/ksomemo/items/ab498ad8d6d25728db43)
