いつも迷うので検索したら、それっぽいのあったけど、迷い中。

## install
```r:install-ProjectTemplate.R
install.packages('ProjectTemplate')
# or
# install.packages("devtools")
require(devtools)
devtools::install_github('johnmyleswhite/ProjectTemplate')
```

## create project
```r:create-project.R
require(ProjectTemplate)
packageVersion("ProjectTemplate")
[1] ‘0.6’

create.project(project.name = "new-project", minimal = FALSE)
create.project(project.name = "new-project-minimal", minimal = TRUE)
```

## list contents of directories
```text:tree-new-project.txt
tree new-project

new-project
├── README
├── TODO
├── cache
├── config
│   └── global.dcf
├── data
├── diagnostics
│   └── 1.R
├── doc
├── graphs
├── lib
│   └── helpers.R
├── logs
├── munge
│   └── 01-A.R
├── profiling
│   └── 1.R
├── reports
├── src
│   └── eda.R
└── tests
    └── 1.R
```

```text:tree-new-project-minimal.txt
tree new-project-minimal

new-project-minimal
├── README
├── cache
├── config
│   └── global.dcf
├── data
├── munge
│   └── 01-A.R
└── src
    └── eda.R
```

```txt:diff-each-project-files.txt
diff new-project new-project-minimal

Only in new-project: TODO
Common subdirectories: new-project/cache and new-project-minimal/cache
Common subdirectories: new-project/config and new-project-minimal/config
Common subdirectories: new-project/data and new-project-minimal/data
Only in new-project: diagnostics
Only in new-project: doc
Only in new-project: graphs
Only in new-project: lib
Only in new-project: logs
Common subdirectories: new-project/munge and new-project-minimal/munge
Only in new-project: profiling
Only in new-project: reports
Common subdirectories: new-project/src and new-project-minimal/src
Only in new-project: tests
```

## 見てみた感想
```markdown:見てみた感想.md
- 初めて見たものが多い
- RStudioでEmptyProject作る時よりはマシ
- Package作る時に含まれるR/manは存在しない
- 有名なRepository(hadley氏)を参考にしてみるとやっぱり違う
- しかし、data/src/testsは共通している
- inst/revdep/vignettesなど知らないものがあった
    - http://r-pkgs.had.co.nz/
    - ここに詳しく書いてある
```

## 疑問
```markdown:疑問.md
- packageは上の情報を見ればよいが、固有のprojectの場合どうすればよいのか
- 例えば、Project共通のUtilityではあるがProject外では使えないものの共通化
- これを読み込む時の方法がわかってない(´・ω・｀)
```

## まとめ
```markdown:まとめ.md
- 専用Packageは使わなくてよさそう
- .gitignoreとRprojファイル目当てでRStudioからProject作成する
- とりあえず、Rディレクトリを作ってそこにRコード入れる
- srcはCompiledって書いてあったので今のところ気にしない
- ほかにもいろいろ調べて見る必要があるので追記する
```
