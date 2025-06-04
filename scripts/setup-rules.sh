#!/bin/bash
# Setup script to install development rules into a project

# Default values
COPY_DOCS=false
AUTO_MODE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --auto|-a)
            AUTO_MODE=true
            COPY_DOCS=true
            shift
            ;;
        --copy-docs|-d)
            COPY_DOCS=true
            shift
            ;;
        --no-docs)
            COPY_DOCS=false
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS] /path/to/target/project"
            echo ""
            echo "Options:"
            echo "  --auto, -a       Run in automated mode (no prompts, copy docs)"
            echo "  --copy-docs, -d  Copy documentation files"
            echo "  --no-docs        Skip copying documentation files"
            echo "  --help, -h       Show this help message"
            echo ""
            echo "Environment variables:"
            echo "  DEV_RULES_AUTO=true    Same as --auto"
            echo "  DEV_RULES_COPY_DOCS=true/false    Control doc copying"
            exit 0
            ;;
        -*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            TARGET_DIR="$1"
            shift
            ;;
    esac
done

# Check environment variables for automation
if [ "$DEV_RULES_AUTO" = "true" ]; then
    AUTO_MODE=true
    COPY_DOCS=true
fi

if [ "$DEV_RULES_COPY_DOCS" = "true" ]; then
    COPY_DOCS=true
elif [ "$DEV_RULES_COPY_DOCS" = "false" ]; then
    COPY_DOCS=false
fi

# Check if target directory is provided
if [ -z "$TARGET_DIR" ]; then
  echo "Usage: $0 [OPTIONS] /path/to/target/project"
  echo "Use --help for more options"
  exit 1
fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Target directory '$TARGET_DIR' does not exist."
  exit 1
fi

echo "Setting up development rules in $TARGET_DIR"

# Create necessary directories
mkdir -p "$TARGET_DIR/.tasks"
mkdir -p "$TARGET_DIR/.temp"
mkdir -p "$TARGET_DIR/.history"
mkdir -p "$TARGET_DIR/.github"

# Copy template files
cp "$BASE_DIR/templates/.tasks/current.json.template" "$TARGET_DIR/.tasks/current.json"
cp "$BASE_DIR/templates/.tasks/progress.md.template" "$TARGET_DIR/.tasks/progress.md"

# Copy README files
cp "$BASE_DIR/templates/.temp/README.md" "$TARGET_DIR/.temp/README.md" 2>/dev/null
cp "$BASE_DIR/templates/.history/README.md" "$TARGET_DIR/.history/README.md" 2>/dev/null

# Copy GitHub files
cp "$BASE_DIR/.github/copilot-instructions.md" "$TARGET_DIR/.github/copilot-instructions.md"

# Copy rule documentation (conditional)
if [ ! -d "$TARGET_DIR/docs" ]; then
  mkdir -p "$TARGET_DIR/docs/rules"
fi

# Handle documentation copying based on mode
if [ "$AUTO_MODE" = "true" ]; then
    if [ "$COPY_DOCS" = "true" ]; then
        cp "$BASE_DIR/rules/"*.md "$TARGET_DIR/docs/rules/"
        echo "Documentation files copied to $TARGET_DIR/docs/rules/"
    fi
else
    # Interactive mode - ask user
    read -p "Do you want to copy rule documentation files to the project? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp "$BASE_DIR/rules/"*.md "$TARGET_DIR/docs/rules/"
        echo "Documentation files copied to $TARGET_DIR/docs/rules/"
    fi
fi

# Recommend .gitignore additions
echo "Consider adding these lines to your .gitignore file:"
echo ".history/"
echo ".temp/"
echo "But keep .tasks/ tracked for project progress information."

echo "Setup complete! Development rules installed in $TARGET_DIR"
