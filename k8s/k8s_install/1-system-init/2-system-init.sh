#!/bin/bash

echo "===================1、升级yum==================="
#升级yum
yum update -y
echo "===================2、设置免密登录==================="
sh /root/k8s/k8s_install/1-system-init/source/3-set-keylogin.sh
#执行批量复制公匙到其他服务器主机的脚本
echo "========3、执行批量复制公匙到其他服务器主机的脚本======="
sh /root/k8s/k8s_install/1-system-init/source/4-local_copy_ssh_to_host.sh
echo "========4、安装ansible======="
sh /root/k8s/k8s_install/1-system-init/source/5-ansible-config.sh
echo "========5、进一步初始化======="
sh /root/k8s/k8s_install/1-system-init/source/6-system-init-all.sh
