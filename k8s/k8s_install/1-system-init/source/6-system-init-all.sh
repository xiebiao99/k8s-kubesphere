#!/bin/bash

#1、系统初始化
echo "==================1.1：安装依赖包================="

echo "========当前系统的内核版本为:$(uname -r)========"
#安装依赖包和必备组件
yum install -y ntpdate ntp conntrack ipvsadm ipset jq iptables curl sysstat libseccomp wget vim net-tools git

echo "=================1.2：关闭防火墙================="
#关闭防火墙： 或者阿里云开通安全组端口访问
systemctl stop firewalld
systemctl disable firewalld

echo "=======1.3：设置防火墙为lptables并设置空规则======="
#设置防火墙为lptables并设置空规则
yum -y install iptables-services && systemctl start iptables && systemctl enable iptables && iptables -F && service iptables save

echo "================1.4：关闭swap分区和selinux================"
# 关闭swap 在所有的节点上 包括主节点和woker节点
# 切记一定要关闭 不然 kubelet启动失败 血的教训
swapoff -a
# 禁止swap开机启动
sed -i '/swap/s/^\(.*\)$/#\1/g' /etc/fstab
#查看swap分区
echo "================查看swap分区===============
$(free -m)"

# 关闭selinux
setenforce 0
sed -i 's#SELINUX=enforcing#SELINUX=disabled#g' /etc/sysconfig/selinux
sed -i 's#SELINUX=enforcing#SELINUX=disabled#g' /etc/selinux/config
getenforce ##检查selinux状态

# 关闭dnsmasq(否则可能导致docker容器无法解析域名)
systemctl stop dnsmasq && systemctl disable dnsmasq

echo "=================1.5：同步时间=================="
#时间同步
yum install ntpdate -y ntpdate time.windows.com

#设置系统时区为中国/上海
timedatectl set-timezone Asia/Shanghai
#将当前的UTC时间写入硬件时钟
timedatectl set-local-rtc 0
#重启依赖于系统时间的服务
systemctl restart rsyslog
systemctl restart crond

echo "==============1.6：关闭系统不需要服务============="
#关闭系统不需要服务
systemctl stop postfix && systemctl disable postfix
#关闭系统不需要服务
systemctl stop postfix && systemctl disable postfix
echo "==============1.7：持久化保存日志的目录============="
#设置rsyslogd和systemd journald

#持久化保存日志的目录
mkdir /var/log/journal 

mkdir /etc/systemd/journald.conf.d

cat > /etc/systemd/journald.conf.d/99-prophet.conf <<EOF
[Journal]

#持久化保存到磁盘
Storage=persistent

#压缩历史日志
Compress=yes

SyncIntervalSec=5m
RateLimitInterval=30s
RateLimitBurst=1000

#最大占用空间10G
SystemMaxUse=10G

#单日志文件最大200N
SystemMaxFilesize=280M

#日志保存时间2周
MaxRetentionSec=2week

#不将日志转发到
syslogForwardToSyslog=no
EOF

systemctl restart systemd-journald

echo "================1.8：设置流量转发================="
#设置流量转发
#将桥接的 IPv4 流量传递到 iptables 的链：
# 修改 /etc/sysctl.conf
#设置流量转发
#由于开启内核 ipv4 转发需要加载 br_netfilter 模块，所以加载下该模块
modprobe br_netfilter

cat > /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1 
net.bridge.bridge-nf-call-iptables = 1 
net.ipv4.ip_forward = 1
vm.swappiness = 0 
EOF

echo "=============查看流量转发配置$(cat /etc/sysctl.d/kubernetes.conf)============="
# 执行命令以应用
sysctl --system
sysctl -p /etc/sysctl.d/k8s.conf  #手动刷新，并让其立即生效 

echo "================1.9：kube-proxy开启ipvs的前置条件================="
#前提:kube-proxy开启ipvs的前置条件
modprobe br_netfilter
modprobe ip_conntrack
#注意：新版的5.xx版本的nf_conntrack_ipv4已经改为nf_conntrack了
cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack
EOF

#赋予该文件755权限并执行该文件，然后使用lsmod命令查看这些文件是否被引导
#注意：新版的5.xx版本的nf_conntrack_ipv4已经改为nf_conntrack了
chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack
#增加这两行，防止后面报错
echo "1">/proc/sys/net/bridge/bridge-nf-call-iptables
echo "1">/proc/sys/net/bridge/bridge-nf-call-ip6tables
echo "=============查看ipvs的前置条件配置$(cat /etc/sysconfig/modules/ipvs.modules)============="

echo "==============1.10：安装 Containerd============="
#前提
yum install ipset
yum install ipvsadm
