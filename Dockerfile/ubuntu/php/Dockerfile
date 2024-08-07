FROM ubuntu:22.04
LABEL maintainer=chenlin
# 安装依赖项  
RUN apt-get update && apt-get install -y \  
    gcc \  
    libssl-dev \  
    libxml2-dev \  
    libbz2-dev \  
    libsqlite3-dev \  
    libonig-dev \  
    make \  
    pkg-config \
    zlib1g-dev && \
#创建nginx用户
    useradd -r -s /sbin/nologin nginx

# 添加PHP源代码并解压  
ADD ./php-8.3.3.tar.gz /opt/  
WORKDIR /opt/php-8.3.3  
  
# 配置和编译PHP  
RUN ./configure \  
    --prefix=/usr/local/php83 \  
    --with-config-file-path=/usr/local/php83/etc \ 
    --with-config-file-scan-dir=/usr/local/php83/etc/php.d \ 
    --enable-mysqlnd \  
    --with-mysqli=mysqlnd \  
    --with-pdo-mysql=mysqlnd \  
    --with-openssl \  
    --with-zlib \  
    --enable-mbstring \  
    --enable-xml \  
    --enable-sockets \  
    --enable-fpm \  
    --enable-maintainer-zts \  
    --disable-fileinfo \  
    --with-fpm-user=www-data \  
    --with-fpm-group=www-data \ 
 && make  \  
 && make install 
  
COPY ./set-php-config.sh /opt/ 
RUN bash /opt/set-php-config.sh && \
    apt-get clean -y && \
    rm -rf /var/lib/apt
  
# 暴露PHP-FPM端口  
EXPOSE 9000  
  
# 设置默认命令启动PHP-FPM
CMD ["/usr/local/php83/sbin/php-fpm","-F"]
