#!/bin/bash

BOOKMARK_DIR="$HOME/.bookmarks"

# create bookmark directory if it does not exists
[ -d "$BOOKMARK_DIR" ] || mkdir "$BOOKMARK_DIR"

if [ -d "$BOOKMARK_DIR" ]; then
  export CDPATH=".:$BOOKMARK_DIR:/"
  
  alias goto="cd -P"
  # goto completion function
  _goto() {
    local IFS=$'\n'
    local cur=${COMP_WORDS[COMP_CWORD]}
    local BOOKMARK_LIST="$(/bin/ls $BOOKMARK_DIR)"
    COMPREPLY=( $( compgen -W "$BOOKMARK_LIST" -- ${cur}) )
  } && complete -F _goto goto

  function bookmark {
    # $1: directory that will be bookmarked
    # $2: bookmark name
    ln -s "$1" "$BOOKMARK_DIR/$2"
  }

  function unbookmark {
    # $1: bookmark name
    rm "$BOOKMARK_DIR/$1"
  }
  # unbookmark completion function
  _unbookmark() {
    local IFS=$'\n'
    local cur=${COMP_WORDS[COMP_CWORD]}
    local BOOKMARK_LIST="$(/bin/ls $BOOKMARK_DIR)"
    COMPREPLY=( $( compgen -W "$BOOKMARK_LIST" -- ${cur}) )
  } && complete -F _unbookmark unbookmark

fi
