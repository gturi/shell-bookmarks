# bash-bookmarks

Utility to bookmark directories, avoiding the hassle of remembering/typing long path names to reach them.

## Usage

First you need to bookmark a directory using the `bookmark` command:

```bash
bookmark /path/to/directory/to/bookmark @bookmark-name

# Tip: use `pwd` to bookmark the current working directory
bookmark `pwd` @bookmark-name
```

Then use `goto` command to quickly `cd` to the bookmarked directory:

```bash
goto @bookmark-name
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

Run `install.sh` script. The changes will be loaded from the next terminal session you will open.

## Update

Just pull the git repository to have the latest project version.

## Uninstall

Remove the following lines from your `.bashrc`:

```bash
# bash bookmarks
if [ -f "/path/to/bash-bookmarks.sh" ]; then
    source "/path/to/bash-bookmarks.sh"
fi
```

Remove `$HOME/.bookmarks` directory.

## Troubleshooting

If anything goes wrong, you can find your bookmarks inside `$HOME/.bookmarks` directory (they are actually just symbolic links to your directories) and manually delete them. And remember to file an issue!

## License

[GPL-3.0](LICENSE)
