FROM php:7-apache
ENV MYSQL_HOST=
ENV MYSQL_USER=
ENV MYSQL_PASSWORD=
ENV MYSQL_DATABASE=
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY start-apache.sh /var/www/html
ADD web /var/www/html/app
RUN a2enmod rewrite
RUN apt-get update && apt-get install nano
WORKDIR /var/www/html/app
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    libzip-dev \
    curl
RUN docker-php-ext-install pdo_mysql zip exif pcntl


RUN composer clearcache 
RUN composer install -vvv
RUN cp web/.env.example web/.env
RUN chmod -R 755 .
RUN chmod -R 777 storage

EXPOSE 80
CMD ["/var/www/html/start-apache.sh"]
