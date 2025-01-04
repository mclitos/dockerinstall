#!/bin/bash

# Run system updates
apt-get update
apt-get upgrade -y

# Install curl
apt-get install -y curl

# Ask if the user wants to install sudo
read -p "¿Quieres instalar con sudo? (s/n) " install_sudo
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

# Ask if the user wants to install Dockge
read -p "¿Quieres instalar Dockge? (s/n) " install_dockge
if [[ $install_dockge =~ ^[Ss]$ ]]; then
    # Create directories that store your stacks and stores Dockge's stack
    mkdir -p /opt/stacks /opt/dockge
    cd /opt/dockge

    # Download the compose.yaml
    curl https://raw.githubusercontent.com/louislam/dockge/master/compose.yaml --output compose.yaml

    # Start the server
    docker compose up -d

fi

# Ask if the user wants to create a new sudo user
read -p "¿Quieres crear un nuevo usuario sudo? (s/n) " create_user
if [[ $create_user =~ ^[Ss]$ ]]; then
    read -p "Enter the desired username: " username
    while true; do
        read -s -p "Enter the password: " password
        echo
        read -s -p "Confirm the password: " password_confirm
        echo
        if [[ $password == $password_confirm ]]; then
            break
        else
            echo "El Passwords no coinciden. Intentalo de nuevo."
        fi
    done
    useradd -m -s /bin/bash $username
    echo "$username:$password" | sudo chpasswd
    usermod -aG sudo,docker $username
    echo "Se ha creado el usuario $username y se ha agregado a los grupos sudo y docker."
fi
