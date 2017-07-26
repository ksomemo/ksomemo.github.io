# not installed package names
```R
installed.pkg.names <- rownames(installed.packages())
pkg.names <- (read.table(pipe("pbpaste"), header = F, stringsAsFactors = F))$V1
not.installed.pkg.names <- setdiff(pkg.names, installed.pkg.names)

not.installed.pkg.names
 [1] "FSelector"     "RWeka"         "rattle"
```

- Package名を間違っていてInstallできていないことがあるので、ググる
- gcc, gfortran, XQuartzの設定でインストールできるようになる

## rattle
### gtk
- http://www.gtk.org/
- http://www.ggobi.org/rgtk2/

install-gtk.sh

```bash
brew install gtk+
brew install gtk+3
```

### Rgtk2
- https://github.com/Homebrew/homebrew/issues/43290#issuecomment-135601807
- http://apple.stackexchange.com/questions/202501/how-to-install-rgtk2-on-os-x-10-10-5

install-rgtk2-for-macos.R

```R
install.packages("RGtk2", dependencies = T, type = 'mac.binary.mavericks')
```

```
Error in dyn.load(file, DLLpath = DLLpath, ...) :
   共有ライブラリ '/usr/local/lib/R/site-library/RGtk2/libs/RGtk2.so' を読み込めません:
  dlopen(/usr/local/lib/R/site-library/RGtk2/libs/RGtk2.so, 6): Library not loaded: /Library/Frameworks/GTK+.framework/Versions/2.24.X11/Resources/lib/libgtk-x11-2.0.0.dylib
  Referenced from: /usr/local/lib/R/site-library/RGtk2/libs/RGtk2.so
  Reason: image not found
Need GTK+ ? (Restart R after installing)

1: Install GTK+
2: Do not install GTK+
```

1:pkgでInstallを促されるので、brewでインストールしたものを消しておいた…

- install.packages("XML") # success
- install.packages("cairoDevice") # failしたけどOptionとしてなので放置中

### pkg-config
- http://whispon.blogspot.jp/2014/12/gtk.html



## FSelector
install-FSelector.R

```R
install.packages("FSelector")
also installing the dependencies ‘RWekajars’, ‘rJava’, ‘RWeka’

# より RWekaと同じ, Java関連

...

install.packages("rJava")

...

checking whether JNI programs can be compiled...
configure: error: Cannot compile a simple JNI program. See config.log for details.

Make sure you have Java Development Kit installed and correctly registered in R.
If in doubt, re-run "R CMD javareconf" as root.

ERROR: configuration failed for package ‘rJava’
```

R:java-info-from-RStudio.R

```R
> system("java -version")
java version "1.8.0_20"
Java(TM) SE Runtime Environment (build 1.8.0_20-b26)
Java HotSpot(TM) 64-Bit Server VM (build 25.20-b23, mixed mode)
> system("echo $JAVA_HOME")

>
```

### javareconf
- `install.packages("rJava")` のときに言われたことをする
- jenv使ってたので心配だったけど、エラーは出なかった

R-CMD-javareconf.sh

```bash
R CMD javareconf
Java interpreter : /Users/xxx/.jenv/versions/1.7/jre/bin/java
Java version     : 1.7.0_09
Java home path   : /Users/xxx/.jenv/versions/1.7
Java compiler    : /Users/xxx/.jenv/versions/1.7/bin/javac
Java headers gen.: /Users/xxx/.jenv/versions/1.7/bin/javah
Java archive tool: /Users/xxx/.jenv/versions/1.7/bin/jar
Non-system Java on OS X

trying to compile and link a JNI program
detected JNI cpp flags    : -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/darwin
detected JNI linker flags : -L/Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home/jre/lib/server -ljvm
clang -I/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/include -DNDEBUG -I/usr/local/include -I/Users/xxx/.jenv/versions/1.7/include -I/Users/xxx/.jenv/versions/1.7/include/darwin -I/usr/local/opt/gettext/include -I/usr/local/opt/readline/include -I/usr/local/opt/openssl/include -I/usr/local/include  -I/usr/local/include   -fPIC  -g -O2  -c conftest.c -o conftest.o
clang -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/usr/local/Cellar/r/3.2.2_1/R.framework/Resources/lib -L/usr/local/opt/gettext/lib -L/usr/local/opt/readline/lib -L/usr/local/opt/openssl/lib -L/usr/local/lib -o conftest.so conftest.o -L/Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home/jre/lib/server -ljvm -F/usr/local/Cellar/r/3.2.2_1/R.framework/.. -framework R -lintl -Wl,-framework -Wl,CoreFoundation


JAVA_HOME        : /Users/xxx/.jenv/versions/1.7
Java library path: /Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home/jre/lib/server
JNI cpp flags    : -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/darwin
JNI linker flags : -L/Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home/jre/lib/server -ljvm
Updating Java configuration in /usr/local/Cellar/r/3.2.2_1/R.framework/Resources
Done.
```

```
install.packages("rJava") # success
install.packages("FSelector") # success
```
