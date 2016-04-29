FROM bytepark/alpine-nginx:latest
MAINTAINER Steven McCullagh <stevenmccullagh@gmail.com>

ENV IMAGICK_VERSION=3.4.1

# Add PHP 7
RUN apk upgrade -U && \
    apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add \
    imagemagick-dev make g++ autoconf libtool \
    php7-zlib php7-zip php7-sqlite3 php7-dev  \
    php7 \
    php7-xml \
    php7-xsl \
    php7-pdo_mysql \
    php7-mcrypt \
    php7-curl \
    php7-json \
    php7-fpm \
    php7-phar \
    php7-openssl \
    php7-mysqli \
    php7-ctype \
    php7-opcache \
    php7-mbstring \
    supervisor

# Install Imagick
RUN cd / && \
    curl https://pecl.php.net/get/imagick-${IMAGICK_VERSION}.tgz | tar zxv && \
    cd imagick-${IMAGICK_VERSION} && \
    phpize7 && \
    ./configure --with-php-config=php-config7 && \
    make && \
    make install && \
    echo "extension=imagick.so" > /etc/php7/conf.d/imagick.ini

COPY /ops /

# Small fixes
RUN ln -s /etc/php7 /etc/php && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm && \
    ln -s /usr/lib/php7 /usr/lib/php && \
    rm -fr /var/cache/apk/*

# Install composer global bin
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Setup Volume
VOLUME ["/usr/share/nginx/html"]

ENTRYPOINT ["/init"]