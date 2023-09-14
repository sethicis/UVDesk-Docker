FROM composer/composer:2.2.21

RUN composer clear-cache \
    && composer create-project uvdesk/community-skeleton /var/www/html

FROM php:8.0-apache

ENV PHP_EXTENSION_MAILPARSE=1 \
    PHP_EXTENSION_IMAP=1 \
    APACHE_DOCUMENT_ROOT=/var/www/html/public
COPY --FROM=0 /var/www/html /var/www/html

RUN a2enmod rewrite \
    && cd /var/www/html/ \
    && chmod 777 .env var config \
    && php bin/console c:c
