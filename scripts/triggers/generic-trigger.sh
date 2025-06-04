#!/bin/bash
# Generic trigger script for unknown/generic AI assistants

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

echo "🚀 Setting up generic development rules..."

# Run the main setup script in automated mode
bash "$SCRIPT_DIR/setup-rules.sh" --auto "$PROJECT_ROOT"

# Generic AI assistant setup
echo "📝 Configuring generic AI assistant settings..."

# Create .ai-rules directory for configuration
mkdir -p "$PROJECT_ROOT/.ai-rules"

# Create generic rules file
echo "📋 Creating generic AI rules file..."
cat "$SCRIPT_DIR/../rules"/*.md > "$PROJECT_ROOT/.ai-rules/instructions.md"

# Add generic header
sed -i '1i# AI Assistant Development Instructions\n\nThese are generic development rules that can be used with any AI coding assistant.\n' "$PROJECT_ROOT/.ai-rules/instructions.md"

# Setup basic VS Code extensions
if [ ! -d "$PROJECT_ROOT/.vscode" ]; then
    mkdir -p "$PROJECT_ROOT/.vscode"
fi

# Create or update extensions.json with basic recommendations
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

# Create a simple README for AI instructions
cat > "$PROJECT_ROOT/.ai-rules/README.md" << 'EOF'
# AI Assistant Development Rules

This directory contains development rules and guidelines for AI coding assistants.

## Files:
- `instructions.md` - Main development rules and guidelines
- `README.md` - This file

## Usage:
These rules can be referenced by any AI coding assistant to maintain consistent development practices across the project.

## Supported AI Assistants:
- GitHub Copilot
- Cursor
- Windsurf  
- Claude Dev
- Cline
- And any other AI coding assistant

## Customization:
Feel free to modify the instructions.md file to match your specific project needs and coding preferences.
EOF

echo "✅ Generic AI assistant setup completed!"
echo "💡 Check .ai-rules/ directory for instruction files"
echo "📖 Reference .ai-rules/instructions.md in your AI assistant"
echo "🔧 You can customize the rules for your specific AI assistant"
