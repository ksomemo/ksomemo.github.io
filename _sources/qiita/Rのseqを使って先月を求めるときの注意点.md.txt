月末日を利用して先月を求めたときのメモ。

＜追記あり＞

下記のように計算されているので、月末ではなく月初を利用するようにした。

* 2015-03-31の先月は2015-03-03
* 2015-03-03 -> 2015-02-31

```r
x <- "2015-03-31"
print(seq(as.Date(x), len=12, by="-1 month"))

 [1] "2015-03-31" "2015-03-03" "2015-01-31" "2014-12-31" "2014-12-01" "2014-10-31"
 [7] "2014-10-01" "2014-08-31" "2014-07-31" "2014-07-01" "2014-05-31" "2014-05-01"

x <- "2015-03-01"
print(seq(as.Date(x), len=12, by="-1 month"))

 [1] "2015-03-01" "2015-02-01" "2015-01-01" "2014-12-01" "2014-11-01" "2014-10-01"
 [7] "2014-09-01" "2014-08-01" "2014-07-01" "2014-06-01" "2014-05-01" "2014-04-01"
```

## lubridate
 >https://twitter.com/kohske/status/583989166301511680
 >日付扱う時はlubridateが便利だと思う。何も考えず `ymd("2015-03-31") %m-%months(1:12)` で事足りる

と書かれていたので思いつくのものを試してみた。
結論は便利。ただし、Timezoneだけめんどう。

### sample
```r
install.packages("lubridate")
library(lubridate)

ymd("2015-03-31") %m-% months(1:12)
#  [1] "2015-02-28 UTC" "2015-01-31 UTC" "2014-12-31 UTC" "2014-11-30 UTC" "2014-10-31 UTC"
#  [6] "2014-09-30 UTC" "2014-08-31 UTC" "2014-07-31 UTC" "2014-06-30 UTC" "2014-05-31 UTC"
# [11] "2014-04-30 UTC" "2014-03-31 UTC"
```

### ymd
```r
ymd("2015-03-31")
#[1] "2015-03-31 UTC"

class(ymd("2015-03-31"))
#[1] "POSIXct" "POSIXt" 

?ymd
#ymd(..., quiet = FALSE, tz = "UTC",
#    locale = Sys.getlocale("LC_TIME"), truncated = 0)
```

### months
```r
months(1)
#[1] "1m 0d 0H 0M 0S"
?months
# {base} 

class(months(1))
#[1] "Period"
#attr(,"package")
#[1] "lubridate"

# classを見て疑問に思ったので
# libraryする前を試してみると
months(1)
# 以下にエラー UseMethod("months") :
#   'months' をクラス "c('double', 'numeric')" のオブジェクトに適用できるようなメソッドがありません
```

### Date and POSIXct
```r
class(as.Date("2015-03-31"))
#[1] "Date"

as.POSIXct(as.Date("2015-03-31"))
#[1] "2015-03-31 09:00:00 JST"
```

### tz
```r
ymd("2015-03-31", tz = "JST")
#[1] "2015-03-31 GMT"
# 警告メッセージ: 
#1: In as.POSIXct.POSIXlt(lt) : unknown timezone 'JST'
#2: In as.POSIXlt.POSIXct(ct) : unknown timezone 'JST'
#3: In as.POSIXct.POSIXlt(t) : unknown timezone 'JST'
#4: In as.POSIXlt.POSIXct(ct) : unknown timezone 'JST'
#5: In as.POSIXlt.POSIXct(x, tz) : unknown timezone 'JST'

ymd("2015-03-31", tz = "Asia/Tokyo")
#[1] "2015-03-31 JST"
```

### years
```r
years(1:12)
# [1] "1y 0m 0d 0H 0M 0S"  "2y 0m 0d 0H 0M 0S"  "3y 0m 0d 0H 0M 0S"  "4y 0m 0d 0H 0M 0S" 
# [5] "5y 0m 0d 0H 0M 0S"  "6y 0m 0d 0H 0M 0S"  "7y 0m 0d 0H 0M 0S"  "8y 0m 0d 0H 0M 0S" 
# [9] "9y 0m 0d 0H 0M 0S"  "10y 0m 0d 0H 0M 0S" "11y 0m 0d 0H 0M 0S" "12y 0m 0d 0H 0M 0S"

ymd("2015-03-31") %y-% years(1:12)
# エラー:  関数 "%y-%" を見つけることができませんでした 
ymd("2015-03-31") %Y-% years(1:12)
# エラー:  関数 "%Y-%" を見つけることができませんでした 
ymd("2015-03-31") %d-% years(1:12)
# エラー:  関数 "%d-%" を見つけることができませんでした 

ymd("2015-03-31") %m-% years(1:12)
# [1] "2014-03-31 UTC" "2013-03-31 UTC" "2012-03-31 UTC" "2011-03-31 UTC" "2010-03-31 UTC"
# [6] "2009-03-31 UTC" "2008-03-31 UTC" "2007-03-31 UTC" "2006-03-31 UTC" "2005-03-31 UTC"
#[11] "2004-03-31 UTC" "2003-03-31 UTC"
```
