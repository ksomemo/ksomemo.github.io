
## 今までのワンライナー

* (仕方なく使っている)Windowsで気軽にテキスト処理したい
* PowerShellはよくわからない
* Gitをインストールした時についてくるGit Bash(+awk, sed, たまにperl)で頑張っていた

## なぜRubyなのか

* １つの言語で済ませたいなと思って調べているとRubyでできるっぽい
* Perlを必死に覚えればいいけど、今更感ある
* Pythonのほうがよく使うけど、ワンライナーとlambdaが貧弱かつPython2と3の違いを意識したくなかった

## Hello Ruby Oneliner 
```bash:ruby_oneliner.sh
ruby -e 'puts "Hello Ruby Oneliner"'
```

## 複数行
```bash:ruby_oneliner_ex.sh
# 省略形がどのように推移しているかまとめた
seq 1 3 | ruby -e 'while gets; puts $_; end'
seq 1 3 | ruby -ne 'puts $_'
seq 1 3 | ruby -ne 'print'
seq 1 3 | ruby -npe ''
1
2
3
```

## 出力の評価タイミング
```bash:ruby_oneliner_ex2.sh
# コマンド実行後に出力される
seq 1 3 | ruby -pne 'print "-"'
-1
-2
-3
```

## 型の確認
```bash:ruby_oneliner_ex3.sh
# pで確認すると末尾の改行が残っている
seq 1 3 | ruby -ne 'p $_'
"1\n"
"2\n"
"3\n"
```

## 末尾の改行をとる
```bash:ruby_oneliner_ex4.sh
# l オプションによって改行が除かれる
seq 1 3 | ruby -nle 'p $_'
"1"
"2"
"3"
```

```bash:ruby_oneliner_ex5.sh
# オプションをつけると特殊な変数の内容が変わるらしい
echo "" | ruby -ne 'p $/; p $\'
"\n"
nil

echo "" | ruby -nle 'p $/; p $\'
"\n"
"\n"
```

## awkの代わり
```bash:ruby_oneliner_ex6.sh
echo "1 2 3" | ruby -ane 'p $F'
["1", "2", "3"]

echo "1,2,3" | ruby -ane 'p $F'
["1,2,3"]

echo "1,2,3" | ruby -F, -ane 'p $F'
["1", "2", "3\n"]
```

## 区切り文字
```bash:ruby_oneliner_ex7.sh
echo "" | ruby -ae 'p $;'
nil

# 区切り文字は正規表現扱い
echo "" | ruby -F.  -ae 'p $;'
echo "" | ruby -F\. -ae 'p $;'
/./

echo "" | ruby -F\\.  -ae 'p $;'
echo "" | ruby -F'\.' -ae 'p $;'
/\./
```

## 正規表現区切り
```bash:ruby_oneliner_ex8.sh
# テスト用
seq -w 0 .05 .1
0.00
0.05
0.10
```

```bash:ruby_oneliner_ex9.sh
seq -w 0 .05 .1 | ruby -F'\.' -anle 'p $F'
["0", "00"]
["0", "05"]
["0", "10"]
```

## 分割した値にアクセス
```bash:ruby_oneliner_ex10.sh
seq -w 0 .05 .1 | ruby -F'\.' -anle 'p $F[1]'
"00"
"05"
"10"
```

## 行へのアクセス
```bash:ruby_oneliner_ex11.sh
# sedの代わりなら、gsub
seq -w 0 .05 .1 | ruby -nle 'p $_.to_f'
0.0
0.05
0.1
```

## 他の機能
* ファイル指定をしてワンライナー実行
* awkのようにBEGIN, ENDを使ったsummaryの作成
* sedのようにiオプションでバックアップファイルの作成

## まとめ
* Rubyだけでいろいろできる
* Rubyで書いておくとShellだけで突っ走らずにスクリプトにするようにしそうな気がした
