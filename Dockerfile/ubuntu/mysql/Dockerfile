FROM ubuntu:22.04
LABEL maintainer=chenlin
COPY ./init.sh /opt/
WORKDIR /opt/
RUN apt-get update
RUN apt-get install wget software-properties-common dirmngr ca-certificates apt-transport-https  -y
RUN apt-get install -y mariadb-server mariadb-client&& bash /opt/init.sh
EXPOSE 3306
CMD ["mysqld_safe","--user=root"]
