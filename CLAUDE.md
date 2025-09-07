# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Claude Code integration tool that mirrors Obsidian documentation locally and provides a `/obsidian-docs` slash command for accessing it. The project downloads the official Obsidian Help repository and creates a searchable local documentation system.

## Key Commands

### Installation and Setup
- `./install.sh` - Install the tool (creates `~/.obsidian-docs/` and Claude Code integration)
- `./uninstall.sh` - Remove all installed components
- `~/.obsidian-docs/uninstall.sh` - Alternative uninstall from installed location

### Development and Testing
- `./scripts/obsidian-docs-helper.sh` - Main helper script for documentation operations
- `~/.obsidian-docs/obsidian-docs-helper.sh` - Installed version of the helper script

### User Commands (after installation)
- `/obsidian-docs` - List documentation categories
- `/obsidian-docs update` - Update documentation from source
- `/obsidian-docs search <term>` - Search for files containing term
- `/obsidian-docs content <term>` - Search content with context
- `/obsidian-docs status` - Show installation status

## Architecture

### Core Components

1. **Installation Script** (`install.sh`)
   - Clones repositories to `~/.obsidian-docs/`
   - Downloads official Obsidian Help documentation
   - Creates Claude Code slash command in `~/.claude/commands/obsidian-docs.md`
   - Copies and processes English documentation from `obsidian-help/en/` to `docs/`

2. **Helper Script** (`scripts/obsidian-docs-helper.sh`)
   - Bash script with functions for documentation operations
   - Handles search (using ripgrep or grep fallback)
   - Manages documentation updates via git
   - Provides category listing and file browsing

3. **Documentation Structure**
   - Source: Official Obsidian Help repository (`obsidianmd/obsidian-help`)
   - Local mirror: `~/.obsidian-docs/docs/` (English documentation only)
   - Categories include: Plugins, Getting started, Obsidian Sync, etc.

### Installation Flow

1. Creates `~/.obsidian-docs/` directory
2. Clones this repository and obsidian-help repository
3. Copies English docs from `obsidian-help/en/` to `docs/`
4. Creates proper Claude Code slash command (not hook-based)
5. Sets up executable permissions

### Update Mechanism

- Manual updates only (no automatic syncing)
- Updates pull latest from `obsidianmd/obsidian-help` repository
- Re-copies English documentation to local `docs/` folder
- Updates timestamp in `.last_update` file

## Development Notes

### File Structure
```
~/.obsidian-docs/
├── docs/                    # Processed documentation (English only)
├── obsidian-help/          # Source repository clone
├── obsidian-docs-helper.sh # Main script
├── install.sh              # Installation script
├── uninstall.sh           # Removal script
└── .last_update           # Update timestamp
```

### Integration Method
The project creates a proper Claude Code slash command file at `~/.claude/commands/obsidian-docs.md` rather than using hooks. This ensures the `/obsidian-docs` command is properly recognized by Claude Code.

### Search Implementation
- Prefers ripgrep (`rg`) for fast searching when available
- Falls back to standard `grep` and `find` commands
- Supports both file name search and content search with context

### Error Handling
- Checks for installation directory existence
- Validates documentation directory before operations
- Provides helpful error messages with suggested remedies
- Falls back gracefully when optional tools are unavailable