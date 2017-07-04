#!/bin/bash
clear

# Actualiza el stack y escala el servicio vote de 2 a 15 réplicas a través de un
# fichero stack nuevo llamado docker-stack-scale.yml. Dará error los servicios 
# encuesta_db, encuesta_visualizer y encuesta _worker debido a las constraints.

eval $(docker-machine env manager-01)

echo "# Comprobamos el número de réplicas"
echo "# Se ejecuta «docker stack services encuesta»"
docker stack services encuesta

echo "\n# Actualizando el stack con un nuevo fichero"
echo "# Se ejecuta «docker stack deploy -c example-voting-app/docker-stack-scale.yml encuesta»"
docker stack deploy -c example-voting-app/docker-stack-scale.yml encuesta

sleep 30s
echo "\n# Comprobamos el número de réplicas de los servicios del stack"
echo "# Se ejecuta «docker stack services encuesta»"
docker stack services encuesta

echo "\n# Pulse Enter para ejecutar 03-listar-tareas.sh"
read enterKey
sh 03-listar-tareas.sh
