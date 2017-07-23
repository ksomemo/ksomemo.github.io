```bash:golang.sh
# install
# brew install go

# golang
export GOPATH=~/golang/gopath
export GOROOT=/usr/local/opt/go/libexec/
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# go get でpeco入れた, 便利
# gom(go)/gondler(ruby)というpackage managerがある
# 本格的に使うまではどちらも使わない方針
# gondlerのほうが名前通りbundlerに近いがRuby製
# ただし、gondlerもgomの提供しているフォーマットgomfileを使っている

# 参考
- https://github.com/peco/peco
- https://github.com/mattn/gom
- http://rosylilly.hatenablog.com/entry/2013/09/29/035023
```
