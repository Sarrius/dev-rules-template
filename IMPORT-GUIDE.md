# Import Guide: Development Rules Template

This guide provides comprehensive examples of how to import and use the development rules template system across different projects, environments, and workflows.

## Quick Start

The fastest way to get started is using the auto-detection system:

```bash
# Clone the template (one-time setup)
git clone https://github.com/yourusername/dev-rules-template.git ~/dev-rules-template

# Navigate to your project
cd /path/to/your/project

# Auto-detect and setup
~/dev-rules-template/scripts/auto-trigger.sh
```

## Import Methods

### 1. Automatic Detection (Recommended)

The auto-trigger script detects your AI assistant automatically:

```bash
# Basic auto-detection
./scripts/auto-trigger.sh

# Silent mode (no prompts, perfect for automation)
./scripts/auto-trigger.sh --silent

# Force re-run (even if previously executed)
./scripts/auto-trigger.sh --force
```

**Environment Variables:**
```bash
export DEV_RULES_AUTO=true        # Enable automation
export DEV_RULES_SILENT=true      # Silent mode
export DEV_RULES_COPY_DOCS=true   # Copy documentation
```

### 2. Manual Installation

For specific customization or when auto-detection isn't suitable:

```bash
# Interactive setup
./scripts/setup-rules.sh /path/to/project

# Automated setup
./scripts/setup-rules.sh --auto /path/to/project

# Copy documentation
./scripts/setup-rules.sh --copy-docs /path/to/project

# Skip documentation
./scripts/setup-rules.sh --no-docs /path/to/project
```

### 3. Direct Trigger Scripts

Target specific AI assistants directly:

```bash
# GitHub Copilot
./scripts/triggers/copilot-trigger.sh /path/to/project

# Cursor
./scripts/triggers/cursor-trigger.sh /path/to/project

# Windsurf
./scripts/triggers/windsurf-trigger.sh /path/to/project

# Claude Dev
./scripts/triggers/claude-trigger.sh /path/to/project

# Cline
./scripts/triggers/cline-trigger.sh /path/to/project

# Firebase AI Studio/Gemini
./scripts/triggers/gemini-trigger.sh /path/to/project

# Generic (any AI assistant)
./scripts/triggers/generic-trigger.sh /path/to/project
```

## Project-Specific Examples

### React/Next.js Project

```bash
cd ~/projects/my-react-app

# Will likely detect GitHub Copilot or Cursor
~/dev-rules-template/scripts/auto-trigger.sh

# Creates .github/copilot-instructions.md or .cursor-rules
# Includes React-specific patterns and guidelines
```

### Python Project

```bash
cd ~/projects/my-python-app

# Auto-detect AI assistant
~/dev-rules-template/scripts/auto-trigger.sh

# For Python projects, adds:
# - Virtual environment guidelines
# - requirements.txt management
# - Testing patterns
```

### Flutter/Dart Project

```bash
cd ~/projects/my-flutter-app

# Detects Flutter-specific patterns
~/dev-rules-template/scripts/auto-trigger.sh

# Creates Flutter-specific rules including:
# - Widget patterns
# - State management
# - Testing guidelines
```

### Firebase Project

```bash
cd ~/projects/my-firebase-app

# Detects firebase.json and creates Firebase AI Studio setup
~/dev-rules-template/scripts/auto-trigger.sh

# Creates:
# - .gemini-rules/ directory
# - Firebase-specific context
# - Cloud Functions patterns
```

### Full-Stack Project

```bash
cd ~/projects/my-fullstack-app

# Detects multiple technologies
~/dev-rules-template/scripts/auto-trigger.sh

# Adapts rules for:
# - Frontend frameworks
# - Backend APIs
# - Database patterns
# - Deployment strategies
```

## Team & Organization Examples

### Team Onboarding Script

```bash
#!/bin/bash
# team-setup.sh

echo "🚀 Setting up development environment..."

# Clone team's customized rules
git clone https://github.com/your-org/dev-rules-template.git ~/.dev-rules

# Setup for current project
cd "$(pwd)"
~/.dev-rules/scripts/auto-trigger.sh --silent

echo "✅ Development rules installed!"
echo "📋 Check your AI assistant's configuration file for the rules."
```

### Multiple Projects Batch Setup

```bash
#!/bin/bash
# batch-setup.sh

echo "Setting up dev rules for all projects..."

for project_dir in ~/projects/*/; do
  if [ -d "$project_dir" ]; then
    echo "Processing: $project_dir"
    cd "$project_dir"
    
    # Skip if not a git repository
    if [ ! -d ".git" ]; then
      echo "  ⏭️  Skipping (not a git repository)"
      continue
    fi
    
    # Run silent setup
    ~/.dev-rules/scripts/auto-trigger.sh --silent
    echo "  ✅ Rules installed"
  fi
done

echo "🎉 Batch setup complete!"
```

### Makefile Integration

