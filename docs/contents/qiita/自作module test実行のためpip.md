# 自作module test実行のためpip
実行のためにめんどうな設定を指定たので調べてみた。

## 今までのmoduleへのPATHを通し方
- 自分用では、setup.pyからのtest実行時にsys.pathへの追加
- PYTHONPATHへの設定追加

```python3
sys.path.append('/path/to/module')
```

```bash
export PYTHONPATH=path/to/module
```

以下、改善。

## 環境設定
- pyvenvでvirtual envの設定(pyenvで今まで済ませていたけど、pyenv使えない環境のための勉強用)
- test用moduleのinstall

## pip install -e PATH
- local pathをmoduleとしてinstallできる(privateなrepositoryも？)
- pipなので最低限のsetup.pyを用意する必要がある

```python3
from setuptools import setup

setup(
    name='mymodule'
)
```

環境設定と合わせると以下のとおり

```bash
cd path/to/module
pyvenv venv
pip install pytest
# 他環境のpy.test実行を防ぎ、PATH設定されない状態を防ぐ)
pip install -e .
```

```bash
pip freeze
py==1.4.30
pytest==2.7.2
mymodule==0.0.0
```

## test実行
pytestのテスト収集規則により、venv/lib/pythonXX/site-packages内のtestが実行されるので自分のtestのみを対象にする

```bash
py.test test
```

## まとめ
- 簡単にmoduleをinstall済みとして扱える
- venvディレクトリがあると他に必要なmoduleを追加したいときに気後れしない
- もしよさげなmoduleができたらsetup.pyが既にあるので追加で書けそう

すべてが好循環になりそう。
