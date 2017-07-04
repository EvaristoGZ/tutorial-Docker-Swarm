#!/bin/bash
clear

# Accede al manager-01 y lista las tareas encuesta_vote que se ejecutan en todos
# los nodos. Lista las tareas que encuesta_vote que se ejecutan en el nodo-03.

eval $(docker-machine env manager-01)

echo "# Tareas de encuesta_vote en contenedores de todos los nodos"
echo "# Se ejecuta «docker service ps encuesta_vote»"
docker service ps encuesta_vote

echo "\n# Pulse Enter para continuar"
read enterKey

echo "# Tareas de encuesta_vote en contenedores de nodo-03"
echo "# Se ejecuta «docker service ps -f node=nodo-03 encuesta_vote»"
docker service ps -f node=nodo-03 encuesta_vote

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con 10-rollback.sh"
read enterKey
sh 10-rollback.sh
