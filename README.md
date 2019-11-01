# Docker y Docker Swarm
Proyecto Integrado del CFGS de Administración de Sistemas Informáticos en Red sobre Docker y Docker Swarm. En él se muestra, mediante scripts interactivos en Bash, el funcionamiento de un clúster de Docker realizado con la tecnología de orquestación Docker Swarm.

Se realizan tres despliegues de ejemplo:

- Aplicación "Example Voting App" y "Portainer" en un clúster local de Docker Swarm con tres nodos.
- WordPress + MariaDB en un clúster local de Docker Swarm con tres nodos.
- Despliegue automático de un nodo en Amazon Web Services.

# Presentación y tutorial en YouTube
La presetanción de este proyecto, así como el funcionamiento, está disponible en un vídeo de YouTube titulado "Docker y Docker Swarm - Presentación & Tutorial".

**[Ver "Docker y Docker Swarm - Presentación & Tutorial" en YouTube](https://youtu.be/8iRCdnl9hOY)**

Se comenta al completo el funcionamiento de Docker Machine y Docker Swarm con el despliegue de las tres demos.

# Instrucciones de uso

## Despliegue de Example Voting App y Portainer
1. Hacer un `git clone` del repositorio.
2. Ejecutar el primer script .sh: *01-crear-cluster.sh*
3. Seguir, interactivamente, las instrucciones en pantalla.

## Despliegue de WordPress + MariaDB
1. Hacer un `git clone` del repositorio.
2. Ejecutar *01-crear-cluster.sh*
3. Pulsar Ctrl+C cuando se muestre en pantalla "# Pulse Enter para continuar con 02-crear-stack-encuesta.sh"
4. Ejecutar *a-desplegar-wordpress.sh*

## Despliegue de nodo en AWS (Amazon Web Services)
1. Hacer un `git clone` del repositorio.
2. Ejecutar *a-nodo-aws.sh*
3. Ejecutar `docker-machine rm pruebaAWS` para eliminar el nodo en AWS.

---
Presentado en junio de 2017 por Evaristo García Zambrana para el IES Gonzalo Nazareno de Dos Hermanas (Sevilla).

Más información consultar el documento PDF: *Evaristo GZ - Docker y Docker Swarm.pdf* de este repositorio.

Realizado y probado sobre las siguientes versiones:
- Docker v17.03.1
- Docker Machine v0.10
- VirtualBox 5.1.22
