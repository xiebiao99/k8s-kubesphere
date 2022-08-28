#!/bin/bash

echo "==================1.升级系统内核=================="
#注意:由于3.xx系列的系统内核安装docker和k8s会不稳定，有很多bug，所以在整个安装过程中会有两次系统内核的设置

#导入公钥
#rpm -Uvh http://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
#安装ELRepo
yum install -y https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
#安装完成后检查/boot/grub2/grub.cfg 中对应内核menuentry中是否包含 initrd16配置，如果有，再安装—次!
#启用ELRepo源仓库
yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
#安装指定版本的系统内核，这里装的是最新版本
yum --enablerepo=elrepo-kernel install -y kernel-lt
echo "========当前系统的内核版本为:$(uname -r)========"

echo "===============2.设置开机从新内核启动==============="
#设置开机从新内核启动,修改默认启动项，这里的0代表的是第一个内核，第x个内核这里就填x-1
grub2-set-default 0
#最重要的一步，重新创建内核配置-更新grub.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg
#查看内核修改结果
grub2-editenv list
#先查看所有可用内核
cat /boot/grub2/grub.cfg |grep ^menuentry
#重启
reboot
