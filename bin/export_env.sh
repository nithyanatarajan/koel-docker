#! /bin/bash

export DB_CONNECTION=$(jq --raw-output '.DB_CONNECTION' /config/settings.json)
export DB_HOST=$(jq --raw-output '.DB_HOST' /config/settings.json)
export DB_DATABASE=$(jq --raw-output '.DB_DATABASE' /config/settings.json)
export DB_USERNAME=$(jq --raw-output '.DB_USERNAME' /config/settings.json)
export DB_PASSWORD=$(jq --raw-output '.DB_PASSWORD' /config/settings.json)
export ADMIN_EMAIL=$(jq --raw-output '.ADMIN_EMAIL' /config/settings.json)
export ADMIN_NAME=$(jq --raw-output '.ADMIN_NAME' /config/settings.json)
export ADMIN_PASSWORD=$(jq --raw-output '.ADMIN_PASSWORD' /config/settings.json)
