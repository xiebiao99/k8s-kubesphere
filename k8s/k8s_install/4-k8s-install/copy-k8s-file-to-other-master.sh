#!/bin/bash

echo "=============6.1：复制到k8s-master2节点============="
scp /etc/kubernetes/pki/ca.* root@k8s-master2:/etc/kubernetes/pki/
scp /etc/kubernetes/pki/sa.* root@k8s-master2:/etc/kubernetes/pki/
scp /etc/kubernetes/pki/front-proxy-ca.* root@k8s-master2:/etc/kubernetes/pki/
scp /etc/kubernetes/pki/etcd/ca.* root@k8s-master2:/etc/kubernetes/pki/etcd/
scp /etc/kubernetes/admin.conf root@k8s-master2:/etc/kubernetes/

echo "=============6.1：复制到k8s-master3节点============="
scp /etc/kubernetes/pki/ca.* root@k8s-master3:/etc/kubernetes/pki/
scp /etc/kubernetes/pki/sa.* root@k8s-master3:/etc/kubernetes/pki/
scp /etc/kubernetes/pki/front-proxy-ca.* root@k8s-master3:/etc/kubernetes/pki/
scp /etc/kubernetes/pki/etcd/ca.* root@k8s-master3:/etc/kubernetes/pki/etcd/
scp /etc/kubernetes/admin.conf root@k8s-master3:/etc/kubernetes/

echo "=============6.1：复制到k8s-node节点============="
scp /etc/kubernetes/admin.conf root@k8s-node1:/etc/kubernetes/
scp /etc/kubernetes/admin.conf root@k8s-node2:/etc/kubernetes/
scp /etc/kubernetes/admin.conf root@k8s-node3:/etc/kubernetes/

scp /root/.kube/config root@k8s-node1:/root/.kube/
scp /root/.kube/config root@k8s-node2:/root/.kube/
scp /root/.kube/config root@k8s-node3:/root/.kube/
 