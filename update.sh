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
echo "###BUILDING $LATEST###"
docker build -t sqlatenwiki/peppermintywiki:$LATEST -t sqlatenwiki/peppermintywiki:stable /home/sql/myimages
echo "###PUSHING $LATEST###"
docker push sqlatenwiki/peppermintywiki:$LATEST
docker push sqlatenwiki/peppermintywiki:stable
docker push sqlatenwiki/peppermintywiki:latest


cd /home/sql/myimages
rm -rf /home/sql/myimages/webroot
echo "###CLONING###"
git clone https://github.com/sbrl/Pepperminty-Wiki.git webroot
cd /home/sql/myimages/webroot
chown www-data:www-data * -R
cd /home/sql/myimages
echo "###BUILDING MASTER###"
docker build -t sqlatenwiki/peppermintywiki:master -t sqlatenwiki/peppermintywiki:dev /home/sql/myimages
echo "###PUSHING master###"
docker push sqlatenwiki/peppermintywiki:master
docker push sqlatenwiki/peppermintywiki:dev
