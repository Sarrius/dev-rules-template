#!/bin/bash
# Auto-trigger script that detects AI assistant and runs appropriate setup

# Default values
FORCE_RERUN=false
SILENT_MODE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --force|-f)
            FORCE_RERUN=true
            shift
            ;;
        --silent|-s)
            SILENT_MODE=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --force, -f      Force re-run even if already executed"
            echo "  --silent, -s     Run in silent mode (minimal output)"
            echo "  --help, -h       Show this help message"
            echo ""
            echo "Environment variables:"
            echo "  DEV_RULES_FORCE=true     Same as --force"
            echo "  DEV_RULES_SILENT=true    Same as --silent"
            exit 0
            ;;
        -*)
            echo "Unknown option $1"
            exit 1
            ;;
    esac
done

# Check environment variables
if [ "$DEV_RULES_FORCE" = "true" ]; then
    FORCE_RERUN=true
fi

if [ "$DEV_RULES_SILENT" = "true" ]; then
    SILENT_MODE=true
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(pwd)"
TRIGGER_MARKER_DIR="$PROJECT_ROOT/.dev-rules/.triggers"

# Create trigger marker directory if it doesn't exist
mkdir -p "$TRIGGER_MARKER_DIR"

# Function to detect AI assistant
detect_ai_assistant() {
    # Check for Firebase AI Studio / Gemini first (most specific project indicators)
    if [ -f "$PROJECT_ROOT/.firebase" ] || [ -f "$PROJECT_ROOT/firebase.json" ] || [ -f "$PROJECT_ROOT/.gemini-rules" ]; then
        echo "gemini"
        return
    fi
    
    # Check for GitHub Copilot FIRST (VS Code with Copilot extensions installed)
    if [ -f "$PROJECT_ROOT/.github/copilot-instructions.md" ] || 
       ([ -d ~/.vscode/extensions ] && ls ~/.vscode/extensions/ | grep -q "github.copilot" 2>/dev/null) ||
       (pgrep -f "Visual Studio Code" >/dev/null 2>&1 && [ -d ~/.vscode/extensions ] && ls ~/.vscode/extensions/ | grep -q "github.copilot" 2>/dev/null); then
        echo "copilot"
        return
    fi
    
    # Check for Google AI Studio indicators
    if [ -f "$PROJECT_ROOT/.google-ai" ] || [ -f "$PROJECT_ROOT/.aistudio" ]; then
        echo "gemini"
        return
    fi
    
    # Check for Cursor (looks for cursor-specific files or processes, but NOT if VS Code is running)
    if ! pgrep -f "Visual Studio Code" >/dev/null 2>&1 && (pgrep -f "Cursor" >/dev/null 2>&1 || [ -f "$PROJECT_ROOT/.cursor-rules" ]); then
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
    
    # Check for Firebase CLI or related environment variables (with additional context)
    if command -v firebase >/dev/null 2>&1 || [ -n "$FIREBASE_TOKEN" ] || [ -n "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
        # Additional check for project context to avoid false positives
        if [ -f "$PROJECT_ROOT/firebase.json" ] || [ -d "$PROJECT_ROOT/.firebase" ]; then
            echo "gemini"
            return
        fi
    fi
    
    # Global GitHub Copilot check (last resort)
    if command -v gh >/dev/null 2>&1; then
        echo "copilot"
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
    if [ "$SILENT_MODE" != "true" ]; then
        echo "🔍 Auto-detecting AI assistant..."
    fi
    
    AI_TYPE=$(detect_ai_assistant)
    if [ "$SILENT_MODE" != "true" ]; then
        echo "📋 Detected AI assistant: $AI_TYPE"
    fi
    
    if [ "$FORCE_RERUN" != "true" ] && is_trigger_executed "$AI_TYPE"; then
        if [ "$SILENT_MODE" != "true" ]; then
            echo "✅ $AI_TYPE trigger already executed. Skipping..."
            echo "💡 To re-run, use --force or delete: $TRIGGER_MARKER_DIR/${AI_TYPE}_triggered"
        fi
        exit 0
    fi
    
    if [ "$SILENT_MODE" != "true" ]; then
        echo "🎯 First time setup for $AI_TYPE"
    fi
    execute_trigger "$AI_TYPE"
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
