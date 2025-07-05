FROM nginx:stable-alpine
 
WORKDIR /etc/nginx/conf.d
 
COPY nginx/default.conf .
 
#RUN mv nginx.conf default.conf

#WORKDIR /var/www/html
 
#COPY src .

WORKDIR /var/www

# Copy Laravel app
COPY ./app /var/www