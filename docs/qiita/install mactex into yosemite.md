sympyのために仕方なくInstall

```bash:brew-insta-prepare.sh
brew install imagemagic
brew install ghostscript
```

```txt:download-mactex.txt
ftp://ftp.u-aizu.ac.jp/pub/tex/CTAN/systems/mac/mactex/
mactex-20150613.pkg
```

```markdown:memo.md
## memo
- ghostscript16が内蔵されてた
- めっちゃ大きい(2.5 GB)
- インストールすると5 GB以上
```

```txt:latex-version.txt
latex -version

pdfTeX 3.14159265-2.6-1.40.16 (TeX Live 2015)
kpathsea version 6.2.1
Copyright 2015 Peter Breitenlohner (eTeX)/Han The Thanh (pdfTeX).
There is NO warranty.  Redistribution of this software is
covered by the terms of both the pdfTeX copyright and
the Lesser GNU General Public License.
For more information about these matters, see the file
named COPYING and the pdfTeX source.
Primary author of pdfTeX: Peter Breitenlohner (eTeX)/Han The Thanh (pdfTeX).
Compiled with libpng 1.6.17; using libpng 1.6.17
Compiled with zlib 1.2.8; using zlib 1.2.8
Compiled with xpdf version 3.04

# /Library/TeX/texbin がPATHに追加れさていた
```
