- いまさらflask使ってみた
- jinjaは前に使ったことあるので特に問題なし

## まとめ
- flask便利
- htmlをrendorできた
- json API作れた
- file downloadもできた
- メモアプリとしては未完成…
- Microな域を超えたらdjangoにしないと消耗しそう

```py3:memo.py
from flask import (
    Flask,
    render_template,
    jsonify,
    request,
    send_from_directory
)
import sys
import datetime
app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/hello_html/<name>')
def hello_html(name=None):
    return 'hello {}'.format(name)


@app.route('/api/save/word', methods=['POST'])
def save_word():
    filename = 'save.tsv'
    print(request.form)
    with open(filename, 'a') as f:
        data = [
            request.form['word'],
            request.form['memo'],
            datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        ]
        f.write('\t'.join(data) + '\n')
    return jsonify({'status': 'ok'})


@app.route('/download/<path:filename>')
def download(filename):
    """donwload file"""
    return send_from_directory('.', filename)


if __name__ == '__main__':
    debug = False
    if len(sys.argv) > 1 and sys.argv[1] == 'debug':
        debug = True
    app.run(debug=debug)
```

```html:template.html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>index</title>
</head>
<body>
  <h1>memo app</h1>
  <h2>単語登録</h2>
    単語:<input type="text" id="word">
    メモ<textarea id="memo">メモ内容</textarea>
    <input type="button" id="register" value="登録">
  <h2>単語一覧</h2>
  <table border="1">
    <thead>
      <th>単語</th>
      <th>メモ</th>
      <th>調べた回数</th>
    </thead>
    <tbody>
      <td>hellow</td>
      <td>こんにちは</td>
      <td>1</td>
    </tbody>
  </table>
  <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
  <script>
    $(function() {
      $("#register").on('click', function() {
        postData = {
          "word": $("#word").val(),
          "memo": $("#memo").val()
        };
        $.post("{{ url_for('save_word') }}", postData, function(data) {
          console.log(data);
        })
      });
    });
  </script>
</body>
</html>
```
