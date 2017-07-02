あまりにも雑だったので用途を書いたけど、不適切っぽいのでドキュメントどおりに適切に使おう

```py3:contextlib_exitstack_enter_context.py
# 普通の書き方
with open('f1.txt') as f1, \
     open('f2.txt', 'w') as f2:
    for line in f1:
        f2.write(line)

# http://docs.python.jp/3/library/contextlib.html#contextlib.ExitStack
from contextlib import ExitStack
with ExitStack() as stack:
    # すっきり書けている感じがするが、特に意味がない
    f1 = stack.enter_context(open('f1.txt'))
    f2 = stack.enter_context(open('f2.txt', 'w'))

    # 条件によって、追加でcontext managerを扱う
    # (with statementがないので、明示的でない)
    line_count = sum(1 for _ in f1)
    if line_count > 2:
        f3 = stack.enter_context(open('f3.txt', 'w'))
        f3.write(str(line_count))
```
