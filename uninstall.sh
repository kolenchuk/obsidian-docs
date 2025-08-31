#!/bin/bash

INSTALL_DIR="$HOME/.obsidian-docs"
CLAUDE_COMMAND="$HOME/.claude/commands/obsidian-docs.md"

echo "🗑️ Uninstalling Obsidian Docs..."

# Remove installation directory
if [ -d "$INSTALL_DIR" ]; then
    echo "📁 Removing installation directory: $INSTALL_DIR"
    rm -rf "$INSTALL_DIR"
    echo "✅ Installation directory removed"
else
    echo "ℹ️ Installation directory not found"
fi

# Remove Claude Code slash command
if [ -f "$CLAUDE_COMMAND" ]; then
    echo "🔗 Removing Claude Code slash command"
    rm -f "$CLAUDE_COMMAND"
    echo "✅ Claude Code slash command removed"
else
    echo "ℹ️ Claude Code slash command not found"
fi

echo "✅ Uninstallation complete!"
echo "📚 Obsidian Docs has been completely removed from your system"