#!/usr/bin/env bash
clear

# Crea un stack llamado encuesta. Una aplicación ejecutada en microservicios
# que permite elegir a través de web dos opciones. Luego muestra los servicios y
# tareas ejecutadas en cada nodo.

eval $(docker-machine env manager-01)

echo "# Desplegando el stack docker-stack.yml con nombre encuesta"
echo "# Se ejecuta «docker stack deploy -c example-voting-app/docker-stack.yml encuesta»"
docker stack deploy -c example-voting-app/docker-stack.yml encuesta

echo "\n# Comprobamos los servicios del stack encuesta"
echo "# Se ejecuta «docker stack services encuesta»"
docker stack services encuesta

echo "\n# Espera de 45 segundos"
sleep 45s

echo "\n# Comprobamos los servicios del stack encuesta tras 45 segundos"
echo "# Se ejecuta «docker stack services encuesta»"
docker stack services encuesta

for nodo in "manager-01" "nodo-02" "nodo-03"; do
	echo "\n# Accediendo a $nodo"
	eval $(docker-machine env $nodo)
	echo "# Tareas en contenedores de $nodo"
	docker ps
done

# Ejecución continua para realizar la demostración en vivo
echo "\n# Pulse Enter para continuar con 03-listar-tareas.sh"
read enterKey
sh 03-listar-tareas.sh