# LNMP架构的搭建及应用部署

**LNMP架构**

LNMP是指一组通常一起使用来运行动态网站或者服务器的自由软件名称首字母缩写。L指Linux，N指Nginx，M一般指MySQL，也可以指MariaDB，P一般指PHP，也可以指Perl或Python。

## **1. LNMP介绍**

LNMP代表的就是：Linux系统下Nginx+MySQL+PHP这种网站服务器架构。

Linux是一类Unix计算机操作系统的统称，是目前最流行的免费操作系统。代表版本有：debian、centos、ubuntu、fedora、gentoo等。

Nginx (engine x) 是一个高性能的HTTP和反向代理web服务器，同时也提供了IMAP/POP3/SMTP服务。其特点是占有内存少，并发能力强，事实上nginx的并发能力在同类型的网页服务器中表现较好

MySQL是一种开放源代码的关系型数据库管理系统(RDBMS)，使用最常用的数据库管理语言--结构化查询语言(SQL)进行数据库管理。MySQL不仅是开放源代码的，也因为其速度、可靠性和适应性而备受关注。大多数人都认为在不需要事务化处理的情况下，MySQL是管理内容最好的选择。

PHP即“超文本预处理器”，是一种通用开源脚本语言。PHP是在服务器端执行的脚本语言，与C语言类似，是常用的网站编程语言。因为PHP的开源性、免费性、快捷性等特点使其成为目前最流行的编程语言。
![image-20240309202102789](C:\Users\86183\AppData\Roaming\Typora\typora-user-images\image-20240309202102789.png)
第一步：用户在浏览器输入域名或者IP访问网站

第二步：用户在访问网站的时候，向web服务器发出http request请求，服务器响应并处理web请求，返回静态网页资源，如CSS、picture、video等，然后缓存在用户主机上。

第三步：服务器调用动态资源，PHP脚本调用fastCGI传输给php-fpm，然后php-fpm调用PHP解释器进程解析PHP脚本。

第四步：出现大流量高并发情况，PHP解析器也可以开启多进程处理高并发，将解析后的脚本返回给php-fpm，然后php-fpm再调给fast-cgi将脚本解析信息传送给nginx，服务器再通过http response传送给用户浏览器。

第五步：浏览器再将服务器传送的信息进行解析与渲染，呈现给用户。
