#!/bin/bash

DIR=$(dirname $(readlink -f $0))

SCRIPT=$DIR/bash-bookmarks.sh

if [ -f "$SCRIPT" ]; then
    # adds to .bashrc
    # if [ -f "$SCRIPT" ]; then
    #     source "$SCRIPT"
    # fi
    printf '\n%s\n%s\n%s\n' \
        "if [ -f \"$SCRIPT\" ]; then" \
        "    source \"$SCRIPT\"" \
        'fi' \
        >> "$HOME/.bashrc"
fi
