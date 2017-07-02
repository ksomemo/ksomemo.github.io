- scaffoldがない
- 積み中, とりあえず最低限は完了

## 参考
- https://docs.djangoproject.com/en/1.10/
- https://docs.djangoproject.com/en/1.10/intro/

## install
```bash:pip_install_django.sh
pip install django
```

## project
アプリじゃなくてプロジェクト作成

```bash:django_admin_startproject.sh
django-admin startproject en_jp_dict

cd en_jp_dict
ls
manage.py en_jp_dict
```

## migrate
基本となるテーブル作成

```bash:manage_py_migrate.sh
python manage.py migrate

sqlite3 db.sqlite3

sqlite> .tables
sqlite> .schema
```

## 管理ユーザと管理画面
```bash:manage_py_createsuperuser.sh
python manage.py createsuperuser
# mail省略化
```

## WebServer
- サーバー立ち上げて確認
- ついでに /admin も確認

```bash:runserver.sh
python manage.py runserver

Starting development server at http://127.0.0.1:8000/
```

```text:response.txt
It worked!
Congratulations on your first Django-powered page.

Of course, you haven't actually done any work yet. Next, start your first app by running python manage.py startapp [app_label].
You're seeing this message because you have DEBUG = True in your Django settings file and you haven't configured any URLs. Get to work!
```

## プロジェクトファイル一覧
```bash:project_files.sh
cd en_jp_dict
ls
__init__.py __pycache__ settings.py urls.py wsgi.py
```

- init
  - 何も書いてない
- settings
  - 各種設定
    - INSTALLED_APPS
        - 管理機能やsessionなど便利そうな名前ものが存在する
    - MIDDLEWARE
        - hook ?
        - contribもある
    - DATABASES
        - DB設定/pyファイルなので環境変数などからパスワードを取得がよさそう
  - runserverに出てきたので見始めた
- urls
  - ルーティング設定
  - 正規表現書いてあった
  - idなどのキャプチャのサンプルはなかった
- wsgi
  - https://www.python.org/dev/peps/pep-0333/
  - Web Server Gateway Interface
    - WebアプリはPHPでしか作ったこと無い
    - Rackなどのここら辺わかってない…
    - 概要はWAFとWebServerのインターフェイス
    - これに沿っていればWAF WebServerを入れ替えられる

```py3:japanese_settings.py
# settings.pyの日本に関わりそうな部分を変更しておく
LANGUAGE_CODE = 'ja'
TIME_ZOME = Asia/Tokyo
```

