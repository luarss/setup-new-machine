# PLAN-001: Ansible-Based Developer Automation Package

## Executive Summary

Create a robust, modular developer automation package using Ansible as the primary automation framework. The system will use Ansible roles for component management, with a Python CLI wrapper for user interaction and orchestration. This approach provides enterprise-grade reliability, idempotency, and comprehensive testing capabilities.

## Objectives

- [ ] Design Ansible-based role architecture for component management
- [ ] Create Ansible playbooks for npm, python, and system tool installation
- [ ] Implement git and shell configuration through Ansible roles
- [ ] Build Python CLI wrapper for user interaction and profile management
- [ ] Establish Molecule testing framework for role validation
- [ ] Provide idempotent installations with comprehensive verification

## Architecture

### Core Framework
- **Automation Engine**: Ansible 2.9+ for configuration management and installation
- **CLI Wrapper**: Python 3.8+ with Click for user interaction
- **Role Architecture**: Modular Ansible roles for each component category
- **Testing Framework**: Molecule with Docker for comprehensive validation
- **Configuration**: YAML-based profiles and inventory management

### Component Structure
```
setup-new-machine/
├── ansible/
│   ├── ansible.cfg           # Ansible configuration
│   ├── inventory/
│   │   ├── localhost.yml     # Local machine inventory
│   │   └── group_vars/       # Variable definitions
│   ├── playbooks/
│   │   ├── site.yml          # Main orchestration playbook
│   │   ├── full.yml          # Complete developer environment
│   │   └── custom.yml        # User-customizable playbook
│   └── roles/
│       ├── npm_tools/        # NPM package installations
│       ├── python_tools/     # Python ecosystem tools
│       ├── system_tools/     # System packages (ripgrep, etc.)
│       ├── git_config/       # Git configuration
│       └── shell_config/     # Shell configuration
├── cli/
│   ├── __init__.py
│   ├── main.py               # Click-based CLI interface
│   ├── ansible_runner.py     # Ansible execution wrapper
│   ├── profile_manager.py    # Profile handling and validation
│   └── utils.py              # Common utilities
├── profiles/
│   ├── full.json             # Complete developer environment
│   └── custom.json           # User-customizable profile
├── tests/
│   ├── molecule/             # Molecule scenarios for each role
│   ├── integration/          # End-to-end testing
│   └── unit/                 # Python CLI unit tests
├── requirements.txt          # Python dependencies
├── requirements.yml          # Ansible dependencies
└── setup.py                  # Package installation
```

## Implementation Phases

### Phase 1: Foundation (Weeks 1-2)
**Core Infrastructure**
- Set up Python package structure
- Implement abstract plugin base class
- Create configuration manager for YAML profiles
- Build basic CLI interface with argparse/click
- Establish logging and error tracking systems

**Deliverables:**
- Working plugin registration system
- Configuration loading from YAML files
- Basic CLI that can list available plugins
- Error handling framework with transaction logging

### Phase 2: Core Component Plugins (Weeks 3-4)
**NPM Tools Plugin**
- Install Node.js if not present (via NodeSource repository)
- Install global npm packages: Claude Code, CCSetup, Claude Code Sandbox
- Verify installations and report versions

**Python Tools Plugin**
- Install uv package manager via curl script
- Verify installation and functionality
- Handle PATH modifications if needed

**System Tools Plugin**
- Install ripgrep via package manager (apt/yum/pacman detection)
- Handle different Linux distributions
- Verify binary availability

**Deliverables:**
- Three working plugins with installation and verification
- Cross-distribution package manager detection
- Installation progress reporting

### Phase 3: Configuration Management (Weeks 5-6)
**Git Configuration Plugin**
- Interactive prompts for user.name and user.email
- Configure common git settings (push.default, pull.rebase, etc.)
- SSH key generation and configuration (optional)
- GPG signing setup (optional)

**Shell Configuration Plugin (ZSH)**
- Install zsh if not present
- Install oh-my-zsh framework
- Configure basic plugins and theme
- Set as default shell
- Handle existing shell configurations

