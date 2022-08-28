#!/bin/bash

kubectl delete -f calico.yaml

ip link delete cni0
ip link delete flannel.1
rm -rf /var/lib/cni/
rm -f /etc/cni/net.d/*

