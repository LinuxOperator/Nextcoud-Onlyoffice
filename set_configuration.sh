#!/bin/bash
# the following commands will change values in nextcloud's config.php file

# add trusted domain for nginx
set -x
docker exec -u www-data nextcloud_app php occ --no-warnings config:system:get trusted_domains >> trusted_domain.tmp
if ! grep -q "nextcloud_nginx" trusted_domain.tmp; then
    TRUSTED_INDEX=$(cat trusted_domain.tmp | wc -l);
    docker exec -u www-data nextcloud_app php occ --no-warnings config:system:set trusted_domains $TRUSTED_INDEX --value="nextcloud_nginx"
fi
rm trusted_domain.tmp

# install add-on onlyoffice
docker exec -u www-data nextcloud_app php occ --no-warnings app:install onlyoffice

# set onlyoffice URLs
docker exec -u www-data nextcloud_app php occ --no-warnings config:system:set onlyoffice DocumentServerUrl --value="/ds-vpath/"
docker exec -u www-data nextcloud_app php occ --no-warnings config:system:set onlyoffice DocumentServerInternalUrl --value="http://nextcloud_onlyoffice/"
docker exec -u www-data nextcloud_app php occ --no-warnings config:system:set onlyoffice StorageUrl --value="https://nextcloud_nginx/"


# overwriteprotocol = https
docker exec -u www-data nextcloud_app php occ --no-warnings config:system:set overwriteprotocol --value="https"
