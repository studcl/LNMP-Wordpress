#!/bin/bash  
  
# PHP 安装目录  
PHP_INSTALL_DIR="/usr/local/php83"  
# 配置文件目录  
PHP_CONFIG_DIR="/etc/php83"  
# 额外的配置文件目录  
PHP_EXTRA_CONFIG_DIR="/etc/php.d"  
  
# 创建配置文件目录  
mkdir -p "$PHP_CONFIG_DIR"  
mkdir -p "$PHP_EXTRA_CONFIG_DIR"  
  
# 复制 php.ini 配置文件  
cp "$PHP_INSTALL_DIR/php.ini-production" "$PHP_CONFIG_DIR/php.ini"  
  
# 复制 php-fpm 配置文件  
cp "$PHP_INSTALL_DIR/etc/php-fpm.conf.default" "$PHP_INSTALL_DIR/etc/php-fpm.conf"  
cp "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf.default" "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf"  
  
# 修改 php-fpm 的用户和用户组为 nginx  
sed -i 's/^user = .*/user = nginx/' "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf"  
sed -i 's/^group = .*/group = nginx/' "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf"  
sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf"  
sed -i 's/^pm = .*/pm = dynamic/' "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf"  
sed -i 's/^pm.max_children = .*/pm.max_children = 5/' "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf"  
sed -i 's/^pm.start_servers = .*/pm.start_servers = 2/' "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf"  
sed -i 's/^pm.min_spare_servers = .*/pm.min_spare_servers = 1/' "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf"  
sed -i 's/^pm.max_spare_servers = .*/pm.max_spare_servers = 3/' "$PHP_INSTALL_DIR/etc/php-fpm.d/www.conf"