**Deliverables:**
- Git configuration with interactive setup
- ZSH installation and configuration
- User preference handling for optional features

### Phase 4: Advanced Features (Weeks 7-8)
**Error Handling & Rollback**
- Transaction-based installation tracking
- Automatic rollback on failures
- Partial installation recovery
- Detailed error reporting and suggestions

**Testing Framework**
- Unit tests for each plugin
- Integration tests with Docker containers
- Multiple Linux distribution testing
- Mock testing for destructive operations

**Profile Management**
- Profile inheritance and composition
- Custom profile creation tools
- Profile validation and dependency checking
- Interactive profile builder

**Deliverables:**
- Comprehensive error handling with rollback
- Full test coverage across plugins
- Advanced profile management features

### Phase 5: Polish & Distribution (Weeks 9-10)
**User Experience**
- Interactive installation wizard
- Progress bars and status reporting
- Colored output and formatting
- Installation summaries and next steps

**Documentation & Distribution**
- Complete README with usage examples
- Plugin development guide
- Packaging for PyPI distribution
- GitHub Actions for CI/CD

**Performance & Reliability**
- Parallel installations where safe
- Dependency resolution optimization
- Cache management for repeated installations
- Performance benchmarking

**Deliverables:**
- Production-ready package
- Complete documentation
- Distribution pipeline
- Performance optimization

## Technical Specifications

### Plugin Interface
```python
class PluginBase:
    def __init__(self, config: dict):
        self.config = config
    
    def check_prerequisites(self) -> bool:
        """Check if plugin can run on this system"""
        pass
    
    def install(self) -> bool:
        """Perform installation"""
        pass
    
    def verify(self) -> bool:
        """Verify installation succeeded"""
        pass
    
    def rollback(self) -> bool:
        """Remove installed components"""
        pass
```

### Profile Format (YAML)
```yaml
name: "Full Developer Environment"
description: "Complete setup for development work"
plugins:
  - name: "npm_tools"
    packages:
      - "@anthropic-ai/claude-code"
      - "ccsetup" 
      - "@textcortex/claude-code-sandbox"
  - name: "python_tools"
    tools:
      - "uv"
  - name: "system_tools"
    packages:
      - "ripgrep"
  - name: "git_config"
    interactive: true
  - name: "shell_config"
    shell: "zsh"
    framework: "oh-my-zsh"
```

### Error Handling Strategy
- **Atomic Operations**: Each plugin operation is tracked in transaction log
- **Rollback Capabilities**: Failed installations can be cleanly removed
- **Dependency Resolution**: Install order determined by dependency graph
- **Graceful Degradation**: Partial installations allowed with user confirmation
- **Detailed Logging**: All operations logged with timestamps and context

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Package manager variations | High | Detect distribution and use appropriate package manager |
| Permission issues | Medium | Clear sudo requirements and permission checking |
| Network failures | Medium | Retry mechanisms and offline fallback options |
| Conflicting installations | High | Thorough prerequisite checking and conflict detection |
| User environment corruption | High | Comprehensive rollback and backup mechanisms |

## Success Metrics

- **Reliability**: 95%+ successful installations across test environments
- **Coverage**: Support for 3+ major Linux distributions  
- **Performance**: Complete installation in under 10 minutes
- **Usability**: Installation requires minimal user intervention
- **Maintainability**: New plugins can be added in under 2 hours
- **Documentation**: 100% API coverage and usage examples

## Dependencies

- Python 3.8+ (system requirement)
- curl (for downloading installers)
- sudo access (for system package installations)
- Internet connectivity (for downloading packages)

## Future Enhancements

- **Cross-Platform Support**: macOS and Windows compatibility
- **Container Integration**: Docker/Podman development environment setup
- **Cloud Integration**: AWS/GCP CLI tools and authentication
- **IDE Configuration**: VS Code extensions and settings sync
- **Dotfiles Management**: Personal configuration file synchronization
- **Team Profiles**: Shared configuration profiles for development teams