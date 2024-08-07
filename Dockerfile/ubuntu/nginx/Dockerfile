#指定了基础镜像为Ubuntu 22.04
FROM ubuntu:22.04
LABEL maintainer=chenlin
#更新Ubuntu的软件包列表
RUN apt-get update -y && \
#安装Nginx软件包
    apt-get install -y nginx && \
#创建了一个名为nginx的系统组，然后创建一个名为nginx的系统用户，并将该用户添加到nginx组中
    groupadd -r nginx && \  
    useradd -r -g nginx nginx && \
    apt-get clean -y && \
    rm -rf /var/lib/apt
#将当前目录下的nginx.conf文件复制到镜像的/etc/nginx/目录下，替换Nginx的默认配置文件
COPY ./nginx.conf /etc/nginx/nginx.conf
#将Nginx日志直接输出到标准输出\错误中
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log
#在容器运行时，80端口应被暴露
EXPOSE 80
#设置Nginx在启动时不会后台运行
CMD ["nginx","-g","daemon off;"]
