#!/bin/bash

set -e

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Starting installation..."

# Docker
if command_exists docker; then
    echo "Docker already installed"
else
    echo "Installing Docker..."
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg lsb-release
    
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker "$USER"
fi

# Docker Compose
if docker compose version &>/dev/null; then
    echo "Docker Compose already installed"
else
    sudo apt install -y docker-compose
fi

# Python
if command_exists python3 && python3 -c "import sys; exit(0 if sys.version_info >= (3,9) else 1)"; then
    echo "Python $(python3 -V 2>&1) already installed"
else
    echo "Installing Python 3.9..."
    sudo apt update
    sudo apt install -y python3.9 python3-pip
fi

# Django
if python3 -m django --version &>/dev/null; then
    echo "Django already installed"
else
    echo "Installing Django..."
    python3 -m pip install django
fi

echo "Installation complete!"