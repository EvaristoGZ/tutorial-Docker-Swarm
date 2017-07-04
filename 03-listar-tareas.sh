#!/bin/bash
clear

# Muestra las tareas que sirven la página web a través del puerto 5000 y
# el puerto 5001 para los resultados.

echo "# Se ejecuta un bucle for. (Consultar código)"
echo "# Se ejecuta «docker ps --format "{{.ID}} {{.Names}}" --filter Name=encuesta_vote»"
for nodo in "manager-01" "nodo-02" "nodo-03"; do
	NODO_IP=$(docker-machine ip $nodo)
	eval $(docker-machine env $nodo)
	echo "\n# Tareas de encuesta_vote en contenedores de $nodo ($NODO_IP)"
	docker ps --format "{{.ID}} {{.Names}}" --filter Name=encuesta_vote
done

echo "\n# Accede a http://192.168.99.100:5000 para votar o"
echo "# http://192.168.99.100:5001 para ver los resultados."

echo "\n# Accede a http://192.168.99.100:8080 para ver Visualizer"

# Ejecución continua para realizar la demostración en vivo
echo "\n# Escriba 04 para continuar con 04-manager-pause.sh o 06 para continuar con 06-comprobar-manager.sh"
while true; do
    read menu
    case $menu in
        04 ) sh 04-manager-pause.sh; break;;
        06 ) sh 06-comprobar-manager.sh;;
        * ) echo "Opción inválida";;
    esac
done
