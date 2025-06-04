# Development Rules Template

A reusable set of development guidelines, rules, and folder structures that can be incorporated into any project.

## Overview

This repository provides a standardized approach to:
- Task tracking
- Code organization
- Refactoring
- Efficiency guidelines
- Development workflow

## Features

- **Workflow Rules**: Standardized development workflow from task assessment to completion
- **Efficiency Guidelines**: Patterns for parallel execution and maximizing throughput
- **File Organization**: Standardized approaches for temporary files and work-in-progress
- **Refactoring Guidelines**: Safety-first approach to refactoring code
- **Code Principles**: Functions and SOLID principles
- **Task Tracking**: Template for tracking tasks and progress

## Installation

### Automatic Detection & Setup

The easiest way to set up these rules is using the auto-trigger system:

```bash
# Clone the repository
git clone https://github.com/yourusername/dev-rules-template.git

# Run the auto-trigger script (detects your AI assistant automatically)
cd dev-rules-template
./scripts/auto-trigger.sh
```

**Automated/Silent Mode** (no prompts, perfect for CI/CD):
```bash
# Full automation - no prompts, copies documentation
./scripts/auto-trigger.sh --silent

# Force re-run even if already executed
./scripts/auto-trigger.sh --force

# Environment variables for automation
DEV_RULES_AUTO=true DEV_RULES_SILENT=true ./scripts/auto-trigger.sh
```

The auto-trigger system will:
- Detect which AI assistant you're using (GitHub Copilot, Cursor, Windsurf, Claude Dev, Cline, Firebase AI Studio/Gemini, etc.)
- Run the appropriate setup script for your environment
- Create necessary configuration files
- Mark the setup as completed to avoid duplicate runs

### Manual Installation

For manual installation or specific customization:

```bash
# Interactive mode (prompts for options)
./scripts/setup-rules.sh /path/to/your/project

# Automated mode (no prompts, copies documentation)
./scripts/setup-rules.sh --auto /path/to/your/project

# Copy documentation without prompts
./scripts/setup-rules.sh --copy-docs /path/to/your/project

# Skip documentation copying
./scripts/setup-rules.sh --no-docs /path/to/your/project
```

**Environment Variables for Automation:**
```bash
# Enable full automation
export DEV_RULES_AUTO=true
export DEV_RULES_COPY_DOCS=true

./scripts/setup-rules.sh /path/to/your/project
```

### Supported AI Assistants

- **GitHub Copilot**: Creates `.github/copilot-instructions.md`
- **Cursor**: Creates `.cursor-rules` file
- **Windsurf**: Creates `.windsurf/rules.md` and configuration
- **Claude Dev**: Creates `.claude-dev/instructions.md`
- **Cline**: Creates `.cline/instructions.md`
- **Firebase AI Studio/Gemini**: Creates `.gemini-rules/` directory with Firebase-specific context
- **Generic**: Creates `.ai-rules/instructions.md` for any AI assistant

See [INSTALL.md](./INSTALL.md) for detailed installation instructions and customization options.

## Customization

The templates can be customized to fit your project's specific needs. See the documentation in each section for customization options.

## License

MIT
