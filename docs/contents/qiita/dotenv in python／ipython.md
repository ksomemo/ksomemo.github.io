# dotenv in python/ipython
## 動機
django触っていたらSECRET_KEYが出てきたので隠したかった

## modules
- https://github.com/joke2k/django-environ
    - djangoって書いてあるけど,`import envrion` ...
    - `os.environ`ではなく専用のclassを利用する
    - pythonの型(int,str,float,list,dict,tuple,etc)を指定して取得できる
    - url, path(root指定して相対path取得), db_urlなど拡張されている
- https://github.com/theskumar/python-dotenv
    - simple, `import dotenv`
    - `os.environ`を利用する
    - https://github.com/jpadilla/django-dotenv も dotenv moduleなので注意
    - ipython用のmagic commandがある
        - https://github.com/theskumar/python-dotenv#ipython-support
        - 雑になりがちなjupyter notebookでの作業だからこそ便利


### 違い
- `key='string'` と設定されているファイルからkeyの値を取得したとき
    - environ -> string
    - dotenv -> string with quote
