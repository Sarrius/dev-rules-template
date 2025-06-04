#!/bin/bash
# Firebase AI Studio / Gemini specific trigger script

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

echo "🚀 Setting up development rules for Firebase AI Studio / Gemini..."

# Run the main setup script in automated mode
bash "$SCRIPT_DIR/setup-rules.sh" --auto "$PROJECT_ROOT"

# Firebase AI Studio / Gemini specific setup
echo "📝 Configuring Firebase AI Studio / Gemini specific settings..."

# Create .gemini-rules directory for configuration
mkdir -p "$PROJECT_ROOT/.gemini-rules"

# Create gemini-specific rules file with enhanced instructions for Firebase AI Studio
echo "📋 Creating Firebase AI Studio / Gemini rules file..."
cat "$SCRIPT_DIR/../rules"/*.md > "$PROJECT_ROOT/.gemini-rules/instructions.md"

# Add Firebase AI Studio specific header and context
cat > "$PROJECT_ROOT/.gemini-rules/firebase-ai-context.md" << 'EOF'
# Firebase AI Studio / Gemini Development Context

## Firebase AI Studio Integration
When working with Firebase AI Studio:
- Utilize Firebase's AI capabilities for intelligent code suggestions
- Leverage Gemini models for code generation and optimization
- Integrate with Firebase services (Firestore, Auth, Functions, etc.)
- Follow Firebase best practices for scalable applications

## Gemini Model Capabilities
- Code generation and completion
- Bug detection and fixing
- Code explanation and documentation
- Refactoring suggestions
- Performance optimization recommendations

## Firebase Services Integration
- **Firestore**: NoSQL database with real-time capabilities
- **Authentication**: User management and security
- **Cloud Functions**: Serverless backend logic
- **Hosting**: Web app deployment
- **Storage**: File storage and management
- **Analytics**: User behavior tracking

## Best Practices
- Use Firebase SDK efficiently
- Implement proper error handling for Firebase operations
- Follow Firebase security rules
- Optimize for offline capabilities when using Firestore
- Implement proper data validation
EOF

# Combine all rules into one comprehensive file
cat "$PROJECT_ROOT/.gemini-rules/firebase-ai-context.md" "$PROJECT_ROOT/.gemini-rules/instructions.md" > "$PROJECT_ROOT/.gemini-rules/complete-rules.md"

# Create Firebase AI Studio workspace configuration
cat > "$PROJECT_ROOT/.aistudio" << 'EOF'
{
  "version": "1.0",
  "rules": {
    "source": ".gemini-rules/complete-rules.md",
    "autoApply": true
  },
  "firebase": {
    "integration": true,
    "services": ["firestore", "auth", "functions", "hosting", "storage"]
  },
  "gemini": {
    "model": "gemini-pro",
    "features": ["code-generation", "optimization", "debugging", "documentation"]
  }
}
EOF

# Setup VS Code extensions for Firebase development
if [ ! -d "$PROJECT_ROOT/.vscode" ]; then
    mkdir -p "$PROJECT_ROOT/.vscode"
fi

# Create or update extensions.json with Firebase and Gemini recommendations
cat > "$PROJECT_ROOT/.vscode/extensions.json" << 'EOF'
{
    "recommendations": [
        "ms-vscode.vscode-json",
        "esbenp.prettier-vscode",
        "firebase.vscode-firebase-explorer",
        "toba.vsfire",
        "bradlc.vscode-tailwindcss",
        "ms-python.python",
        "ms-vscode.vscode-typescript-next",
        "ms-vscode.live-server"
    ]
}
EOF

# Create Firebase configuration template if it doesn't exist
if [ ! -f "$PROJECT_ROOT/firebase.json" ]; then
    cat > "$PROJECT_ROOT/firebase.json" << 'EOF'
{
  "hosting": {
    "public": "build",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  },
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "functions": {
    "predeploy": [
      "npm --prefix \"$RESOURCE_DIR\" run lint",
      "npm --prefix \"$RESOURCE_DIR\" run build"
    ]
  }
}
EOF
    echo "📄 Created firebase.json template"
fi

echo "✅ Firebase AI Studio / Gemini setup completed!"
echo "💡 Check .gemini-rules/ directory for instruction files"
echo "📖 Firebase AI Studio will reference .gemini-rules/complete-rules.md"
echo "🔥 Firebase configuration created in firebase.json"
echo "🚀 Install recommended extensions for optimal Firebase development experience"
