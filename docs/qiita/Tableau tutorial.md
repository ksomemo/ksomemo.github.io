
* 公式のチュートリアルをやったメモ
* 

## Mac Desktop版のDownload
* 14日無料
* チュートリアルを見るためにサイト上でも必要だった

## 起動
* Downloadしたdmgからインストール
* 起動
* ユーザー登録が必要

## チュートリアル
* Windowでのチュートリアル

## ホーム画面
* 接続へのリンク
* データ一覧

## データ接続
* localファイル
	* Excel
	* Access
	* Text file
	* Tableau独自形式？
* Server系データソース
	* RDB
		* MySQL
		* SQL Server
		* Oracle
		* PostgreSQL
	* Google
		* Google Analytics
		* Google BigQuery
	* Amazon
		* Redshift
	* Hadoop/Hive
		* Cloudera
		* MapR
		* Hortonworks
	* IBM
		* Neteeza
		* DB2
	* Other
		* Teradata
		* Salesforce
		* Firebird
		* etc.

### sample
* Tableau付属のファイル
	* /Users/xxx/Documents/マイ Tableau リポジトリ/Datasources/
		* Sample - Superstore Subset (Excel).xlsx
		* Sample - Superstore Subset (Excel).tds
	* Tableau用のデータもあったがExcelを選択
	* Excelをインストールしていなくても問題なさそう
* Excelのようなもの
* 商品の購入ログ
* ヘッダーつき

## シートの表示と結合
* シート一覧からOrdersをDrag
* 追加でReturnsをダブルクリック
* OrdersとReturnsが勝手に結合される
	* 結合のIconは結合の仕方を意味する
	* デフォルトはInnerJoin
	* Iconをクリックすると結合の仕方を変更できる
		* 左外部結合
		* 右外部結合
		* 完全結合
	* また、結合されているキーも確認できる

tutorialではOrdersだけを使う

## データプレビュー
* 結合の下にスプレッドシートのようなプレビューがある
* カラム名はRenameできる
	* カラム名右のメニューから
* カラムのデータ型を変更できる
	* カラム名下の#から
	* 地理的データ型が存在する
		* 住所や郵便番号など

## 接続方法
Connection部分

* Live
	* 常に変化するデータが有る場合
	* スペックの高いサーバーなどの場合
* Extract
	* 抽出してからなので、Offlineでも接続できる
	* どこにインポートされるのか？

## WorkSheet
ワークシートに移動をクリックする

### 右上
4つのタブのうち、一番左が選択されている。左から

* View?
* Sheet and Dashboard list?
* 接続選択画面(キャンセルで元の画面に戻る)
* ホーム画面

### 左側
* Data(取込元)
* Demensions(ヘッダー一部)
	* カテゴリ系フィールド
	* 数値データをDicing/Slicing
	* 青色
* Measures(ヘッダー一部)
	* 測定基準
	* 分析対象の数値
	* 緑色

### 真ん中
* Pages
* Filters
* Marks
* Columns
* Row
* ドロップするところ

### 右
* 表示形式のfloatメニューが存在する
* クリックすると隠れる

## データセットに接続
下記をドロップするところにドラッグして集計している

* Columns
	* Quantity orderd new
		* 受注数
		* 勝手にSum()されている
	* Region
		* MarksのColorにドラッグして地域ごとの数値のバーが色付けされた
* Row
	* Product Category
	* Costomer Segment

