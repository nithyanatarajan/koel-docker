#! /bin/bash
set -e
FILE="/config/settings.sh"

echo $FILE

if [ -f "$FILE" ];
then
  echo "File $FILE found. Sourcing the file."
  source $FILE
else
  echo "File $FILE does not exist."
fi

envsubst < .env.template > .env
dockerize -wait tcp://$DB_HOST:3306 -timeout 60s
php artisan koel:init
php artisan serve --host 0.0.0.0
