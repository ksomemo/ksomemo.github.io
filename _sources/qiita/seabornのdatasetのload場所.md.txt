```py3:seaborn_load_dataset.py
# ダウンロード可能一覧はseabornから調べることができないので、
# すべてダウンロードしておくとよい
sns.load_dataset
# => <function seaborn.utils.load_dataset>

# https://github.com/mwaskom/seaborn/blob/master/seaborn/utils.py#L376
# "https://github.com/mwaskom/seaborn-data/raw/master/{0}.csv"

sns.load_dataset("iris")

%ls ~/seaborn-data/
iris.csv
```
