#!/bin/bash

#复制文件到其他主机
scp -r /root/k8s root@k8s-node1:/root/
scp -r /root/k8s root@k8s-node2:/root/
