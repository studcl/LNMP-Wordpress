#!/bin/bash
mysql_install_db --user=root
sleep 3
mysqld_safe --user=root &
sleep 5
mysqladmin -u root password "000000"

# 授权
mysql -u root -p000000 -e "use mysql; grant all privileges on *.* to 'root'@'%' identified by 
'000000' with grant option;"

mysql -u root -p000000 -e "use mysql; grant all privileges on *.* to 'root'@'localhost' identified by '000000' with grant option;"

# 刷新权限
mysql -u root -p000000 -e "flush privileges;"
