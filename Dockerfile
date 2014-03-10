#
# CommunityID Dockerfile
#
# VERSION               0.1.0
# DOCKER-VERSION        0.8.0

#

# Pull base image.
FROM ubuntu:12.04

# Install Nginx and PHP5.
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties curl
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx php5-common php5-cli php5-fpm php5-mcrypt php5-sasl
RUN apt-get install -y zend-framework zend-framework-bin
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

RUN perl -i -pe 's/listen = .*/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf
RUN perl -i -pe 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php5/fpm/php5-fpm.conf

ADD . /src 
RUN cp /src/sites-default /etc/nginx/sites-available/default
RUN cd /src; tar xzf cid-1.0.1.tar.gz

RUN ln -s /src/communityid/webdir /usr/share/nginx/html/communityid

# Attach volumes.
#VOLUME /etc/nginx/sites-enabled
#VOLUME /var/log/nginx

# Set working directory.
WORKDIR /etc/nginx

# Expose ports.
EXPOSE 80

# Define default command.
# ENTRYPOINT ["nginx"]

