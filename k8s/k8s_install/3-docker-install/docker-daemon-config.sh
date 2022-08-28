#!/bin/bash

#1、配置daemon
#启动Docker并设置为开机自启
systemctl start docker && systemctl enable docker

#查看系统内核
uname -r

#配置daemon
cat > /etc/docker/daemon.json <<EOF 
{
  "registry-mirrors":["https://registry.docker-cn.com","https://kxv08zer.mirror.aliyuncs.com"],
  "exec-opts":["native.cgroupdriver=systemd"],
  "log-driver":"json-file",
  "log-opts":{
    "max-size":"100m"
  }
}
EOF

#创建存储Docker配置文件的目录
mkdir -p /etc/systemd/system/docker.service.d

#重新读取配置文件并重启Docker
systemctl daemon-reload && systemctl restart docker && systemctl enable docker
