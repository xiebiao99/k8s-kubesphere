#!/bin/bash

echo "===================1、安装expect==================="

#安装expect
#注意: 必须安装expect,不然执行不了local_copy_ssh_to_host.sh脚本中的expect命令
yum install expect -y

##2、执行批量复制公匙到其他服务器主机的脚本
#记得先执行这条命令生成公匙，如果已经生成过可忽略，没有就执行下面命令:
#ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa &> /dev/null
#或者
#ssh-keygen -t rsa
#按三次回车，一路回车即可生成密钥
echo "================2、生成公钥ssh-keygen================"
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa &> /dev/null
#ssh-keygen -t rsa

echo "================3、查看生成的公钥为:=================
$(cat ~/.ssh/id_rsa.pub)"

echo "=========4、设置ssh连接,否则批量复制公匙到其他服务器主机的时候会报错========="
#设置ssh连接,否则会报错:The authenticity of host can't be established
cat >> /etc/ssh/ssh_config << EOF
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
EOF

#执行批量复制公匙到其他服务器主机的脚本
echo "========5、执行批量复制公匙到其他服务器主机的脚本======="
source ./4-local_copy_ssh_to_host.sh
