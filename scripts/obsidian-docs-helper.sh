#!/bin/bash

DOCS_DIR="$HOME/.obsidian-docs/docs"
INSTALL_DIR="$HOME/.obsidian-docs"
OBSIDIAN_HELP_DIR="$INSTALL_DIR/obsidian-help"

update_docs() {
    echo "🔄 Updating Obsidian documentation..."
    
    # Check if installation exists
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "❌ Obsidian docs not installed. Run install.sh first."
        return 1
    fi
    
    cd "$INSTALL_DIR"
    
    # Show last update time
    if [ -f ".last_update" ]; then
        last_update=$(cat .last_update)
        echo "📅 Last updated: $last_update"
    fi
    
    # Update obsidian-help repository
    if [ -d "obsidian-help" ]; then
        cd obsidian-help
        echo "📥 Pulling latest changes from obsidian-help..."
        git pull origin main || git pull origin master
        cd ..
    else
        echo "📥 Cloning obsidian-help repository..."
        git clone "https://github.com/obsidianmd/obsidian-help.git" obsidian-help
    fi
    
    # Update local docs directory
    echo "📋 Updating local documentation..."
    rm -rf docs/
    mkdir -p docs/
    cp -r obsidian-help/en/* docs/
    
    # Update timestamp
    date > .last_update
    echo "✅ Documentation updated to latest version"
}

search_docs() {
    local query="$1"
    if [ -z "$query" ]; then
        echo "❌ Please provide a search term"
        echo "Usage: /obsidian-docs search <term>"
        return 1
    fi
    
    if [ ! -d "$DOCS_DIR" ]; then
        echo "❌ Documentation not found. Run 'install.sh' first."
        return 1
    fi
    
    echo "🔍 Searching for: $query"
    echo "📄 Files containing '$query':"
    
    # Use ripgrep if available, otherwise fall back to grep
    if command -v rg &> /dev/null; then
        rg -l --type md "$query" "$DOCS_DIR" | head -10
    else
        find "$DOCS_DIR" -name "*.md" -type f -exec grep -l "$query" {} \; | head -10
    fi
}

search_content() {
    local query="$1"
    if [ -z "$query" ]; then
        echo "❌ Please provide a search term"
        return 1
    fi
    
    if [ ! -d "$DOCS_DIR" ]; then
        echo "❌ Documentation not found. Run 'install.sh' first."
        return 1
    fi
    
    echo "🔍 Content search for: $query"
    
    # Use ripgrep if available, otherwise fall back to grep
    if command -v rg &> /dev/null; then
        rg --type md -C 2 "$query" "$DOCS_DIR" | head -20
    else
        find "$DOCS_DIR" -name "*.md" -type f -exec grep -H -C 2 "$query" {} \; | head -20
    fi
}

list_categories() {
    if [ ! -d "$DOCS_DIR" ]; then
        echo "❌ Documentation not found. Run 'install.sh' first."
        return 1
    fi
    
    echo "📁 Available documentation categories:"
    find "$DOCS_DIR" -type d -mindepth 1 -maxdepth 1 | sed "s|$DOCS_DIR/||" | sort | while read -r dir; do
        file_count=$(find "$DOCS_DIR/$dir" -name "*.md" | wc -l)
        echo "  📂 $dir ($file_count files)"
    done
}

show_category() {
    local category="$1"
    if [ -z "$category" ]; then
        echo "❌ Please provide a category name"
        return 1
    fi
    
    if [ ! -d "$DOCS_DIR" ]; then
        echo "❌ Documentation not found. Run 'install.sh' first."
        return 1
    fi
    
    local category_path="$DOCS_DIR/$category"
    if [ ! -d "$category_path" ]; then
        echo "❌ Category '$category' not found"
        echo "📁 Available categories:"
        list_categories
        return 1
    fi
    
    echo "📂 Files in '$category':"
    find "$category_path" -name "*.md" -type f | sed "s|$DOCS_DIR/||" | sort
}

show_status() {
    echo "📊 Obsidian Docs Status:"
    
    if [ -d "$INSTALL_DIR" ]; then
        echo "✅ Installation directory: $INSTALL_DIR"
        
        if [ -f "$INSTALL_DIR/.last_update" ]; then
            last_update=$(cat "$INSTALL_DIR/.last_update")
            echo "📅 Last updated: $last_update"
        else
            echo "⚠️ No update timestamp found"
        fi
        
        if [ -d "$DOCS_DIR" ]; then
            doc_count=$(find "$DOCS_DIR" -name "*.md" | wc -l)
            echo "📄 Documentation files: $doc_count"
        else
            echo "❌ Documentation directory not found"
        fi
        
        if [ -f "$HOME/.claude/obsidian-docs-hook.sh" ]; then
            echo "✅ Claude Code hook installed"
        else
            echo "⚠️ Claude Code hook not found"
        fi
    else
        echo "❌ Not installed"
        echo "Run 'install.sh' to install Obsidian Docs"
    fi
}

show_help() {
    echo "📚 Obsidian Docs - Local documentation access for Claude Code"
    echo ""
    echo "Commands:"
    echo "  /obsidian-docs                    - List available categories"
    echo "  /obsidian-docs update            - Update documentation from source"
    echo "  /obsidian-docs search <term>     - Search for files containing term"
    echo "  /obsidian-docs content <term>    - Search content with context"
    echo "  /obsidian-docs show <category>   - Show files in specific category"
    echo "  /obsidian-docs status            - Show installation status"
    echo "  /obsidian-docs help              - Show this help"
    echo ""
    echo "Quick access commands:"
    echo "  /obsidian-docs plugins           - Plugin documentation"
    echo "  /obsidian-docs sync              - Sync documentation"
    echo "  /obsidian-docs publish           - Publish documentation"
}

# Main command processing
case "$1" in
    "/obsidian-docs"|"/obsidian-docs list")
        list_categories
        ;;
    "/obsidian-docs update"|"/obsidian-docs -u")
        update_docs
        ;;
    "/obsidian-docs search"*)
        search_docs "${1#*/obsidian-docs search }"
        ;;
    "/obsidian-docs content"*)
        search_content "${1#*/obsidian-docs content }"
        ;;
    "/obsidian-docs show"*)
        show_category "${1#*/obsidian-docs show }"
        ;;
    "/obsidian-docs plugins")
        show_category "Plugins"
        ;;
    "/obsidian-docs sync")
        show_category "Obsidian Sync"
        ;;
    "/obsidian-docs publish")
        show_category "Obsidian Publish"
        ;;
    "/obsidian-docs status")
        show_status
        ;;
    "/obsidian-docs help"|"/obsidian-docs -h")
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        show_help
        ;;
esac