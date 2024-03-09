FROM ubuntu:22.04
LABEL maintainer=chenlin
RUN apt-get update
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y php php-cli php-common && \
    apt-get install -y php-json php-opcache && \
    apt-get install -y php-mysql php-pgsql php-sqlite3 && \
    apt-get install -y php-gd php-xml php-mbstring php-fpm
EXPOSE 9000
CMD ["php-fpm","-F;"]
