#!/bin/bash
clear

# Actualiza el stack para quitar las constraints que obligan a ciertos
# servicios iniciarse únicamente en el nodo Manager.

eval $(docker-machine env manager-01)

echo "# Tareas de encuesta en contenedores del nodo manager-01"
echo "# Se ejecuta «docker ps --filter name=encuesta_»"
docker ps --filter name=encuesta_

echo "\n# Comprobamos el número de réplicas de los servicios del stack"
echo "# Se ejecuta «docker stack services encuesta»"
docker stack services encuesta

echo "\n# Actualizando el stack con un nuevo fichero"
echo "# Se ejecuta «docker stack deploy -c example-voting-app/docker-stack-constraint.yml encuesta»"
docker stack deploy -c example-voting-app/docker-stack-constraints.yml encuesta

sleep 30s
echo "\n# Las tareas pasarían a ejecutarse otro nodo"
echo "# Se ejecuta «docker stack services encuesta»"
docker stack services encuesta

echo "\n# Se ejecuta «docker service ps encuesta_worker»"
docker service ps encuesta_worker

echo "\n# Se ejecuta «docker service ps encuesta_db»"
docker service ps encuesta_db

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con 08-recrear-problemas.sh"
read enterKey
sh 08-recrear-problemas.sh
