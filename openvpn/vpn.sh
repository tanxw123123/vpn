#!/bin/bash
echo "   1) 安装/管理/卸载"
echo "   2) 创建用户"
echo "   3) 查看用户"
echo "   4) 删除所有用户"
echo "   5) 退出"
read -p "请选择：" choose
case $choose in
    1|"")
        echo "   1) 安装步骤一"
        echo "   2) 安装步骤二"
        echo "   3) 管理/卸载"
        read -p "请选择：" choose1
        case $choose1 in
            1)
                rm -rf openvpn-install.sh
                wget https://raw.githubusercontent.com/OrochW/Openvpn/main/openvpn-install.sh && bash openvpn-install.sh
            ;;
            2)
                wget -P /etc/openvpn/server https://raw.githubusercontent.com/OrochW/openvpn/main/checkpsw.sh
                chmod 755 /etc/openvpn/server/checkpsw.sh
                echo 'test test' >> /etc/openvpn/psw-file
                echo "script-security 3"  >> /etc/openvpn/server/server.conf
                echo "auth-user-pass-verify /etc/openvpn/server/checkpsw.sh via-env"  >> /etc/openvpn/server/server.conf
                echo "username-as-common-name"  >> /etc/openvpn/server/server.conf
                echo "verify-client-cert none"  >> /etc/openvpn/server/server.conf
                systemctl restart openvpn-server@server
                echo "auth-user-pass" >> *.ovpn
            ;;
            3 )
                echo "此项仅适用于卸载/管理"
                bash openvpn-install.sh
            ;;
            *)
                echo "没有符合"$choose1"的服务被执行!"
            esac
    ;;
    2 )
        read -p "请输入要创建的用户(小写)：" user
        rand_passwd=`openssl rand -base64 9`
        echo "你的用户名密码分别是"
        echo $user $rand_passwd >> /etc/openvpn/psw-file
        echo "$user $rand_passwd"
    ;;
    3 )
        cat /etc/openvpn/psw-file
    ;;
    4 )
        echo "test test" > /etc/openvpn/psw-file
        echo "已删除所有用户仅剩test test"
    ;;
    5 )
        exit 1
    ;;
esac
