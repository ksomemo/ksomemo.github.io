今更Jenkinsの設定等メモ

## Environments
Windows

## Install
Installer

## Jenkinsの管理
- ここからいろいろ設定
- JenkinsのUpdate等も行える

### プラグインの管理
とりあえず入れたもの

- AnsiColor
- Build Pipeline Plugin
- buildgraph-view
- Credentials Plugin
- Git plugin
- PegDown Formatter Plugin

#### Job Configuration History Plugin
ジョブの設定変更の履歴が見れるようになる

#### scripttrigger
Scriptでビルドトリガーを定義できるようにする

#### Timestamper
コンソール出力に時刻が出力されるようになる

#### Discard Old Build plugin
- ビルド完了後、古いビルドを削除できるようになる
- 安定や失敗などを選べる
- http://softwaretest.jp/labo/tech/labo-237/

#### JobDelete Builder Plugin
- ジョブのビルド定義にジョブの削除が追加される
- ジョブを正規表現指定して複数削除できるようになる

#### Groovy Plugin
- ビルド定義をGroovyで記述できるようになる
- Groovyコマンドとスクリプトがある？

### 

### HTTP Proxyの設定
しておく

## Jenkins CLI
- 使った, 便利

### ビルドの範囲指定削除
```
java -jar jenkins-cli.jar -s http://yourserver.com delete-builds <JobName> 11-1717 --username user --password pass
```

## 認証情報の管理
？

## ユーザーの管理
- ユーザー追加
- API TOKENの表示

## api
- http://localhost:8080/job/job_name/api/
- http://wiki.jenkins-ci.org/display/JENKINS/Remote+access+API

## build
### error
```bash:build_exapmle.sh
curl -X POST http://localhost:8080/job/job_name/build
```

### authorization
```bash:build_with_basic_authorization.sh
curl --user id:pass -X POST \
http://localhost:8080/job/job_name/build
```

### delay
```bash:build_with_delay_paramter.sh
curl --user id:pass -X POST \
 "http://localhost:8080/job/job_name/build?delay=120sec&cause=test"
```

#### コンソール出力
- ユーザー(id)が実行
- 要因のtestが見当たらない

### with token(job)
#### build trigger(project setting)
- リモートからビルドをチェック
- 認証トークンを入力

curl --user id:pass -X POST "http://localhost:8080/job/job_name/build?delay=120sec&token=tokentest&cause=test"

#### コンソール出力
- リモートホスト0:0:0:0:0:0:0:1が実行(test)
- 要因が表示された
- １人で使っている時のトークンの利点は？

### buildWithParameters
- ビルドのパラメータ化
- 例として、各違うdelayを付加してbuild requestを送っても同じとして扱われてしまい、キューにたまらない


## 同時実行数

1. ビルド実行状態リンク(http://localhost:8080/computer/)
2. 右のアイコンから設定変更画面へ(http://localhost:8080/computer/(master)/configure)

default: 2

## 環境変数
同時実行数と同じ画面にて設定できる(ノードプロパティ)

環境変数 key: value
