# Imagen base optimizada para Laravel (Nginx + PHP-FPM ya configurados)
FROM serversideup/php:8.2-fpm-nginx

# Variables de entorno para PHP
ENV PHP_OPCACHE_ENABLE=1
ENV PHP_OPCACHE_MEMORY_CONSUMPTION=128
ENV PHP_MEMORY_LIMIT=512M

# Directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos de la aplicación
COPY . .

# Instalar dependencias de Composer
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Optimizaciones de Laravel
RUN php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

# Permisos correctos (esto es lo que te expliqué antes)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache && \
    chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Exponer puerto 80 (Nginx)# Imagen base optimizada para Laravel (Nginx + PHP-FPM ya configurados)
FROM serversideup/php:8.2-fpm-nginx

# Variables de entorno para PHP
ENV PHP_OPCACHE_ENABLE=1
ENV PHP_OPCACHE_MEMORY_CONSUMPTION=128
ENV PHP_MEMORY_LIMIT=512M

# Directorio de trabajo
WORKDIR /var/www/html

# Copiar SOLO composer.json y composer.lock primero (para aprovechar cache de Docker)
COPY composer.json composer.lock ./

# Crear directorios necesarios ANTES de composer install
RUN mkdir -p storage/logs storage/framework/cache storage/framework/sessions storage/framework/views bootstrap/cache

# Configurar permisos ANTES de composer install
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 775 storage bootstrap/cache

# Instalar dependencias (ahora con permisos correctos)
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts

# Copiar el resto de archivos de la aplicación
COPY --chown=www-data:www-data . .

# Asegurar permisos finales
RUN chmod -R 775 storage bootstrap/cache

# Optimizaciones de Laravel
RUN php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

# Exponer puerto 80 (Nginx)
EXPOSE 80

# El CMD ya está configurado en la imagen base (nginx + php-fpm)
EXPOSE 80

# El CMD ya está configurado en la imagen base (nginx + php-fpm)