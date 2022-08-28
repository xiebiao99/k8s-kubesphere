#!/bin/bash

chmod a+x /root/k8s/k8s_install/scp-file.sh
#1-system-init
chmod a+x /root/k8s/k8s_install/1-system-init/1-system-init.sh 
chmod a+x /root/k8s/k8s_install/1-system-init/2-system-init.sh
chmod a+x /root/k8s/k8s_install/1-system-init/source/*
#3-docker-install
chmod a+x /root/k8s/k8s_install/3-docker-install/*
#4-k8s-install
chmod a+x /root/k8s/k8s_install/4-k8s-install/*
#5-calico
chmod a+x /root/k8s/k8s_install/5-calico/delete-calico.sh
#6-kubesphere
chmod a+x /root/k8s/k8s_install/6-kubesphere/kubekey/before-kubekey-install.sh
chmod a+x /root/k8s/k8s_install/6-kubesphere/kubekey/resolve_cpu_bug.sh
#manifests
chmod a+x /root/k8s/k8s_install/manifests/manifests-config.sh  
chmod a+x /root/k8s/k8s_install/manifests/kube-vip-config.sh
#flannel
chmod a+x /root/k8s/k8s_install/flannel/delete-flannel.sh
