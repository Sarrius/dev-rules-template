#!/bin/bash
# Cursor specific trigger script

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

echo "🚀 Setting up development rules for Cursor..."

# Run the main setup script
bash "$SCRIPT_DIR/setup-rules.sh" "$PROJECT_ROOT"

# Cursor specific setup
echo "📝 Configuring Cursor specific settings..."

# Create .cursor-rules file with our development rules
echo "📋 Creating Cursor rules file..."
cat "$SCRIPT_DIR/rules"/*.md > "$PROJECT_ROOT/.cursor-rules"

# Add Cursor-specific header
sed -i '1i# Cursor Development Rules\n' "$PROJECT_ROOT/.cursor-rules"

# Setup VS Code extensions for Cursor (since Cursor is VS Code based)
if [ ! -d "$PROJECT_ROOT/.vscode" ]; then
    mkdir -p "$PROJECT_ROOT/.vscode"
fi

# Create or update extensions.json with Cursor-friendly recommendations
cat > "$PROJECT_ROOT/.vscode/extensions.json" << 'EOF'
{
    "recommendations": [
        "ms-vscode.vscode-json",
        "esbenp.prettier-vscode",
        "bradlc.vscode-tailwindcss",
        "ms-python.python",
        "ms-vscode.vscode-typescript-next",
        "ms-vscode.live-server"
    ]
}
EOF

echo "✅ Cursor setup completed!"
echo "💡 Review .cursor-rules for AI assistant guidelines"
echo "📖 Cursor will automatically use the rules in .cursor-rules file"
