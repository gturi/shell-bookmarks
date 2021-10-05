# bash-bookmarks

Utility to bookmark directories, avoiding the hassle of remembering/typing long path names to reach them.

## Usage

First you need to bookmark a directory using the `bookmark` command:

```bash
bookmark /path/to/directory/to/bookmark @bookmark-name
```

Then use `goto` command to quickly `cd` to the bookmarked directory:

```bash
goto @bookmark-name
```

Finally you can use `unbookmark` command to remove one or multiple bookmarks:

```
unbookmark @bookmark-name @other-bookmark-name
```

If anything goes wrong, your bookmarks will be stored inside `$HOME/.bookmarks` directory (they are actually just symbolic links to your directories). And remember to file an issue!

Tip: you can quickly bookmark the current working directory using `bookmark` in combination with `pwd` command:

```bash
bookmark `pwd` @bookmark-name
```

## Install

Run `install.sh` script. The changes will be loaded from the next terminal session you will open.

## Uninstall

Remove the following lines from your `.bashrc`:

```bash
# bash bookmarks
if [ -f "/path/to/bash-bookmarks.sh" ]; then
    source "/path/to/bash-bookmarks.sh"
fi
```

Remove `$HOME/.bookmarks` directory.

## License

[GPL-3.0](LICENSE)
