FROM krallin/ubuntu-tini:16.04 AS base
MAINTAINER Rishabh Joshi

#
# UTF-8 by default
#
RUN apt-get -qq update && \
    apt-get -qqy install locales tzdata ntp && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TZ=Asia/Kolkata

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#
# Pull Zulu OpenJDK binaries from official repository:
#
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 && \
    echo "deb http://repos.azulsystems.com/ubuntu stable main" >> /etc/apt/sources.list.d/zulu.list && \
    apt-get -qq update && \
    apt-get -qqy install zulu-9 && \
    rm -rf /var/lib/apt/lists/*
