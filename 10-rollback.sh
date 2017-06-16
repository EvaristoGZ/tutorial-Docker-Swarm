#!/usr/bin/env bash
clear

# Hace un rollback del servicio encuesta_vote, en este caso volviendo a
# escalar el servicio a 15 réplicas en vez de 30 como se establecía en el script
# 08-recrear-problemas.sh

eval $(docker-machine env manager-01)

echo "# Hacemos rollback del servicio encuesta_vote. De 30 a 15 réplicas."
echo "# Se ejecuta «docker service update --rollback encuesta_vote»"
docker service update --rollback encuesta_vote

sleep 15s
echo "\n# Comprobamos el número de réplicas de los servicios del stack"
echo "# Se ejecuta «docker stack services encuesta»"
docker stack services encuesta

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con 11-registry-portainer.sh"
read enterKey
sh 11-registry-portainer.sh