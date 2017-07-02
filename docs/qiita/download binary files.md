- requestsいつも忘れるのでメモ
- binary fileをどうればよいか調べた
- おまけとして、optionの引数を調べた

```py3:download-binary-files.py
import requests
import io
import shutil
import zipfile

headers = {'user-agent': 'my-agent'}
r = requests.get(pdf_url, headers=headers)
shutil.copyfileobj(io.BytesIO(r.content), open(pdf_url.split("/")[-1], "wb"))

proxies = {
    "http": "http://xxx.xxx.xxx.:xxxx",
    "https": "http://xxx.xxx.xxx.:xxxx",
}
r = requests.get(zip_url, proxies=proxies)
with zipfile.ZipFile(io.BytesIO(r.content)) as z:
    z.extractall()
```
