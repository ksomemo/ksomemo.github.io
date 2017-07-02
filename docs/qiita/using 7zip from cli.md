```bat:7za_sample.bat
rem windows
7-Zip (A) 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18

7za a -tgzip data.gz data.tsv
7za e data.gz # data.tsv
7za x data.gz # data.tsv
7za l data.gz


Listing archive: data.gz

--
Path = data.gz
Type = gzip

   Date      Time    Attr         Size   Compressed  Name
------------------- ----- ------------ ------------  ------------------------
2016-02-03 12:42:39 .....     14046126      2429999  data
.tsv
------------------- ----- ------------ ------------  ------------------------
                              14046126      2429999  1 files, 0 folders
```

```p7zip.sh
brew install p7zip
# or brew upgrade p7zip
```


- gzipはこちら http://qiita.com/ksomemo/items/7d8c2c22d1e52914c642#gzip-sample
- zipはこちら http://qiita.com/pb_tmz08/items/bc22620477f473ece62c
