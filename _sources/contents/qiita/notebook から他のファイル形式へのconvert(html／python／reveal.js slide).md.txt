
## htmlへ
defaultではhtml

```sh:notebook_convert_deafault.sh
ipython nbconvert ch02.ipynb
[NbConvertApp] Converting notebook ch02.ipynb to html
[NbConvertApp] Writing 224503 bytes to ch02.html
```

## python scriptへ

```py3:notebook_convert_to_script.sh
ipython nbconvert --to script ch02.ipynb
[NbConvertApp] Converting notebook ch02.ipynb to python
[NbConvertApp] Writing 639 bytes to ch02.py
```

```py3:notebook_convert_to_script.sh
# coding: utf-8

# In[13]:

get_ipython().magic('matplotlib inline')
# -> 元々は、%matplotlib inline　(magic command)
```

--to pythonでも同じだった。

## slideとして
reveal.jsを使ったslideとしてWebServer＋ブラウザが起動する。

```py3:notebook_convert_for_slide_server.sh
ipython nbconvert --to slides ch02.ipynb --post serve
[NbConvertApp] Converting notebook ch02.ipynb to slides
[NbConvertApp] Writing 226741 bytes to ch02.slides.html
[NbConvertApp] Redirecting reveal.js requests to https://cdn.jsdelivr.net/reveal.js/2.6.2
Serving your slides at http://127.0.0.1:8000/ch02.slides.html
Use Control-C to stop this server
```

```slides.md
`--post serve`をつけないと、ch02.slides.htmlが生成されるだけでサーバーは起動しない。

- 必要なjs/cssが用意されていない状態なので、post serveした状態で収集しておくと良さそう？
- => `--reveal-prefix` を使って指定する http://cdn.bootcss.com/reveal.js/3.1.0
```

### slideの設定
- Cell Toolbar:　を slideshow に変更する
- 各Cellの右にSlideに関する選択肢が現れる
- Slide Typeをslideに変更する
- 適宜、sub-slideなどに変更して整える
