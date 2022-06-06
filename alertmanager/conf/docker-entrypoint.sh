#!/bin/sh -e

cat /etc/alertmanager/alertmanager.yml |\
    sed "s@#api_url: <url>#@api_url: '$SLACK_URL'@g" |\
    sed "s@#channel: <channel>#@channel: '#$SLACK_CHANNEL'@g" |\
    sed "s@#username: <user>#@username: '$SLACK_USER'@g" > /tmp/alertmanager.yml

mv /tmp/alertmanager.yml /etc/alertmanager/alertmanager.yml

if [ -f /etc/alertmanager/alertmanager_overwrite.yml ] 
then
  echo /etc/alertmanager/alertmanager_overwrite.yml > /etc/alertmanager/alertmanager.yml
fi

set -- /bin/alertmanager "$@"

exec "$@"
