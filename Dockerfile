#
# CommunityID Dockerfile
#
# VERSION               0.1.0
# DOCKER-VERSION        0.8.0

#

# Pull base image.
FROM ubuntu:12.04

# Install Nginx and PHP5.
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx php5-mcrypt php5-sasl
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

ADD . /src 

RUN cd /tmp
RUN curl http://downloads.sourceforge.net/project/communityid/Community-ID/cid-1.0.1/cid-1.0.1.tar.gz
RUN tar xzf cid-1.0.1.tar.gz

# Attach volumes.
#VOLUME /etc/nginx/sites-enabled
#VOLUME /var/log/nginx

# Set working directory.
WORKDIR /etc/nginx

# Expose ports.
EXPOSE 80

# Define default command.
ENTRYPOINT ["nginx"]

