#!/bin/bash
#修改阈值为30，写入文件
echo 30 > /proc/sys/kernel/watchdog_thresh 
#修改阈值为30，临时生效
sysctl -w kernel.watchdog_thresh=30

#修改阈值为30，写入启动文件
grep 'watchdog_thresh' /etc/sysctl.conf
if [ $? -ne 0 ]; then
	echo "kernel.watchdog_thresh=30" >> /etc/sysctl.conf
else
	echo "正常"
fi

