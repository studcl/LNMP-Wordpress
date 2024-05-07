#指定基础镜像为centos:centos7.9.2009
FROM centos:centos7.9.2009
LABEL maintainer=chenlin
#使用yum包管理器安装编译Nginx所需的依赖项，包括gcc编译器、pcre-devel（用于正则表达式支持）、openssl-devel（用于SSL支持）、zlib-devel（用于压缩功能）和make工具
RUN yum -y install gcc pcre-devel openssl-devel zlib-devel make
#将当前目录下的nginx-1.22.1.tar.gz文件添加到镜像的/usr/local/src/目录中并自动解压
ADD ./nginx-1.22.1.tar.gz /usr/local/src/
#设置工作目录为/usr/local/src/nginx-1.22.1/，即Nginx源代码解压后的目录
WORKDIR /usr/local/src/nginx-1.22.1/
#运行Nginx的configure脚本来配置编译选项
RUN ./configure --prefix=/usr/local/nginx \  
--user=nginx \  
--group=nginx \
--with-http_ssl_module \ 
--with-http_v2_module \ 
--with-http_realip_module \ 
--with-http_stub_status_module \ 
--with-http_gzip_static_module \ 
--with-pcre \ 
--with-stream \ 
--with-stream_ssl_module \ 
--with-stream_realip_module && \
#调用make命令来编译Nginx
make && \ 
#调用make install命令来安装Nginx到之前通过--prefix指定的目录
make install && \ 
#添加一个名为nginx的系统组，然后创建一个属于这个组的同名系统用户
groupadd -r nginx && \  
useradd -r -g nginx nginx
#更改配置文件
COPY ./nginx.conf /usr/local/nginx/conf/nginx.conf
#输出日志
RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log && ln -sf /dev/stderr /usr/local/nginx/logs/error.log
#声明容器在运行时应该监听的网络端口号
EXPOSE 80
#设置容器启动时执行的默认命令。这里使用Nginx的可执行文件来启动Nginx服务，并通过-g选项设置Nginx不以守护进程模式运行（即在前台运行）
CMD ["/usr/local/nginx/sbin/nginx","-g","daemon off;"]
