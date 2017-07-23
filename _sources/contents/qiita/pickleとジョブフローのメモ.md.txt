## Pickle化するコードと読み込み

```sh:tree.sh
tree
.
├── item.py
├── pickle_sample.py
├── user.py
└── users.pickle
```

```py3:pickle_sample.py
import pickle
import user
import item

user1 = user.User(1, 'A')
user2 = user.User(2, 'B')
item1 = item.Item('I1')
item2 = item.Item('I2')
user1.append_items([item1, item2])
user2.append_items([item1, item2])
users = [user1, user2]
print(users)

with open('users.pickle', 'wb') as f:
    pickle.dump(users, f)
with open('users.pickle', 'rb') as f:
    users_loaded = pickle.load(f)
    print(users_loaded)
```

```py3:user.py
class User:
    def __init__(self, id, name):
        self.id = id
        self.name = name
        self.items = []

    def __repr__(self):
        return '<%s(%s): %s>' % (self.__class__, id(self), self.__dict__)

    def append_items(self, items):
        for i in items:
            self.items.append(i)
```

```py3:item.py
class Item:
    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return '<%s(%s): %s>' % (self.__class__, id(self), self.__dict__)
```


```py3:run_pickle_sample.sh
python pickle_sample.py
[<<class 'user.User'>(4330090336): {'items': [<<class 'item.Item'>(4330307768): {'name': 'I1'}>, <<class 'item.Item'>(4330622592): {'name': 'I2'}>], 'id': 1, 'name': 'A'}>, <<class 'user.User'>(4330307712): {'items': [<<class 'item.Item'>(4330307768): {'name': 'I1'}>, <<class 'item.Item'>(4330622592): {'name': 'I2'}>], 'id': 2, 'name': 'B'}>]
[<<class 'user.User'>(4330622704): {'items': [<<class 'item.Item'>(4330635336): {'name': 'I1'}>, <<class 'item.Item'>(4330635560): {'name': 'I2'}>], 'id': 1, 'name': 'A'}>, <<class 'user.User'>(4330635728): {'items': [<<class 'item.Item'>(4330635336): {'name': 'I1'}>, <<class 'item.Item'>(4330635560): {'name': 'I2'}>], 'id': 2, 'name': 'B'}>]
```

## モジュールを読み込めないディレクトリでPickle読み込み
```py3:load_pickle.sh
mkdir test && cd test
python -c "
import pickle
with open('../users.pickle', 'rb') as f:
    users_loaded = pickle.load(f)
    print(users_loaded)
"

Traceback (most recent call last):
  File "<string>", line 4, in <module>
ImportError: No module named 'user'
```

## pickle化したオブジェクトの再利用
ジョブフローの落ちたジョブの再実行用にジョブ内容をpickle化したいなと考えていた

- 再利用するには、実行した時と同じコードのモジュールが必要
- バージョン管理が基本の今、gitのHash値などと合わせて確実に再利用できる

## その他ジョブ実行のフロー用のメモ
- ジョブ実行の履歴管理
- ジョブのフローと成功の有無
- 失敗時のタスクを再実行可能にする
- そもそものジョブの冪等性の意識



