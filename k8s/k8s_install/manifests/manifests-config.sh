#!/bin/bash

#然后将/usr/local/bin和/usr/local/sbin追加到~/.bashrc文件的PATH环境变量中
export PATH=$PATH:/usr/local/bin:/usr/local/sbin
#执行下面的命令使其生效
source ~/.bashrc
#containerd的默认配置文件为/etc/containerd/config.toml,我们需要生成一个默认的配置
mkdir -p /etc/containerd
#生成配置文件
containerd config default>/etc/containerd/config.toml
#修改覆盖/etc/containerd的config.toml文件
#cp /root/k8s/k8s_install/manifests/config.toml /etc/containerd
#使用原生复制命令，强制覆盖原有文件
/bin/cp /root/k8s/k8s_install/manifests/config.toml /etc/containerd

systemctl daemon-reload
systemctl enable containerd --now
ctr version
systemctl start containerd

#安装gcc编译环境防止后面编译失败
yum install -y gcc gcc-c++ autoconf pcre pcre-devel make automake 
yum install -y httpd-tools gperf
