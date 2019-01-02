#!/bin/bash

cd /home/sql/myimages
rm -rf /home/sql/myimages/webroot
echo "###CLONING LATEST RELEASE###"
git clone https://github.com/sbrl/Pepperminty-Wiki.git webroot
cd /home/sql/myimages/webroot
LATEST="$(git describe --abbrev=0 --tags)"
echo "###CHECKING OUT RELEASE $LATEST###"
git checkout $LATEST
cd /home/sql/myimages
echo "###BUILDING RELEASE $LATEST###"
docker build -t sqlatenwiki/peppermintywiki:$LATEST /home/sql/myimages
echo "###PUSHING RELEASE $LATEST###"
docker push sqlatenwiki/peppermintywiki:$LATEST


cd /home/sql/myimages                                                                                                                                                                             
rm -rf /home/sql/myimages/webroot                                                                                                                                                                 
echo "###CLONING MASTER###"                                                                                                                                                                              
git clone https://github.com/sbrl/Pepperminty-Wiki.git webroot                                                                                                                                    
cd /home/sql/myimages/webroot                                                                                                                                                                     
echo "###CHECKING OUT MASTER###"
cd /home/sql/myimages
echo "###BUILDING MASTER###"
docker build -t sqlatenwiki/peppermintywiki:master /home/sql/myimages
echo "###PUSHING master###"
docker push sqlatenwiki/peppermintywiki:master
