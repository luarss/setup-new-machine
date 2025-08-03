# setup-new-machine

Automates the setting up common developer dependencies on new machines using Ansible.

## Quick Start

```bash
# Install Ansible (if not already installed)
./prereq.sh

# Install required Ansible collections
ansible-galaxy install -r requirements.yml

# Or full environment with shell config (15 minutes)
make install-dev

# Verify installation
make verify
```

## Components

**NPM Tools**
- `Claude Code`: Global npm package for AI-powered development
- `CCSetup`: Development environment configuration utility  
- `Claude Code Sandbox`: Isolated development environment

**Python Ecosystem**
- `uv`: Fast Python package installer and resolver
- `claude-monitor`: Monitoring tools for Claude integrations

**System Packages**
- `ripgrep`: Ultra-fast text search tool

**Git Configuration**
- Global git settings (user.name, user.email, pull.rebase, etc.)
- SSH key generation and configuration

**Shell Configuration** 
- ZSH with oh-my-zsh framework (optional, in full installation)

## Usage

### Makefile Commands

```bash
make help                # Show all available commands
make install-dev        # Complete environment including shell config
make verify             # Check what's currently installed
make check              # Dry run - see what would be installed
```

### Component-Specific Installation

```bash
make install-npm        # Just npm tools
make install-python     # Just python tools  
make install-system     # Just system packages
make install-git        # Just git configuration
make install-shell      # Just shell configuration
```

### Direct Ansible Commands

```bash
# Change to ansible directory
cd ansible

# Run specific playbooks
ansible-playbook playbooks/full.yml
ansible-playbook playbooks/verify.yml

# Custom configuration
ansible-playbook playbooks/site.yml -e "npm_packages=['@anthropic-ai/claude-code']"
```

## Configuration

Customize installations by editing files in `ansible/group_vars/`:

- `all.yml` - Global defaults
- `full.yml` - Complete installation profile

## Requirements

- **Ansible 2.9+**: Configuration management engine
- **sudo access**: For system package installations
- **curl**: For downloading installers
- **Internet connection**: For package downloads

## Architecture

```
ansible/
├── ansible.cfg           # Ansible configuration
├── inventory/           
│   └── localhost.yml     # Local machine inventory
├── group_vars/          # Variable definitions by profile
├── playbooks/           # Main orchestration playbooks
└── roles/               # Component-specific roles
    ├── npm_tools/       # NPM package management
    ├── python_tools/    # Python ecosystem setup
    ├── system_tools/    # System package installation
    ├── git_config/      # Git configuration
    └── shell_config/    # Shell setup (ZSH)
```

## Features

- **Idempotent**: Safe to run multiple times
- **Cross-platform**: Works on Debian, Ubuntu, CentOS, RHEL
- **Modular**: Install only what you need
- **Verification**: Built-in installation checking
- **Interactive**: Prompts for git user configuration