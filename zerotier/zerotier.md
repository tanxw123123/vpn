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

