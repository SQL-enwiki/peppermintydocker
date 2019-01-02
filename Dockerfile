#Download base image debian stretch
FROM debian:stretch
 
# Update Software repository
RUN apt-get update
 
# Install nginx, php-fpm, and other prerequisites from ubuntu repository
RUN apt-get install -y nginx php7.0-fpm php-mbstring php-imagick php-fileinfo php-zip php-intl supervisor ca-certificates && \
   rm -rf /var/lib/apt/lists/*  && \
   rm -rf /var/www/html/*

#Define the ENV variable
ENV nginx_vhost /etc/nginx/sites-available/default
ENV php_conf /etc/php/7.0/fpm/php.ini
ENV nginx_conf /etc/nginx/nginx.conf
ENV supervisor_conf /etc/supervisor/supervisord.conf

# Enable php-fpm on nginx virtualhost configuration
COPY default ${nginx_vhost}
RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_conf} && \
    echo "\ndaemon off;" >> ${nginx_conf}

COPY supervisord.conf ${supervisor_conf} 

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /var/www/html && \
    chown -R www-data:www-data /run/php
 
# Volume configuration
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]
 
COPY start.sh /start.sh
CMD ["./start.sh"]

#COPY webroot/diff.min.js /var/www/html
#COPY webroot/idindex.json /var/www/html
#COPY webroot/index.php /var/www/html
#COPY webroot/pageindex.json /var/www/html
#COPY webroot/ParsedownExtra.php /var/www/html
#COPY webroot/Parsedown.php /var/www/html
#COPY webroot/peppermint.json /var/www/html
#COPY webroot/recent-changes.json /var/www/html
COPY webroot/* /var/www/html/

EXPOSE 80
