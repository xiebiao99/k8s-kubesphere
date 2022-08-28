#!/bin/bash

swapoff -a
kubeadm reset
rm /etc/cni/net.d/* -f
#设置k8s开机自启动
systemctl daemon-reload
systemctl restart kubelet
systemctl enable kubelet.service && systemctl start kubelet && systemctl enable kubelet
#设置docker开机自启动
systemctl daemon-reload && systemctl restart docker && systemctl enable docker --now

iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X 
rm -rf $HOME/.kube
sh ../manifests/manifests-config.sh
