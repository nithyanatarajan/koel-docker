FROM debian:jessie
MAINTAINER Krishnaswamy,Nithya
ARG KOEL_VERSION=3.5.4
ARG NODE_VERSION=6.9.4

EXPOSE 8000
VOLUME ["/config","/media"]
WORKDIR /opt

RUN apt-get update \
    && apt-get install -y \
    wget \
    unzip \
    php5 \
    php5-curl \
    php5-mysql \
    python \
    make \
    g++ \
    xz-utils \
    gettext

ENV DOCKERIZE_VERSION v0.3.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN wget https://getcomposer.org/installer \
    && php installer \
    && mv composer.phar /usr/local/bin/composer \
    && rm installer

RUN wget https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz \
    && tar -xvf node-v$NODE_VERSION-linux-x64.tar.xz -C /opt \
    && mv node-v$NODE_VERSION-linux-x64 nodejs \
    && rm node-v$NODE_VERSION-linux-x64.tar.xz \
    && ln -sf /opt/nodejs/bin/node /usr/bin/node \
    && ln -sf /opt/nodejs/bin/npm /usr/bin/npm

RUN npm install -g yarn \
   && ln -sf /opt/nodejs/bin/yarn /usr/bin/yarn

RUN wget https://github.com/phanan/koel/archive/v$KOEL_VERSION.zip \
    && unzip -o v$KOEL_VERSION.zip -d /opt \
    && rm v$KOEL_VERSION.zip

WORKDIR /opt/koel-$KOEL_VERSION

RUN composer install

COPY template/.env.docker .env.template
COPY bin/docker-entrypoint.sh /bin/start.sh
RUN chmod +x /bin/start.sh
CMD /bin/start.sh
