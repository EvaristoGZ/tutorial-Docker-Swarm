#!/usr/bin/env bash
clear

# Crea un nodo en Amazon Web Service con la clave de acceso y la clave secreta
# establecida en las variables. Muestra información a través de inspect.

ACCESS_KEY=TU_CLAVE_DE_ACCESO_AWS
SECRET_KEY=TU_CLAVE_SECRETA_AWS
NODO=pruebaAWS

echo "\n# Los valores de ACCESS_KEY, SECRET_KEY y NOMBRE_NODO son los siguientes:"
echo "# ACCESS_KEY=$ACCESS_KEY"
echo "# SECRET_KEY=$SECRET_KEY"
echo "# NOMBRE_NODO=$NOMBRE_NODO"

echo "\n# Creando nodo en Amazon Web Service"
echo "# Se ejecuta «docker-machine create -d amazonec2 --amazonec2-access-key $ACCESS_KEY --amazonec2-secret-key $SECRET_KEY $NODO»"
docker-machine create -d amazonec2 --amazonec2-access-key $ACCESS_KEY --amazonec2-secret-key $SECRET_KEY $NODO

echo "\n# Listamos los nodos de Docker Machine"
echo "# Se ejecuta «docker-machine ls»"
docker-machine ls

echo "# Información del nodo de Docker Machine $NODO, alojado en AWS 3 #"
echo "# Se ejecuta \$(docker-machine inspect -f {{.Driver.VALOR}} $NODO)"
echo "\n# Nombre máquina:\t $(docker-machine inspect -f {{.Driver.MachineName}} $NODO)"
echo "# ID instancia:\t\t $(docker-machine inspect -f {{.Driver.InstanceId}} $NODO)"
echo "# Región:\t\t $(docker-machine inspect -f {{.Driver.Region}} $NODO)"
echo "# Tipo instancia:\t $(docker-machine inspect -f {{.Driver.InstanceType}} $NODO)"
echo "# Precio de puja:\t $(docker-machine inspect -f {{.Driver.SpotPrice}} $NODO)"
echo "# Dirección IP:\t\t $(docker-machine inspect -f {{.Driver.IPAddress}} $NODO)"
echo "# Dirección IP privada:\t $(docker-machine inspect -f {{.Driver.PrivateIPAddress}} $NODO)"
