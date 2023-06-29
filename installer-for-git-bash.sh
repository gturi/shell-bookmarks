#!/bin/bash

# gets the absolute path to directory containing this script
DIR=$(dirname "$(readlink -f "$0")")

SCRIPT="$DIR/shell-bookmarks-git-bash.sh"

if [ -f "$SCRIPT" ]; then
    # adds to .bashrc
    # # shell bookmarks
    # if [ -f "$SCRIPT" ]; then
    #     source "$SCRIPT"
    # fi
    printf '\n%s\n%s\n%s\n%s\n' \
        "# shell bookmarks" \
        "if [ -f \"$SCRIPT\" ]; then" \
        "    source \"$SCRIPT\"" \
        'fi' \
        >> "$HOME/.bashrc"
fi
