# note: mecab + python
結局janomeだけでなくMeCabも試した

## nstall_mecab_env.sh
```bash
# https://github.com/neologd/mecab-ipadic-neologd/blob/master/README.ja.md
brew install mecab
brew install mecab-ipadic
git clone --depth 1 git@github.com:neologd/mecab-ipadic-neologd.git ~/mecab-ipadic-neologd
cd ~/mecab-ipadic-neologd
./bin/install-mecab-ipadic-neologd -n

./bin/install-mecab-ipadic-neologd -h
Usage: install-mecab-ipadic-NEologd [OPTIONS]
  This script is the installer of mecab-ipadic-NEologd

Options:
  -h, --help
  -v, --version
  -p, --prefix /PATH/TO/INSTALL/DIRECTORY
     Set any directory path where you want to install
  -y, --forceyes If you want to install regardless of the result of test
  -u, --asuser   If you want to install to the user directory as an user
  -n, --newest   If you want to update mecab-ipadic-NEologd

# 次回からは、 -y を追加して実行すればよさそう

cd -
pip install mecab-python3
```

## parse_to_node.py
```py3
import MeCab


"""
- 毎回while書くのめんどうなのでforで使えるgeneratorを作った
- なぜかencodeできない値が発生するので方法をググった
- http://www.trifields.jp/how-to-use-mecab-in-ubuntu-14-04-and-python-3-1196
- neologdを試せるようにしておいた
"""
def parse_to_node(text, opt=None):
    if opt is None:
        opt = "-Ochasen"
    mecab = MeCab.Tagger(opt)

    # encode error対策
    mecab.parse("")

    node = mecab.parseToNode(text)
    while node:
        yield node
        node = node.next
    # https://www.python.org/dev/peps/pep-0479/
    raise StopIteration()

# to_df
import pandas as pd


text = "すもももももももものうち"
# 利用できそうな属性を探した
attrs = [
    # 'bnext', 'enext', 'prev', 'next', 'this',
    'alpha', 'beta', 'char_type', 'cost', 'feature', 'id',
    'isbest', 'lcAttr', 'length', 'lpath', 'posid',
    'prob', 'rcAttr', 'rlength', 'rpath', 'stat', 'surface', 'wcost'
]
gen = ({a: getattr(n, a) for a in dir(n) if a in attrs}  for n in parse_to_node(text))
nodes = pd.DataFrame(gen)

# to_table.py
import tabulate


"""
- 形態素の情報を使いやすくした
- カラムが多い + pd.optionで調整するのがめんどうだったのでtableにした
- df.to_html + stringIO -> pypandoc(github markdown) では変換時にhtml classが付加されるせいでうまくいかなかった
- tabulate(https://pypi.python.org/pypi/tabulate)をたまに見るのでやってみた + headers="keys"が便利
"""
features = nodes.feature.str.split(",", expand=True)
features.columns = "f0 f1 f2 f3 f4 f5 f6 f7 f8".split()
nodes = pd.concat([nodes.drop("feature", axis=1), features], axis=1)

print(tabulate.tabulate(nodes, headers="keys", tablefmt="pipe"))
nodes
```

|    |   alpha |   beta |   char_type |   cost |   id |   isbest |   lcAttr |   length |   lpath |   posid |   prob |   rcAttr |   rlength |   rpath |   stat | surface   |   wcost | f0      | f1   | f2   | f3   | f4   | f5   | f6   | f7   | f8   |
|---:|--------:|-------:|------------:|-------:|-----:|---------:|---------:|---------:|--------:|--------:|-------:|---------:|----------:|--------:|-------:|:----------|--------:|:--------|:-----|:-----|:-----|:-----|:-----|:-----|:-----|:-----|
|  0 |       0 |      0 |           0 |      0 |    0 |        1 |        0 |        0 |         |       0 |      0 |        0 |         0 |         |      2 |           |       0 | BOS/EOS | *    | *    | *    | *    | *    | *    | *    | *    |
|  1 |       0 |      0 |           6 |   7263 |    9 |        1 |     1285 |        9 |         |      38 |      0 |     1285 |         9 |         |      0 | すもも       |    7546 | 名詞      | 一般   | *    | *    | *    | *    | すもも  | スモモ  | スモモ  |
|  2 |       0 |      0 |           6 |   7774 |   18 |        1 |      262 |        3 |         |      16 |      0 |      262 |         3 |         |      0 | も         |    4669 | 助詞      | 係助詞  | *    | *    | *    | *    | も    | モ    | モ    |
|  3 |       0 |      0 |           6 |  15010 |   24 |        1 |     1285 |        6 |         |      38 |      0 |     1285 |         6 |         |      0 | もも        |    7219 | 名詞      | 一般   | *    | *    | *    | *    | もも   | モモ   | モモ   |
|  4 |       0 |      0 |           6 |  15521 |   30 |        1 |      262 |        3 |         |      16 |      0 |      262 |         3 |         |      0 | も         |    4669 | 助詞      | 係助詞  | *    | *    | *    | *    | も    | モ    | モ    |
|  5 |       0 |      0 |           6 |  22757 |   36 |        1 |     1285 |        6 |         |      38 |      0 |     1285 |         6 |         |      0 | もも        |    7219 | 名詞      | 一般   | *    | *    | *    | *    | もも   | モモ   | モモ   |
|  6 |       0 |      0 |           6 |  23131 |   46 |        1 |      368 |        3 |         |      24 |      0 |      368 |         3 |         |      0 | の         |    4816 | 助詞      | 連体化  | *    | *    | *    | *    | の    | ノ    | ノ    |
|  7 |       0 |      0 |           6 |  23729 |   58 |        1 |     1313 |        6 |         |      66 |      0 |     1313 |         6 |         |      0 | うち        |    5796 | 名詞      | 非自立  | 副詞可能 | *    | *    | *    | うち   | ウチ   | ウチ   |
|  8 |       0 |      0 |           0 |  21245 |   62 |        1 |        0 |        0 |         |       0 |      0 |        0 |         0 |         |      3 |           |       0 | BOS/EOS | *    | *    | *    | *    | *    | *    | *    | *    |
