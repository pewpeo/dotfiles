# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## How to check out dotfiles/lazyvim into ~/.config/nvim

The `lazyvim/` subdirectory of the dotfiles repo is extracted into a standalone
branch using `git subtree split`, so `~/.config/nvim` can be its own git repo
with the files at root level.

The full dotfiles repo lives at `~/Code/dotfiles`.

### Initial setup

```bash
# Extract lazyvim/ subdirectory as a standalone branch in the dotfiles repo
git -C ~/Code/dotfiles subtree split --prefix=lazyvim -b lazyvim-root

# Init ~/.config/nvim as its own repo and pull the extracted branch
cd ~/.config/nvim
git init
git pull ~/Code/dotfiles lazyvim-root
git branch -M main
```

### Pulling updates

```bash
# Update the dotfiles repo and re-run the subtree split
git -C ~/Code/dotfiles pull
git -C ~/Code/dotfiles subtree split --prefix=lazyvim -b lazyvim-root

# Pull into ~/.config/nvim
cd ~/.config/nvim && git pull ~/Code/dotfiles lazyvim-root
```
