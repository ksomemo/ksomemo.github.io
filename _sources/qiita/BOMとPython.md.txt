
## 動機
あるファイルをMac OS Xで扱っていたらおかしかったので調べた

## 詳細
- seabornでplotしたときに下記エラーが発生した
- matplotlibのときは付いたままでも問題なかった

```
ValueError: could not convert string to float: '\ufeff2013-11-18'
```

## \ufeff
- BOM BEでした
- Mac で遭遇したの初めてで確認方法がわからなかったので調べた
- Windowsではsakura editorで別のEncodingに変換してた

## 確認
```
file *.csv
data.csv:   DBase 3 data file with memo(s)
sample.csv: ASCII text
test.csv:   UTF-8 Unicode (with BOM) text
train.csv:  UTF-8 Unicode (with BOM) text
```

## Pythonにおける扱い
下記参照

- http://docs.python.jp/3.5/library/codecs.html#codecs.BOM
- http://docs.python.jp/3.5/library/codecs.html#standard-encodings
    - 表いちばん下
- http://docs.python.jp/3.5/library/codecs.html#module-encodings.utf_8_sig

## 削除せずに読み込む
Pythonにおける扱いのutf_8_sigをencoding指定する

## 削除してしまう
- awk, sed, nkf等で処理する
- 定数として存在するので利用する

```py3:codecs_BOM_BE.py
import codecs
print(codecs.BOM_BE) # => b'\xfe\xff'
```







