# -----------------------------
# 1. Base Image (PHP + Apache)
# -----------------------------
FROM php:8.2-apache

# -----------------------------
# 2. Install required packages
# -----------------------------
RUN apt-get update && apt-get install -y \
    zip unzip git

# -----------------------------
# 3. Enable Apache modules
# -----------------------------
RUN a2enmod rewrite

# -----------------------------
# 4. Install PHP extensions (optional)
# -----------------------------
RUN docker-php-ext-install mysqli pdo pdo_mysql

# -----------------------------
# 5. Install Composer globally
# -----------------------------
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# -----------------------------
# 6. Copy project files
# -----------------------------
COPY . /var/www/html/

# -----------------------------
# 7. Set permissions
# -----------------------------
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# -----------------------------
# 8. Expose Apache Port
# -----------------------------
EXPOSE 80

# -----------------------------
# 9. Start Apache
# -----------------------------
CMD ["apache2-foreground"]
  
