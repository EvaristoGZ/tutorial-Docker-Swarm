#!/bin/bash
clear

# Promueve el nodo-02 a manager. Degrada el manager-01 a worker.
# El manager-01 abandona el clúster.

eval $(docker-machine env manager-01)

echo "# Comprobamos el valor Manager de los nodos"
echo "# Se ejecuta «docker node ls»"
docker node ls

echo "\n# Promoviendo el nodo-02 a Manager"
echo "# Se ejecuta «docker node promote nodo-02»"
docker node promote nodo-02

sleep 15s
echo "\n# Comprobamos el valor Manager de los nodos"
echo "# Se ejecuta «docker node ls»"
docker node ls

echo "\n# Pulse Enter para continuar"
read enterKey

echo "# Conectando al nodo-02"
echo "# Se ejecuta «eval \$(docker-machine env nodo-02)»"
eval $(docker-machine env nodo-02)

echo "\n# Degradando el manager-01 a Worker"
echo "# Se ejecuta «docker node demote manager-01»"
docker node demote manager-01

sleep 15s
echo "\n# Comprobamos el valor Manager de los nodos"
echo "# Se ejecuta «docker node ls»"
docker node ls

echo "\n# Pulse Enter para continuar"
read enterKey

echo "# Conectando al manager-01"
echo "# Se ejecuta «eval \$(docker-machine env manager-01)»"
eval $(docker-machine env manager-01)

echo "\n# Abandonando el clúster de Swarm"
echo "# Se ejecuta «docker swarm leave»"
docker swarm leave

echo "\n# Conectando al node-02"
echo "# Se ejecuta «eval \$(docker-machine env nodo-02)»"
eval $(docker-machine env nodo-02)

sleep 15s
echo "\n# Comprobamos los nodos"
echo "# Se ejecuta «docker node ls»"
docker node ls

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con XX-eliminar-cluster.sh"
read enterKey
sh XX-eliminar-cluster.sh
