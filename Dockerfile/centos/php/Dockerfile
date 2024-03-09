FROM centos:centos7.9.2009  
LABEL maintainer=chenlin  
  
# 安装依赖项  
RUN yum -y install http://down.24kplus.com/linux/oniguruma/oniguruma-6.7.0-1.el7.x86_64.rpm \  
 && yum -y install http://down.24kplus.com/linux/oniguruma/oniguruma-devel-6.7.0-1.el7.x86_64.rpm \  
 && yum -y install gcc openssl-devel libxml2-devel bzip2-devel libmcrypt-devel sqlite-devel make \  
 && yum clean all  
  
#创建nginx用户
RUN useradd -r -s /sbin/nologin nginx

# 添加PHP源代码并解压  
ADD ./php-8.3.3.tar.gz /opt/  
WORKDIR /opt/php-8.3.3  
  
# 配置和编译PHP  
RUN ./configure \  
    --prefix=/usr/local/php83 \  ##设置PHP安装后的基础目录为/usr/local/php83
    --with-config-file-path=/usr/local/php83/etc \ ##指定PHP的配置文件（php.ini）所在的目录为/usr/local/php83/etc
    --with-config-file-scan-dir=/usr/local/php83/etc/php.d \ ##定义一个目录，PHP将扫描该目录下的额外配置文件
    --enable-mysqlnd \  ##启用MySQL的原生驱动（mysqlnd）
    --with-mysqli=mysqlnd \  ##启用mysqli扩展，并设置它使用mysqlnd驱动
    --with-pdo-mysql=mysqlnd \  ##启用PDO_MYSQL扩展，并使用mysqlnd驱动来连接MySQL数据库
    --with-openssl \  ##启用OpenSSL支持
    --with-zlib \  ##启用zlib压缩支持
    --enable-mbstring \  ##启用多字节字符串（mbstring）支持
    --enable-xml \  ##启用XML支持
    --enable-sockets \  ##启用sockets支持
    --enable-fpm \  ##启用PHP FastCGI Process Manager（FPM）
    --enable-maintainer-zts \  ##启用线程安全（ZTS）模式
    --disable-fileinfo \  ##禁用fileinfo扩展，这个扩展用于获取文件的信息
    --with-fpm-user=www-data \  ##设置FPM进程运行的用户为www-data
    --with-fpm-group=www-data \ ##设置FPM进程运行的组为www-data
 && make  \  
 && make install 
  
COPY ./set-php-config.sh /opt/ 
RUN bash /opt/set-php-config.sh
  
# 暴露PHP-FPM端口  
EXPOSE 9000  
  
# 设置默认命令启动PHP-FPM
CMD ["/usr/local/php83/sbin/php-fpm","-F"]