### 感想
* 簡単にクロス集計できている
* 行と列にドラッグしたDemensionやMeasureは編集できる
	* 各名前の横のメニューから行う
	* Measure
		* Sumから別の集計への変更
		* filterによる値の制限(範囲など
	* Demensions
		* filterによる制限ができる
		* 並べ替え
		* Measure扱いにも出来る
	* 両方
		* 属性に変換できる
		* 用途がわからない
		* 他にも色々できそう

## 売上高の例

先ほどの例を☓マークがついている、シートのクリアでなかったことにしてから始めた

* MeasuresのSalesをViewにドラッグ
	* Sumが表示された
* 経時的見ていく(経過する時間順であるさま、時系列で見ていく)
	* DemensionsからOrder DateをViewの最上位にドラッグ
	* Salesのバーの上, 列にドラッグしても同じだった
	* 年ごとに表示された(Order DateにYear()が適用されている)
	* 年の隣の＋をクリックすると、四半期ごとのデータが表示された(ドリルダウン)
		* Order DateにQuarter()が適用されている
		* Columnsに年・四半期の順に並んでいると、軸が年ごとの四半期データとして表示される
			* 各年のQuarterごとの推移を見ることができる
		* 四半期・年の順にドラッグして並べ替えると、軸が四半期ごとの年のデータとして表示される
			* 各年の第1Quarterの推移を見ることができる
	* 各年の四半期ごとの複数の折れ線グラフにするために、Columnsの年をColorにドラッグする
	* Columnsの四半期を月ごとに変更する場合、メニューから行う
		* 月
		* 四半期
		* 年
		* 日
		* 詳細(日数ごとや、週ごと)
	* 月にしてから＋をクリックすると、日になったのでドリルダウンを意味している
	* 総売上ではなく、平均売上にするときはMeasureをメニューから変更する
	* Sum()に戻すときに、上部メニューの左矢印を使った(Command+zでもできた)

## 前年度と比べた時の成長率

* これもメニューから1クリックできる
* Sum()のかかっているMeasureのメニューの簡易表計算(Quick Table Calculation)
* 今回は前年比成長率(Year over Year Growth)をクリックする
	* メニューの部分が上向き三角形になる
	* グラフの線にマウスカーソルを合わせると前年比が表示される(Tool hint)
* 元の売上高を表示するには、SalesをRowsにドラッグする
* Marksのツールヒントに前年比成長率を求めた行をドラッグすると、１つのグラフで見ることができる
* 製品カテゴリごとの売上を確認するために、Product CategoryをRowにドラッグする
	* 経時的に見ているので、いつ売上が好調であるかを把握できる
* コメントをつけられる
	* Viewで右クリックメニューから、注釈をつける(Annotate)
		* Point
		* Area(こちら)
		* あとはコメントを書くと、コメントが作成される
* Viewで右クリックメニューから、ViewをCopyできる
	* Crosstab(クロス集計)
	* Data
		* データがタブ区切りでコピーされる
	* Image
		* 試しにExcelに張ったら画像がコピーされた
* シート名の編集は、シート名をダブルクリックして変更できる
	* シートの追加はとなりのシート＋ボタン
	* そのとなりの田っぽいのをクリックすると、ダッシュボードが作成された
		* シートをまとめて表示するもの
		* 関連分析シートをまとめている例があった
* シートの情報をクロス集計として複製する
	* シートの右クリックメニューから、クロス集計として複製(Duplicate as Crosstab)を選択する
	* 新しいシートにクロス集計された結果が表示された
		* メジャーネーム(Measure Name、名前がついていないMeasure？)
	* 軸の入れ替えは、上部メニューの両端矢印のアイコン(Swap)を押す
		* 今回は、入れ替え後にProduct Categoryを行に移動して各製品の月ごとの売上を見ている
	* 行が多くて見にくい場合は表示を調整する
		* 標準となっているセレクトボックスを変更する
			* 幅を合わせる(Fit Width)
			* 高さを合わせる(Fit Height)
			* ビュー全体(Entire View、今回はこれ)
	* 売上の状況を把握しやすくするため、Salesに色をつける
		* ColorにSalesをドラッグする
		* 色が見栄えしない時は編集する(緑系のみになった…)
			* Colorをクリックして、色の編集をクリックする
			* 自動の部分を好きな色に変える(赤青の分化にしてみた)
			* Stepped Color: 6
			* Use Full Color Range: On
		* さらに
			* Marksの自動を四角(Square)にする
			* ラベルが見えなくなるので、ラベルをクリックしてマークラベルを表示する
		* 家具(Office Supplies)の売上が低いことがわかった
	* ここから分析
		* 販売地域にある全ての地域で売上が低いのか確認する
		* 新しいシートにCrosstabという名前をつけて作成する
		* 

###

##
###

##
###

##
###

##
###
