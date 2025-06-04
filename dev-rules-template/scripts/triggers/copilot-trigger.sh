#!/bin/bash
# GitHub Copilot specific trigger script

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

echo "🚀 Setting up development rules for GitHub Copilot..."

# Run the main setup script
bash "$SCRIPT_DIR/setup-rules.sh" "$PROJECT_ROOT"

# GitHub Copilot specific setup
echo "📝 Configuring GitHub Copilot specific settings..."

# Ensure .github directory exists
mkdir -p "$PROJECT_ROOT/.github"

# Create or update copilot-instructions.md with our enhanced template
if [ ! -f "$PROJECT_ROOT/.github/copilot-instructions.md" ]; then
    echo "📋 Creating GitHub Copilot instructions..."
    cp "$SCRIPT_DIR/.github/copilot-instructions.md" "$PROJECT_ROOT/.github/"
else
    echo "⚠️  Existing copilot-instructions.md found. Backup created."
    cp "$PROJECT_ROOT/.github/copilot-instructions.md" "$PROJECT_ROOT/.github/copilot-instructions.md.backup"
    cp "$SCRIPT_DIR/.github/copilot-instructions.md" "$PROJECT_ROOT/.github/"
fi

# Setup VS Code extensions for Copilot
if [ ! -d "$PROJECT_ROOT/.vscode" ]; then
    mkdir -p "$PROJECT_ROOT/.vscode"
fi

# Create or update extensions.json with Copilot recommendations
cat > "$PROJECT_ROOT/.vscode/extensions.json" << 'EOF'
{
    "recommendations": [
        "github.copilot",
        "github.copilot-chat",
        "ms-vscode.vscode-json",
        "esbenp.prettier-vscode",
        "bradlc.vscode-tailwindcss",
        "ms-python.python",
        "ms-vscode.vscode-typescript-next"
    ]
}
EOF

echo "✅ GitHub Copilot setup completed!"
echo "💡 Make sure to install the recommended extensions in VS Code"
echo "📖 Review .github/copilot-instructions.md for usage guidelines"
