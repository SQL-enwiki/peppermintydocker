#!/bin/bash
cd /home/sql/myimages/webroot
git pull
cd /home/sql/myimages
docker build /home/sql/myimages
docker push sqlatenwiki/peppermintywiki
