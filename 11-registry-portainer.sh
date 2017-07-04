#!/bin/bash
clear

# Cambia el Availability de manager-01 a Active. Despliega un servicio de
# Registry y otro de Portainer como servicios independientes.

eval $(docker-machine env manager-01)

echo "# Cambiando el campo Availability a Active de manager-01"
echo "# Se ejecuta «docker node update --availability active manager-01»"
docker node update --availability active manager-01

echo "\n# Creando un servicio de Registry en manager-01"
echo "# Se ejecuta «docker service create --name registry --constraint 'node.role == manager' --publish 5050:5000 registry»"
docker service create \
--name registry --constraint \
'node.role == manager' \
--publish 5050:5000 registry

echo "\n# Creando un servicio de Portainer en manager-01"
echo "# Se ejecuta «docker service create --name portainer --constraint 'node.role == manager' --publish 9000:9000 --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock portainer/portainer -H unix:///var/run/docker.sock»"
docker service create \
--name portainer \
--constraint 'node.role == manager' \
--publish 9000:9000 \
--mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
portainer/portainer \
-H unix:///var/run/docker.sock

sleep 15s
echo "\n# Comprobamos los servicios desplegados en el Swarm"
echo "# Se ejecuta «docker service ls»"
docker service ls

echo "\n# Accede a http://192.168.99.100:9000 para configurar Portainer."

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con 12-worker-a-manager.sh"
read enterKey
sh 12-worker-a-manager.sh
