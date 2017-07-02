
```bash:create-new-package-project-and-open.sh
cd /path/to/new-package-parent-folder
R -q -e "library(devtools); devtools::create('mypackage')"
# open /Applications/RStudio.app
open -a RStudio mypackage
```

## ここからおまけ
```R:Lib.R
# library path関連
.Library.site
[1] "/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/site-library"
# => 存在しない…
.Library
[1] "/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/library"

.libPaths()
[1] "/usr/local/lib/R/site-library"                                         
[2] "/usr/local/Cellar/r/3.2.2_1/R.framework/Versions/3.2/Resources/library"

Sys.getenv("R_HOME")
[1] "/usr/local/Cellar/r/3.2.2_1/R.framework/Resources"

Sys.getenv("R_LIBS_USER")
[1] "~/Library/R/3.2/library"

system("env | grep ^R_ | sort")
R_BROWSER=/usr/bin/open
R_BZIPCMD=/usr/bin/bzip2
R_DOC_DIR=/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/doc
R_GZIPCMD=/usr/bin/gzip
R_HOME=/usr/local/Cellar/r/3.2.2_1/R.framework/Resources
R_INCLUDE_DIR=/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/include
R_LIBS_SITE=
R_LIBS_USER=~/Library/R/3.2/library
R_PAPERSIZE=a4
R_PDFVIEWER=/usr/bin/open
R_PLATFORM=x86_64-apple-darwin14.5.0
R_PRINTCMD=lpr
R_RD4PDF=times,inconsolata,hyper
R_SESSION_TMPDIR=/var/folders/zl/rlmkmk5d3vv_jb8397gd61900000gn/T//Rtmp4KmmMB
R_SHARE_DIR=/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/share
R_SYSTEM_ABI=osx,gcc,gxx,gfortran,?
R_TEXI2DVICMD=/usr/local/opt/texinfo/bin/texi2dvi
R_UNZIPCMD=/usr/bin/unzip
R_ZIPCMD=/usr/bin/zip

R -q -e 'system("env | grep ^R_ | sort")' # in terminal
R_ARCH=
R_BROWSER=/usr/bin/open
R_BZIPCMD=/usr/bin/bzip2
R_DOC_DIR=/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/doc
R_GZIPCMD=/usr/bin/gzip
R_HOME=/usr/local/Cellar/r/3.2.2_1/R.framework/Resources
R_INCLUDE_DIR=/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/include
R_LIBS_SITE=
R_LIBS_USER=~/Library/R/3.2/library
R_PAPERSIZE=a4
R_PDFVIEWER=/usr/bin/open
R_PLATFORM=x86_64-apple-darwin14.5.0
R_PRINTCMD=lpr
R_RD4PDF=times,inconsolata,hyper
R_SESSION_TMPDIR=/var/folders/zl/rlmkmk5d3vv_jb8397gd61900000gn/T//RtmpdMqOVl
R_SHARE_DIR=/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/share
R_SYSTEM_ABI=osx,gcc,gxx,gfortran,?
R_TEXI2DVICMD=/usr/local/opt/texinfo/bin/texi2dvi
R_UNZIPCMD=/usr/bin/unzip
R_ZIPCMD=/usr/bin/zip

# in terminal
env | grep -e "^R_"
empty
```

```R:library-test.R
library(mypackage)
 library(mypackage) でエラー: 
   ‘mypackage’ は有効なインストール済みパッケージではありません 

library(mypackage)
 library(mypackage) でエラー: 
   ‘mypackage’ という名前のパッケージはありません 
# 置いただけではだめ、Installするひつようがある
```

```R：devtools_便利.R
devtools::add_travis()

# Sample .travis.yml for R projects

language: r
warnings_are_errors: true
sudo: required

# 他にもいろいろある
```


```links.md
- https://support.rstudio.com/hc/en-us/articles/200711843-Working-Directories-and-Workspaces
``` 
