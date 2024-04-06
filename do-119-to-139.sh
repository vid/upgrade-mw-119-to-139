#!/bin/bash

set -xe

update_image_version() {
 local version="$1" 
 sed -i "/mwup:/,/image:/s|image: .*|image: ${version}|" docker-compose.yml
 echo "Switched to MediaWiki version: ${version}"
}

docker-compose up -d mwdb
sleep 15

for wiki in subventionsmw.sql.gz zooidwiki.sql.gz canbudget.sql.gz cedwiki.sql.gz ; do
  cp -a ../ovh2023/sqldump/$wiki import/import.mysqldump.gz
  docker-compose exec -T mwdb mysqladmin -uroot -psecret drop -f mediawiki || true
  docker-compose exec -T mwdb mysqladmin -uroot -psecret create mediawiki

  if [ -f "import/import.mysqldump.gz" ]; then
   docker-compose exec -T mwdb sh -c 'gunzip -cd /tmp/import/import.mysqldump.gz | mysql -uroot -psecret mediawiki'
  elif [ -f "import/import.mysqldump" ]; then
   docker-compose exec -T mwdb sh -c 'cat /tmp/import/import.mysqldump | mysql -uroot -psecret mediawiki'
  else
   echo "Please put your source mw 1.19 database in import/import.mysqldump or import/import.mysqldump.gz"
  fi


  for version in xetusoss/mediawiki:1.23 marcelofmatos/mediawiki:1.27 mediawiki:1.31 mediawiki:1.35 mediawiki:1.39; do
   update_image_version "${version}"

   docker-compose up -d mwup
   sleep 15

   docker-compose exec -T mwup php maintenance/update.php --quick

   docker-compose stop mwup
  done
  docker-compose exec -T mwdb mysqldump -uroot -psecret mediawiki > ${wiki}-1.39.mysqldump
done



ls -lat mediawiki-1.39.mysqldump

