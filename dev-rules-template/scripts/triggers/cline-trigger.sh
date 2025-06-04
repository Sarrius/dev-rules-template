#!/bin/bash
# Cline (formerly Claude Dev) specific trigger script

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

echo "🚀 Setting up development rules for Cline..."

# Run the main setup script
bash "$SCRIPT_DIR/setup-rules.sh" "$PROJECT_ROOT"

# Cline specific setup
echo "📝 Configuring Cline specific settings..."

# Create .cline directory for configuration
mkdir -p "$PROJECT_ROOT/.cline"

# Create cline-specific rules file
echo "📋 Creating Cline rules file..."
cat "$SCRIPT_DIR/rules"/*.md > "$PROJECT_ROOT/.cline/instructions.md"

# Add header specific to Cline
sed -i '1i# Cline Development Instructions\n' "$PROJECT_ROOT/.cline/instructions.md"

# Setup VS Code extensions for Cline
if [ ! -d "$PROJECT_ROOT/.vscode" ]; then
    mkdir -p "$PROJECT_ROOT/.vscode"
fi

# Create or update extensions.json with Cline
cat > "$PROJECT_ROOT/.vscode/extensions.json" << 'EOF'
{
    "recommendations": [
        "saoudrizwan.claude-dev",
        "ms-vscode.vscode-json",
        "esbenp.prettier-vscode",
        "bradlc.vscode-tailwindcss",
        "ms-python.python",
        "ms-vscode.vscode-typescript-next"
    ]
}
EOF

echo "✅ Cline setup completed!"
echo "💡 Check .cline/ directory for instruction files"
echo "📖 Cline will reference .cline/instructions.md"
