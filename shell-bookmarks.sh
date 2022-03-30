#!/bin/bash

BOOKMARK_DIR="$HOME/.shell-bookmarks"

# create bookmark directory if it does not exists
[ -d "$BOOKMARK_DIR" ] || mkdir "$BOOKMARK_DIR"

if [ -d "$BOOKMARK_DIR" ]; then
  export CDPATH=".:$BOOKMARK_DIR:/"

  function goto {
    # $1: bookmark name
    [ "$#" -ne "1" ] && echo 'Usage: goto $bookmarkName' && return 1
    [ ! -L "$BOOKMARK_DIR/$1" ] && echo "Bookmark named $1 not found" && return 1

    cd -P "$BOOKMARK_DIR/$1"
  }
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
    [ "$#" -ne "2" ] && echo 'Usage: bookmark $directory $bookmarkName' && return 1
    [ ! -d "$1" ] && echo "$1 is not an absolute path to a directory" && return 1
    [ -L "$BOOKMARK_DIR/$2" ] && echo "bookmark name $2 already in use" && return 1

    ln -s "$1" "$BOOKMARK_DIR/$2"
  }

  function unbookmark {
    # $@: space separated bookmark names 
    [ "$#" -lt "1" ] && echo 'Usage: unbookmark $bookmarkName...' && return 1

    for bookmarkName in "$@"
    do
      if [[ -L "$BOOKMARK_DIR/$bookmarkName" ]]; then
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
    local BOOKMARK_LIST="$(/bin/ls $BOOKMARK_DIR)"
    COMPREPLY=( $( compgen -W "$BOOKMARK_LIST" -- ${cur}) )
  } && complete -F _unbookmark unbookmark

  function rnbookmark {
    # $1: bookmark name
    # $2: new bookmark name
    [ "$#" -lt "2" ] && echo 'Usage: rnbookmark $bookmarkName $newBookmarkName' && return 1
    [ ! -L "$BOOKMARK_DIR/$1" ] && echo "Bookmark named $1 not found" && return 1
    [ -L "$BOOKMARK_DIR/$2" ] && echo "bookmark name $2 already in use" && return 1

    mv "$BOOKMARK_DIR/$1" "$BOOKMARK_DIR/$2"
  }
  # rnbookmark completion function
  _rnbookmark() {
    local IFS=$'\n'
    local cur=${COMP_WORDS[COMP_CWORD]}
    local BOOKMARK_LIST="$(/bin/ls $BOOKMARK_DIR)"
    COMPREPLY=( $( compgen -W "$BOOKMARK_LIST" -- ${cur}) )
  } && complete -F _rnbookmark rnbookmark

  function cleanbookmarks {
    local BROKEN_BOOKMARK=false
    for file in "$BOOKMARK_DIR"/*; 
    do
      if [ ! -e "$file" ] ; then # if the symlink is broken
        echo "bookmark '$file' is broken and will be removed";
        rm "$file"
        BROKEN_BOOKMARK=true
      fi
    done

    if [ "$BROKEN_BOOKMARK" = false ] ; then
      echo 'No broken bookmarks have been found'
    fi
  }
fi
