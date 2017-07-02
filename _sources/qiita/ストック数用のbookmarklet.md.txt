- http://qiita.com/hikarut/items/c71063af8cb79124de72 のextensionが動かなかったので、bookmarkletにした
- error logをalertにした
- chromeなのでes6で書いてみた
    - let, const, template literal
- 一部minifyしてある
- stockersへのリンク追加

```js:qiita_stock.js
javascript:(() => {
    let path = window.location.pathname
    , itemId=path.substr(-20, 20)
    , url = `https://qiita.com/api/v1/items/${itemId}`;
    if (path.match(/items/)) {
        $.ajax({
            url: url,
            success :(t) => {
                $(".StockButton__label").prepend(t.stock_count);
                const stockerLink = $(`<a href="https://qiita.com/items/${itemId}/stockers">stockers</a>`);
                $(".ArticleAsideHeader__stock").prepend(stockerLink);
            },
            error:() => {
                alert("qiitaStock request error");
            },
            dataType:"json",
            timeout:3e3}
        );
    }
})()
```
