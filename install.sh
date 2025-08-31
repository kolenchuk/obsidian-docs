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

# Create Claude Code hook
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"

echo "🔗 Creating Claude Code integration..."
cat > "$CLAUDE_DIR/obsidian-docs-hook.sh" << 'EOF'
#!/bin/bash
if [[ "$1" == "/obsidian-docs"* ]]; then
    ~/.obsidian-docs/obsidian-docs-helper.sh "$@"
fi
EOF

chmod +x "$CLAUDE_DIR/obsidian-docs-hook.sh"

# Update timestamp
date > "$INSTALL_DIR/.last_update"

echo "✅ Installation complete!"
echo "📚 Use /obsidian-docs to access documentation"
echo "🔄 Use /obsidian-docs update to refresh documentation"
echo "🔍 Use /obsidian-docs search <term> to search documentation"