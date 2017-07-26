# javascript basic authorization
- jquery事前読み込み済み
- url, user, password は事前に準備済み

```js
// read jquery
script = document.createElement('script');
script.src ="https://code.jquery.com/jquery-2.1.4.min.js";
document.body.appendChild(script);
```

```js
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
