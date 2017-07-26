# Rで簡単に前処理＋クロス集計＋α
## execute system command
```R
system("R --version")

R version 3.1.2 (2014-10-31) -- "Pumpkin Helmet"
Copyright (C) 2014 The R Foundation for Statistical Computing
Platform: i386-w64-mingw32/i386 (32-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
http://www.gnu.org/licenses/.
```

## attributes of variable
```R
# result is NULL
attributes(c())
attributes(NULL)
attributes(1)
attributes("1")
attributes(T)

# class, names, dim, row.names
# names -> var$name
attributes(as.Date(Sys.time()))
attributes(Sys.getenv())
attributes(matrix(1:5))
attributes(data.frame(1:5))

# attributes(POSIXlt)
# $names
#  [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"   "isdst"
# [10] "zone"   "gmtoff"
# $class
# [1] "POSIXlt" "POSIXt"
#
# $tzone
# $[1] ""    "JST" "JDT"
```

## date(seq and datetime)

```R
# seq for date
last.ym <- function (x) {
  d <- seq(as.Date(x), len=2, by="-1 month")[2]
  return(format(d, "%Y%m"))
}

# POSIXlt(as datetime)
month.first.date <- function (x) {
  t <- as.POSIXlt(x)
  e <- as.POSIXlt(t - (t$mday - 1) * 60 * 60 * 24)
  return(as.Date(e))
}
```

## package version
```R
packageVersion("dplyr")
[1] ‘0.4.1’
```


```R
## data processing library

library(dplyr)
library(data.table)

> library(dplyr)

 次のパッケージを付け加えます: ‘dplyr’

The following objects are masked from ‘package:plyr’:

    arrange, count, desc, failwith, id, mutate, rename, summarise, summarize

The following object is masked from ‘package:stats’:

    filter

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> library(data.table)
data.table 1.9.4  For help type: ?data.table
*** NB: by=.EACHI is now explicit. See README to restore previous behaviour.

 次のパッケージを付け加えます: ‘data.table’

The following objects are masked from ‘package:dplyr’:

    between, last
```

### fast read file
```R
df1 <- data.table::fread(df1.path, header = T, stringsAsFactors = F)
```

### pipe
easy to understand.

* join
* add column
* filter
* delete column(or choose column)

```R
# %.% is duplicated.
df1 %>%
  dplyr::left_join(df2, by="id") %>%
  dplyr::inner_join(df3, by="id")
  dplyr::mutate(col5 = ifelse(is.na(df3$col4), 0, 1)) %>%
  dplyr::filter(mem_type %in% c("a", "z")) %>%
  dplyr::select(-col1, -col2, col3, col2)
```

### grouping and summarize
```R
grouped <- device %>%
  dplyr::group_by(id) %>%
  dplyr::summarize(last_timestamp = max(timestamp))

# distinct
# Don't use group for instead of unique().
dplyr::distinct(df1, id, type)
```

## sql like
```R
library(sqldf)
var.name.chain.dot <- data.frame(1:5)
var_name_chain_dot <- var.name.chain.dot
sqldf("select count(*) from var_name_chain_dot")
# sqldf("select count(*) var.name.chain.dot")
# ↑ error
```

## delete var and gc
```R
rm(var1, var2)
gc()

# for gloval env
clear.var.global <- function(vars) {
  rm(list=vars, pos = ".GlobalEnv")
  gc()
}
```

## cross tabulation
```R
library(reshape2)

# one column
dcast(df1, value.var = "id",
      type ~ .,
      length)
# table(d$g)

# cross tabulation
dcast(df1, value.var = "id",
      status ~ type,
      length)
# table(d$g, d$s)

# multi column cross tabulation
dcast(df1, value.var = "id",
      status + type + category ~ is_max,
      length)
```

## arguments parser

```R
# Python optparse like
library(optparse)
optslist <- list(
  make_option("--flag1",          action="store_T", default=F,      help="A Flag"),
  make_option(c("-f", "--flag2"), action="store",   default=F,      help="A Flag", type="logical"),
  make_option("--num",            type="integer",   default=1,      help="A Number"),
  make_option("--raw-data",       type="character", default="hoge", help="a string")
)
parser <- OptionParser(option_list = optslist)
opts <- parse_args(parser)

cat(sprintf("flag1=%s, flag2=%s, num=%d, raw-data=%s",
            opts$flag1, opts$flag2, opts$num, opts[["raw-data"]]))
```

## exit or assertion like function
```R
stop("Message")

stopifnot(T)
stopifnot(F == T)
# -> Error:  F == T は TRUE ではありません
```

### random, shuffle(sample)
```R
m1 <- matrix(runif(100), nrow=10)
m2 <- matrix(sample(c(rep(0, 5), rep(1, 5)), size = 9), ncol=3)
```

## network graph
```R
library(igraph)
g <- graph.adjacency(m1 <= 0.5, mode="undirected")

# edge
E(g)$color <- "grey"
E(g)$width <- 1
E(g)$weight <- 100
E(g)$label <- letters[1:length(E(g))]

# node
V(g)$size <- 5
V(g)$color <- "blue"
V(g)$shape <- "circle"
V(g)$label <- letters[1:length(V(g))]
V(g)$label.cex <- 1.5                   # font size for label
```

### plot
```R
plot(g)
plot(g, layout=layout.circle)
plot(g, layout=layout.star)
plot(g, layout=layout.grid)
plot(g, layout=layout.kamada.kawai)

# directed and weighted
g <- graph.adjacency(m2, mode="directed", weighted=TRUE)
plot(g, vertex.color="white", vertex.label = V(g)$name, edge.color = "black", edge.label = E(g)$weight, vertex.size=10)

# tree
g <- graph.tree(15)
plot.igraph(g)

# dendrogram like
lay <- layout.reingold.tilford(g)
plot(g, layout=lay)
```

