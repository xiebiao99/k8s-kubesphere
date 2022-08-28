#!/bin/bash

#安装Kubeadm(主从配置)并且添加阿里与yum源
#添加阿里与yum源
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes] 
name=Kubernetes 
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1 
gpgcheck=0 
repo_gpgcheck=0 
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg 
https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

#安装指定版本的kubeadm，kubelet和kubectl
yum install -y kubelet-1.21.5-0 kubeadm-1.21.5-0 kubectl-1.21.5-0 --disableexcludes=kubernetes
#--disableexcludes 禁掉除了kubernetes之外的别的仓库 

#开机启动
systemctl enable kubelet.service && systemctl start kubelet && systemctl enable kubelet 
#关闭开机启动
#systemctl disable kubelet.service && systemctl stop kubelet && systemctl disable kubelet  

#查看kubelet的状态
systemctl status kubelet

#查看kubelet版本：
kubelet --version
kubeadm version
