#!/bin/bash
ARCHS="linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6,linux/amd64,linux/386"
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
docker buildx build --platform $ARCHS -t sqlatenwiki/peppermintywiki:latest -t sqlatenwiki/peppermintywiki:stable -t sqlatenwiki/peppermintywiki:$LATEST  . --push

cd /home/sql/myimages
rm -rf /home/sql/myimages/webroot
echo "###CLONING###"
git clone https://github.com/sbrl/Pepperminty-Wiki.git webroot
cd /home/sql/myimages/webroot
chown www-data:www-data * -R
cd /home/sql/myimages
docker buildx build --platform $ARCHS -t sqlatenwiki/peppermintywiki:dev -t sqlatenwiki/peppermintywiki:master . --push
