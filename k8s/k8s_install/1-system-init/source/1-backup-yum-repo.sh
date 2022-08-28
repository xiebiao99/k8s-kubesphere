#!/bin/bash

#下载必要组件
yum install -y conntrack ntpdate ntp ipvsadm ipset jq iptables curl sysstatlibseccomp wget vim net-tools git

#备份
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

#下载yum.repo源
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo #CentOS 7

#生成缓存
yum clean all
yum makecache fast
