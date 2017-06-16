#!/usr/bin/env bash
clear

# Muestra ejemplos de cómo se eliminan distintos elementos. Borra todos los
# nodos de Docker Machine de manera forzosa.

echo "# Conectando al nodo-02"
echo "# Se ejecuta «eval \$(docker-machine env nodo-02)"
eval $(docker-machine env nodo-02)


echo "# Comprobamos los stacks"
echo "# Se ejecuta «docker stack ls»"
docker stack ls

echo "\n# Borrando el stack encuesta"
echo "# Se ejecuta «docker stack rm encuesta»"
docker stack rm encuesta

echo "\n# Pulse Enter para continuar"
read enterKey

echo "# Comprobamos los servicios individuales"
echo "# Se ejecuta «docker service ls»"
docker service ls

echo "\n# Eliminamos todos los servicios"
echo "# Se ejecuta «docker service rm \$(docker service ls -q)»"
docker service rm $(docker service ls -q)

echo "\n# Pulse Enter para continuar"
read enterKey

echo "# Comprobamos los nodos de Docker Machine"
echo "# Se ejecuta «docker-machine ls»"
docker-machine ls

echo "\n# Eliminamos todos los nodos de Docker Machine"
echo "# Se ejecuta un for con «docker-machine rm -f»"
for nodo in "manager-01" "nodo-02" "nodo-03"; do
	docker-machine rm -f $nodo
done
echo "\n# Si desea eliminar TODOS los nodos de Docker Machine ejecute manualmente:"
echo "# «docker-machine rm -f \$(docker-machine ls -q)»"