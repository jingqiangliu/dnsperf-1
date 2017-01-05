FROM ubuntu
MAINTAINER Trine Lise Aavik

# set env vars
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# configure apt behaviour
RUN echo "APT::Get::Install-Recommends 'false'; \n\
  APT::Get::Install-Suggests 'false'; \n\
  APT::Get::Assume-Yes "true"; \n\
  APT::Get::force-yes "true";" > /etc/apt/apt.conf.d/00-general

# systemd tweaks
RUN rm -rf /lib/systemd/system/getty*;

# install
RUN apt-get update
RUN apt-get install -y apt-utils

# install dependencies
RUN apt-get install -y wget build-essential bind9utils libbind-dev libkrb5-dev libssl-dev libcap-dev libxml2-dev dnsutils geoip-bin libgeoip-dev 
RUN wget ftp://ftp.nominum.com/pub/nominum/dnsperf/2.1.0.0/dnsperf-src-2.1.0.0-1.tar.gz
RUN tar -xvzf dnsperf-src-2.1.0.0-1.tar.gz
RUN cd /dnsperf-src-2.1.0.0-1 
RUN ./configure 
RUN make 
RUN make install
