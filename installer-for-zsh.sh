#!/bin/bash

# gets the absolute path to directory containing this script
DIR=$(dirname "$(readlink -f "$0")")

SCRIPT="$DIR/shell-bookmarks.sh"

if [ -f "$SCRIPT" ]; then
    # adds to .zshrc
    # # shell bookmarks
    # autoload bashcompinit && bashcompinit
    # emulate sh -c '. "$SCRIPT"'
    printf '\n%s\n%s\n%s\n%s\n%s\n' \
        "# shell bookmarks" \
        "if [ -f \"$SCRIPT\" ]; then" \
        '  autoload bashcompinit && bashcompinit' \
        "  emulate sh -c '. \"$SCRIPT\"'" \
        'fi' \
        >> "$HOME/.zshrc"
fi
