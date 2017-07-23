
[editRを試した](http://qiita.com/ksomemo/items/c71e8be21bcdd8c72a0a)でEditorの上の方にあったpublishについて調べた

## 概要
- shinyappsが必要らしい
- ぐぐったら出てきた https://www.shinyapps.io/
- Share your Shiny Applications Online(Deploy your Shiny applications on the Web in minutes)
- Shinyの概要おさらい:Shiny　by RStudio, A web application framework for R
- Web ApplicationのDeploy
- FreePlanあり
- Shinyについては他の記事参照

便利そう(2016-01-08)

## 料金体系
$0/month

New to Shiny? Deploy your applications for FREE.

5 Applications
25 Active Hours
 Community Support
 RStudio Branding

## sign up
Githubアカウントでできた

## 必要なPackage
```r:install-package.R
install.packages("RCurl")
devtools::install_github('rstudio/shinyapps')
```

## アカウント設定
```r:setAccountInfo.R
# https://www.shinyapps.io/admin/#/dashboard からTokenを確認
# 1つ以上作成したらこっちから？ https://www.shinyapps.io/admin/#/tokens
library(shinyapps)
shinyapps::setAccountInfo(name='ksomemo',
			  token='your token',
			  secret='<SECRET>')
```

https://www.shinyapps.io/admin/#/account/billing

## deploy
Shinyプロジェクトの雛形からプロジェクトを作って、青いマークからPublish

```
Preparing to deploy application...DONE
Uploading bundle for application: 77136...DONE
Deploying bundle: 345960 for application: 77136 ...
Waiting for task: 128967448
  building: Parsing manifest
  building: Installing packages
  building: Installing files
  building: Pushing image: 339939
  deploying: Starting instances
  rollforward: Activating new instances
  unstaging: Stopping old instances
Application successfully deployed to https://ksomemo.shinyapps.io/shiny-sample/
Deployment completed: https://ksomemo.shinyapps.io/shiny-sample/
```

https://ksomemo.shinyapps.io/shiny-sample/ にアクセスすると動いている！

https://www.shinyapps.io/admin/#/dashboard が, tutorialからダッシュボードに変わっている

## ダッシュボード
1　APPLICATIONS ONLINE
1 Running

https://www.shinyapps.io/admin/#/applications/running
歯車のアイコンをクリックしてAppの設定画面へ

### Overview
Bundle のDownloadから、AppのSourceをダウンロードできる

APPLICATION USAGE
Total: 0.08 hours
と表示されている

  INSTANCES + ←　これをクリックすると、下記文言が出た
Id: ｘｘｘｘｘ
You have reached the maximum number of instances per application.

### Metrics
- CONNECTIONS
- MEMORY USAGE
- WORKER PROCESSES
- CPU USAGE
- NETWORK USAGE

### URLs
Your account subscription does not allow custom domains which is a requirement to have custom application urls. Please upgrade your subscription to the Professional plan.

#### setting(General)

shinyapps.io branding cannot be disabled in the free tier. upgrade now!

-> https://www.rstudio.com/faq-items/powered-rstudio-show-application-get-rid/

Instance

Instance Size

Select larger instances if you require more memory for your application. Free and starter plans are limited to a maximum of 1GB (Large).

Instance Idle Timeout	15 min	


### setting(Advanced)
Server関連

- Worker Settings
- Instance Settings
- Build Settings

### users
To enable authentication, upgrade your subscription to the Standard plan or higher.

SECURITY SETTINGS => disabled => Public only

### LOGS
- アクセスではなく、起動関連だけ？
- Download可能

### 起動停止関連
- Restart
- Archive/Restore
- Delete

起動させないようにArchiveしたら、Restore表示に切り替わった

## インスタンスの状態と操作
- running -> Archive -> Archived
- Archived -> restart -> running
- Archived -> restore -> running
- running -> delete -> Application must be archived before it can be deleted.

## sleeping状態にしてみる
Instance Idle Timeoutをdefaultの15分から最短の5分にして試す

Archived -> 時間経過 -> Sleeping

## delete
- Sleeping -> delete -> Application must be archived before it can be deleted.
- Archived -> delete -> deleted

## まとめ
- publishはshiny appをdeployする機能である
- shinyappsは無料でdeployできる環境である
- shinyappsでの主な制限はメモリ1GB

