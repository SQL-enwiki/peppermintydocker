#!/bin/bash

cd /home/sql/myimages
rm -rf /home/sql/myimages/webroot
echo "###CLONING###"
git clone https://github.com/sbrl/Pepperminty-Wiki.git webroot
cd /home/sql/myimages/webroot
LATEST="$(git describe --abbrev=0 --tags)"
echo "###CHECKING OUT $LATEST###"
git checkout $LATEST
cd /home/sql/myimages
echo "###BUILDING AND PUSHING $LATEST###"
docker buildx build --platform linux/arm,linux/arm64,linux/amd64 -t sqlatenwiki/peppermintywiki:latest -t sqlatenwiki/peppermintywiki:stable -t sqlatenwiki/peppermintywiki:$LATEST  . --push

cd /home/sql/myimages
rm -rf /home/sql/myimages/webroot
echo "###CLONING###"
git clone https://github.com/sbrl/Pepperminty-Wiki.git webroot
cd /home/sql/myimages/webroot
chown www-data:www-data * -R
cd /home/sql/myimages
docker buildx build --platform linux/arm,linux/arm64,linux/amd64 -t sqlatenwiki/peppermintywiki:dev -t sqlatenwiki/peppermintywiki:master . --push
