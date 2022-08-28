#!/bin/bash

echo "==================1.备份yum.repo源=================="
sh /root/k8s/k8s_install/1-system-init/source/1-backup-yum-repo.sh

echo "==================2.升级系统内核=================="
sh /root/k8s/k8s_install/1-system-init/source/2-update-kernel.sh
