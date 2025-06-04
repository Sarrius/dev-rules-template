#!/bin/bash
# Windsurf specific trigger script

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

echo "🚀 Setting up development rules for Windsurf..."

# Run the main setup script in automated mode
bash "$SCRIPT_DIR/setup-rules.sh" --auto "$PROJECT_ROOT"

# Windsurf specific setup
echo "📝 Configuring Windsurf specific settings..."

# Create .windsurf directory for configuration
mkdir -p "$PROJECT_ROOT/.windsurf"

# Create windsurf-specific rules file
echo "📋 Creating Windsurf rules file..."
cat "$SCRIPT_DIR/../rules"/*.md > "$PROJECT_ROOT/.windsurf/rules.md"

echo "✅ Windsurf setup completed!"
echo "💡 Check .windsurf/ directory for configuration files"
echo "📖 Windsurf will use the rules in .windsurf/rules.md"
