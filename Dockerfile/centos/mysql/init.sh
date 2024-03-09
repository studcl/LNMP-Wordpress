#!/bin/bash
#以root用户的身份调用mysql_install_db命令来初始化MySQL的数据目录
mysql_install_db --user=root
sleep 3
#以root用户的身份使用mysqld_safe命令来安全地启动MySQL服务器,&符号意味着这个命令会在后台运行
mysqld_safe --user=root &
sleep 5
#使用mysqladmin命令为root用户设置密码
mysqladmin -u root password "000000"
# 授权
mysql -u root -p000000 -e "use mysql; grant all privileges on *.* to 'root'@'%' identified by 
'000000' with grant option;"

mysql -u root -p000000 -e "use mysql; grant all privileges on *.* to 'root'@'localhost' identified by '000000' with grant option;"
# 刷新权限
mysql -u root -p000000 -e "flush privileges;"
