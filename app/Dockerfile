FROM php:8.3-fpm

# Install system dependencies
# RUN apt-get update && apt-get install -y \
#     zip unzip git curl libpng-dev libonig-dev libxml2-dev \
#     libzip-dev && \
#     docker-php-ext-install pdo pdo_mysql zip 

# Install system dependencies + PHP extensions
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip unzip git \
    nodejs npm \
    netcat-traditional \
    libzip-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    libicu-dev \
    libpq-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    default-mysql-client

# Install required PHP extensions including pdo_mysql
RUN docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

WORKDIR /var/www

# Copy Laravel app
COPY ./app /var/www

RUN composer install --optimize-autoloader --no-dev

#RUN chown -R www-data:www-data /var/www \
#    && chmod -R 775 storage bootstrap/cache

# Set correct permissions for Laravel
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
    

EXPOSE 9000

CMD ["php-fpm"]
