# chatwork apiを試してみた

```js
document.write(
'<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>'
);
var token = 'xxxx';
var urlBase = 'https://api.chatwork.com/v1';

var roomIds = {
  'develop' : xxxx
};

var ajaxPrm = {
  url: urlBase,
  headers: {
    'X-ChatWorkToken': token
  },
  dataType: 'json',
  success: function(data, dataType) {
    console.log(data);
  }
};

ajaxPrm.url += '/rooms/' + roomIds.develop + '/tasks';

$.ajax(ajaxPrm);
```
