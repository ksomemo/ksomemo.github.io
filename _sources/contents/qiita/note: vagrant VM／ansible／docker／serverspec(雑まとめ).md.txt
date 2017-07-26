# note: vagrant VM／ansible／docker／serverspec(雑まとめ)
## 動機
- 開発環境を整える環境を最新にする
- いいかげんにDockerを触る

## 流れ
- MacなのでDockerのためのVMを立ち上げる
    - VagrantでVM立ち上げる(Ubuntu: 今までRedhat系だったので触ってみる)
    - VagrantのためのVirtualBoxを5にUpdate
- DockerとDockerのコンテナ以外の準備のためのAnsible準備
    - 今回はvagrantのprovisioning, bootstrap.shで対応
- playbookの記述
    - <del>コンテナをServerspecでテストするのでruby+serverspecも</del>
- DockerFileの記述
    - こっちでinstall serverspec + α and test

いろいろめんどうだったので、流れが変

## virtualbox
- https://www.virtualbox.org/wiki/Downloads
- 5.0.20

## vagrant
https://www.vagrantup.com/docs/

### install
- installer
- https://www.vagrantup.com/downloads.html
- Vagrant 1.8.1

### VM
- https://atlas.hashicorp.com/boxes/search
    - ubuntu 0.14.0までしかなかった
- <del>http://www.vagrantbox.es/</del> -> 古い
- <del>http://opscode.github.io/bento/</del> -> 消えてた
    - http://chef.github.io/bento/ に移ってた
    - https://atlas.hashicorp.com/bento/ bento/ubuntu-16.04 あった

### donwload and settings
vagrant-vm-setup.sh

```bash
mdkir ~/programming/vagrant/ubuntu && $_
vagrant box add bento/ubuntu-16.04
vagrant init bento/ubuntu-16.04
vagrant up
vagrant ssh

# or
vagrant ssh-config --host ubuntu1604 >> ~/.ssh/config
ssh ubuntu1604

# host os
touch synced_folder_test
# guest os
ls /vagrant/synced_folder_test
# https://www.vagrantup.com/docs/synced-folders/basic_usage.html
```

vagrant-bootstrap.sh

```bash
#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y vim
sudo apt-get install -y git
wget -q -O- https://bootstrap.pypa.io/get-pip.py | sudo python
sudo apt-get install -y ansible
# or sudo apt-get install -y python-dev
# and sudo pip install ansible
```

Vagrantfile-provisioning

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.provision :shell, path: "bootstrap.sh"
end

# then vagrant halt && vagrant up --provision
# or vagrant reload --provision
# https://www.vagrantup.com/docs/provisioning/
```

## ansible
- python製ssh経由でprovisioning(default)
- python2.7でも動いた
- ansible2系が出てる。騒がれてなかったからbreaking changesは少なさそう

### commands
- ansible
- ansible-playbook
- doc, galaxy, pull, vaultとは？

### ansible command
- playbookを使わない
- hostの指定が必要(port付きでも良い)

### inventory
- http://docs.ansible.com/ansible/intro_inventory.html
- default=/etc/ansible/hosts
- -i hostfilepath
- hostはgroup化できる

playbook example

```bash
cat <<EOF > ansible_hosts
[local]
localhost ansible_connection=local
EOF

ansible local -i ansible_hosts -m ping
ansible all   -i ansible_hosts -m shell -a "echo ansible shell module"
```

### ansible-playbook
- playbookを使うとき

playbook-example.yml

```yaml
-------
- hosts: 127.0.0.1
  tasks:
    - name: ping
      ping:

- hosts: local
  tasks:
    - name: shell
      shell: "echo $item"
      with_items:
        - ansible
        - playbook

# command
# ansible-playbook -i ansible_hosts playbook-example.yml
```

## install docker on ubuntu
- https://docs.docker.com/engine/installation/linux/ubuntulinux/
- 設定が思っていたよりめんどうだったので、ansible-playbookやめてbootstrap.shに追加した

docker_install_for_ubuntu.sh

```bash
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" \
   > /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get purge lxc-docker

sudo apt-get install -y linux-image-extra-$(uname -r)
sudo apt-get install -y docker.io
sudo apt-get install -y docker-engine
sudo service docker start

sudo groupadd docker
sudo usermod -aG docker vagrant
docker run hello-world # without sudo
```

## docker ecosystem
### brew serachで見つかったもの
- <del>boot2docker</del>
- docker-machine
    - Automate Docker provisioning
    - create VM
- docker
    - client
- docker-compose
    - for multi-container application
- docker-swarm
    - native clustering capabilities to turn a group of Docker engines into a single, virtual Docker Engine.

### docker toolbox
https://www.docker.com/products/docker-toolbox, docker関連いろいろ

- Docker Engine
    - Docker Engine runs on Linux to create the operating environment
- Compose
- Machine
- Kitematic
    - GUI

なんのためにubuntu用意したんだ…

#### installして使ってみた
- install時に設定を行うshell scriptを実行された
    - `/.docker/machine/machines/default/boot2docker.iso`
    - VM/SSH等の設定
    - VMはVirtualBox上では`default`という名前のメモリ2G
- `docker run hello-world` 問題なし
- 上記実行終了時に勧められた `docker run -it ubuntu bash` 問題なし
    - `uname -a`
    - `Linux 87631664c41b 4.4.8-boot2docker #1 SMP Mon Apr 25 21:57:27 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux`
