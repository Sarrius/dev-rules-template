#!/bin/bash
# Claude Dev specific trigger script

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

echo "🚀 Setting up development rules for Claude Dev..."

# Run the main setup script in automated mode
bash "$SCRIPT_DIR/setup-rules.sh" --auto "$PROJECT_ROOT"

# Claude Dev specific setup
echo "📝 Configuring Claude Dev specific settings..."

# Create .claude-dev directory for configuration
mkdir -p "$PROJECT_ROOT/.claude-dev"

# Create claude-dev-specific rules file
echo "📋 Creating Claude Dev rules file..."
cat "$SCRIPT_DIR/../rules"/*.md > "$PROJECT_ROOT/.claude-dev/instructions.md"

echo "✅ Claude Dev setup completed!"
echo "💡 Check .claude-dev/ directory for instruction files"
echo "📖 Claude Dev will reference .claude-dev/instructions.md"
