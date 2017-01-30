#! /bin/bash
source /config/settings.sh
envsubst < .env.template > .env

echo $DB_HOST

dockerize -wait tcp://$DB_HOST:3306 -timeout 60s
php artisan koel:init
php artisan serve --host 0.0.0.0
