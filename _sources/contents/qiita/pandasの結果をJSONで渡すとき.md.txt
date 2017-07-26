# pandasの結果をJSONで渡すとき

qiita.com/ynakayama/items/7dc01f45caf6d87a981b

を見て、pandasの結果をJSONで渡すときの話。

## 転置させればよさそう

見出し通り、下記のようにすれば求めていることができた。

```py3
import pandas as pd


df = pd.DataFrame()
df['a'] = range(3)
df['b'] = range(1, 4)
df.T.to_json()
```

## 結果
そのままJSON化

```json
{"a":{"0":0,"1":1,"2":2},"b":{"0":1,"1":2,"2":3}}
```

```json
{"0":{"a":0,"b":1},"1":{"a":1,"b":2},"2":{"a":2,"b":3}}
```

## Documentのorient
こっちのがよい

```py3
df.to_json(orient='records')
# => '[{"a":0,"b":1},{"a":1,"b":2},{"a":2,"b":3}]'
```
