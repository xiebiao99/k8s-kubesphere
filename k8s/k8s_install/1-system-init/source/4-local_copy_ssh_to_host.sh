#!/bin/bash

#批量复制公匙到服务器
#记得先执行这条命令生成公匙：ssh-keygen
password=xb123?

for j in {10,11,12,20,21,22}
  do
    expect <<-EOF
    set timeout 5
    spawn ssh-copy-id -i root@192.168.66.$j
    expect {
    "password:" { send "$password\n" }
    }
  interact
  expect eof
EOF
done
