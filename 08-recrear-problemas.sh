#!/usr/bin/env bash
clear

# Escala el servicio encuesta_vote a 30 réplicas. Accede al nodo-02 y elimina
# todos los contenedores que ejecutan tareas. Comprueba que se han eliminado.

eval $(docker-machine env manager-01)

echo "# Escalamos el servicio encuesta_vote a 30"
echo "# Se ejecuta «docker service scale encuesta_vote=30»"
docker service scale encuesta_vote=30

echo "\n# Espera de 30 segundos"
sleep 30s

echo "\n# Comprobamos el número de réplicas de los servicios del stack"
echo "# Se ejecuta «docker stack services encuesta»"
docker stack services encuesta

echo "\n# Conectando al nodo-02"
echo "# Se ejecuta eval «\$(docker-machine env nodo-02)»"
eval $(docker-machine env nodo-02)

echo "\n# Pulse Enter para continuar"
read enterKey

echo "# Se ejecuta «docker ps»"
docker ps

echo "\n# Borrando masivamente las tareas de nodo-02"
echo "# Se ejecuta «docker rm -f \$(docker ps -aq)»"
docker rm -f $(docker ps -aq)

echo "\n# Se ejecuta «docker ps»"
docker ps

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con 09-tareas-nodo-03.sh"
read enterKey
sh 09-tareas-nodo-03.sh