FROM ubuntu:18.04

# Apache and mod_tile
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:osmadmins/ppa && \
    apt update && \
    apt install -y --no-install-recommends apache2 libapache2-mod-tile && \
    rm -rf /var/lib/apt/lists/*
# Config files (These are automatically created)
#   /etc/apache2/mods-available/tile.load : for loading mod_tile module
#   /etc/apache2/sites-available/tileserver_site.conf : for providing OSM tile support

ADD ./tileserver_renderd.conf /etc/tileserver_renderd.conf
ADD ./tileserver_site.conf /etc/apache2/sites-available/tileserver_site.conf

CMD ["apachectl", "-D", "FOREGROUND"]
