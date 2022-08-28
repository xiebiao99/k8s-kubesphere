#!/bin/bash

echo "==================1、安装python及epel==============="
#1、安装必要组件
#安装python及epel
yum install -y epel-release python-pip python34 python34-pip

echo "====================2、安装ansible=================="
#安装ansible(必须先安装 epel 源再安装 ansible)
yum install -y ansible

echo "===============3、配置ansible的hosts文件============="
cat > /etc/ansible/hosts <<EOF
[k8smaster]
192.168.66.10 hostname=k8s-master1
192.168.66.11 hostname=k8s-master2
192.168.66.12 hostname=k8s-master3

[k8sworker]
192.168.66.20 hostname=k8s-node1
192.168.66.21 hostname=k8s-node2
192.168.66.22 hostname=k8s-node3

[k8s:children]
k8smaster
k8sworker

[all:vars]
ansible_ssh_user=root
EOF