SECRET_KEYはenvironで回避した(http://qiita.com/ksomemo/items/ea887b527182500991cb)

- http://stackoverflow.com/questions/13866926/python-pytz-list-of-timezones
- USE_TZはそのまま
- 変えるようにしてるのあるけど、どう変わるのかわからないのでそのまま

## アプリ作成
```bash:manage_py_startapp.sh
cd ..
python manage.py startapp dictionary

cd dictionary
ls
__init__.py admin.py migrations models.py tests.py views.py
```

- init
- migrations/\__init__.py
  - 何も書いてない

- admin
- models
- tests
- views

```py3:app_templates.py
from django.contrib import admin
# Register your models here.

from django.db import models
# Create your models here.

from django.test import TestCase
# Create your tests here.

from django.shortcuts import render
# Create your views here.
```

- ここから、上記のhere部分にコードを書く
- めんどうだなーと思ってScaffold調べたら古くてメンテされていなかった
- 素直に頑張ろう

## app Inex view
- appの`views.py` に関数を定義する
    - request引数を持つ
    - http.Responseを返す(文字列でbodyを渡した)
- appに`urls.py` を作成
    - 明示的にroutingを定義する必要がある
    - urlpatternsというlistにurl定義を追加する
    - regex, callable?, url name
- siteの`urls.py` にappの`urls.py`を利用するように登録する
    - こちらも明示する

## create model
- appの`models.py`にclassを定義する
    - `models.Model`のsubtype
    - fieldは, `models.XxxxField`
        - columnでない理由はDBに限らないmodelであるため
        - formとして利用されることを想定している
    - Wordクラスを作成しChar,Int,DateTimeを利用した
        - formとして利用されることもあるのでDBの型に限らない
        - File/Image, IP Address/UUIDなど
        - 辞書として必要な word, japanese, search_count, created_at, updated_at を作成した
        - 検索履歴tableを作ればよいのだけど、めんどうなので１つにしてある
    - いろいろなoptionがある
        - primary_key: word
        - default
            - immutable value or a callable object
        - auto_now/auto_now_add
            - datetime field
            - 上記で現在日時(djangoのtimezone.now)が使われる
            - https://docs.djangoproject.com/ja/1.10/ref/models/fields/#datefield
            - なので、`default=datetime.datetime.now` とは違いそう
        - unique: 今回使っていない
        - db_index: 時刻に使った
        - null/blank: null許容/formでのblank許容, japaneseに試してみた
        - editable: formでの編集拒否, xxx_atに試してみた
- appのmodelを利用できる準備
    - `settings.py` のINSTALLED_APPSに追加する
    - `app/apps.py` に `AppConfig` classがあるのでその名前と規則に従う
- modelの追加をMigrationsファイルに書き出す
    - `python manage.py makemigrations app`
    - app/migrations/0001_initial.py:
        - Create model Word
    - migration classにoperationがずらずらと書かれていた
    - 今回はCreateModel, modelの内容とほぼ同じ
    - `python manage.py sqlmigrate app 0001` でSQLとして確認できる
- migrationする(前回と同じコマンド)
    - sqliteにtable作られていた
    - 詳しくは下記
        - https://docs.djangoproject.com/en/1.10/topics/migrations/
- migrationの履歴
    - `python manage.py showmigrations` でmigration一覧を見るとX markがついている
    - djangoのmeta tableにmigrationの履歴が残っている
    - deleteして一覧をみるとX markが消えている
    - migrateするとtableが存在するのでエラーになる
        - `migrate --fake` をして履歴だけ作成する
        - ｀--fake-initial｀ の説明だけしかなかった
        - 本来の用途は、すでにDB存在するけど,djangoへの移行などに使う感じがする

```bash:sqlite3_run_sql_from_stdin.sh
echo "select * from django_migrations" | \
sqlite3 db.sqlite3 -column -cmd ".headers on"
```

### add model and change model
- Wordに品詞(Parts of Speech)を追加
    - posとしてchoicesを利用
    - form selectorのようなデータの持ち方 `list[tuple(value, name), ...]`
- 品詞テーブルを作成し、上記は外部キーとする
    - `HINT: ForeignKey(unique=True) is usually better served by a OneToOneField.`
    - https://docs.djangoproject.com/ja/1.10/topics/db/models/#verbose-field-names
    - ForeignKey for Many-to-one relationships
        - マスタと紐付けた明示
- makemigration
    - OneToOneに使ったfieldがnon-nullableなのにdefault値がないので警告
    - 続けるかやめるかの選択, 親切
    - 続けたらdefault値の設定を求められた
        - 1回目:1, 2回目:Noneを設定(両方成功)
        - migration fileに反映されている
        - model fileには反映されていない
    - `0002_auto_yyyymmdd_HHMM.py`
- sqlmigrateの内容
    - 変更ありテーブルはrename
        - 新定義で作り直し
            - `(sqlite3)CREATE TABLE 定義 SELECT *, (新定義カラム:makemigration で決めたdefault値)`
        - renameしたtableをdrop
    - index貼り直し
        - これは使い物にならないのでは…

## django shell
- ipythonで起動した
- installされてない場合, default python repl

### insert to 品詞master 
```py3:model_in_django_shell.py 
from dictionary.models import PartOfSpeech, Word

# SQLAlchemyと似た感じ, choiceは名前を引ける
p_list=[PartOfSpeech(pos=i) for i in range(1, len(PartOfSpeech.CHOICES)+1)]
[p.save() for p in p_list]
[(p.pos, p.get_pos_display()), for p in PartOfSpeech.objects.all()]
w = Word(word="word test", japanese="テスト",
         parts_of_speech=PartOfSpeech.objects.get(pos=1))
# choiceはmodel instanceを求められる, xxx_at are empty
w.save()
# xxx_at are not empty
w.word = "test"
w.save()
# updated_at is updated
```

## 管理画面でmodel操作
- `app/admin.py` にmodelを登録
- user, group以外に登録したモデルが操作できるようになった
- model class名しか分からなくて一覧の意味がない…
- 下記で対応したけど、best practiceが分からない

```py3:to_string_model.py
    def __str__(self):
        values = [str(v) for v in [self.pos, self.get_pos_display()]]
        return "({0})".format(", ".join(values))
```
