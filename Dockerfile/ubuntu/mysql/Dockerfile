#指定基础镜像为Ubuntu 22.04
FROM ubuntu:22.04
LABEL maintainer=chenlin
#将当前目录下的init.sh文件复制到镜像的/opt/目录下
COPY ./init.sh /opt/
#设置了工作目录为/opt/
WORKDIR /opt/
#更新Ubuntu的软件包列表
RUN apt-get update
#安装一系列软件包
RUN apt-get install wget software-properties-common dirmngr ca-certificates apt-transport-https -y
#安装MariaDB的服务器和客户端并执行init.sh脚本
RUN apt-get install -y mariadb-server mariadb-client&& bash /opt/init.sh
#将当前目录下的50-server.cnf文件复制到镜像的/etc/mysql/mariadb.conf.d/目录下，开启远程访问
COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
#Docker在运行时暴露3306端口
EXPOSE 3306
#设置容器启动后要执行的命令，mysqld_safe是一个启动MariaDB服务器的脚本，--user=root指定了MariaDB以root用户身份运行
CMD ["mysqld_safe","--user=root"]
