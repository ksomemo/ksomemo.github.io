
- jquery事前読み込み済み (http://qiita.com/ksomemo/items/becd4929593e0ffb4dda )
- url, user, password は事前に準備済み

```js:basicAuthorization.js
$.ajax({
  url: url,
  success: function(data) {console.log(data)},
  error: function(xhr, status, error) {
    console.log(status);
    console.log(error);
    console.log(xhr);
  },
  beforeSend: function(xhr) {
    xhr.setRequestHeader("Authorization", "Basic " + window.btoa(user + ":" + password));
  }
});
```
