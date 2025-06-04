#!/bin/bash
# Auto-trigger script that detects AI assistant and runs appropriate setup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(pwd)"
TRIGGER_MARKER_DIR="$PROJECT_ROOT/.dev-rules/.triggers"

# Create trigger marker directory if it doesn't exist
mkdir -p "$TRIGGER_MARKER_DIR"

# Function to detect AI assistant
detect_ai_assistant() {
    # Check for GitHub Copilot
    if [ -f "$PROJECT_ROOT/.github/copilot-instructions.md" ] || command -v gh >/dev/null 2>&1; then
        echo "copilot"
        return
    fi
    
    # Check for Cursor (looks for cursor-specific files or processes)
    if pgrep -f "Cursor" >/dev/null 2>&1 || [ -f "$PROJECT_ROOT/.cursor-rules" ]; then
        echo "cursor"
        return
    fi
    
    # Check for Windsurf (looks for windsurf-specific indicators)
    if pgrep -f "windsurf" >/dev/null 2>&1 || [ -f "$PROJECT_ROOT/.windsurf" ]; then
        echo "windsurf"
        return
    fi
    
    # Check for Claude Dev (VS Code extension)
    if [ -d "$PROJECT_ROOT/.vscode" ] && grep -q "claude" "$PROJECT_ROOT/.vscode/extensions.json" 2>/dev/null; then
        echo "claude"
        return
    fi
    
    # Check for Cline (formerly Claude Dev)
    if [ -d "$PROJECT_ROOT/.vscode" ] && grep -q "cline" "$PROJECT_ROOT/.vscode/extensions.json" 2>/dev/null; then
        echo "cline"
        return
    fi
    
    # Default fallback
    echo "generic"
}

# Function to check if trigger has been executed
is_trigger_executed() {
    local ai_type="$1"
    [ -f "$TRIGGER_MARKER_DIR/${ai_type}_triggered" ]
}

# Function to mark trigger as executed
mark_trigger_executed() {
    local ai_type="$1"
    echo "$(date)" > "$TRIGGER_MARKER_DIR/${ai_type}_triggered"
}

# Function to execute trigger script
execute_trigger() {
    local ai_type="$1"
    local trigger_script="$SCRIPT_DIR/triggers/${ai_type}-trigger.sh"
    
    if [ -f "$trigger_script" ]; then
        echo "🚀 Executing $ai_type trigger script..."
        bash "$trigger_script" "$PROJECT_ROOT"
        mark_trigger_executed "$ai_type"
        echo "✅ $ai_type trigger completed and marked as executed"
    else
        echo "⚠️  No specific trigger found for $ai_type, using generic setup"
        bash "$SCRIPT_DIR/triggers/generic-trigger.sh" "$PROJECT_ROOT"
        mark_trigger_executed "$ai_type"
    fi
}

# Main execution
main() {
    echo "🔍 Auto-detecting AI assistant..."
    
    AI_TYPE=$(detect_ai_assistant)
    echo "📋 Detected AI assistant: $AI_TYPE"
    
    if is_trigger_executed "$AI_TYPE"; then
        echo "✅ $AI_TYPE trigger already executed. Skipping..."
        echo "💡 To re-run, delete: $TRIGGER_MARKER_DIR/${AI_TYPE}_triggered"
        exit 0
    fi
    
    echo "🎯 First time setup for $AI_TYPE"
    execute_trigger "$AI_TYPE"
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
