#!/bin/bash

source /tools/config.sh

if [ -f /usr/local/bin/docker-compose ];then
    docker-compose -v &>/dev/null
    if [ $? -ne 0 ];then
      mv /usr/local/bin/docker-compose /usr/local/bin/$time
    else
    read -p "docker-compose已存在回车后继续安装,(原文件将会被备份)："
      mv /usr/local/bin/docker-compose /usr/local/bin/$time
    fi

fi


case $(uname -m) in
x86_64)
  case $1 in
  2.23.3)
  wget -P /usr/local/bin/ ${docker_compose_download_urls[$2]}
  cd /usr/local/bin/  && mv docker-compose-linux-x86_64 docker-compose && chmod +x docker-compose
  command -v docker-compose &>/dev/null
  [ $? -ne 0 ] && echo "export PATH=$PATH:/usr/local/bin/" >>/etc/profile
  docker-compose -v &>/dev/null
  if [ $? -eq 0 ];then
  echo -e "${green}安装完成${plain}"
  else
  echo -e "${red}安装失败${plain}"
  fi
  ;;
  *)
    echo "暂时不支持的版本"
  ;;
  esac
;;
*)
  echo "暂时不支持`uname -m`架构"
  ;;
esac
read -p "回车后返回主菜单："
