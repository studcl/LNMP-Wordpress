#指定基础镜像为centos:centos7.9.2009
FROM centos:centos7.9.2009
MAINTAINER chenlin
#将当前目录下的init.sh脚本文件复制到镜像中的/opt/init.sh位置
COPY ./init.sh /opt/init.sh
#使用yum包管理器在镜像中安装mariadb-server软件包
RUN yum -y install mariadb-server && \
#执行前面复制进镜像的init.sh脚本
   bash /opt/init.sh
#设置了环境变量LC_ALL的值为en_US.UTF-8
ENV LC_ALL en_US.UTF-8
#容器在运行时应该监听的网络端口号
EXPOSE 3306
#设置容器启动时执行的默认命令。这里使用mysqld_safe来启动MariaDB服务，并以root用户身份运行
CMD ["mysqld_safe","--user=root"]
