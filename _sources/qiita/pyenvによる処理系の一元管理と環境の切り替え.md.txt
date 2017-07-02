
## 用途
* pythonの処理系の一元管理
* 特定ディレクトリでのpython処理系の切り替え
* 各プロジェクトごとの環境(python version, library, etc.)の切り替え
* 特定ディレクトリでの環境切り替え

## pyenvのインストール
```shell-session
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
```

## 設定
各shの設定ファイルに以下を追加

```zsh
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

## pythonの処理系のインストール

* やむをえず2系
* これからの安定3系
* （通常とは使用するライブラリが異なるので）機械学習やデータ処理のための簡易環境として anaconda, miniconnda
* （使ったこと無いけど）速さを求めて pypy

```shell-session
pyenv install --list
pyenv install <name>
```

### 特定ディレクトリでのバージョン切り替え
```shell-session
cd target_dir
pyenv local <name>
cat .python-version
# <name>

# version確認
python -V # <name>
mkdir -p depth1/depth2
cd depth1/depth2; python -V # <name>
cd ..; python -V # <name>
cd ../..; python -V # default
cd taget_dir; rm .python-version; python -V # default
```

## 各プロジェクトごとの環境の切り替え

* 環境切替に便利なvirtualenvをpyenvから簡単に使える
* globalなコマンドではなく、pyenvのサブコマンドとして使える

### 環境の作成と切り替えと削除
```shell-session
pyenv virtualenv env-name
pyenv virtualenvs
pyenv activate env-name
pyenv deactivate
pyenv uninstall env-name
```

### 特定ディレクトリでの環境の切り替え
```shell-session
cd target_dir
pyenv local env-name
# activate -> (env-name)

cat .python-version
# env-name

python -V # version-for-env

# 自動切り替え
cd ..
# pyenv-virtualenv: deactivate env-name
cd -
# pyenv-virtualenv: activate env-name
```

## まとめ
pyenv localによって簡単に切り替えられるので、習慣付けたい
