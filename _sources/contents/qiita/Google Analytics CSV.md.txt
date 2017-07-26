# Google Analytics CSV
ga-memo-csv.js

```js
var records = ["名前,作成者,日付"];
$('#ID-m-content tbody tr').each(function(idx, el) {
  $el = $(el);
  records.push([
    $el.find('td.ID-editAnnotation > a').text(),
    $el.find('td:nth-child(3) > div').text(),
    $el.find('td:nth-child(4) > div > span').text()
  ].join(','));
});

a = document.createElement('a');
a.href = 'data:text/plain;charset=utf-8,' + encodeURIComponent(records.join("\r\n"));
a.setAttribute('download', 'google-analytics-memo.csv');
a.dispatchEvent(new CustomEvent('click'));
```
