# Imagen base optimizada para Laravel
FROM serversideup/php:8.2-fpm-nginx

# Variables de entorno para PHP
ENV PHP_OPCACHE_ENABLE=1 \
    PHP_OPCACHE_MEMORY_CONSUMPTION=128 \
    PHP_MEMORY_LIMIT=512M

# Directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos como www-data desde el inicio
COPY --chown=www-data:www-data . .

# Crear directorios necesarios con permisos correctos
RUN mkdir -p storage/logs \
    storage/framework/cache \
    storage/framework/sessions \
    storage/framework/views \
    bootstrap/cache && \
    chmod -R 775 storage bootstrap/cache

# Instalar dependencias de Composer
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Optimizaciones de Laravel
RUN php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

# Exponer puerto 80
EXPOSE 80