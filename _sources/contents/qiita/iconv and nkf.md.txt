
- nkfばっかりつかってたのでメモ
- guessできないっぽい
- のでnkfの方がいいと思ってnkfも調べてた

## iconv
```
iconv --version
iconv (GNU libiconv 1.11)
```

- `iconv --help`
- `man iconv`

iconv - character set conversion 

### code list
`iconv -l`

### example
```bash:iconv-exmaple.sh
echo 'text' | iconv -f from_encoding -t to_encoding
iconv -f e -t e from.txt > out.txt
```

### まだ使ってない
- Options controlling error output
- Options controlling conversion problems

## nkf
`nkf --version: Network Kanji Filter Version 2.1.3 (2013-11-22)`

help見てたらいろんな変換あったのでメモ

### 仮名 to カナ
エシディシに感謝

```bash:nkf-仮名-to-カナ.sh
echo "あァァァんまりだァァアァ" | nkf --katakana
アァァァンマリダァァアァ

echo "あァァァんまりだァァアァ" | nkf --katakana | nkf --hiragana
あぁぁぁんまりだぁぁあぁ

echo "あァァァんまりだァァアァ" | nkf --katakana-hiragana
アぁぁぁンマリダぁぁあぁ
```

### 半角 to 全角
```bash:nkf-han-to-zen.sh
echo "ﾊﾟﾊﾟｼﾞｼﾞ" | nkf -X
パパジジ
```

### Z option
>
```txt:z-option.txt
Z[0-4]   Default/0: Convert JISX0208 Alphabet to ASCII
          1: Kankaku to one space  2: to two spaces  3: HTML Entity
          4: JISX0208 Katakana to JISX0201 Katakana
```

```bash:nkf-z-exmaple.sh
echo "ａ" | nkf -Z0
a
# ａ -> 

echo "&<>'\"" | nkf -Z3
&amp;&lt;&gt;'&quot;

echo "ﾊﾟﾊﾟｼﾞｼﾞ" | nkf -Z4
パパジジ

echo "ﾊﾟﾊﾟｼﾞｼﾞ" | nkf -Z4 | nkf -Z4
ﾊﾟﾊﾟｼﾞｼﾞ
### 
```

### Z1/Z2(全角スペース to 半角スペース)
視認しづらい…

- Z1: to one space
- Z2: to two spaces
- Kankakuの定義とは？（TODO）

```bash:nkf-z1-z2-exmaple.sh
echo -n "" | wc -c
       0

# 全角
echo -n "　" | wc -c
       3

echo -n "　" | nkf -Z2 | wc -c
       2

echo -n "　" | nkf -Z2
  %
```

### おまけ
```bash:nkf-sjis-to-utf8.sh
find . -name "*.R" | xargs nkf -g
find . -name "*.R" | xargs nkf -w -S -Lu --in-place
```

### まとめ
- 便利なのと面倒なのがある
- プログラムとの使い分け
