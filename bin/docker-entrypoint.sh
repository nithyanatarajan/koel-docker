#! /bin/bash
set -e
FILE="/config/settings.json"

if [ -f "$FILE" ];
then
  echo "File $FILE found. Exporting environmental variables."
  source /bin/export_env.sh
else
  echo "File $FILE does not exist."
fi

case "$DB_CONNECTION" in
  pgsql) DB_PORT=5432 ;;
  *) DB_PORT=3306 ;;
esac

envsubst < .env.template > .env
dockerize -wait tcp://$DB_HOST:$DB_PORT -timeout 60s
php artisan koel:init
php artisan serve --host 0.0.0.0
