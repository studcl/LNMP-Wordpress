# LNMP架构的搭建及应用部署

**LNMP架构**

LNMP是指一组通常一起使用来运行动态网站或者服务器的自由软件名称首字母缩写。L指Linux，N指Nginx，M一般指MySQL，也可以指MariaDB，P一般指PHP，也可以指Perl或Python。

## **1. LNMP介绍**

LNMP代表的就是：Linux系统下Nginx+MySQL+PHP这种网站服务器架构。

Linux是一类Unix计算机操作系统的统称，是目前最流行的免费操作系统。代表版本有：debian、centos、ubuntu、fedora、gentoo等。

Nginx (engine x) 是一个高性能的HTTP和反向代理web服务器，同时也提供了IMAP/POP3/SMTP服务。其特点是占有内存少，并发能力强，事实上nginx的并发能力在同类型的网页服务器中表现较好

MySQL是一种开放源代码的关系型数据库管理系统(RDBMS)，使用最常用的数据库管理语言--结构化查询语言(SQL)进行数据库管理。MySQL不仅是开放源代码的，也因为其速度、可靠性和适应性而备受关注。大多数人都认为在不需要事务化处理的情况下，MySQL是管理内容最好的选择。

PHP即“超文本预处理器”，是一种通用开源脚本语言。PHP是在服务器端执行的脚本语言，与C语言类似，是常用的网站编程语言。因为PHP的开源性、免费性、快捷性等特点使其成为目前最流行的编程语言。
![image](https://github.com/studcl/LNMP-Wordpress/blob/master/image-20240309202102789.png)
第一步：用户在浏览器输入域名或者IP访问网站

第二步：用户在访问网站的时候，向web服务器发出http request请求，服务器响应并处理web请求，返回静态网页资源，如CSS、picture、video等，然后缓存在用户主机上。

第三步：服务器调用动态资源，PHP脚本调用fastCGI传输给php-fpm，然后php-fpm调用PHP解释器进程解析PHP脚本。

第四步：出现大流量高并发情况，PHP解析器也可以开启多进程处理高并发，将解析后的脚本返回给php-fpm，然后php-fpm再调给fast-cgi将脚本解析信息传送给nginx，服务器再通过http response传送给用户浏览器。

第五步：浏览器再将服务器传送的信息进行解析与渲染，呈现给用户。
## 2.**实战部署LNMP架构**

```
git clonehttps://github.com/studcl/LNMP-Wordpress.git
./
├── centos
│   ├── data
│   │   ├── index.html
│   │   ├── test.php
│   │   └── wordpress-6.4.3-zh_CN.tar.gz
│   ├── docker-compose.yaml
│   ├── mysql
│   │   ├── Dockerfile
│   │   └── init.sh
│   ├── nginx
│   │   ├── Dockerfile
│   │   ├── nginx-1.22.1.tar.gz
│   │   └── nginx.conf
│   └── php
│       ├── Dockerfile
│       ├── php-8.3.3.tar.gz
│       └── set-php-config.sh
└── ubuntu  ##ubuntu还在开发中......
    ├── mysql
    │   ├── Dockerfile
    │   └── init.sh
    ├── nginx
    │   └── Dockerfile
    └── php
        └── Dockerfile
##依次构建MYSQL、Nginx、php镜像
```

## 3.基于镜像部署Wordpress

```
version: '3'
services:
  php:
    container_name: php-wordpress
    image: php-test:1.0 ##根据镜像名字修改
    ports:
      - 9001:9000 ##根据个人情况修改端口
    networks:
      - wordpress
    volumes:
      - /root/Dockerfile/centos/data/wordpress/:/data/wordpress/ ##根据实际情况修改
  nginx:
    container_name: nginx-wordpress
    image: nginx-test:1.0 ##根据镜像名字修改
    ports:
      - 8066:80 ##根据个人情况修改端口
    volumes:
      -  /root/Dockerfile/centos/nginx/nginx.conf:/usr/local/nginx/conf/nginx.conf ##根据实际情况修改
      - /root/Dockerfile/centos/data/wordpress/:/data/wordpress/ ##根据实际情况修改
    depends_on:
      - php
    networks:
      - wordpress
  mysql:
    container_name: mysql-wordpress
    image: mysql-test:1.0 ##根据镜像名字修改
    ports: 
      - 3311:3306 ##根据个人情况修改端口
    networks:
      - wordpress
networks:
  wordpress:


[root@master nginx]# cat nginx.conf 
user  nobody;  
worker_processes  1;  
  
# 注释掉错误日志记录，如果需要记录，请取消注释并选择相应的日志级别  
  error_log  logs/error.log;  
  error_log  logs/error.log  notice;  
  error_log  logs/error.log  info;  
  
# PID 文件的位置  
# pid        logs/nginx.pid;  
  
events {  
    worker_connections  1024;  
}  
  
http {  
    include       mime.types;  
    default_type  application/octet-stream;  
  
    # 开启高效文件传输模式  
    sendfile        on;  
  
    # 保持连接超时时间  
    keepalive_timeout  65;  
  
    # 定义一个 server，监听 80 端口，server_name 为 localhost  
    server {  
        listen       80;  
        server_name  localhost;  
  
        # 定义根目录和默认索引文件  
        location / {  
            root   /data/wordpress;  # 指定 WordPress 目录  
            index  index.php index.html index.htm;  # 指定默认主页  
        }  
  
        # 错误页面配置  
        error_page   500 502 503 504  /50x.html;  
        location = /50x.html {  
            root   html;  
        }  
  
        # PHP 脚本处理配置  
        location ~ \.php$ {  
            root           /data/wordpress;  
            fastcgi_pass   192.168.199.10:9001;  # PHP-FPM 监听地址和端口   根据个人情况修改
            fastcgi_index  index.php;  
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;  
            include        fastcgi_params;  
        }  
    }  
}

##解压Wordpress压缩包
[root@master data]# ls
index.html  test.php  wordpress-6.4.3-zh_CN.tar.gz
[root@master data]# pwd
/root/Dockerfile/centos/data
[root@master data]# tar -zxf wordpress-6.4.3-zh_CN.tar.gz 
[root@master data]# ls
index.html  test.php  wordpress  wordpress-6.4.3-zh_CN.tar.gz
##启动docker-compose
[root@master centos]# docker-compose up -d
##成功后在浏览器访问http://IP:8066/index.php
```

![image-20240309204427833](https://github.com/studcl/LNMP-Wordpress/blob/master/image-20240309204427833.png)

```
##进入mysql容器创建数据库
[root@master centos]# docker exec -it mysql-wordpress /bin/bash
[root@c80c66120568 /]# mysql -uroot -p000000
MariaDB [(none)]> create database wordpress;

```

![image-20240309204652200](https://github.com/studcl/LNMP-Wordpress/blob/master/image-20240309204652200.png)

```
##创建wp-config.php文件
```

![image-20240309204746470](https://github.com/studcl/LNMP-Wordpress/blob/master/image-20240309204746470.png)

```
##进入wordpress数据目录
[root@master wordpress]# pwd
/root/Dockerfile/centos/data/wordpress
##创建wp-config.php文件
[root@master wordpress]# vi wp-config.php ##将复制的内容拷贝进去
```

![image-20240309205000849](C:\Users\86183\AppData\Roaming\Typora\typora-user-images\image-20240309205000849.png)