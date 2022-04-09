用zerotier实现内网穿透：  
# 1. 官网注册账号，创建自己的局域网网段  
<https://www.zerotier.com/>  
1. Create A Network  
2. 点击创建好的网络，进入设置界面设置  
```
Acess Control：  
PRIVATE：客户端加入网络，需要手动确认是否允许加入。  
PUBLIC：客户端加入网络，不需要手动确认，会自动加入到网络中。  
为了安全，我这里建议采用PRIVATE的方式！  
```
```
IPv4 Auto-Assign:
可以采用Easy选择局域网网段
也可以选择Advanced，自定义局域网网段。
```
我这里自定义192.168.10.0/24作为内网网段。  
![avatar](https://raw.githubusercontent.com/tanxw123123/vpn/master/zerotier/img/zt-01.jpg)  
![avatar](https://raw.githubusercontent.com/tanxw123123/vpn/master/zerotier/img/zt-02.jpg)  
# 2. 客户端加入网络
1. linux客户端：  
```
$ curl -s https://install.zerotier.com | sudo bash
$ zerotier-cli join 网络ID
```
2. windows客户端：  
下载客户端：<https://www.zerotier.com/download/>  
加入网络：  
![avatar](https://raw.githubusercontent.com/tanxw123123/vpn/master/zerotier/img/zt-03.jpg)   
# 3. 配置路由
上面的配置已经实现了内网之间的通信！但是如果客户端想要访问公司内网的所有服务器，那就需要在所有的服务器上面安装zerotier客户端，这很不方便。所以我们需要配置路由转发规则！   
1. 通过iptables防火墙的nat伪装  
拿一台linux作为网关设备，去访问公司内网  
- 首先，安装zerotier客户端  
- 加入创建的网络
```
配置iptables规则：
# apt-get install iptables 
# iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE   # ens5为这台网关机器的网卡

保存规则
# apt install iptables-persistent
# netfilter-persistent  save
```
后台配置路由转发规则：  
![avatar](https://raw.githubusercontent.com/tanxw123123/vpn/master/zerotier/img/zt-04.jpg)  
192.168.10.1是网关设备分配的局域网ip地址  
10.0.0.0/16是要访问的内网资源  

但是nat伪装有个缺点，访问资源看到的源地址是这台网关设备的ip，不好溯源访问源地址。  

2. 通过配置路由方式  
我这里举例通过ZT访问aws的内网资源,还是拿一台linux机器作为网关设备  
- aws内网资源： 10.0.0.0/16  
- linux网关机器：  aws内网随便一台机器  
网关机器配置：  
- 安装zerotier客户端  
- 加入创建的网络  
```
开启内核转发功能：
# vim /etc/sysctl.conf
net.ipv4.ip_forward=1
# sysctl -p    #生效配置
```
后台配置路由规则：  
![avatar](https://raw.githubusercontent.com/tanxw123123/vpn/master/zerotier/img/zt-04.jpg)  
这条规则是，本地网络通过网关设备的 192.168.10.1 到 aws内网 的路由，我们还需要从aws到本地网络的路由，在下面配置  

在AWS中，执行操作如下：  
```
从 ec2 实例的操作菜单中禁用 ZT 网关实例的源/目标检查。  

- 登录到您的 AWS 账户后，转到Services->EC2->Instances
- 选择充当 ZeroTier 网关的实例，然后选择 Actions- >Networking->Change Source/Dest Check
- 如果启用则禁用设置（默认为启用）
```
```
添加路由以通过充当 ZeroTier 网关的设备将流量发送到您的本地网络。
- 登录到您的 AWS 账户后，转到Services->VPC->Route Tables
- 选择要更改的路由，然后选择Actions->Edit routes
```
![avatar](https://raw.githubusercontent.com/tanxw123123/vpn/master/zerotier/img/zt-05.jpg)  
选择实例为网关这台机器  
```
最后，aws内网资源安全组加白局域网网段 192.168.10.0/24，允许局域网访问。
```



