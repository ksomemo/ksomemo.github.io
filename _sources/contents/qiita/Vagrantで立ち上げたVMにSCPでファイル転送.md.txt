# Vagrantで立ち上げたVMにSCPでファイル転送
hadoop環境を作成時に、OracleJDKを使う必要があったため

```bash
scp -F ~/.ssh/config ~/Downloads/jdk-6u45-linux-x64-rpm.bin vagrant@cdh42:~/
```
