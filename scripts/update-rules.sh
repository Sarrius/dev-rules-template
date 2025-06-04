#!/bin/bash
# Script to update development rules in an existing project

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

echo "Updating development rules in $TARGET_DIR"

# Check if necessary directories exist, create if they don't
if [ ! -d "$TARGET_DIR/.tasks" ]; then
  mkdir -p "$TARGET_DIR/.tasks"
  echo "Created .tasks directory"
fi

if [ ! -d "$TARGET_DIR/.temp" ]; then
  mkdir -p "$TARGET_DIR/.temp"
  echo "Created .temp directory"
fi

if [ ! -d "$TARGET_DIR/.history" ]; then
  mkdir -p "$TARGET_DIR/.history" 
  echo "Created .history directory"
fi

if [ ! -d "$TARGET_DIR/.github" ]; then
  mkdir -p "$TARGET_DIR/.github"
  echo "Created .github directory"
fi

# Update GitHub files
cp "$BASE_DIR/.github/copilot-instructions.md" "$TARGET_DIR/.github/copilot-instructions.md"
echo "Updated copilot-instructions.md"

# Ask if user wants to update documentation files
if [ -d "$TARGET_DIR/docs/rules" ]; then
  read -p "Do you want to update rule documentation files? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp "$BASE_DIR/rules/"*.md "$TARGET_DIR/docs/rules/"
    echo "Documentation files updated in $TARGET_DIR/docs/rules/"
  fi
else
  read -p "Do you want to add rule documentation files to the project? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    mkdir -p "$TARGET_DIR/docs/rules"
    cp "$BASE_DIR/rules/"*.md "$TARGET_DIR/docs/rules/"
    echo "Documentation files added to $TARGET_DIR/docs/rules/"
  fi
fi

echo "Update complete! Development rules updated in $TARGET_DIR"
