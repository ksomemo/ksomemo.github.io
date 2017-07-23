## packages
```R:packages.R
# data processing
install.packages("tidyverse")
install.packages("data.table")

# date
install.packages("lubridate")

# visualization
install.packages("psych")
install.packages("scales")
install.packages("GGally") # http://www.ggplot2-exts.org/gallery/

# dev
install.packages("devtools")
install.packages("testthat")
install.packages("roxygen2")

# machine learning
install.packages("caret")
#install.packages("ranger")
install.packages("randomForest")
install.packages("xgboost")

# recommendation
install.packages("arules")
install.packages("arulesViz")

# stats modeling
install.packages("glmnet")

# time series
install.packages("xts")
install.packages("forecast")
install.packages("zoo")

# web app
install.packages("shiny")

# reporting
install.packages("rmarkdown")
install.packages("formatR") # R notebook

# bayse
install.packages("rstan")
#install.packages("dlm")

install.packages("")
```

## Paste from Clip Board
```R:pasteFromClipBoard.R
# win/Linux?
data <- read.table("clipboard")

# mac
data <- read.table(pipe("pbpaste"))
```

## basic functions
```r:basic_func.R
# rangeではない(python脳, range -> output min/max
seq(1, 9) # 1 to 9
seq(1, 9, by = 0.1) # step
seq(1, 9, length.out = 5) # n = 5

# log
log(2, base = exp(1))

# shuffle/sampling
sample(1:5)
sample(1:5, 3)
sample(1:5, 10, replace=TRUE)

# zero matrix
matrix(0, nrow=2, ncol=2)

# identity matrix
diag(nrow=2)
```
## repeat / replicate
```R:repeat_replicate.R
rep(1:3, 2)
[1] 1 2 3 1 2 3

# byrowにしたいときはt() で転置
replicate(2, 1:3)
     [,1] [,2]
[1,]    1    1
[2,]    2    2
[3,]    3    3
```

## sub(tract) vector from matrix
```sub_vector_from_matrix.R
(mat <- matrix(1:6, ncol=2))
     [,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6

# MARGIN: 1 -> row, 2 -> col
sweep(mat, 2, mat[1, ])
     [,1] [,2]
[1,]    0    0
[2,]    1    1
[3,]    2    2

# matrixではなくdataframeの場合、data.matrixで変換してから対応する
# matrixにしてもカラムは消えない
```

## apply系
```R:apply.R
# MARGIN = c(1,2) のとき成分ごとに適用
# sumはnumpyと同じで1つのスカラーに集約してしまうので、applyが必要
apply(df, MARGIN, sum)
```

## dot/outer product
```R:dot_outer_product.R
1:3 %*% 1:3
     [,1]
[1,]   14

1:3 %o% 1:3
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    2    4    6
[3,]    3    6    9
```

## list
```R:list.R
# append
l <- list()
l <- c(l, list(1))
l <- c(l, list(2), list(3))
```

## dummy
```dummies.R
install.packages("dummies")
library(dummies)
a <- 1:5
df <- data.frame(a=a)

dummies::dummy(a)
dummies::dummy("a", df)
```

## duplicated / drop duplicated
```duplicated_distinct_unique.R
df <- data.frame(d1=c(1,1,2,3,3,4,5,6,6),
                 d2=c(1,1,2,3,3,4,5,5,6))
df$df_duplicated          <- duplicated(df[, c("d1", "d2")])
df$d1_duplicated          <- duplicated(df$d1)
df$d1_duplicated_fromlast <- duplicated(df$d1, fromLast = T)
df$d1_duplicated_all      <- duplicated(df$d1) | duplicated(df$d1, fromLast = T)
# => https://stackoverflow.com/questions/7854433/finding-all-duplicate-rows-including-elements-with-smaller-subscripts

# drop duplicated
unique(df$d1)
df %>% select(d1, d2) %>% distinct()

# drop duplicated/base d1 and drop d2
# drop duplicated/base d1 and keep d2
df %>% select(d1, d2) %>% distinct(d1)
df %>% select(d1, d2) %>% distinct(d1, .keep_all = T)
```

## 標準化
```scale.R
scale(iris[, -5]) == scale(iris[, -5], center = T, scale = T)
# center, scaleは標準化でなくてもよい
# 上記2つに数値を渡すこともできるので、min-max scaleもできる
```

## PCA
```pca.R
# デフォルトの変換対象は分散共分散行列(center = T, scale = F)
iris_pca <- prcomp(iris[, -5])

# 固有分解
iris_cov_eigen <- eigen(cov(iris[, -5]))
## 固有ベクトル
iris_pca$rotation == iris_cov_eigen$vectors
## 固有値
iris_pca$sdev ^ 2 == iris_cov_eigen$values

# 変換後データ と 元の行列
iris_pca$x
scale(iris[, -5], scale = F) == (iris_pca$x %*% t(iris_pca$rotation))

# 寄与率
iris_pca_summary <- summary(iris_pca)
iris_pca_summary
```

