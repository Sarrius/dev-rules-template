#!/bin/bash
# Setup script to install development rules into a project

# Check if target directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/target/project"
  exit 1
fi

TARGET_DIR="$1"
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

# Copy rule documentation (optional)
if [ ! -d "$TARGET_DIR/docs" ]; then
  mkdir -p "$TARGET_DIR/docs/rules"
fi

# Ask if user wants to copy documentation files
read -p "Do you want to copy rule documentation files to the project? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  cp "$BASE_DIR/rules/"*.md "$TARGET_DIR/docs/rules/"
  echo "Documentation files copied to $TARGET_DIR/docs/rules/"
fi

# Recommend .gitignore additions
echo "Consider adding these lines to your .gitignore file:"
echo ".history/"
echo ".temp/"
echo "But keep .tasks/ tracked for project progress information."

echo "Setup complete! Development rules installed in $TARGET_DIR"
