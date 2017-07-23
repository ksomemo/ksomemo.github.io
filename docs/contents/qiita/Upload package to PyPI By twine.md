
## 目的 
- ライブラリ公開に対して気楽になるように経験する
- setup.pyの勉強
- のはずだったんだけど、twineの勉強になってた

packageはtravis試した時に作ったがらくた

## 設定(setup.py)
- いろいろ設定する
- DRYにしようとすると面倒
- setup.cfgはdistutils用っぽい
- 現在はsetuptoolが主流なので、便利と思って使ってはいけない

### version
- めんどうなものの１つ
- ほかにはREADMEを読み込んでlong_descriptionに設定するもの

http://python-packaging-user-guide.readthedocs.org/en/latest/single_source_version/

## uploadするファイルの準備
- source codeのtar ball
- userがbuildしなくて済むようにするwheel

なにを実行しているかわかりやすようにgrepしてみた。詳細は素の出力をみるとわかる

```
python setup.py sdist | grep running

running sdit
running egg_info
running check
```

```
python setup.py bdist_wheel | grep running

running bdist_wheel
running build
running build_py
running install
running install_lib
running install_egg_info
running egg_info
running install_scripts
```

### 成果物
- build
- ciserviceex.egg-info
- dist

#### 確認
eff-infoのPKG_INFOを見ればsetup.pyの設定の反映を確認できる

#### dist
uploadするもの

```
tree dist

dist
├── ciserviceex-0.0.1-py2.py3-none-any.whl
└── ciserviceex-0.0.1.tar.gz
```

#### wheel
>
```
https://pypi.python.org/pypi/wheel
A wheel is a ZIP-format archive with a specially formatted filename and the .whl extension. 
```

なので下記で確認できる

```
mkdir hoge && cd $_
unzip ../dist/ciserviceex-0.0.1-py2.py3-none-any.whl
```

## Upload

### アカウントの登録
https://pypi.python.org/pypi?%3Aaction=register_form

### testpypi
- https://testpypi.python.org/pypi
- pypiのid/passは使えないのでアカウントはこれ用に登録する必要がある

### twine
setup.pyだけでもPyPIへの登録はできるが、こちらを推奨しているようなので使ってみた。理由はgithubに書いてあった

- https://github.com/pypa/twine
- http://bugs.python.org/issue12226

#### install
```
pip install twine
```

### .pypirc
pypi用の設定ファイル

https://wiki.python.org/moin/EnhancedPyPI

- 上記を見るとpypiだけでなく、ほかのServerを設定できるらしい
- 調べてみるとtest用のpypiがあった
- passwordが含まれるので、github等で公開している人はgitignoreに入れるなりしないと危ない
- もしくはpasswordの設定だけ書かない
- passwordを含めた設定は以下のとおり

```
cat << EOF > ~/.pypirc
[distutils]
index-servers=
    pypi
    test

[pypi]
repository = https://pypi.python.org/pypi
username = <xxx>
password = <xxx>

[test]
repository = https://testpypi.python.org/pypi
username = <xxx>
password = <xxx>
EOF
```

`python -c "import distutils"` で一応使えるか確認しておいた

#### アカウント登録前
```
twine upload -r test dist/*

Uploading distributions to https://testpypi.python.org/pypi
Uploading ciserviceex-0.0.1-py2.py3-none-any.whl
HTTPError: 401 Client Error: You must be identified to edit package information for url: https://testpypi.python.org/pypi
```

#### アカウント登録後
```
twine upload -r test dist/*

Uploading distributions to https://testpypi.python.org/pypi
Uploading ciserviceex-0.0.1-py2.py3-none-any.whl
HTTPError: 403 Client Error: You are not allowed to edit 'ciserviceex' package information for url: https://testpypi.python.org/pypi
```

#### packageをProjectとして登録
- そもそもの使い方が違っていた
- https://github.com/pypa/twine/issues/21

```
twine register -r test dist/ciserviceex-0.0.1.tar.gz
```

Webブラウザでrepository URLにアクセスすると、右上のあたりにYour packages:が追加されている

#### tar.gz と whlのUpload
```
twine upload dist/*
```

ようやくUploadできた

### pip install
-r test を消していままでの流れを実行すればpip install できるだろうけど、testpypiからインストールする方法を調べた

```
pip install -h

Package Index Options (including deprecated options):
  -i, --index-url <url>       Base URL of Python Package Index (default https://pypi.python.org/simple).
```

```
pip install -i https://testpypi.python.org/pypi ciserviceex

Collecting ciserviceex
  Downloading https://testpypi.python.org/packages/py2.py3/c/ciserviceex/ciserviceex-0.0.1-py2.py3-none-any.whl
Installing collected packages: ciserviceex
Successfully installed ciserviceex-0.0.1
```

## 参考
- https://python-packaging-user-guide.readthedocs.org/en/latest/distributing/
- https://github.com/pypa/sampleproject
- https://pypi.python.org/pypi?%3Aaction=list_classifiers
- https://pythonhosted.org/an_example_pypi_project/setuptools.html

## おまけ
uploadするということは事前にimportしてあげないといけないので、pathの通し方について出てきたリンクを貼っておく

- http://pythonhosted.org//setuptools/setuptools.html#development-mode
- http://stackoverflow.com/questions/19048732/python-setup-py-develop-vs-install
- https://mail.python.org/pipermail/distutils-sig/2014-April/024112.html
