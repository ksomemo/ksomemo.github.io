# git mergeでコンフリクトしたファイルを,mergeしたブランチのファイルで全て上書き

```bash
git ls-files -u | ¥
    awk -F" " '{ print "git checkout --theirs " $4 }' | ¥
    sort | ¥
    uniq | ¥
    while read line; do ${line}; done
```

* コンフリクトしたファイル一覧の取得
* コンフリクトした際、どちらのブランチのファイルを使うかのオプション
* 今回は無理やりsquashでまとめつつマージなので、あまりよくない…
