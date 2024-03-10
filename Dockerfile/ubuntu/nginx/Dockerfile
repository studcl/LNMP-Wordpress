FROM ubuntu:22.04
LABEL maintainer=chenlin
RUN apt-get update
RUN apt-get install -y nginx
RUN groupadd -r nginx && \  
    useradd -r -g nginx nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