## docallによるlist展開
```docall.R
# cbindにベクトルを渡す
do.call(cbind, list(1:2, 3:4, 5:6))
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6

## 引数が足りない場合
myfunc <- function(a, b, c, bias1, bias2 = 2) {
  return(sum(a, b, c) + bias1 + bias2)
}
do.call(myfunc, list(1:2, 3:4, bias1 = 1))
 (function (a, b, c, bias1, bias2 = 2)  でエラー: 
   引数 "c" がありませんし、省略時既定値もありません 

## デフォルト引数
do.call(myfunc, list(1:2, 3:4, 5:6, bias1 = 1))
[1] 24

## 可変長引数関数
variadic_func <- function(..., bias1, bias2 = 2) {
  return(sum(...) + bias1 + bias2)
}
do.call(variadic_func, list(1:2, 3:4, bias1 = 1))
[1] 13
do.call(variadic_func, list(1, 2, 3, 4, 5, bias1 = 1))
[1] 18
```

## ggplot
```ggplot.R
library(ggplot2)
library(gridExtra)

# 複数グラフ
plots <- list()
plots[[1]] <- ggplot2::ggplot() +
  geom_point(aes(x, y1), data = df)
plots[[2]] <- ggplot2::ggplot() +
  geom_point(aes(x, y2), data = df)

gridExtra::marrangeGrob(plots, nrow=1, ncol=2)
# or
do.call(gridExtra::grid.arrange, c(plots, nrow=1, ncol=2))

# violin
geom_violin

# for pca
install.packages("ggbiplot")
library(ggbiplot)
```

## time series
```time_series.R
data("AirPassengers")
class(AirPassengers)
# => [1] "ts"
tsp(AirPassengers)
# => start end frequency

# plot
plot(AirPassengers)
decomposed <-decompose(AirPassengers)
plot(decomposed)
# observed, trend, seasonal, random

## 変化率 log近似とdefault
plot(diff(log(AirPassengers)))
plot(diff(AirPassengers) / AirPassengers)

## (偏)自己相関
acf(AirPassengers)
pacf(AirPassengers)

# TODO
```

## Rで共分散と相関係数を求める(自作と {stats})
```r:Rで共分散と相関係数を求める.R
## 数式をプログラムに落とし込む練習
# Σとか行列・ベクトルを見ても怖がらないように
# 落ち着けば問題なさそう
# 作っているうちにイメージしやすくなった
# forがダサく見える…
# もっといい方法があったら知りたい

v1 <- 1:9
v2 <- sample(v1)
m <- matrix(sample(v2), 3)

# cor
(function(m){
  len <- dim(m)[1]
  mat.cor <- diag(rep(1, len))
  for (k in 1:len) {
    for (j in 1:len) {
      if (k == j) next
      if (k > j) {
        cor.kj <- mat.cor[j, k]
      } else {
        d1 <- m[, k] - mean(m[, k])
        d2 <- m[, j] - mean(m[, j])
        cor.kj <- sum(d1 * d2) / (sqrt(sum(d1 ** 2)) * sqrt(sum(d2 ** 2)))
      }
      mat.cor[k, j] <- cor.kj
    }
  }
  return(mat.cor)
})(m)
cor(m)

# cov
(function(m){
  len <- dim(m)[1]
  mat <- matrix(0, len, len)
  for (k in 1:len) {
    for (j in 1:len) {
      d1 <- m[, k] - mean(m[, k])
      d2 <- m[, j] - mean(m[, j])
      mat[k, j] <- sum(d1 * d2)
    }
  }
  return(mat / (len - 1))
})(m)
cov(m)
```

## Rで変数削除
```r:Rで変数削除.R
library(dplyr)
library(caret)

df.filtered <- df %>%
  select(-caret::nearZeroVar(df)) %>%
  select(-caret::findCorrelation(cor(.), cutoff = 任意の閾値))

# おまけ
# tidyr　はたいでぃーあーる
```

## 他記事のリンク
#### [Rで簡単に前処理＋クロス集計＋α](http://qiita.com/ksomemo/items/e5df50251402369b978d)
#### [Rでの前処理として覚えたこと](http://qiita.com/ksomemo/items/c80802a16e75dd38ea8a)
#### [Rのseqを使って先月を求めるときの注意点](http://qiita.com/ksomemo/items/2c399a35b8edf087237c)
#### [not installed package names](http://qiita.com/ksomemo/items/b6ed564ff247261bd31f)
- もう一回インストールしたら嵌りそうなもの

