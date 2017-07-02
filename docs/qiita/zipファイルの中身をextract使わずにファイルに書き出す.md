```py3:write_zip_archives.py
import zipfile
import shutil


with zipfile.ZipFile("z.zip") as z:
    for i, n in enumerate(z.namelist()):
        shutil.copyfileobj(open(n), open("out" + str(i) + ".ext", "wb"))
```
