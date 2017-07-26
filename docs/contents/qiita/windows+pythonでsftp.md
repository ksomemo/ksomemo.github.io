# windows+pythonでsftp
## Windowsでの接続

puttyを使って自動化してみた

```bat
rem passwordの事前入力
rem "C:\Program Files (x86)\WinSCP\PuTTY\pageant.exe" path-to.ppk

rem バッチ実行
"C:\Program Files (x86)\WinSCP\WinSCP.com" /script=sftp_sample.txt /log=sftp_sample.log

Set RESULT=%ERRORLEVEL%
Exit %RESULT%
```

```
open sftp://user@hostname:22 -privatekey="path-to.ppk"

cd /dir1/dir1_1
ls
close
exit
```

## 問題点
引数を渡せるけど扱いが面倒

## pythonでやってみた

```py3
import paramiko
import os

HOST = "hostname"
PORT = 22
USER = "user"
PRIVATE_KEY = "path-to-pem-or-ppk"

def ssh_client_ver():
    # こちらうまくいかなかったので、メインのほうでためした
    ssh = paramiko.SSHClient()
    private_key = paramiko.RSAKey.from_private_key_file(PRIVATE_KEY)
    ssh.connect(HOST, username=USER, password="", pkey=private_key)
    sftp = ssh.open_sftp()

    sftp.close()
    ssh.close()

def main():
    paramiko.util.log_to_file("paramiko_sample_sftp.log")

    # 接続
    t = paramiko.Transport(HOST)
    private_key = paramiko.RSAKey.from_private_key_file(PRIVATE_KEY)
    t.connect(username=USER, pkey=private_key)
    sftp = paramiko.SFTPClient.from_transport(t)

    # 確認用
    print(dir(t), "\n")
    print(dir(sftp), "\n")

    # ディレクトリ情報
    print(sftp.getcwd()) # RootはNone
    sftp.chdir("dir1/dir1_1")
    print(sftp.getcwd())
    print(sftp.listdir())

    # getの方法
    print(sftp.get("remote.txt", "local.txt"))
    print(paramiko.SFTPClient.get(sftp, "remote.txt", "local.txt"))

    sftp.close()
    t.close()

if __name__ == "__main__":
    main()
```

