#!/bin/sh

if [ -n "$ENABLE_XDEBUG" ]; then
  cat > /usr/local/etc/php/conf.d/xdebug.ini <<EOF
xdebug.mode=debug
xdebug.client_host=${XDEBUG_CLIENT:-host.docker.internal}
xdebug.start_with_request=yes
EOF
else
  echo "; xdebug disabled" > /usr/local/etc/php/conf.d/xdebug.ini
  echo "xdebug.mode=off" >> /usr/local/etc/php/conf.d/xdebug.ini
fi

exec "$@"
