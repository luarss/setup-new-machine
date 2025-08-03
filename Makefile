.PHONY: help install-dev install-custom verify check clean
.DEFAULT_GOAL := help

help:
	@echo "Developer Environment Setup - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Examples:"
	@echo "  make install-dev      # Install development environment (15 min)"
	@echo "  make verify          # Check current installation status"
	@echo "  make check           # Dry run without making changes"

install-dev:
	@echo "Installing development environment..."
	@ansible-playbook playbooks/full.yml

install-custom:
	@echo "Installing developer environment with default configuration..."
	@ansible-playbook playbooks/site.yml

verify:
	@echo "Verifying installation status..."
	@ansible-playbook playbooks/verify.yml

check:
	@echo "Dry run - showing what would be installed..."
	@ansible-playbook playbooks/full.yml --check --diff

# Component-specific installations
install-npm:
	@echo "Installing npm tools..."
	@ansible-playbook playbooks/site.yml --tags npm_tools

install-python:
	@echo "Installing python tools..."
	@ansible-playbook playbooks/site.yml --tags python_tools

install-system:
	@echo "Installing system packages..."
	@ansible-playbook playbooks/site.yml --tags system_tools

install-git:
	@echo "Configuring git..."
	@ansible-playbook playbooks/site.yml --tags git_config

install-shell:
	@echo "Configuring shell..."
	@ansible-playbook playbooks/site.yml --tags shell_config
