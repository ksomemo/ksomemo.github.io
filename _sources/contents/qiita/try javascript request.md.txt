
```js:requestWithJqueryAjax.js
// read jquery
script = document.createElement('script');
script.src ="https://code.jquery.com/jquery-2.1.4.min.js";
document.body.appendChild(script);

// request
var request = function(url, data) {
  $.ajax({
    url: url,
    method: keys(data).length === 0 ? "GET" : "POST",
    data: data
  }).done(function(res, status, xhr) {
    console.log(status);
    console.log(res);
    console.log(xhr);
  }).fail(function(xhr, status, error) {
    console.error(status);
    console.error(error);
    console.error(xhr);
  });
  // or then(fSuccess, fError);
};
```
