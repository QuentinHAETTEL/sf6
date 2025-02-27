FROM registry.2le.net/2le/2le:base-sf6
COPY ./docker/php/php.ini /usr/local/etc/php/
COPY . /var/www/html/
WORKDIR /var/www/html
ENV APP_NAME="[PROJECT]"
ARG app_version=dev
ENV APP_VERSION=$app_version
RUN COMPOSER_MEMORY_LIMIT=-1
RUN composer install
RUN bin/console assets:install
RUN npm install
# RUN npm run build
VOLUME ["/var/www/html/var/cache"]
EXPOSE 80
CMD ["sh", "-c", "make prepare && php-fpm"]
