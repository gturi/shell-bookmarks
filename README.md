# shell-bookmarks

Utility to bookmark directories, avoiding the hassle of remembering/typing long path names to reach them.

## Usage

First you need to bookmark a directory using the `bookmark` command:

```bash
bookmark /path/to/directory/to/bookmark @bookmark-name

# Tip: use `pwd` to bookmark the current working directory
bookmark `pwd` @bookmark-name
```

Then use `warp` command to quickly `cd` to the bookmarked directory:

```bash
warp @bookmark-name
```

Finally you can use `unbookmark` command to remove one or multiple bookmarks:

```bash
unbookmark @bookmark-name @other-bookmark-name
```

Moreover, you can also rename an existing bookmark using `rnbookmark` command:

```bash
rnbookmark @bookmark-name @new-bookmark-name
```

## Install

Choose the installer according to your shell. The changes will be loaded from the next terminal session you will open.

If you are using git bash, you need to first install [windows-shortcut-util](https://github.com/gturi/windows-shortcut-util)

## Update

Just pull the git repository to have the latest project version.

## Uninstall

Remove `$HOME/.shell-bookmarks` directory.

For bash install remove the following lines from your `.bashrc`:

```bash
# shell bookmarks
if [ -f "/path/to/bash-bookmarks.sh" ]; then
    source "/path/to/shell-bookmarks.sh"
fi
```

For zsh install remove the following lines from your `.zshrc`:

```bash
# shell bookmarks
autoload bashcompinit && bashcompinit
emulate sh -c "/path/to/shell-bookmarks.sh"
```

## Troubleshooting

If anything goes wrong, you can find your bookmarks inside `$HOME/.shell-bookmarks` directory (they are actually just symbolic links to your directories) and manually delete them. And remember to file an issue!
