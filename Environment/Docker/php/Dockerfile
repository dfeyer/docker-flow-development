FROM php:7.0-fpm

# Ensure UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# PECL Extensions
ENV PECL_REDIS_VERSION     3.0.0
ENV PECL_YAML_VERSION      2.0.0RC8
ENV PECL_UUID_VERSION      1.0.4
ENV PECL_IMAGICK_VERSION   3.4.3RC1

# Debian
ENV DEBIAN_FRONTEND noninteractive

# Setup Debian Multimedia
RUN set -ex \
  && echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list \
  && apt-get -y update \
  && apt-get install -y --force-yes deb-multimedia-keyring \
  && apt-get -y update

RUN usermod -u 1000 www-data

RUN mkdir -p /run/php

# Upgrade system + create application user
RUN set -ex \
  && apt-get -y upgrade \
  && apt-get install -y \
    locales-all \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libbz2-dev \
    libicu-dev \
    libxslt-dev \
    libpq-dev \
    libmysqlclient-dev \
    libyaml-dev \
    uuid-dev \
    imagemagick \
    curl \
    git \
    unzip \
    wget \
    ssmtp \
    locales \
    libmagickwand-dev \
    ffmpeg x264

RUN set -ex \
  && docker-php-ext-install -j$(nproc) \
    bcmath \
    opcache \
    mcrypt \
    zip \
    bz2 \
    mbstring \
    pcntl \
    xsl \
    soap \
    pdo_mysql \
    pdo_pgsql \
    intl

RUN set -ex \
  && pecl install -o -f \
    redis-${PECL_REDIS_VERSION} \
    yaml-${PECL_YAML_VERSION} \
    uuid-${PECL_UUID_VERSION} \
    imagick-${PECL_IMAGICK_VERSION} \
  && docker-php-ext-enable \
    redis \
    yaml \
    uuid \
    imagick \
  && rm -rf \
      /usr/src/php \
      /tmp/pear \
    && php -v \
    && php -i
