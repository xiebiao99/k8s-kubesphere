#!/bin/bash

echo "==================1.1：设置kube-vip，只在3台master机器上之执行,这里先在k8s-master1上执行================="
#注意: 设置kube-vip，只在3台master机器上之执行,这里先在k8s-master1上执行，k8s-master2、k8s-master3要在join k8s集群之后才能执行(设置kube-vip)，否则会报错
mkdir -p /etc/kubernetes/manifests/
export VIP=192.168.66.100
export INTERFACE=ens33
#docker版
ctr image pull docker.io/plndr/kube-vip:v0.3.8
#生成配置文件
ctr run --rm --net-host docker.io/plndr/kube-vip:v0.3.8 vip \
/kube-vip manifest pod \
--interface $INTERFACE \
--vip $VIP \
--controlplane \
--services \
--arp \
--leaderElection | tee  /etc/kubernetes/manifests/kube-vip.yaml
