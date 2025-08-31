# Obsidian Docs

A local documentation mirror for Obsidian, specifically designed for Claude Code integration. Provides instant access to comprehensive, up-to-date Obsidian documentation for AI-assisted vault management and advanced workflows.

## Features

- ⚡ **Instant documentation access** via `/obsidian-docs` command in Claude Code
- 📚 **Complete Obsidian documentation** mirrored from official sources
- 🔍 **Fast search capabilities** for specific topics and features
- 🔄 **Manual update system** - update documentation when you need it
- 🚀 **Local performance** - faster than web-based documentation
- 🧠 **AI-optimized structure** for efficient Claude Code queries

## Installation

### One-Line Installation

```bash
curl -fsSL https://raw.githubusercontent.com/kolenchuk/obsidian-docs/main/install.sh | bash
```

### Alternative Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/kolenchuk/obsidian-docs.git
   cd obsidian-docs
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

This will:
- Install documentation to `~/.obsidian-docs/`
- Set up Claude Code integration
- Download the latest Obsidian documentation
- Configure the `/obsidian-docs` command

### Manual Installation

If you prefer manual setup:

1. Create installation directory:
   ```bash
   mkdir -p ~/.obsidian-docs
   cd ~/.obsidian-docs
   ```

2. Clone repositories:
   ```bash
   git clone https://github.com/kolenchuk/obsidian-docs.git .
   git clone https://github.com/obsidianmd/obsidian-help.git obsidian-help
   ```

3. Set up documentation:
   ```bash
   cp -r obsidian-help/en/* docs/
   cp scripts/obsidian-docs-helper.sh .
   chmod +x obsidian-docs-helper.sh
   ```

4. Create Claude Code slash command:
   ```bash
   mkdir -p ~/.claude/commands
   cat > ~/.claude/commands/obsidian-docs.md << 'EOF'
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
   ```

## Usage

### Basic Commands

- `/obsidian-docs` - List available documentation categories
- `/obsidian-docs help` - Show all available commands
- `/obsidian-docs status` - Show installation status and statistics

### Search and Navigation

- `/obsidian-docs search <term>` - Search for files containing a specific term
- `/obsidian-docs content <term>` - Search content with context preview
- `/obsidian-docs show <category>` - List files in a specific category

### Quick Access Commands

- `/obsidian-docs plugins` - Direct access to plugin documentation
- `/obsidian-docs sync` - Obsidian Sync help and troubleshooting  
- `/obsidian-docs publish` - Obsidian Publish workflows and setup

### Update Documentation

- `/obsidian-docs update` - Manually update documentation from source

## Documentation Categories

The documentation includes these main categories:

- **Getting started** - Basic setup and initial configuration
- **Editing and formatting** - Markdown syntax and advanced formatting
- **Files and folders** - File management workflows
- **Linking notes and files** - Wikilinks, backlinks, and embedding
- **Plugins** - Core and community plugins (33+ files)
- **User interface** - Interface customization and themes
- **Obsidian Publish** - Publishing workflows and configuration
- **Obsidian Sync** - Synchronization setup and troubleshooting
- **Import notes** - Importing from various sources
- **Teams** - Obsidian for team collaboration

## Examples

### Getting Plugin Help
```bash
# List all plugin documentation
/obsidian-docs plugins

# Search for specific plugin information
/obsidian-docs search "daily notes"

# Find content about templates
/obsidian-docs content template
```

### Troubleshooting Sync Issues
```bash
# Access sync documentation
/obsidian-docs sync

# Search for sync problems
/obsidian-docs search "sync conflict"
```

### Setting Up Publishing
```bash
# View publish documentation
/obsidian-docs publish

# Search for publish configuration
/obsidian-docs search "custom domain"
```

## Update Strategy

This project uses **manual updates only**:

- **No automated syncing** - Updates only when requested
- **User control** - You decide when to refresh documentation  
- **Resource efficient** - No unnecessary API calls or storage
- **Simple maintenance** - No complex automation to maintain

To update documentation:
```bash
/obsidian-docs update
```

## Installation Status

Check if everything is working correctly:
```bash
/obsidian-docs status
```

Expected output:
```
📚 Obsidian Docs Status:
📁 Installation directory: /home/user/.obsidian-docs
🔄 Last updated: [timestamp]
📊 Documentation files: 158
🔗 Claude Code slash command installed
```

## Uninstallation

### Method 1: Using the uninstall script (Recommended)

```bash
~/.obsidian-docs/uninstall.sh
```

### Method 2: One-line uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/kolenchuk/obsidian-docs/main/uninstall.sh | bash
```

### Method 3: Manual removal

```bash
rm -rf ~/.obsidian-docs ~/.claude/commands/obsidian-docs.md
```

This will remove:
- Installation directory (`~/.obsidian-docs/`)
- Claude Code slash command (`~/.claude/commands/obsidian-docs.md`)
- All downloaded documentation

## Troubleshooting

### Command Not Found

If `/obsidian-docs` doesn't work:

1. Check installation status:
   ```bash
   ~/.obsidian-docs/obsidian-docs-helper.sh "/obsidian-docs status"
   ```

2. Verify slash command exists:
   ```bash
   ls -la ~/.claude/commands/obsidian-docs.md
   ```

3. Test helper script manually:
   ```bash
   ~/.obsidian-docs/obsidian-docs-helper.sh "/obsidian-docs help"
   ```

### Documentation Not Found

If you get "Documentation not found" errors:

1. Run the update command:
   ```bash
   /obsidian-docs update
   ```

2. Check directory exists:
   ```bash
   ls -la ~/.obsidian-docs/docs/
   ```

3. Reinstall if necessary:
   ```bash
   ./uninstall.sh
   ./install.sh
   ```

### Search Not Working

If search returns no results:

1. Check documentation is installed:
   ```bash
   /obsidian-docs status
   ```

2. Try alternative search terms
3. Use content search for broader results:
   ```bash
   /obsidian-docs content <term>
   ```

## Technical Details

### File Structure
```
~/.obsidian-docs/
├── docs/                      # Mirrored documentation
│   ├── Getting started/
│   ├── Plugins/
│   ├── Obsidian Sync/
│   └── ...
├── obsidian-help/            # Source repository
├── obsidian-docs-helper.sh   # Main script
└── .last_update             # Update timestamp
```

### Requirements
- Bash shell
- Git (for updates)
- Claude Code (for integration)
- ~50MB disk space

### Performance
- **Documentation files**: 158 markdown files
- **Categories**: 16 main categories
- **Search speed**: <1 second for most queries
- **Update time**: 30-60 seconds depending on connection

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with both manual and automated installation
5. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Related Projects

- [claude-code-docs](https://github.com/anthropics/claude-code-docs) - Official Claude Code documentation mirror
- [obsidian-help](https://github.com/obsidianmd/obsidian-help) - Official Obsidian documentation source

## Support

For issues and questions:
1. Check the troubleshooting section above
2. Search existing issues
3. Create a new issue with detailed information about your setup and the problem