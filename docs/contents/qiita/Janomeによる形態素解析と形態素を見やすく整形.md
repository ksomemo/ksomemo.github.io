# Janomeによる形態素解析と形態素を見やすく整形
mecabめんどうだったのでInstall

```bash
# https://github.com/mocobeta/janome
pip install janome
```

## example_janome.py
```py3
# 見づらい
from janome.tokenizer import Tokenizer
t = Tokenizer()
for token in t.tokenize(u'すもももももももものうち'):
    print(token)
    print(type(token))
    for attr_name in dir(token):
        if attr_name.startswith("_"):
            continue
        attr = getattr(token, attr_name)
        print(attr_name, attr, type(attr))
    break
```

```
すもも	名詞,一般,*,*,*,*,すもも,スモモ,スモモ
<class 'janome.tokenizer.Token'>
base_form すもも <class 'str'>
infl_form * <class 'str'>
infl_type * <class 'str'>
node_type SYS_DICT <class 'str'>
part_of_speech 名詞,一般,*,* <class 'str'>
phonetic スモモ <class 'str'>
reading スモモ <class 'str'>
surface すもも <class 'str'>
```

janome_token_dataframe.py

```py3
import pandas as pd
from janome.tokenizer import Tokenizer

pd.DataFrame(
    {attr_name: getattr(token, attr_name) for attr_name in dir(token) if not attr_name.startswith("_")}
    for token in Tokenizer().tokenize(u'すもももももももものうち')
)
```

<div class="output_subarea output_html rendered_html output_result"><div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>base_form</th>
      <th>infl_form</th>
      <th>infl_type</th>
      <th>node_type</th>
      <th>part_of_speech</th>
      <th>phonetic</th>
      <th>reading</th>
      <th>surface</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>すもも</td>
      <td>*</td>
      <td>*</td>
      <td>SYS_DICT</td>
      <td>名詞,一般,*,*</td>
      <td>スモモ</td>
      <td>スモモ</td>
      <td>すもも</td>
    </tr>
    <tr>
      <th>1</th>
      <td>も</td>
      <td>*</td>
      <td>*</td>
      <td>SYS_DICT</td>
      <td>助詞,係助詞,*,*</td>
      <td>モ</td>
      <td>モ</td>
      <td>も</td>
    </tr>
    <tr>
      <th>2</th>
      <td>もも</td>
      <td>*</td>
      <td>*</td>
      <td>SYS_DICT</td>
      <td>名詞,一般,*,*</td>
      <td>モモ</td>
      <td>モモ</td>
      <td>もも</td>
    </tr>
    <tr>
      <th>3</th>
      <td>も</td>
      <td>*</td>
      <td>*</td>
      <td>SYS_DICT</td>
      <td>助詞,係助詞,*,*</td>
      <td>モ</td>
      <td>モ</td>
      <td>も</td>
    </tr>
    <tr>
      <th>4</th>
      <td>もも</td>
      <td>*</td>
      <td>*</td>
      <td>SYS_DICT</td>
      <td>名詞,一般,*,*</td>
      <td>モモ</td>
      <td>モモ</td>
      <td>もも</td>
    </tr>
    <tr>
      <th>5</th>
      <td>の</td>
      <td>*</td>
      <td>*</td>
      <td>SYS_DICT</td>
      <td>助詞,連体化,*,*</td>
      <td>ノ</td>
      <td>ノ</td>
      <td>の</td>
    </tr>
    <tr>
      <th>6</th>
      <td>うち</td>
      <td>*</td>
      <td>*</td>
      <td>SYS_DICT</td>
      <td>名詞,非自立,副詞可能,*</td>
      <td>ウチ</td>
      <td>ウチ</td>
      <td>うち</td>
    </tr>
  </tbody>
</table>
</div></div>

