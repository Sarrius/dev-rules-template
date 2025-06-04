#!/bin/bash
# Windsurf specific trigger script

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

echo "🚀 Setting up development rules for Windsurf..."

# Run the main setup script
bash "$SCRIPT_DIR/setup-rules.sh" "$PROJECT_ROOT"

# Windsurf specific setup
echo "📝 Configuring Windsurf specific settings..."

# Create .windsurf directory for configuration
mkdir -p "$PROJECT_ROOT/.windsurf"

# Create windsurf-specific rules file
echo "📋 Creating Windsurf rules file..."
cat "$SCRIPT_DIR/rules"/*.md > "$PROJECT_ROOT/.windsurf/rules.md"

# Add Windsurf-specific configuration
cat > "$PROJECT_ROOT/.windsurf/config.json" << 'EOF'
{
    "rules": {
        "source": "./rules.md",
        "autoApply": true
    },
    "workflow": {
        "taskTracking": true,
        "progressUpdates": true
    },
    "refactoring": {
        "safetyFirst": true,
        "preserveOriginals": true
    }
}
EOF

# Setup VS Code extensions for Windsurf
if [ ! -d "$PROJECT_ROOT/.vscode" ]; then
    mkdir -p "$PROJECT_ROOT/.vscode"
fi

# Create or update extensions.json
cat > "$PROJECT_ROOT/.vscode/extensions.json" << 'EOF'
{
    "recommendations": [
        "ms-vscode.vscode-json",
        "esbenp.prettier-vscode",
        "bradlc.vscode-tailwindcss",
        "ms-python.python",
        "ms-vscode.vscode-typescript-next"
    ]
}
EOF

echo "✅ Windsurf setup completed!"
echo "💡 Check .windsurf/ directory for configuration files"
echo "📖 Windsurf will use the rules in .windsurf/rules.md"
