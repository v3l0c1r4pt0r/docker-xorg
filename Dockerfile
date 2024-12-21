FROM ubuntu:24.04

RUN apt update -y && apt upgrade -y

RUN apt install -y wget libfreetype-dev libxext6 libxrender1 libxtst6 libxi6 xauth file git vim apt-file

RUN userdel ubuntu # useradd would fail otherwise, if current user id is 1000
ARG uid=1000
ARG gid=1000
RUN groupadd -g $gid admin
RUN useradd -m admin -u $uid -g $gid # create user with same id as on host

WORKDIR /home/admin

RUN apt install -y locales

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt install -y xterm strace iproute2

COPY entrypoint.sh /opt/

RUN chmod +x /opt/entrypoint.sh

VOLUME /home/admin/workspace
USER admin
WORKDIR /home/admin

ENTRYPOINT ["/opt/entrypoint.sh"]
