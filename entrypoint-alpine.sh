#!/bin/bash

if [ "$1" == "alias" ] ; then
  echo "alias docker-compose='docker run -ti -e LOCAL_USER_ID=\`id -u \$USER\` -e LOCAL_USER_GROUP_ID=\`id -g \$USER\` -e LOCAL_USER_GROUP_NAME=\`id -gn \$USER\` --rm -v \$(pwd):\$(pwd) -w \$(pwd) -v /var/run/docker.sock:/var/run/docker.sock:ro infrabricks/docker-compose:alpine docker-compose'"
else

# Add local user and group
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

  if [ $(getent group $LOCAL_USER_GROUP_ID) ]; then
    # echo "group exists."
    # echo "$(getent group $LOCAL_USER_GROUP_ID)"
    LOCAL_USER_GROUP_NAME=$(getent group $LOCAL_USER_GROUP_ID |  awk -F : '{print $1}')
  else
    addgroup -g "$LOCAL_USER_GROUP_ID" -S "$LOCAL_USER_GROUP_NAME"
  fi


  USER_ID=${LOCAL_USER_ID:-501}

  #echo "Starting with UID : $USER_ID"

  adduser -S -u $USER_ID -G $LOCAL_USER_GROUP_NAME -D -s /bin/bash user
  export HOME=/home/user
  exec /usr/local/bin/gosu user "$@"

fi
