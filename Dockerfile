FROM php:7-apache
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY start-apache.sh /var/www/html
ADD app /var/www/html/app
RUN a2enmod rewrite
WORKDIR /var/www/html/app
# RUN git clone https://github.com/belal-azzam/laravel-devops-project . 
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
# RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
# RUN docker-php-ext-install gd

RUN composer update -vvv
# RUN cp /var/www/html/app/.env.exmaple /var/www/html/app/.env
RUN chmod -R 777 .
COPY app/.env.example .env

EXPOSE 80
CMD ["/var/www/html/start-apache.sh"]
