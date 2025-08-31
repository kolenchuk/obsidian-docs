#!/bin/bash
set -e

INSTALL_DIR="$HOME/.obsidian-docs"
REPO_URL="https://github.com/kolenchuk/obsidian-docs.git"
OBSIDIAN_HELP_URL="https://github.com/obsidianmd/obsidian-help.git"

echo "🔧 Installing Obsidian Docs for Claude Code..."

# Create installation directory
echo "📁 Creating installation directory: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Clone or update main repository
echo "📥 Cloning obsidian-docs repository..."
if [ -d ".git" ]; then
    echo "📄 Existing installation found, updating..."
    git pull
else
    git clone "$REPO_URL" .
fi

# Clone Obsidian help documentation
echo "📥 Cloning Obsidian help documentation..."
if [ -d "obsidian-help" ]; then
    echo "📄 Updating existing Obsidian help docs..."
    cd obsidian-help
    git pull
    cd ..
else
    git clone "$OBSIDIAN_HELP_URL" obsidian-help
fi

# Copy English documentation to docs folder
echo "📋 Processing documentation..."
rm -rf docs/
mkdir -p docs/
cp -r obsidian-help/en/* docs/

# Copy helper script and make it executable
if [ -f "scripts/obsidian-docs-helper.sh" ]; then
    cp scripts/obsidian-docs-helper.sh "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/obsidian-docs-helper.sh"
fi

# Create Claude Code slash command
CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
mkdir -p "$COMMANDS_DIR"

echo "🔗 Creating Claude Code integration..."
cat > "$COMMANDS_DIR/obsidian-docs.md" << 'EOF'
Execute the Obsidian Docs helper script

Usage:
- /obsidian-docs - List available categories
- /obsidian-docs update - Update documentation from source
- /obsidian-docs search <term> - Search for files containing term
- /obsidian-docs content <term> - Search content with context
- /obsidian-docs show <category> - Show files in specific category
- /obsidian-docs status - Show installation status
- /obsidian-docs help - Show this help

Quick access:
- /obsidian-docs plugins - Plugin documentation
- /obsidian-docs sync - Sync documentation
- /obsidian-docs publish - Publish documentation

Execute: ~/.obsidian-docs/obsidian-docs-helper.sh "$ARGUMENTS"
EOF

# Update timestamp
date > "$INSTALL_DIR/.last_update"

echo "✅ Installation complete!"
echo "📚 Use /obsidian-docs to access documentation"
echo "🔄 Use /obsidian-docs update to refresh documentation"
echo "🔍 Use /obsidian-docs search <term> to search documentation"