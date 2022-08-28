#!/bin/bash

#安装Docker -CE
yum install -y yum-utils device-mapper-persistent-data lvm2

#导入阿里云的docker-ce仓库
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# 设置docker repo的yum位置,添加仓库源，用这个
#yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

#安装docker
yum install -y docker-ce docker-ce-cli containerd.io

#设置开机从新内核启动,修改默认启动项，这里的0代表的是第一个内核，第x个内核这里就填x-1
grub2-set-default 0
#最重要的一步，重新创建内核配置-更新grub.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg
#查看内核修改结果
grub2-editenv list
#先查看所有可用内核
cat /boot/grub2/grub.cfg |grep ^menuentry
