#!/usr/bin/env bash
clear

# Comprueba que el Manager no ha ejecutado ninguna tarea más tras escalar el
# servicio vote a 15 réplicas.

eval $(docker-machine env manager-01)

echo "# Tareas de encuesta en contenedores del nodo manager-01"
echo "# Se ejecuta «docker ps --filter name=encuesta_»"
docker ps --filter name=encuesta_

echo "\n# Comprobamos el número de réplicas de los servicios del stack"
echo "# Se ejecuta «docker stack services encuesta»"
docker stack services encuesta

echo "\n# Comprobamos el valor Availability de los nodos"
echo "# Se ejecuta «docker node ls»"
docker node ls

echo "\n# Cambiando el campo Availability a Drain del nodo manager-01"
echo "# Se ejecuta «docker node update --availability drain manager-01»"
docker node update --availability drain manager-01

echo "\n# Comprobamos el valor Availability de los nodos"
echo "# Se ejecuta «docker node ls»"
docker node ls

sleep 15s
echo "\n# Las tareas pasarían a ejecutarse en otro nodo, pero tienen una serie"
echo "# de constraints definidas en el stack docker-stack-scale.yml"
echo "# Se ejecuta «docker service ls»"
docker service ls

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con 07-cambiar-constraints.sh"
read enterKey
sh 07-cambiar-constraints.sh