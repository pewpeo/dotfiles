#!/bin/sh
# Open a path picked by `kitten hints`. Relative paths are resolved against
# the active tmux pane's directory (if tmux is running), else the current dir.
p="$1"
case "$p" in
  /*) ;;
  "~"*) p="$HOME${p#\~}" ;;
  *)
    d=$(/opt/homebrew/bin/tmux display-message -p '#{pane_current_path}' 2>/dev/null)
    [ -n "$d" ] && p="$d/$p"
    ;;
esac
exec open "$p"
