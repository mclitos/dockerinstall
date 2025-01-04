DB Tech's Docker and Docker Compose Install
===

## Instalación con root (método sin root a continuación)

Para instalar las versiones más nuevas de sudo (opcional según el script que use), curl, Docker y docker compose, simplemente acceda por ssh a su servidor y luego clone este repositorio con:

```
git clone https://github.com/dnburgess/dockerinstall.git
```
Si no tiene instalado git, puede ejecutar:
```
apt install git
```

Cambiar al nuevo directorio:
```
cd dockerinstall
```

Crear el ejecutable:
```
chmod +x dockerinstall.sh
```

Ejecutar el Archivo:
```
./dockerinstall.sh
```

## Instalación sin usar root ( Opcion no Recomendable pero Utilizable)

Si no desea usar root/sudo, puede hacer lo siguiente:

Clonar el repositorio:
```
git clone https://github.com/dnburgess/dockerinstall.git
```
Si no tienes git instalado, puedes ejecutar:
```
apt install git
```
Cambiar el Directorio:
```
cd dockerinstall
```

Crear el Ejecutable:
```
chmod +x dockerinstallnoroot.sh
```

Ejecutar el Archivo:
```
./dockerinstallnoroot.sh
```

## Instalar usando root (incluye Portainer)   (Mejor Opcion)

Para instalar las versiones más nuevas de sudo (opcional según el script que uses), curl, Docker y docker compose, simplemente ingresa por ssh a tu servidor y luego clona este repositorio con: 

```
git clone https://github.com/dnburgess/dockerinstall.git
```
Si no tienes git instalado, puedes Ejecutar:
```
apt install git
```

Cambie al nuevo directorio:
```
cd dockerinstall
```

Hacer el ejecutable:
```
chmod +x dockerportainerinstall.sh
```

ejecutar el Archivo:
```
./dockerportainerinstall.sh
```

Explicación del script de Bash
===

Este script de shell automatiza la instalación de Docker y Docker Compose en un sistema Linux. Aquí hay un desglose de lo que hace cada sección del script:
1. Establecer opciones del script:

```
set -o errexit
set -o nounset
IFS=$(printf '\n\t')
```
- ```set -o errexit```: The script will exit if any command exits with a non-zero status.
- ```set -o nounset```: The script will exit if it tries to use an uninitialized variable.
- ```IFS=$(printf '\n\t')```: Internal Field Separator is set to newline and tab.

2. Instalar Docker
```
apt install sudo -y && apt install curl -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
printf '\nDocker installed successfully\n\n'
```

- Instala sudo y curl usando el administrador de paquetes apt.
- Descarga el script de instalación de Docker usando curl.
- Ejecuta el script de instalación de Docker usando sudo sh.
- Imprime un mensaje de éxito.

3. Espera que Docker se inicie
```
printf 'Waiting for Docker to start...\n\n'
sleep 5
```
- Imprime un mensaje que indica que el script está esperando a que Docker se inicie.
- Se queda en reposo durante 5 segundos.

4. Instalar Docker Compose:
```
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
sudo curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
printf '\nDocker Compose installed successfully\n\n'
sudo docker-compose -v
```

- Recupera la última versión de Docker Compose de la API de GitHub.
- Descarga el binario de Docker Compose usando ```curl```  y lo instala en ```/usr/local/bin/```.
- Establece permisos ejecutables para Docker Compose.
- Descarga el script de finalización de Bash para Docker Compose.
- Imprime un mensaje de éxito.
- Muestra la versión instalada de Docker Compose.


Tenga en cuenta que este script asume una distribución de Linux basada en Debian. Si está usando una distribución diferente, es posible que se necesiten ajustes. Además, es esencial revisar y comprender los scripts antes de ejecutarlos, especialmente cuando se usan comandos sudo desde Internet.
