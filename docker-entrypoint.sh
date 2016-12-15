#!/bin/bash

USER_ID=${LOCAL_USER_ID:-0}
USERNAME=${LOCAL_USERNAME:-user}
CHOWNDIRS=${CHOWNDIRS}
HTML_ROOT=/var/www/html

# exit when a subcommand or pipeline returns a non-zero status
set -e

# enable extended patern matching
shopt -s extglob

# if user directory is not yet synced -> rsync
if ! [ -e user/config/system.yaml ]; then
  echo >&2 "No userfiles found - copying now..."
  rsync -a /tmp/grav-$GRAV_VERSION/user/ /var/www/html/user
fi

chown -R www-data:www-data HTML_ROOT;

echo >&2 "Complete! Grav has been successfully installed"

exec "$@"
