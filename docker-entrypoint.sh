#!/bin/bash

USER_ID=${LOCAL_USER_ID:-0}
USERNAME=${LOCAL_USERNAME:-user}
CHOWNDIRS=${CHOWNDIRS}

# exit when a subcommand or pipeline returns a non-zero status
set -e

# enable extended patern matching
shopt -s extglob

# if user directory is not yet synced -> rsync
if ! [ -e user/config/system.yaml ]; then
  echo >&2 "No userfiles found - copying now..."
  rsync -a /tmp/grav-$GRAV_VERSION/user/ /var/www/html/user
fi


#make sure user rights are correct
case ${USER_ID} in
   "0")
        # Run as root
        exec "$@"
        ;;
   *)
        # Run as non-root
        adduser -s /bin/bash -u ${USER_ID} -D -h /home/${USERNAME} ${USERNAME}
        export HOME=/home/${USERNAME}

        # chown dirsp
        if [ "${CHOWNDIRS}" ];
        then
            IFS=',' read -r -a array <<< "${CHOWNDIRS}"
            for element in "${array[@]}"
            do
                printf "transfering directory ownership for ${element} to ${USER_ID}:${USER_ID} ...\n"
                chown -R ${USER_ID}:${USER_ID} ${element};
            done
        fi

        # Exec statement
        exec su-exec ${USERNAME} "$@"
        ;;
esac

echo >&2 "Complete! Grav has been successfully installed"

exec "$@"
