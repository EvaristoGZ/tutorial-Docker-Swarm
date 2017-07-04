#!/bin/bash
clear

# Cambia la disponibilidad (availability) del Manager de Active a Pause.
# Active es el valor por defecto. En pause, no ejecutará nuevas tareas dentro de
# él. Drain hará que las tareas se dejen de ejecutar en el nodo.

eval $(docker-machine env manager-01)

echo "# Comprobamos el valor Availability de los nodos"
echo "# Se ejecuta «docker node ls»"
docker node ls

echo "\n# Tareas de encuesta en contenedores de manager-01"
echo "# Se ejecuta «docker ps --filter name=encuesta_»"
docker ps --filter name=encuesta_

echo "\n# Cambiando el campo Availability a Pause de manager-01"
echo "# Se ejecuta «docker node update --availability pause manager-01»"
docker node update --availability pause manager-01

echo "\n# Comprobamos el valor Availability de los nodos"
echo "# Se ejecuta «docker node ls»"
docker node ls

sleep 15
echo "\n# Tareas de encuesta en contenedores de manager-01"
echo "# Se ejecuta «docker ps --filter name=encuesta_»"
docker ps --filter name=encuesta_

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con 05-actualizar-stack.sh"
read enterKey
sh 05-actualizar-stack.sh
