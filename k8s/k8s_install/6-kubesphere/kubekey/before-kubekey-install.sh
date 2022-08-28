#!/bin/bash
#安装必要组件
yum install -y socat conntrack ebtables ipset 
yum -y install lrzsz
#时间同步
yum install ntpdate -y ntpdate time.windows.#设置系统时区为中国/上海
timedatectl set-timezone Asia/Shanghai
yum install ipset
yum install ipvsadm 
yum install chrony -y 
systemctl enable chronyd 
systemctl start chronyd 
chronyc sources
#将当前的UTC时间写入硬件时钟
timedatectl set-local-rtc 0
#重启依赖于系统时间的服务
systemctl restart rsyslog
systemctl restart crond

#配置glusterfs的yum源,所有k8s节点操作
cat > /etc/yum.repos.d/glusterfs.repo << EOF
[glusterfs]
name=glusterfs
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7.9.2009/storage/x86_64/gluster-9/
#gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos/RPM-GPG-KEY-CentOS-7
gpgcheck=0
ebabled=1
EOF

#配置docker的yum源,阿里云加速
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

yum clean all
yum makecache fast

#重新读取配置文件并重启Docker
systemctl daemon-reload && systemctl restart docker

#安装glusterfs客户端以确保k8s可以正常使用动态存储功能,所有k8s节点操作
yum install -y glusterfs-fuse
