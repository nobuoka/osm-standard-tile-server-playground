cp /etc/apache2/sites-available/tileserver_site.conf ./tileserver_site.conf.original
sudo mv ./tileserver_site.conf /etc/apache2/sites-available/tileserver_site.conf
sudo mv ./tileserver_renderd.conf /etc/tileserver_renderd.conf
sudo mv ./renderd.conf /etc/renderd2.conf

sudo service apache2 restart
sudo service renderd restart
