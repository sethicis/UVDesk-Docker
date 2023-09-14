FROM php:8.0-apache

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ENV PHP_EXTENSION_MAILPARSE=1 \
    PHP_EXTENSION_IMAP=1 \
    APACHE_DOCUMENT_ROOT=/var/www/html/public

RUN sudo apt update \
    && sudo apt install git
RUN composer clear-cache \
    && composer create-project uvdesk/community-skeleton /var/www/html
RUN a2enmod rewrite \
    && cd /var/www/html/ \
    && chmod 777 .env var config \
    && php bin/console c:c
