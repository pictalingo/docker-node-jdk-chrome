FROM buildpack-deps:buster-scm

MAINTAINER Dan Oleynik <dan@pictalingo.com>

RUN echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' >> /etc/apt/sources.list.d/buster-backports.list

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        locales

ENV LANG C.UTF-8
RUN locale-gen $LANG

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        -t buster-backports \
        ca-certificates-java \
        openjdk-11-jre-headless \
        openjdk-11-jre \
        openjdk-11-jdk-headless \
        openjdk-11-jdk

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
RUN export JAVA_HOME

# Install maven
ENV MAVEN_VERSION 3.6.3

RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

VOLUME /root/.m2

# Install node 15
RUN set -x \
    && curl -sL https://deb.nodesource.com/setup_15.x | bash - \
    && apt-get install -y \
        nodejs \
    && npm install -g npm@latest yarn@latest

# Install Chrome
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        xvfb \
        google-chrome-stable

ADD xvfb-chrome /usr/bin/xvfb-chrome
RUN ln -sf /usr/bin/xvfb-chrome /usr/bin/google-chrome

ENV CHROME_BIN /usr/bin/google-chrome
