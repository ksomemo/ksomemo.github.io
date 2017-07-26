# import this と 部分適用
## The Zen of Python と import
import this すると表示されるはよく知られているので省略。

## thisが提供しているもの
* this.c
* this.d
* this.i
* this.s

cとiはなにかの数字、dはdict, sはstrでした。

## dとsの詳細
dは英大文字小文字を別の英大文字小文字にmapする内容でした。

sはThe Zen of Pythonと似たような文章で、

`x is better than y.` が `a vf orggre guna b.` になっているっぽい(x,yも適当なa,bに置き換わっている)。

ここまで分かれば、あとはsの文字をdでmapするだけ。

## functools と 部分適用
```python3
import this
import functools

f = lambda x, d: d[x] if x in d else x
pf = functools.partial(f, d=this.d)

print(''.join(map(pf, this.s)))
```

* mapすればいいけど、引数が複数ある
* functoolsを使えば部分適用した関数を作れる
* 引数を指定できるので、どの位置でも大丈夫そう
