#!/bin/bash
# AI Assistant Detection and Setup Script
# Automatically detects which AI assistant is being used and applies optimal configuration

PROJECT_ROOT="$(pwd)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RULES_DIR="$(dirname "$SCRIPT_DIR")"

echo "🤖 Detecting AI Assistant and optimizing setup..."

# Function to detect AI assistant
detect_ai_assistant() {
    # Check for GitHub Copilot
    if command -v code >/dev/null 2>&1; then
        if code --list-extensions 2>/dev/null | grep -q "github.copilot"; then
            echo "copilot"
            return
        fi
    fi
    
    # Check for Cursor
    if command -v cursor >/dev/null 2>&1; then
        echo "cursor"
        return
    fi
    
    # Check for Windsurf
    if command -v windsurf >/dev/null 2>&1; then
        echo "windsurf"
        return
    fi
    
    # Check for Claude Desktop (Anthropic)
    if [ -d "/Applications/Claude.app" ] || command -v claude >/dev/null 2>&1; then
        echo "claude"
        return
    fi
    
    # Check for VS Code (generic)
    if command -v code >/dev/null 2>&1; then
        echo "vscode"
        return
    fi
    
    echo "generic"
}

# Function to setup for GitHub Copilot
setup_copilot() {
    echo "📝 Setting up for GitHub Copilot..."
    
    # Copy copilot-specific instructions
    mkdir -p "$PROJECT_ROOT/.github"
    cp "$RULES_DIR/.github/copilot-instructions.md" "$PROJECT_ROOT/.github/"
    
    # Create VS Code extensions recommendations
    mkdir -p "$PROJECT_ROOT/.vscode"
    cat > "$PROJECT_ROOT/.vscode/extensions.json" << 'EOF'
{
    "recommendations": [
        "github.copilot",
        "github.copilot-chat",
        "xyz.local-history",
        "gruntfuggly.todo-tree",
        "ms-vscode.vscode-json"
    ]
}
EOF
    
    # Create settings for optimal Copilot experience
    cat > "$PROJECT_ROOT/.vscode/settings.json" << 'EOF'
{
    "github.copilot.enable": {
        "*": true,
        "yaml": true,
        "plaintext": true,
        "markdown": true
    },
    "local-history.enabled": 1,
    "local-history.daysLimit": 30,
    "local-history.maxDisplay": 10,
    "todo-tree.general.tags": [
        "TODO",
        "FIXME",
        "BUG",
        "HACK",
        "NOTE",
        "REFACTOR"
    ],
    "files.exclude": {
        "**/.history": true
    }
}
EOF
    
    echo "✅ GitHub Copilot configuration complete"
}

# Function to setup for Cursor
setup_cursor() {
    echo "🖱️ Setting up for Cursor..."
    
    # Copy cursor-specific instructions
    mkdir -p "$PROJECT_ROOT/.cursor"
    cp "$RULES_DIR/.github/copilot-instructions.md" "$PROJECT_ROOT/.cursor/instructions.md"
    
    # Create cursor-specific configuration
    cat > "$PROJECT_ROOT/.cursor/cursor.json" << 'EOF'
{
    "rules": [
        "Read README.md before starting work",
        "Check .tasks/ folder for current task context",
        "Follow efficiency guidelines for parallel operations",
        "Use safety-first approach for refactoring",
        "Maintain file history awareness"
    ],
    "workflowEnabled": true,
    "complexityTracking": true
}
EOF
    
    echo "✅ Cursor configuration complete"
}

# Function to setup for Windsurf
setup_windsurf() {
    echo "🏄 Setting up for Windsurf..."
    
    # Copy windsurf-specific instructions
    mkdir -p "$PROJECT_ROOT/.windsurf"
    cp "$RULES_DIR/.github/copilot-instructions.md" "$PROJECT_ROOT/.windsurf/rules.md"
    
    # Create windsurf configuration
    cat > "$PROJECT_ROOT/.windsurf/config.json" << 'EOF'
{
    "workflow": {
        "phases": ["BEFORE", "DURING", "AFTER"],
        "complexity": ["E", "M", "H"],
        "trackProgress": true
    },
    "efficiency": {
        "parallelExecution": true,
        "batchOperations": true,
        "multiTask": true
    },
    "safety": {
        "preserveOriginals": true,
        "useHistoryFolder": true,
        "gradualMigration": true
    }
}
EOF
    
    echo "✅ Windsurf configuration complete"
}

