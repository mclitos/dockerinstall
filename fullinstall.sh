#!/bin/bash

# Run system updates
apt-get update
apt-get upgrade -y

# Install curl
apt-get install -y curl

# Ask if the user wants to install sudo
read -p "¿Quieres instalar con sudo? (s/n)  " install_sudo
if [[ $install_sudo =~ ^[Ss]$ ]]; then
    apt-get install -y sudo
fi

# Ask if the user wants to install Docker
read -p "¿Quieres instalar Docker? (s/n) " install_docker
if [[ $install_docker =~ ^[Ss]$ ]]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
fi

# Ask if the user wants to install Docker Compose
read -p "¿Quieres instalar Docker Compose? (s/n) " install_compose
if [[ $install_compose =~ ^[Ss]$ ]]; then
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# Ask if the user wants to install Portainer
read -p "¿Quieres instalar Portainer? (s/n) " install_portainer
if [[ $install_portainer =~ ^[Ss]$ ]]; then
    docker volume create portainer_data
    docker run -d -p 8000:8000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
fi

# Ask if the user wants to create a new sudo user
read -p "¿Quieres crear un nuevo usuario sudo? (s/n) " create_user
if [[ $create_user =~ ^[Ss]$ ]]; then
    read -p "Introduzca el nombre de usuario: " username
    while true; do
        read -s -p "Introduzca el  password: " password
        echo
        read -s -p "Confirme el password: " password_confirm
        echo
        if [[ $password == $password_confirm ]]; then
            break
        else
            echo "El Password no coinciden. Intentalo de nuevo."
        fi
    done
    useradd -m -s /bin/bash $username
    echo "$username:$password" | sudo chpasswd
    usermod -aG sudo,docker $username
    echo "Se ha creado el usuario $username y se ha agregado a los grupos sudo y docker."
fi
