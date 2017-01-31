#!/bin/bash

USER_ID=${LOCAL_USER_ID:-0}
USERNAME=${LOCAL_USERNAME:-user}
CHOWNDIRS=${CHOWNDIRS}
HTML_ROOT=/var/www/html

set -e
shopt -s extglob

if ! [ -e user/config/system.yaml ]; then
  echo >&2 "No userfiles found - copying now..."
  rsync -a /tmp/grav-$GRAV_VERSION/user/ /var/www/html/user
fi

echo >&2 "Setting permissions to www-data ${HTML_ROOT}"
chown -R www-data:www-data ${HTML_ROOT}
find ${HTML_ROOT} -type f -print0 | xargs -0 chmod 664
find ${HTML_ROOT}/bin -type f -print0 | xargs -0 chmod 775
find ${HTML_ROOT} -type d -print0 | xargs -0 chmod 775
find ${HTML_ROOT} -type d -print0 | xargs -0 chmod +s
umask 0002

bin/gpm install login form email admin
echo >&2 "Complete! Grav has been successfully installed"

exec "$@"