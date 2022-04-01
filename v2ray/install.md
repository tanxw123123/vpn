# 一键安装脚本
```
bash <(curl -s -L https://git.io/v2ray-setup.sh)
```
放开tcp 8888 端口  
# 配置命令
```
v2ray info 查看 V2Ray 配置信息
v2ray config 修改 V2Ray 配置
v2ray link 生成 V2Ray 配置文件链接
v2ray infolink 生成 V2Ray 配置信息链接
v2ray qr 生成 V2Ray 配置二维码链接
v2ray ss 修改 Shadowsocks 配置
v2ray ssinfo 查看 Shadowsocks 配置信息
v2ray ssqr 生成 Shadowsocks 配置二维码链接
v2ray status 查看 V2Ray 运行状态
v2ray start 启动 V2Ray
v2ray stop 停止 V2Ray
v2ray restart 重启 V2Ray
v2ray log 查看 V2Ray 运行日志
v2ray update 更新 V2Ray
v2ray update.sh 更新 V2Ray 管理脚本
v2ray uninstall 卸载 V2Ray
```
# 下载客户端
1. windows：  
<https://github.com/2dust/v2rayN/releases/download/3.29/v2rayN.zip>   
<https://github.com/v2fly/v2ray-core/releases/download/v4.31.0/v2ray-windows-64.zip>  
对v2ray-windows-64.zip 和 v2rayN.zip 进行解压，然后将 v2rayN 目录下所有文件复制到v2ray-windows-64解压后的目录，即两个下载好的文件需要在同一目录。  
【【【点击v2rayN.exe启动】】】 

2. mac：  
<https://github.com/Cenmrev/V2RayX/releases>  

# 配置客户端
1. windows：  
复制vmess链接，Ctrl + v导入，修改参数设置如下：  
本地监听端口1080，仅开启http代理,开启Mux多路复用  
![avatar](https://raw.githubusercontent.com/tanxw123123/vpn/master/v2ray/img/v2-01.jpg)  

# 配置浏览器代理（推荐google浏览器）
1. 安装google浏览器插件：Proxy SwitchyOmega  
<https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif>  

2. 配置插件：  

![avatar](https://raw.githubusercontent.com/tanxw123123/vpn/master/v2ray/img/v2-02.jpg)  

