# zipファイルの中身をextract使わずにファイルに書き出す
```py3
import zipfile
import shutil


with zipfile.ZipFile("z.zip") as z:
    for i, n in enumerate(z.namelist()):
        shutil.copyfileobj(open(n), open("out" + str(i) + ".ext", "wb"))
```