```makefile
# Makefile
.PHONY: setup-dev-rules update-dev-rules

setup-dev-rules:
	@echo "Setting up development rules..."
	@if [ ! -d "~/.dev-rules" ]; then \
		git clone https://github.com/your-org/dev-rules-template.git ~/.dev-rules; \
	fi
	@~/.dev-rules/scripts/auto-trigger.sh --auto
	@echo "Development rules installed!"

update-dev-rules:
	@echo "Updating development rules..."
	@cd ~/.dev-rules && git pull origin main
	@~/.dev-rules/scripts/auto-trigger.sh --force
	@echo "Development rules updated!"
```

## CI/CD Integration

### GitHub Actions

```yaml
# .github/workflows/setup-dev-rules.yml
name: Setup Development Rules

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  setup-rules:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Development Rules
        run: |
          git clone https://github.com/your-org/dev-rules-template.git dev-rules
          DEV_RULES_AUTO=true DEV_RULES_SILENT=true ./dev-rules/scripts/auto-trigger.sh
          
      - name: Commit Rules Updates
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add .
          git diff --staged --quiet || git commit -m "Update development rules"
          git push
```

### Docker Integration

```dockerfile
# Dockerfile
FROM node:18-alpine

# Install dev rules during build
RUN git clone https://github.com/your-org/dev-rules-template.git /opt/dev-rules
ENV DEV_RULES_AUTO=true
ENV DEV_RULES_SILENT=true

WORKDIR /app
COPY package*.json ./
RUN npm install

# Setup dev rules for the project
RUN /opt/dev-rules/scripts/auto-trigger.sh

COPY . .
CMD ["npm", "start"]
```

### Docker Compose

```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    volumes:
      - .:/app
      - ~/.dev-rules:/opt/dev-rules:ro
    environment:
      - DEV_RULES_AUTO=true
      - DEV_RULES_SILENT=true
    command: |
      sh -c "
        /opt/dev-rules/scripts/auto-trigger.sh &&
        npm run dev
      "
```

## Advanced Usage

### Custom Template Locations

```bash
# Use custom template location
DEV_RULES_TEMPLATE_DIR=/path/to/custom/template ./scripts/auto-trigger.sh

# Use remote template
DEV_RULES_TEMPLATE_URL=https://github.com/custom/template.git ./scripts/auto-trigger.sh
```

### Environment-Specific Rules

```bash
# Development environment
DEV_RULES_ENV=development ./scripts/auto-trigger.sh

# Production environment
DEV_RULES_ENV=production ./scripts/auto-trigger.sh

# Staging environment
DEV_RULES_ENV=staging ./scripts/auto-trigger.sh
```

### Project Type Detection

The system automatically detects project types based on:

- **Frontend**: `package.json`, `src/`, React/Vue/Angular files
- **Backend**: `requirements.txt`, `Cargo.toml`, `go.mod`, API files
- **Mobile**: `pubspec.yaml`, `android/`, `ios/`, React Native files
- **Firebase**: `firebase.json`, `.firebase/`, Firebase CLI
- **Full-Stack**: Multiple indicators present

### Customization Hooks

```bash
# Pre-setup hook
echo "Custom pre-setup logic" > .dev-rules-pre-hook.sh
chmod +x .dev-rules-pre-hook.sh

# Post-setup hook
echo "Custom post-setup logic" > .dev-rules-post-hook.sh
chmod +x .dev-rules-post-hook.sh

# Run with hooks
./scripts/auto-trigger.sh
```

## Troubleshooting

### Common Issues

1. **Permission Denied**
   ```bash
   chmod +x ~/dev-rules-template/scripts/*.sh
   chmod +x ~/dev-rules-template/scripts/triggers/*.sh
   ```

2. **Already Executed**
   ```bash
   # Force re-run
   ./scripts/auto-trigger.sh --force
   
   # Or remove marker file
   rm .dev-rules-executed
   ```

3. **Wrong AI Assistant Detected**
   ```bash
   # Use specific trigger
   ./scripts/triggers/copilot-trigger.sh /path/to/project
   ```

4. **Custom Configuration Not Applied**
   ```bash
   # Check for custom config
   ls -la .dev-rules-config.sh
   
   # Manual setup with custom config
   ./scripts/setup-rules.sh --config .dev-rules-config.sh
   ```

### Debug Mode

```bash
# Enable debug output
DEBUG=1 ./scripts/auto-trigger.sh

# Verbose logging
VERBOSE=1 ./scripts/auto-trigger.sh
```

## Best Practices

1. **Version Control**: Add dev-rules config files to version control
2. **Team Consistency**: Use organization-wide template repository
3. **Regular Updates**: Set up automated updates for rules
4. **Documentation**: Maintain project-specific rule documentation
5. **Testing**: Test rule changes in development environment first

## Support

For issues, questions, or contributions:
- Check the [main README](./README.md)
- Review [installation guide](./INSTALL.md)
- Open an issue on GitHub
- Contribute improvements via pull requests
