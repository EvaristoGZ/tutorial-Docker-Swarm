#!/bin/bash
reset

# Crea tres nodos en VirtualBox y crea un clúster de Docker Swarm con un manager
# y dos workers: manager-01, nodo-02 y nodo-03.

echo "# Creando los nodos de Docker Machine en VirtualBox"
echo "# Se ejecuta un for con docker-machine create -d virtualbox \$nodo"
for nodo in "manager-01" "nodo-02" "nodo-03"; do
	docker-machine create -d virtualbox $nodo
done

echo "\n# Almacenando la dirección IP del manager en una variable"
echo "# Se ejecuta «\$(docker-machine ip manager-01)»"
MANAGER_IP=$(docker-machine ip manager-01)

echo "\n# Conectando al manager-01"
echo "# Se ejecuta «eval \$(docker-machine env manager-01)»"
eval $(docker-machine env manager-01)

echo "\n# Iniciando un Swarm en manager-01"
echo "# Se ejecuta «eval docker swarm init --advertise-addr \$MANAGER_IP»"
docker swarm init --advertise-addr $MANAGER_IP

echo "# Añadiendo una etiqueta del administrador"
echo "# Se ejecuta «docker node update --label-add administrador=\"Evaristo GZ\" manager-01"
docker node update --label-add administrador="Evaristo GZ" manager-01

echo "\n# Almacenando los tokens en variables"
echo "# Se ejecuta «\$(docker swarm join-token -q manager) y \$(docker swarm join-token -q worker)»"
MANAGER_TOKEN=$(docker swarm join-token -q manager)
WORKER_TOKEN=$(docker swarm join-token -q worker)

echo "\n# Pulse Enter para continuar"
read enterKey
clear

for nodo in "nodo-02" "nodo-03";do
	echo "\n# Almacenando la dirección IP del worker en una variable"
	echo "# Se ejecuta «\$(docker-machine ip $nodo)»"
	WORKER_IP=$(docker-machine ip $nodo)

	echo "\n# Conectado al $nodo"
	echo "# Se ejecuta «eval \$(docker-machine env $nodo)»"
	eval $(docker-machine env $nodo)

	echo "\n# Une al $nodo como worker"
	echo "# Se ejecuta «docker swarm join --token $WORKER_TOKEN --advertise-addr $WORKER_IP $MANAGER_IP:2377»"
	docker swarm join --token $WORKER_TOKEN --advertise-addr $WORKER_IP $MANAGER_IP:2377
done

echo "\n# Accediendo a manager-01"
eval $(docker-machine env manager-01)
echo "# Se ejecuta «docker-machine ls»"
docker-machine ls
echo "\n# Se ejecuta «docker node ls»"
docker node ls

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con 02-crear-stack-encuesta.sh"
read enterKey
sh 02-crear-stack-encuesta.sh
