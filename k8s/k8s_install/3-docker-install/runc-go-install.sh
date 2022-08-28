#!/bin/bash

#安装epel库
yum install epepl -y
#安装golang
yum install go -y
#验证golang
go version

#添加如下内容,在文件末尾追加内容
cat >> ~/.bash_profile <<EOF 
export GOROOT=/usr/lib/golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin
EOF
#让环境变量生效：
source ~/.bash_profile
#验证go环境变量
go env
#重启
reboot
