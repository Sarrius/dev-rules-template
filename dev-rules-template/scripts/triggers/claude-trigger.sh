#!/bin/bash
# Claude Dev specific trigger script

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

echo "🚀 Setting up development rules for Claude Dev..."

# Run the main setup script
bash "$SCRIPT_DIR/setup-rules.sh" "$PROJECT_ROOT"

# Claude Dev specific setup
echo "📝 Configuring Claude Dev specific settings..."

# Create .claude-dev directory for configuration
mkdir -p "$PROJECT_ROOT/.claude-dev"

# Create claude-dev-specific rules file
echo "📋 Creating Claude Dev rules file..."
cat "$SCRIPT_DIR/rules"/*.md > "$PROJECT_ROOT/.claude-dev/instructions.md"

# Add header specific to Claude Dev
sed -i '1i# Claude Dev Development Instructions\n' "$PROJECT_ROOT/.claude-dev/instructions.md"

# Setup VS Code extensions for Claude Dev
if [ ! -d "$PROJECT_ROOT/.vscode" ]; then
    mkdir -p "$PROJECT_ROOT/.vscode"
fi

# Create or update extensions.json with Claude Dev
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

echo "✅ Claude Dev setup completed!"
echo "💡 Check .claude-dev/ directory for instruction files"
echo "📖 Claude Dev will reference .claude-dev/instructions.md"
