# tmux config

Config file: `tmux.conf` (loaded from `~/.config/tmux/tmux.conf`).

Prefix key is remapped to `Ctrl-a` (default is `Ctrl-b`).

## Shortcuts

| Action | Shortcut |
|---|---|
| Prefix key | `Ctrl-a` |
| Reload config | `prefix` + `r` |
| Next/prev window | `prefix` + `n` / `p` |
| Jump to window 1-5 | `Alt-1` … `Alt-5` or `F1` … `F5` (no prefix) |
| New window | `prefix` + `c` |
| Close window | `prefix` + `&` |
| Close pane | `prefix` + `x` |
| Rename window | `prefix` + `,` |
| Split vertical (side-by-side) | `prefix` + `\|` |
| Split horizontal (stacked) | `prefix` + `-` |
| Move between panes | `prefix` + arrow keys (default) |
| Next pane layout | `prefix` + `Space` |
| Preset pane layouts | `prefix` + `Alt-1` … `Alt-5` (even-horizontal, even-vertical, main-horizontal, main-vertical, tiled) |
| Enter copy mode | `prefix` + `Escape` |
| Window menu | `prefix` + `<` |
| Copy mode: begin selection | `v` |
| Copy mode: copy selection & exit | `y` |
| Clear scrollback history | `Ctrl-l` (no prefix) |
| Mouse | click to select pane/window, drag border to resize, scroll to scroll |

## Other notable settings

- Windows and panes are 1-indexed (not 0-indexed).
- Windows renumber automatically when one is closed.
- Scrollback history: 10,000 lines.
- `escape-time` set to 0 for snappier response (good for vim/neovim users).
