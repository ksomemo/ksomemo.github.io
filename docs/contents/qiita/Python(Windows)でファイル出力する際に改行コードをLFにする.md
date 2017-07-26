# Python(Windows)でファイル出力する際に改行コードをLFにする
- https://docs.python.org/3.5/library/functions.html#open
    - `newline="\n"`
- pandas.DataFrame.to_csvやshutilなどはfile objectを渡せるので、これで対応する
    - line_terminatorでは対応できない
- Windowsつらい
