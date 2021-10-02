#!/bin/bash

# gets the absolute path to directory containing this script
DIR=$(dirname $(readlink -f $0))

SCRIPT=$DIR/bash-bookmarks.sh

if [ -f "$SCRIPT" ]; then
    # adds to .bashrc
    # # bash bookmarks
    # if [ -f "$SCRIPT" ]; then
    #     source "$SCRIPT"
    # fi
    printf '\n%s\n%s\n%s\n%s\n' \
        "# bash bookmarks" \
        "if [ -f \"$SCRIPT\" ]; then" \
        "    source \"$SCRIPT\"" \
        'fi' \
        >> "$HOME/.bashrc"
fi
