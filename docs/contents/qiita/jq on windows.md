## いまさら試してみた on Windows
```0.md
## いまさら試してみた on Windows
https://stedolan.github.io/jq/ から jq-win64.exe をDownload
```

## ヘルプが表示された後フォントが変わる
```1.md
## ヘルプが表示された後フォントが変わる
jq-win64 --help

chcp 932

プロンプトのプロパティを見るとutf8に変わってる(65001)

dirが使えなくなった

copy jq-win64.exe jq.exeはできた
```

## 使ったオプション
```2.md
## 使ったオプション
jq --help > jq_help.log 2>&1
type jq_help.log
jq - commandline JSON processor [version 1.5]
Usage: jq [options] <jq filter> [file...]

	...

	Some of the options include:
	...
	 -R		read raw strings, not JSON texts;
	 -C		colorize JSON;
	...
	See the manpage for more options.
```

## 使ってみた
```3.md
## 使ってみた

### raw string
jq -R {\"a\":1,\"b\":2}

入力にスペースを入れず"をescapeすれば動くけど、C-c押さないと出力しっぱなし

### pipe
echo {"a": 1, "b": 2} | jq

スペースが入っても普通に動く

### colorize
echo {"a": 1, "b": 2} | jq -C

動くけど、カラーコードが出力されるだけ

### from file
- {\"a\":1,\"b\":2}
- {}
- \"{}\"

jq jq_file.json

どの行のパターンのファイルもうまく動かない

## まとめ
Windowsではつらい諦めよう
```
