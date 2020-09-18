FROM devopsedu/webapp
MAINTAINER chetana

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update -y
RUN apt-cache pkgnames | grep php7.1

RUN apt-get install -y apache2
RUN apt-get install -y php7.1 libapache2-mod-php7.1 php7.1-cli php7.1-common php7.1-mbstring php7.1-gd php7.1-intl php7.1-xml php7.1-mysql php7.1-mcrypt php7.1-zip

RUN rm -rf /var/www/html/*

ADD website /var/www/html

EXPOSE 80

CMD apachectl -D FOREGROUND
