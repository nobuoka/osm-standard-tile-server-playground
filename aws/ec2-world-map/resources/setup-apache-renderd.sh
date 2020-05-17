cp /etc/apache2/sites-available/tileserver_site.conf ./tileserver_site.conf.bak-$(date "+%Y%m%d-%H%M%S")
sudo mv ./tileserver_site.conf /etc/apache2/sites-available/tileserver_site.conf

sudo mv ./tileserver_renderd.conf /etc/tileserver_renderd.conf

cp /etc/renderd.conf ./renderd.conf.bak-$(date "+%Y%m%d-%H%M%S")
sudo mv ./renderd.conf /etc/renderd.conf

sudo service apache2 restart
sudo service renderd restart
