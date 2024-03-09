FROM ubuntu:22.04
LABEL maintainer=chenlin
RUN apt-get update
RUN apt-get install -y nginx
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
