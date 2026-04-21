FROM php:8.3-fpm

# ---- system deps (required for compiling PHP extensions) ----
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# ---- configure GD properly (IPB uses image handling) ----
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg

# ---- install core extensions required by IPB 4.7 ----
RUN docker-php-ext-install -j$(nproc) \
    mysqli \
    pdo_mysql \
    gd \
    zip \
    intl \
    opcache

# ---- install core extensions required by IPB 4.7 ----
RUN echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini \
  && echo "upload_max_filesize=100M" > /usr/local/etc/php/conf.d/uploads.ini \
  && echo "post_max_size=100M" >> /usr/local/etc/php/conf.d/uploads.ini \
  && echo "opcache.enable=1" > /usr/local/etc/php/conf.d/opcache.ini
