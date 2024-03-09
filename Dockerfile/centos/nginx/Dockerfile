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
RUN ./configure --prefix=/usr/local/nginx \  ##指定了Nginx安装后的基础目录
--user=nginx \  ##设置运行Nginx工作进程的用户为nginx
--group=nginx \ ##设置运行Nginx工作进程的组为nginx
--with-http_ssl_module \ ##启用HTTP SSL模块，使得Nginx能够支持HTTPS协议
--with-http_v2_module \ ##启用HTTP/2模块，允许Nginx支持HTTP/2协议
--with-http_realip_module \ ##启用HTTP真实IP模块，该模块允许Nginx从请求头中获取并设置真实的客户端IP地址
--with-http_stub_status_module \ ##启用一个用于获取Nginx状态信息的模块
--with-http_gzip_static_module \ ##启用静态gzip压缩模块
--with-pcre \ ##启用PCRE（Perl Compatible Regular Expressions）库的支持，使得Nginx能够使用正则表达式处理请求
--with-stream \ ##启用TCP/UDP代理模块，使得Nginx能够处理非HTTP的TCP和UDP流量
--with-stream_ssl_module \ ##在启用了stream模块的基础上，这个选项允许Nginx处理通过SSL加密的TCP/UDP连接
--with-stream_realip_module ##允许Nginx在TCP/UDP代理场景下获取并设置真实的客户端IP地址
#调用make命令来编译Nginx
RUN make 
#调用make install命令来安装Nginx到之前通过--prefix指定的目录
RUN make install
#添加一个名为nginx的系统组，然后创建一个属于这个组的同名系统用户
RUN groupadd -r nginx && \  
    useradd -r -g nginx nginx
#声明容器在运行时应该监听的网络端口号
EXPOSE 80
#设置容器启动时执行的默认命令。这里使用Nginx的可执行文件来启动Nginx服务，并通过-g选项设置Nginx不以守护进程模式运行（即在前台运行）
CMD ["/usr/local/nginx/sbin/nginx","-g","daemon off;"]