- ubuntuをcentosにして実行してみても問題なし
    - unameの結果は同じ
    - ubuntuではpythonなかったが、centosではあったので中身は違う
- itermにしたと思うんだけど、kitematicのDOCKER CLIでterminalが立ち上がらない
    - なので、下記をitermで実行する
    - `bash -c "DOCKER_HOST=tcp://192.168.99.100:2376 DOCKER_CERT_PATH=~/.docker/machine/machines/default DOCKER_TLS_VERIFY=1 /bin/zsh"`
    - shell立ち上げ時に他の設定をするのか、環境変数をただ設定するだけではダメだった

### docker for mac/windows
https://blog.docker.com/2016/03/docker-for-mac-windows-beta/
>
Docker for Mac can be used at the same time as Docker Toolbox on the same machine, allowing developers to continue using Toolbox as they evaluate Docker for Mac.

- betaなのでdocker IDを登録してから使う必要がある
- 下記、使用例。toolboxと比べると便利そう
- http://paiza.hatenablog.com/entry/docker_for_mac

### その他docker関連
- cloud/hubはdocker社のProduct
- betaのときに登録するdocker IDはhubドメインで作る
- notary(https://docs.docker.com/notary/getting_started/)

## Dockerfile

docker_Dockerfile

```bash
# command: docker build -t docker-example:0.0.1 /vagrant/

# Pull base image.
FROM ubuntu:16.04

MAINTAINER ksomemo

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Ruby dependencies
RUN \
  apt-get update && \
  apt-get install -y \
    git tar gcc openssl \
    libssl-dev zlib1g-dev libyaml-dev \
    libreadline-dev libffi-dev libxml2-dev libxslt-dev

# Ruby
RUN git clone https://github.com/rbenv/ruby-build.git
RUN ./ruby-build/install.sh
RUN  ruby-build 2.3.1 /usr/local
  #apt-get update && \
  #apt-get install -y ruby2.3 ruby2.3-dev

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  #echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# serverspec
# Add files.
ADD .gemrc ~/.gemrc
ADD Gemfile Gemfile

RUN gem update --system
RUN gem install bundler
RUN bundle install

# Set environment variables.
ENV HOME /root

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Expose ports.
EXPOSE 80
EXPOSE 443

# Define default command.
CMD ["bash"]"
```

- aaa
- https://docs.docker.com/engine/reference/builder
- 参考ファイル
    - https://github.com/dockerfile/nginx/blob/master/Dockerfile
    - https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
- FROM でbaseとなるDockerfileを指定できる
    - nginxは dockerfile/ubuntu
    - ubuntuは ubuntu:14.04
    - 上記は https://hub.docker.com/r/library/ubuntu/ の14.04のこと
    - 上記は FROM scratch
- apt-get update を頻繁にする必要がある？
    - 一番最初のRUNで実行しているのに二回目のRUNで実行しないとみつからないものがある
- apt-get ruby2.3　でインストールしたrubyはruby2.3コマンドになる(gemも同様)
    - https://github.com/rbenv/ruby-build/wiki を頼った
- cacheされることを考えて、1つのRUNに押し込めないほうが試行錯誤しやすい
    - すでに完了したものをskipできて嬉しい
- Gemfileをheredocでは作成できなかったのでADDした
    - RUN <<EOF xxx EOF は今後できるようにするらしい

### docker hub
#### sign up
- id
- mail
- password

#### 自動化のための連携
- https://hub.docker.com/account/authorized-services/
- github or bitbucket account

#### cliからのlogin
- docker login (username/password)
- ~/.docker/config.json に情報が作成される

#### create repository on github
- Dockerfile
- other files
- webhook setting(Docker)

#### create automated-build on dockerhub
- https://hub.docker.com/add/automated-build/username/
- github の repositoryとの連携
- githubにpushするとdocker hubでbuildされる
    - localより結構時間かかる

#### etc.
- docker port (fowarding port)
- docker inspect (docker info json)
- docker start container (start created container)
- docker attach container (裏で実行中コンテナにshellでアクセス)
    - dettach (C-p, C-q. not C-c -> exit)
- docker commit (操作したコンテナからimage作成)

## serverspec
dockerコンテナでubuntu環境を整えられたので、コピペしてVM ubuntuでもruby環境を整える

serverspec.gemrc

```ruby
gem: --no-ri --no-rdoc
```

serverspec.Gemfile

```ruby
source 'https://rubygems.org'

gem 'rake'
gem 'serverspec'
gem 'docker-api'
```

`serverspec-init`

```
 + spec/
 + spec//sample_spec.rb
 + spec/spec_helper.rb
 + Rakefile
 + .rspec
```





## よくわかってないhashicorp tool
- https://speakerdeck.com/muziyoshiz/2015-4q-report
- http://keyamb.hatenablog.com/entry/2015/05/28/004337
- https://thinkit.co.jp/story/2015/04/13/5875
