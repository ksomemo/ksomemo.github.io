## 動機
- rst覚えるのつらい
- けどrstが要求されるときがある
- 変換してしまえ

```0_Install_pandoc_and_convert_to_ReST_from_markdown.txt
for gist
```

## references
- http://brewformulas.org/pandoc
- http://sky-y.github.io/site-pandoc-jp/users-guide/

## install
```bash:pandoc_install.sh
brew install pandoc
```

## version
```bash:pandoc_version.sh
pandoc -v
pandoc 1.16
```

## useage
```bash:pandoc_help.sh
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
```bash:pandoc_convert.sh
pandoc -f markdown_github -t rst -o this_post.rst this_post.md
```

```rst:thid_post.rst
動機
----

-  rst覚えるのつらい
-  けどrstが要求されるときがある
-  変換してしまえ

references
----------

-  http://brewformulas.org/pandoc
-  http://sky-y.github.io/site-pandoc-jp/users-guide/

install
-------

.. code:: bash:pandoc_install.sh

    brew install pandoc

version
-------

.. code:: bash:pandoc_version.sh

    pandoc -v
    pandoc 1.16

useage
------

.. code:: bash:pandoc_help.sh

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

markdown types
--------------

-  markdown
-  markdown\_github
-  markdown\_mmd
-  markdown\_phpextra
-  markdown\_strict

ReST type is only rst !

convert
-------

.. code:: bash:pandoc_convert.sh

    pandoc -f markdown_github -t rst this_post.md

conclusion
----------

-  pandoc is convenient
-  変換後のRestをMarkdown対応表として使えそう

```

## conclusion
- pandoc is convenient
- 変換後のRestをMarkdown対応表として使えそう
