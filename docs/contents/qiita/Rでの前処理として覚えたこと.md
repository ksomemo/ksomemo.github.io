
dataframeを以下、dfとする。

## の前に、他との比較
* plyrのほうが簡単だけど、下記のdplyrのほうを先に触ってしまった
* dplyrというRのパッケージが一番直感的かつ簡潔に書ける
	* pipeによるデータの扱いとSQL likeな関数による覚えやすさがのため
* PandasというPythonのパッケージでもR標準のdfと同じように書ける
	* ただし、列や行のアクセスに違いあり、かつdplyrのほうが便利
	* 便利だけど、Pythonの方が前処理メインなのでPythonでやってる
	* pandas16にもpipeが出てきたので要チェック

## 覚えたこと

* dfの作り方(行列、ベクトルから)
* 行の連結(df同士、dfとベクトル)
* 列の追加
	* 列への関数適用
	* 忘れやすそうな否定とべき乗
	* cbindでの行列作成とdfとの結合
	* transformによる結合
		* and/orの方法
* dfを列で結合(Left Join)
* 欠損値の埋め方
	* 対象列の判定
	* ifelse
* 行のシフト
	* 時系列での扱いのため
	* 例：セッションログを用いて滞在時間を測るなど
* ファイルへの書き込みと、そのファイルの読み込む

```r
# make dataframe from vector
df <- data.frame(matrix(1:8, ncol = 2), stringsAsFactors = False)
df2 <- data.frame(1:2, stringsAsFactors = False)

# concat row
df <- rbind(df, df)
df2 <- rbind(df2, c(3))

# define function
odd <- function(n) return(n %% 2 == 1)

# add column
df$odd <- sapply(X = df[, "X1"], odd)
df$even <- !(df$odd)
df <- cbind(df, cbind(and = (df$odd & df$even),
                      or = (df$odd | df$even)))

df2$square <- df2[, 1] ^ 2
df2 <- transform(df2, 
                 up.to.low = tolower(LETTERS[1:3]), 
                 low.to.up = toupper(letters[-1:-23]))

# merge, left join
merged <- merge(x = df, y = df2, by.x = c(1), by.y = c(1), all.x = TRUE)

# fill na
merged$fill1 <- merged$square
merged[is.na(merged$fill1), "fill1"] <- 0
merged$fill2 <- ifelse(is.na(merged$square), 0, merged$square)

# shift column
shift <- function(x, n) {
  if (n < 0) {
    return(c(rep(NA, abs(n)), head(x, n)))
  } else if (n > 0) {
    return(c(tail(x, -n), rep(NA, abs(n))))
  } else {
    return(x)
  }
}
merged$shift.up <- shift(merged$X1, 1)
merged$shift.down <- shift(merged$X1, -1)

# write to file and read from file
write.table(merged, "output_dataframe.txt", append=F, quote=F, col.names=T)
result <- read.table(file = "output_dataframe.txt", header = TRUE)

print(result)
```

```
library(plyr)

# grouping
jobs <- data.frame(id=1:12,
                   field=c(rep("web", 6), rep("sports", 6)),
                   category=c(rep("infra", 2), rep("frontend", 4),
                              rep("soccer", 3), rep("tennis", 2), "baseball"))
jobs.counts <- ddply(jobs, .(field, category), summarize, counts = length(id))

# full outer join
hobby.soccer <- data.frame(id=1:10, rep(1, 10))
hobby.tennis <- data.frame(id=6:15, rep(1, 10))
hobby.all <- merge(hobby.soccer, hobby.tennis, by="id", all = TRUE)

# String concatenation
c(paste("a", "b", sep = ""), paste0("a", "b"))

# run as Script
# R --vanilla --slave < script.R
# RScript --vanilla --slave script.R

# first arg is args[1]
args <- commandArgs(trailingOnly = T)
# arg[5] is first arg from cli
args <- commandArgs()

# padding
sprintf("%03s", "a")
sprintf("%3s", "a")
sprintf("%-3s", "a")
```

## 感想
* 前処理は無理にRでやらなくてよさそうだと思った（PythonのPandasを触ったことがあるため
* 次は分析系Packageとコマンドライン引数の扱いを覚えたい
