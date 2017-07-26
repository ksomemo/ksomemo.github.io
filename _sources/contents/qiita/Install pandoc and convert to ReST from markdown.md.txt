# Install pandoc and convert to ReST from markdown
## 動機
- rst覚えるのつらい
- けどrstが要求されるときがある
- 変換してしまえ

## references
- http://brewformulas.org/pandoc
- http://sky-y.github.io/site-pandoc-jp/users-guide/

## install
```bash
brew install pandoc
```

## version
```bash
pandoc -v
pandoc 1.16
```

## useage
```bash
pandoc --help
pandoc [OPTIONS] [FILES]
Input formats: xxx
Output formats: xxx
Options:
  -f FORMAT, -r FORMAT  --from=FORMAT, --read=FORMAT
  -t FORMAT, -w FORMAT  --to=FORMAT, --write=FORMAT
  -o FILENAME           --output=FILENAME
                        --data-dir=DIRECTORY
.
.
.
```

## markdown types
- markdown
- markdown_github
- markdown_mmd
- markdown_phpextra
- markdown_strict

ReST type is only rst !

## convert
```bash
pandoc -f markdown_github -t rst -o this_post.rst this_post.md
```

## conclusion
- pandoc is convenient
- 変換後のRestをMarkdown対応表として使えそう
