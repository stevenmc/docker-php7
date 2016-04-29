Docker PHP7
===========
Dockerfile to run PHP7. Uses the following:

 - Alpine (latest)
 - Nginx 1.9.14
 - PHP7 with:
	 - php7-xml
	 - php7-xsl
	 - php7-pdo_mysql
	 - php7-mcrypt
	 - php7-curl
	 - php7-json
	 - php7-fpm
	 - php7-phar
	 - php7-openssl
	 - php7-mysqli
	 - php7-ctype
	 - php7-opcache
	 - php7-mbstring
 - imagick 3.4.
 - composer

----------

Build
-------

Change as required, but this is a quick start script:

> **Build:**

> `docker build -t=php7image .;`


Run New
------------

Using the script below, your current directory is mounted as the webroot. Url is accessible at 127.0.0.1:7755

> **Build:**

> `docker run -ti --name php7image -v $PWD/:/usr/share/nginx/html/ -p 0.0.0.0:7755:80 php7image;`
