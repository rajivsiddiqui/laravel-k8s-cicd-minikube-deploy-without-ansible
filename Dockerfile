FROM php:8.3-fpm

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip unzip git curl \
    libzip-dev libjpeg-dev libfreetype6-dev     && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath

RUN docker-php-ext-install pdo pdo_mysql bcmath sockets
RUN pecl install redis && docker-php-ext-enable redis

COPY ./app /var/www
RUN ls -la /var/www
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache

    #Add this like just before CMD
RUN php artisan config:clear && php artisan config:cache    
CMD ["php-fpm"]
