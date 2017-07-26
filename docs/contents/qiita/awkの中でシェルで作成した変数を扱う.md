# awkの中でシェルで作成した変数を扱う
## いきなりだけど結論

* awkでの`$xxx`はフィールドとして扱われる
* `$変数`をawk内で使うと存在しないフィールドなのでエラーとなる
* `$変数`をシングルクォーテーションで変数くくると、フィールドとして扱われなくなる
* シェル変数として展開される

または, vオプションを使ってフィールドを追加する。こちらのほうが意図が伝わってよい。

## 例

```bash
#!/bin/sh
var=123456
echo "1,2,3" | awk -F,               '{print $1 "," '$1'}'
echo "1,2,3" | awk -F,               '{print $1 "," "$1"}'
echo "1,2,3" | awk -F,               '{print $1 "," '$var'}'
echo "1,2,3" | awk -F,               '{print $1 "," "'$var'"}'
echo "1,2,3" | awk -F, -v var="$var" '{print $1 "," $var}'
echo "1,2,3" | awk -F, -v var="$var" '{print $1 "," var}'
echo "1,2,3" | awk -F,               '{print $1 "," $var}'
```

```bash
test.sh 111

1,111
1,$1
1,123456
1,123456
1,
1,123456
awk: illegal field $(), name "var"
 input record number 1, file
 source line number 1
```

## 実用例
* 日付がファイル名に含まれるTSVを使う
* 一部の列を使ってフォーマットをCSVにする
* 最後の列に日付を追加する

## Code

```bash
#!/bin/sh

TOTAL_FILE="total.csv"
FILE_NAME_LEN=$(expr length "$TOTAL_FILE")
echo "${TOTAL_FILE}(file name length: ${FILE_NAME_LEN})"

echo -n "" > $TOTAL_FILE
for f in $(ls *.tsv); do
	date=${f:20:4}/${f:24:2}/${f:26:2}
	awk '{ print $1 "," "'$date'"}' $f > "with_date_${f}.csv"
	cat "with_date_${f}.csv" >> $TOTAL_FILE
done
```
