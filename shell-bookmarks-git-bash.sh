#!/bin/bash

BOOKMARK_DIR="$HOME/.shell-bookmarks"

# create bookmark directory if it does not exists
[ -d "$BOOKMARK_DIR" ] || mkdir "$BOOKMARK_DIR"

if [ -d "$BOOKMARK_DIR" ]; then
  export CDPATH=".:$BOOKMARK_DIR:/"

  function addExtensionIfMissing {
    local bookmarkName=$1
    if isWindowsShortcut "$bookmarkName"; then
      echo "$bookmarkName"
    else
      echo "$bookmarkName.lnk"
    fi
  }

  function warp {
    # $1: bookmark name
    [ "$#" -ne "1" ] && echo 'Usage: warp $bookmarkName' && return 1

    local BOOKMARK_NAME
    BOOKMARK_NAME="$(addExtensionIfMissing "$1")"
    local BOOKMARK="$BOOKMARK_DIR/$BOOKMARK_NAME"

    [ ! -f "$BOOKMARK" ] && echo "Bookmark named $1 not found" && return 1

    cd "$BOOKMARK"
  }
  # warp completion function
  _warp() {
    local IFS=$'\n'
    local cur=${COMP_WORDS[COMP_CWORD]}
    local BOOKMARK_LIST
    BOOKMARK_LIST="$(/bin/ls "$BOOKMARK_DIR")"
    COMPREPLY=($(compgen -W "$BOOKMARK_LIST" -- "${cur}"))
  } && complete -F _warp warp

  function bookmark {
    # $1: directory that will be bookmarked
    # $2: bookmark name
    [ "$#" -ne "2" ] && echo 'Usage: bookmark $directory $bookmarkName' && return 1
    [ ! -d "$1" ] && echo "$1 is not an absolute path to a directory" && return 1

    local TARGET_DIR="$1"
    local BOOKMARK_NAME
    BOOKMARK_NAME="$(addExtensionIfMissing "$2")"
    local BOOKMARK="$BOOKMARK_DIR/$BOOKMARK_NAME"
    [ -f "$BOOKMARK" ] && echo "bookmark name $BOOKMARK_NAME already in use" && return 1

    create-shortcut "$TARGET_DIR" "$BOOKMARK"
  }

  function unbookmark {
    # $@: space separated bookmark names
    [ "$#" -lt "1" ] && echo 'Usage: unbookmark $bookmarkName...' && return 1

    for bookmarkName in "$@"; do
      bookmarkName="$(addExtensionIfMissing "$bookmarkName")"
      if [[ -f "$BOOKMARK_DIR/$bookmarkName" ]]; then
        rm "$BOOKMARK_DIR/$bookmarkName"
      else
        echo "No bookmark named $bookmarkName has been found"
      fi
    done
  }
  # unbookmark completion function
  _unbookmark() {
    local IFS=$'\n'
    local cur=${COMP_WORDS[COMP_CWORD]}
    local BOOKMARK_LIST
    BOOKMARK_LIST="$(/bin/ls "$BOOKMARK_DIR")"
    COMPREPLY=($(compgen -W "$BOOKMARK_LIST" -- "${cur}"))
  } && complete -F _unbookmark unbookmark

  function rnbookmark {
    # $1: bookmark name
    # $2: new bookmark name
    [ "$#" -lt "2" ] && echo 'Usage: rnbookmark $bookmarkName $newBookmarkName' && return 1

    local BOOKMARK_NAME
    BOOKMARK_NAME="$(addExtensionIfMissing "$1")"
    [ ! -f "$BOOKMARK_DIR/$BOOKMARK_NAME" ] && echo "Bookmark named $BOOKMARK_NAME not found" && return 1

    local NEW_BOOKMARK_NAME
    NEW_BOOKMARK_NAME="$(addExtensionIfMissing "$2")"
    [ -f "$BOOKMARK_DIR/$NEW_BOOKMARK_NAME" ] && echo "bookmark name $NEW_BOOKMARK_NAME already in use" && return 1

    mv "$BOOKMARK_DIR/$1" "$BOOKMARK_DIR/$2"
  }
  # rnbookmark completion function
  _rnbookmark() {
    local IFS=$'\n'
    local cur=${COMP_WORDS[COMP_CWORD]}
    local BOOKMARK_LIST
    BOOKMARK_LIST="$(/bin/ls "$BOOKMARK_DIR")"
    COMPREPLY=($(compgen -W "$BOOKMARK_LIST" -- "${cur}"))
  } && complete -F _rnbookmark rnbookmark

fi
