#!/bin/bash
clear

# Despliega dos servicios: uno con MariaDB y otro con WordPress. No sigue la
# arquitectura de microservicios. El servicio MariaDB ejecuta la versión 10.3.0
# El servicio de WordPress se ejecuta con WordPress 4.8.0, PHP 7.0 y Apache 2.4.
# ¡ Ejecutar antes 01-crear-cluster.sh !

echo "\n# Asegúrate de haber ejecutado 01-crear-cluster.sh antes"

echo "\n# Conectando al manager-02"
eval $(docker-machine env manager-01)

echo "\n# Generamos aleatoriamente la password de root de la BBDD"
echo "# y la almacenamos en un secreto llamado root_db_pass"
echo "# Se ejecuta «openssl rand -base64 20 | docker secret create root_db_pass -»"
openssl rand -base64 20 | docker secret create root_db_pass -

echo "\n# Generamos aleatoriamente la password de root de la BBDD"
echo "# y la almacenamos en un secreto llamado wp_db_pass"
echo "# Se ejecuta «openssl rand -base64 20 | docker secret create wp_db_pass -»"
openssl rand -base64 20 | docker secret create wp_db_pass -

echo "\n# Listamos los secretos"
echo "# Se ejecuta «docker secret ls»"
docker secret ls

echo "\n# Creamos la red wp"
echo "# Se ejecuta «docker network create -d overlay wp»"
docker network create -d overlay wp

echo "\n# Creamos un volumen dbcontent"
echo "# Se ejecuta «docker volume create dbcontent»"
docker volume create dbcontent

echo "\n# Creamos un volumen wwwcontent"
echo "# Se ejecuta «docker volume create wwwcontent»"
docker volume create wwwcontent

echo "\n# Creamos el servicio mariadb"
docker service create \
--name mariadb \
--replicas 1 \
--constraint=node.role==manager \
--network wp \
--mount type=volume,source=dbcontent,destination=/var/lib/mysql \
--secret source=root_db_pass,target=root_db_pass \
--secret source=wp_db_pass,target=wp_db_pass \
-e MYSQL_ROOT_PASSWORD_FILE=/run/secrets/root_db_pass \
-e MYSQL_PASSWORD_FILE=/run/secrets/wp_db_pass \
-e MYSQL_USER=wp \
-e MYSQL_DATABASE=wp \
mariadb:10.3.0

echo "\n# Creamos el servicio wp"
docker service create \
--name wordpress \
--replicas 1 \
--constraint=node.role==worker \
--network wp \
--publish 80:80 \
--mount type=volume,source=wwwcontent,destination=/var/www/html \
--secret source=wp_db_pass,target=wp_db_pass,mode=0400 \
-e WORDPRESS_DB_USER=wp \
-e WORDPRESS_DB_PASSWORD_FILE=/run/secrets/wp_db_pass \
-e WORDPRESS_DB_HOST=mariadb \
-e WORDPRESS_DB_NAME=wp \
wordpress:4.8.0-php7.0-apache

echo "\n# Puede acceder a http://$(docker-machine ip manager-01) para realizar la instalación de WordPress 4.8.0"
