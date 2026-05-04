#!/usr/bin/env bash
set -e

# Variables
REPO_URL="https://github.com/alvarogadaw/proyectoAlvaro.git"
REPO_DIR="/home/vagrant/wp-landing-page"
PROJECT_DIR="/home/vagrant/proyecto"
WORDPRESS_CONTENT_DIR="/home/vagrant/wordpress-content"

# Actualizar paquetes
sudo apt-get update -y

# Instalar dependencias
sudo apt-get install -y ca-certificates curl git rsync

# Instalar Docker
if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com | sudo sh
  sudo usermod -aG docker vagrant
fi

# Instalar Docker Compose moderno
if ! docker compose version &> /dev/null; then
  sudo apt-get install -y docker-compose-plugin
fi

# Crear estructura correcta de WordPress
mkdir -p "$PROJECT_DIR"
mkdir -p "$WORDPRESS_CONTENT_DIR/themes"

# Copiar docker-compose.yml
cp /vagrant/docker-compose.yml "$PROJECT_DIR/docker-compose.yml"

# Clonar o actualizar repo
if [ ! -d "$REPO_DIR/.git" ]; then
  git clone "$REPO_URL" "$REPO_DIR"
else
  cd "$REPO_DIR"
  git pull origin main || git pull origin master || true
fi

# Copiar el tema correctamente dentro de themes/
rsync -av --delete "$REPO_DIR/" "$WORDPRESS_CONTENT_DIR/themes/wp-landing-page/"

# Levantar contenedores
cd "$PROJECT_DIR"
sudo docker compose pull
sudo docker compose up -d
