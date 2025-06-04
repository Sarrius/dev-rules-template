# Installation Instructions

## Requirements

- Git
- Bash or Zsh shell

## Basic Installation

### Option 1: Using the Installation Script

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dev-rules-template.git
   ```

2. Run the setup script:
   ```bash
   cd dev-rules-template
   ./scripts/setup-rules.sh /path/to/your/project
   ```

### Option 2: Manual Installation

1. Copy the template folders to your project:
   ```bash
   cp -r dev-rules-template/templates/. /path/to/your/project/
   cp -r dev-rules-template/.github /path/to/your/project/
   ```

2. Create required directories:
   ```bash
   mkdir -p /path/to/your/project/.tasks
   mkdir -p /path/to/your/project/.temp
   ```

3. Copy the template files:
   ```bash
   cp dev-rules-template/templates/.tasks/current.json.template /path/to/your/project/.tasks/current.json
   cp dev-rules-template/templates/.tasks/progress.md.template /path/to/your/project/.tasks/progress.md
   ```

## Configuration

### AI Assistant Configuration

If you're using GitHub Copilot or another AI assistant:

1. Ensure the `.github/copilot-instructions.md` file has been copied to your project
2. Customize any project-specific rules as needed

### IDE Integration

For optimal experience, consider installing these VS Code extensions:

- Local History extension for `.history` folder tracking
- Todo Tree extension for task tracking

### Git Configuration

Add these directories to your `.gitignore`:

```
.history/
.temp/
```

But keep `.tasks/` tracked to maintain project progress information.

## Updating Rules

To update to the latest version of the development rules:

```bash
./scripts/update-rules.sh /path/to/your/project
```

## Troubleshooting

If you encounter issues, see the [Troubleshooting section in README.md](./README.md#troubleshooting).
