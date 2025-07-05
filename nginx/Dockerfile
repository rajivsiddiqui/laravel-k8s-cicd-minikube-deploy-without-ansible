FROM nginx:1.27

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./app/public /var/www/public

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
