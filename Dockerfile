FROM ubuntu

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

RUN apt clean
RUN apt-get update && apt install apache2 python3 pip libpq-dev apache2-dev -y \
        && pip3 install --upgrade pip

COPY ./app /var/www/app
RUN chmod -R 775 /var/www/app

RUN pip install -r /var/www/app/requirements.txt
RUN mv /var/www/app/notapp-apache.conf /etc/apache2/sites-available/
RUN public_ip=$(curl -s ifconfig.me) && \
    echo "PUBLIC_IP=$public_ip" > /etc/environment && \
    sed -i "s/ServerName\s*<SERVER_NAME>/ServerName $public_ip/g" /etc/apache2/sites-available/notapp-apache.conf && \
    sed -i "s/#ServerName\s*<SERVER_NAME>/ServerName $public_ip/g" /etc/apache2/apache2.conf && \
    echo "ServerName $public_ip" >> /etc/apache2/apache2.conf

RUN pip install mod_wsgi
RUN mod_wsgi-express module-config > /etc/apache2/mods-available/wsgi.load
RUN a2enmod wsgi
RUN a2dissite 000-default.conf
RUN a2ensite notapp-apache.conf


EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
