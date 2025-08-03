#!/bin/bash

# Prerequisites installer for setup-new-machine
# Installs Ansible if not already present

set -e

echo "Checking for Ansible installation..."

if command -v ansible-playbook >/dev/null 2>&1; then
    echo "✅ Ansible is already installed"
    ansible --version
    exit 0
fi

echo "📦 Installing Ansible..."

# Update package list
sudo apt update

# Install software-properties-common for add-apt-repository
sudo apt install -y software-properties-common

# Add Ansible PPA
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
sudo apt install -y ansible

echo "✅ Ansible installation complete"
ansible --version

echo ""
echo "Next steps:"
echo "  make install-dev     # Install complete environment"