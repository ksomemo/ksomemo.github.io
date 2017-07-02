## help系 magic command と perl
### 動機
ipythonの`%pdoc`というmagic commandをどこかで見たので試していた

### その過程で知ったこと
- jupyter notebook上で他にもpなんとかあるかなーと見てたら`%%perl`があった
- `%%javascript`は知っていた
- けどsyntax highlightされるのは知らなかった
- `%%ruby`もあった
- 素直に各言語の処理系とkernelを入れるほうがよさそう
- `%%python2` はpython2のalias作っておけば便利そう(自分の場合pyenv使っているので無理)

```perl_in_jupyter.pl
%%perl
# http://ipython.readthedocs.org/en/stable/interactive/magics.html
my $a = 1;
sub add {
   my ($x, $y) = @_;
   return $x + $y;
}
print $a + add(2, 3);
```

### %pなんとか(本題)
|command|conent|alias|
|-------|------|-----|
|pdoc   |doc string ||
|pdef   |signature  ||
|pinfo  |Signature,docstring,file,type|?target|
|pinfo2 |pinfo - docstring + source   |??target|
|pfile  |対象の定義されているfileのsource||
|psource|対象のsource||

pagerはQ or ESCで閉じることを知らないと邪魔だと思ってしまうので覚えたほうがいい(知らなかった)

## その他
- `%quickref` か document読もう
- pprintはdefaultでON,OFFにするには`%pprint`
- `%pycat` https://raw.githubusercontent.com/pydata/pandas/master/setup.py によるpytho fileのpager閲覧
- `%set_env` myenv=value による環境変数の設定
    - `%env` myenv で確認できる
    - もちろん `os.environ` にも反映される
    - proxy機能するかあとで試す
- `%doctest_mode` はterminalのprompt表示をdoctestにコピペしやすくするものなので、testできるわけではなさそう
- `%edit` はterminalからだとEditorが立ち上がって編集でき、書いた内容が現在のセッションに反映される(つまりnotebookでは意味が無い…)

### まとめ
- ipythonだけの環境の場合に強くなった
- %p関連は使えそうだけど, ?/??だけでも問題なさそう
- 消耗した


## ipythonで自作magicコマンド
```py3:example.ipynb
%% exmaple line_start line_end
cell_start
1
2
3
cell_end
```

```py3:example.py
# ~/.ipython/extensions/
from IPython.core.magic import register_cell_magic


@register_cell_magic
def exmaple(line, cell):
    print("line:", line)
    print("cell:", cell)
    return line + "[add]", cell + "[add]"

def load_ipython_extension(ipython):
    ipython.register_magic_function(helloworld, 'cell')
```

```py3:ipython_config.py
# ~/.ipython/profile_default/
c.InteractiveShellApp.extensions.append("example")
```

## jupyter hook
```py3:jupyter_notebook_config.py
# http://jupyter-notebook.readthedocs.org/en/latest/extending/savehooks.html
# ~/.jupyter
def scrub_output_pre_save(model, **kwargs):
    """scrub output before saving notebooks"""
    # only run on notebooks
    if model['type'] != 'notebook':
        return
    # only run on nbformat v4
    if model['content']['nbformat'] != 4:
        return

    for cell in model['content']['cells']:
        if cell['cell_type'] != 'code':
            pass
            # continue
        # cell['outputs'] = []
        # cell['execution_count'] = None
        print(cell["outputs"])

c.FileContentsManager.pre_save_hook = scrub_output_pre_save

import io
import os
from notebook.utils import to_api_path

_script_exporter = None


def script_post_save(model, os_path, contents_manager, **kwargs):
    """convert notebooks to Python script after save with nbconvert

    replaces `ipython notebook --script`
    """
    from nbconvert.exporters.script import ScriptExporter

    if model['type'] != 'notebook':
        return

    global _script_exporter
    if _script_exporter is None:
        _script_exporter = ScriptExporter(parent=contents_manager)
    log = contents_manager.log

    base, ext = os.path.splitext(os_path)
    # py_fname = base + '.py'
    script, resources = _script_exporter.from_filename(os_path)
    script_fname = base + resources.get('output_extension', '.txt')
    log.info("Saving script /%s", to_api_path(script_fname, contents_manager.root_dir))
    with io.open(script_fname, 'w', encoding='utf-8') as f:
        f.write(script)

c.FileContentsManager.post_save_hook = script_post_save
```

## nbviewer用のbookmarklet
### 動機
- 今見ているipynbページ or 特定のURLをnbviewerで見たい
- nbviewerで入力しに行くのはめんどう
- つくってしまえ

### code
```open-nbviewer.js
var target = '_target'
, tab = window.open('about:blank', target)
, form = document.createElement('form')
, input = document.createElement('input')
, body = document.querySelector('body')
;
input.type = 'text';
input.name = 'gistnorurl';
input.value = window.prompt() || location.href;
form.method = 'post';
form.target = target;
form.action = 'https://nbviewer.jupyter.org/create';
form.appendChild(input);
body.appendChild(form);
form.submit();
//try {form.submit()} catch(e){alert(e);tab.close()};
body.removeChild(form);
```

### tryの部分
- `submit()`したときに起こったerror
- catchできなかったので、後述のCSPは諦めるしか無い

> Refused to send form data to 'https://nbviewer.jupyter.org/create' because it violates the following Content Security Policy directive: "form-action 'self' github.com gist.github.com".

https://developer.mozilla.org/ja/docs/Web/Security/CSP

> Content Security Policy (CSP) とは、クロスサイトスクリプティング (XSS) やデータを差し込む攻撃などといった、特定の種類の攻撃を検知し、影響を軽減するために追加できるセキュリティレイヤーです。これらの攻撃はデータの窃取からサイトの改ざん、マルウェアの拡散に至るまで、様々な目的に用いられます。


## 他記事のリンク
### [Jupyter Content Management Extensions使ってみた](http://qiita.com/ksomemo/items/dab10c3fcd4df51f7f68)

### [Notebookに複数のDataFrameを(水平に)出力する+displayについて](http://qiita.com/ksomemo/items/4a522cecb098ef487bd9)

### [Python以外 in jupyter notebook](http://qiita.com/ksomemo/items/71843261b7b0919d08b8)
