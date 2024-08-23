## Dockerfile of iot-house_docker ; Ver:2024.8.20
## docker system df  <-- Cache confirmation
## docker builder prune  <-- Build Cache clean
## docker build ./ -t iot-house_docker:v0.01  <-- Build
## docker container ps -a  <-- List container
## docker exec -it iot-house_docker bash  <-- Container into bash
## docker commit iot-house_docker iot-house_docker:new_version  <-- copy Container to image
## docker save iot-house_docker:new_version -o iot_docker_carry.tar <-- carry Container image
## docker load -i iot_docker_carry.tar <-- docker image load
## docker stop house_docker  <-- container stop
## docker start house_docker  <-- container start ... 
## docker restart house_docker  <-- container restart
## docker rm house_docker  <-- container delete
## docker tag iot-house_docker:v0.00 iot-house_docker:v0.01 <-- image tag change
## docker rmi house_docker:v0.01 <-- image delete(REPOSITORY:TAG)
## docker run -it --rm iot-house_docker:v0.00 bash  <-- image into bash, for debug
## docker run -d --restart unless-stopped iot-house_docker <-- container auto restart
## docker update --restart unless-stopped iot-house_docker <-- container auto restart policy set
## docker update --restart=no iot-house_docker <-- container auto restart disable
## docker run -itd --privileged --name iot-house_docker -p 8022:22 -p 80:80 -p 443:443 kujiranodanna/iot-house_docker:ubuntu22.04-latest
## When TWE-Lite-DIP is connected to USB
## docker run -itd --privileged --name iot-house_docker --device=/dev/ttyUSB0:/dev/ttyUSBTWE-Lite -p 8022:22 -p 80:80 -p 443:443 kujiranodanna/iot-house_docker:ubuntu22.04-latest

FROM amd64/ubuntu:22.04
#FROM i386/ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ARG APP_UID=1000
ARG APP_USER=remote
ARG APP_PASSWORD=hand
RUN useradd -s /bin/bash -m --uid ${APP_UID} --groups sudo ${APP_USER} \
  && echo ${APP_USER}:${APP_PASSWORD} | chpasswd
# Copy Dockerfile
COPY Dockerfile /Dockerfile
RUN apt-get update && apt-get install -y \
tzdata \
rsyslog \
sudo \
iputils-ping \
kmod \
net-tools \
apache2 \
curl \
daemontools \
dnsutils \
exim4 \
ffmpeg \
gawk \
jq \
libhidapi-hidraw0 \
lrzsz \
procmail \
nkf \
mplayer \
mutt \
openssh-server \
rrdtool
RUN mkdir /www
RUN mkdir /service
RUN mkdir /usr/src/pepolinux
COPY app-src/rc.local_docker /etc
COPY app-src/pepolinux.tar.gz /usr/src/pepolinux/
COPY app-src/lubuntu_cmd.tar.gz /usr/src/pepolinux/
ADD app-src/lubuntu_cmd.tar.gz /usr/local/bin/
COPY app-src/remote_dio.tar.gz /usr/src/pepolinux/
COPY app-src/mozilla.tar.gz /usr/src/pepolinux/
COPY app-src/log.tar.gz /usr/src/pepolinux/
COPY app-src/spool.tar.gz /usr/src/pepolinux/
COPY app-src/service.tar.gz /usr/src/pepolinux/
ADD app-src/service.tar.gz /service/
ADD app-src/apache_conf.tar.gz /etc/apache2/
ADD app-src/exim4_conf.tar.gz /etc/exim4/
ADD app-src/etc_cron_d.tar.gz /etc/cron.d/
COPY app-src/svscan /etc/init.d/
# copy /usr/local/bin, amd64 or i386 -->
COPY app-src/bin/msleep /usr/local/bin/
COPY app-src/bin/pepochecksum /usr/local/bin/
COPY app-src/bin/pepocp2112ctl /usr/local/bin/
COPY app-src/bin/pepodiodexec /usr/local/bin/
COPY app-src/bin/epicon /usr/local/bin/
# <--
COPY app-src/pepostart_remote-hand_docker /usr/local/bin/
RUN mkdir /etc/rc.pepo
COPY app-src/index.html /var/www/html
COPY app-src/etc_rc.pepo_password /etc/rc.pepo/password
RUN mkdir /root/.mutt
COPY app-src/muttrc /root/.mutt
EXPOSE 22 80 443
#ENTRYPOINT ["/etc/rc.local_docker"]
CMD ["/etc/rc.local_docker"]
