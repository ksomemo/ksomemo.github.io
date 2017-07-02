```py3:encode_url.py
import urllib

# http://docs.python.jp/3/library/urllib.parse.html
# python2とは違う
quoted = urllib.parse.quote("あいうえお")
print(quoted)
# %E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A
print(urllib.parse.unquote(quoted))
# あいうえお
```

```py3:url_parse.py
# URLを各部分にparseしてくれて便利
# paramsの最後のパス要素に対するパラメータ　とは何かわかってない
result = urllib.parse.urlparse("http://ksomemo:pass@qiita.com:80/ksomemo/items/bdf2d39fbbefb12d0eb2?param1=value1&param2=value2#hoge")

[(a, getattr(result, a)) for a in dir(result) if not a.startswith("_")]

[('count', <function ParseResult.count>),
 ('encode',
  <bound method _ResultMixinStr.encode of ParseResult(scheme='http', netloc='ksomemo:pass@qiita.com:80', path='/ksomemo/items/bdf2d39fbbefb12d0eb2', params='', query='param1=value1&param2=value2', fragment='hoge')>),

 ('fragment', 'hoge'),

 ('geturl',
  <bound method ParseResult.geturl of ParseResult(scheme='http', netloc='ksomemo:pass@qiita.com:80', path='/ksomemo/items/bdf2d39fbbefb12d0eb2', params='', query='param1=value1&param2=value2', fragment='hoge')>),

 ('hostname', 'qiita.com'),
 ('index', <function ParseResult.index>),
 ('netloc', 'ksomemo:pass@qiita.com:80'),
 ('params', ''),
 ('password', 'pass'),
 ('path', '/ksomemo/items/bdf2d39fbbefb12d0eb2'),
 ('port', 80),
 ('query', 'param1=value1&param2=value2'),
 ('scheme', 'http'),
 ('username', 'ksomemo')]
```