# Function to setup for Claude
setup_claude() {
    echo "🧠 Setting up for Claude..."
    
    # Create claude-specific instructions
    mkdir -p "$PROJECT_ROOT/.claude"
    cp "$RULES_DIR/.github/copilot-instructions.md" "$PROJECT_ROOT/.claude/instructions.md"
    
    # Add Claude-specific context file
    cat > "$PROJECT_ROOT/.claude/context.md" << 'EOF'
# Claude Development Context

## Project Rules
This project follows structured development rules. Always:
1. Read README.md first
2. Check .tasks/ folder for current context
3. Follow workflow phases: BEFORE → DURING → AFTER
4. Use efficiency guidelines for parallel operations
5. Apply safety-first refactoring approach

## Key Directories
- `.tasks/` - Current task tracking
- `.temp/` - Temporary work files
- `.history/` - File version history
- `.claude/` - Claude-specific configuration

## Complexity Levels
- E: Easy (5-15min, ≤3 files)
- M: Medium (15-60min, ≤10 files, tests required)  
- H: Hard (60min+, architecture changes, tests required)
EOF
    
    echo "✅ Claude configuration complete"
}

# Function to setup for generic VS Code
setup_vscode() {
    echo "📝 Setting up for VS Code (generic)..."
    
    # Copy generic instructions
    mkdir -p "$PROJECT_ROOT/.vscode"
    cp "$RULES_DIR/.github/copilot-instructions.md" "$PROJECT_ROOT/.vscode/development-rules.md"
    
    # Create basic extensions recommendations
    cat > "$PROJECT_ROOT/.vscode/extensions.json" << 'EOF'
{
    "recommendations": [
        "xyz.local-history",
        "gruntfuggly.todo-tree",
        "ms-vscode.vscode-json",
        "ms-vscode.markdown-language-features"
    ]
}
EOF
    
    echo "✅ VS Code configuration complete"
}

# Function to setup generic fallback
setup_generic() {
    echo "🔧 Setting up generic configuration..."
    
    # Copy generic instructions to project root
    cp "$RULES_DIR/.github/copilot-instructions.md" "$PROJECT_ROOT/DEVELOPMENT_RULES.md"
    
    # Create simple reference file
    cat > "$PROJECT_ROOT/.dev-rules-config" << 'EOF'
# Development Rules Configuration
# This project uses structured development rules
# See DEVELOPMENT_RULES.md for complete guidelines
RULES_VERSION=1.0.0
WORKFLOW_ENABLED=true
COMPLEXITY_TRACKING=true
SAFETY_FIRST=true
EOF
    
    echo "✅ Generic configuration complete"
}

# Main execution
AI_ASSISTANT=$(detect_ai_assistant)
echo "🔍 Detected AI Assistant: $AI_ASSISTANT"

case $AI_ASSISTANT in
    "copilot")
        setup_copilot
        ;;
    "cursor")
        setup_cursor
        ;;
    "windsurf")
        setup_windsurf
        ;;
    "claude")
        setup_claude
        ;;
    "vscode")
        setup_vscode
        ;;
    *)
        setup_generic
        ;;
esac

echo ""
echo "🎉 AI Assistant optimization complete!"
echo "📋 Configured for: $AI_ASSISTANT"
echo "📁 Project rules are now active in: $PROJECT_ROOT"
echo ""
echo "Next steps:"
echo "1. Restart your editor/AI assistant"
echo "2. Open the project in your AI assistant"
echo "3. Start development with optimized rule awareness"
