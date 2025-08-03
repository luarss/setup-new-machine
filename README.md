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
- Uses hardcoded configuration from `secrets.yml` (see Configuration section)

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

### Direct Ansible Commands

```bash
# Run main installation playbook
ansible-playbook playbooks/full.yml

# Run verification playbook
ansible-playbook playbooks/verify.yml
```

## Configuration

### Personal Information Setup

Create a `secrets.yml` file (automatically ignored by git) with your personal information:

```yaml
git_user:
  name: "Your Name"
  email: "your.email@example.com"

ssh_key:
  comment: "your.email@example.com"
  type: "rsa"
  size: 4096
```

### Component Configuration

Customize installations by editing files in `group_vars/`:

- `full.yml` - Complete installation profile with all components

## Requirements

- **Ansible 2.9+**: Configuration management engine
- **sudo access**: For system package installations
- **curl**: For downloading installers
- **Internet connection**: For package downloads

## Architecture

```
.
├── ansible.cfg           # Ansible configuration
├── secrets.yml           # Personal configuration (git ignored)
├── group_vars/          
│   └── full.yml          # Complete installation profile
├── playbooks/           
│   ├── full.yml          # Main orchestration playbook
│   └── site.yml          # Base playbook
├── roles/               # Component-specific roles
│   ├── npm_tools/       # NPM package management
│   ├── python_tools/    # Python ecosystem setup (uv, claude-monitor)
│   ├── system_tools/    # System package installation (ripgrep)
│   ├── git_config/      # Git configuration with SSH keys
│   └── shell_config/    # Shell setup (ZSH with oh-my-zsh)
└── Makefile             # Simplified automation commands
```

## Features

- **Idempotent**: Safe to run multiple times, intelligent overwrite protection
- **Cross-platform**: Works on Debian, Ubuntu, CentOS, RHEL  
- **Modular**: Install only what you need
- **Verification**: Built-in installation checking
- **Non-interactive**: Uses hardcoded configuration from secrets file
- **Localhost-only**: Optimized for local machine setup