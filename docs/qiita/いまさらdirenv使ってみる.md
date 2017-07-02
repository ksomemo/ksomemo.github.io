## 動機
- [direnvを使ってgitのユーザ名とメールを切り替え](http://qiita.com/d6rkaiz/items/393fa0fcdbad7c57444e) を見てdirenvの最小の使い方を知った
- repository見たら2.0からgolangで書きなおしたよう
- binary1つだけで使えるため環境に依存せずに導入できてよいと思った

## install
```bash:install-direnv.sh
brew install direnv
==> Downloading https://homebrew.bintray.com/bottles/direnv-2.7.0.yosemite.bottle.tar.gz

direnv
direnv v2.7.0
Usage: direnv COMMAND [...ARGS]

ずらずらー
```

```bash:for_direnv.vimrc
# direnv
eval "$(direnv hook zsh)"

# basic
export EDITOR=vim

source ~/.zshrc
```

## 試してみた
- 単純だけど単純じゃない
- 意図しない変更を許容しないようにしている

```zsh:example_direnv.sh
# echo "export MY_ENV=ababa" > .envrc
direnv edit .
direnv: loading .envrc
direnv: export +MY_ENV

vim .envrc
export MY_ENV=ababac
direnv: error .envrc is blocked. Run `direnv allow` to approve its content.

direnv allow .
direnv: loading .envrc
direnv: export +MY_ENV

vim .envrc
export MY_ENV=ababa
direnv: loading .envrc
direnv: export +MY_ENV

direnv deny .
vim .envrc
export MY_ENV=ababac
direnv: error .envrc is blocked. Run `direnv allow` to approve its content.

cd ..
direnv: unloading
env | grep MY_ENV | wc -l
       0
```
