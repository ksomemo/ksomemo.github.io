# jQueryで雑に処理してダウンロード weblio words
- Weblioの登録単語Exportがしょぼすぎた
- のでjQueryで雑に処理してダウンロードできるようにした
- Array.prototype.map の使い方覚えた
- String.prototype.replace が１つしか置換しなかった
- Date.prototype.toISOString を覚えた

downloadWeblioRegisteredWord.js

```js
var now = new Date();
var sidFuncs = {
  0: function(el) {return $(el).text()},
  1: function(el) {return ""},
  2: function(el) {return $(el).text().replace(/\//g, "")},
  3: function(el) {return $(el).text()},
  4: function(el) {return $(el).text().replace("- Weblio Email例文集", "")},
  5: function(el) {return ""},
  6: function(el) {return ""},
  7: function(el) {return $(el).text()},
  8: function(el) {
    var registerAt = $(el).text();
    var dateInfo = registerAt.split("/");
    if (dateInfo.length === 2) {
      registerAt = now.getFullYear().toString() + '/' + registerAt;
    }
    var registerDate = new Date(registerAt);
    return registerDate.toISOString().split('T')[0];
  },
  9: function(el) {return $(el).text()},
  10: function(el) {return ""}
};

var download = function(fileName, data) {
  a = document.createElement('a');
  a.href = 'data:text/plain;charset=utf-8,' + encodeURIComponent(data);
  a.setAttribute('download', fileName);
  a.dispatchEvent(new CustomEvent('click'));
};

var header = (function() {
  var _header = [];
  // "table.tngMainT tbody tr
  $("#tngIdWlHdTr th").each(function(idx, el){
    _header.push($(el).text());
  });

  return _header;
})();

var records = (function() {
  var _records = [];
  $("[id^='sid']").each(function(idx, el){
    var record = [];
    $(el).find("td").each(function(i, e) {
      record.push(sidFuncs[i](e));
    });
    _records.push(record);
  });

  return _records;
})();

var tsvContent = header.join("\t") + "\n" +
  records.map(function(r) {
    return r.join("\t")}
  ).join("\n");

download('weblio-registered-words.tsv', tsvContent);
```
