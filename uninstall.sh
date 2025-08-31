#!/bin/bash

INSTALL_DIR="$HOME/.obsidian-docs"
CLAUDE_HOOK="$HOME/.claude/obsidian-docs-hook.sh"

echo "🗑️ Uninstalling Obsidian Docs..."

# Remove installation directory
if [ -d "$INSTALL_DIR" ]; then
    echo "📁 Removing installation directory: $INSTALL_DIR"
    rm -rf "$INSTALL_DIR"
    echo "✅ Installation directory removed"
else
    echo "ℹ️ Installation directory not found"
fi

# Remove Claude Code hook
if [ -f "$CLAUDE_HOOK" ]; then
    echo "🔗 Removing Claude Code hook"
    rm -f "$CLAUDE_HOOK"
    echo "✅ Claude Code hook removed"
else
    echo "ℹ️ Claude Code hook not found"
fi

echo "✅ Uninstallation complete!"
echo "📚 Obsidian Docs has been completely removed from your system"