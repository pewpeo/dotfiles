#!/bin/bash
# Sync lazygit colors with the active Ghostty theme.
# Called by the lazygit() shell wrapper before launching lazygit.
# Writes a theme-only config that gets layered on top of the main config
# via LG_CONFIG_FILE.
#
# Note: ghostty +show-config doesn't resolve the light:/dark: theme selector
# at runtime, so we detect macOS appearance and read the theme file directly.
#
# Usage: add the following shell function to your aliases:
#
#   lazygit() {
#     ~/.config/lazygit/theme.sh
#     LG_CONFIG_FILE="$HOME/Library/Application Support/lazygit/config.yml,$HOME/.config/lazygit/theme.yml" command lazygit "$@"
#   }

THEME_FILE="$HOME/.config/lazygit/theme.yml"
GHOSTTY_THEMES="/Applications/Ghostty.app/Contents/Resources/ghostty/themes"

# Parse the theme config from Ghostty: supports both "theme = name" and
# "theme = light:name,dark:name" formats.
GHOSTTY_THEME=$(ghostty +show-config 2>/dev/null | grep "^theme = " | cut -d' ' -f3-)

if [[ "$GHOSTTY_THEME" == *"light:"* ]]; then
  # Conditional theme: extract light/dark names
  LIGHT_THEME=$(echo "$GHOSTTY_THEME" | sed 's/light:\([^,]*\).*/\1/')
  DARK_THEME=$(echo "$GHOSTTY_THEME" | sed 's/.*dark:\(.*\)/\1/')

  if defaults read -g AppleInterfaceStyle &>/dev/null; then
    THEME_NAME="$DARK_THEME"
  else
    THEME_NAME="$LIGHT_THEME"
  fi
else
  # Static theme name
  THEME_NAME="$GHOSTTY_THEME"
fi

# Bail out if we couldn't determine a theme (e.g. not running inside Ghostty)
[[ -z "$THEME_NAME" ]] && exit 0

# Resolve theme file: check custom themes first, then bundled themes
CUSTOM_THEMES="$HOME/.config/ghostty/themes"
BUNDLED_THEMES="/Applications/Ghostty.app/Contents/Resources/ghostty/themes"

if [[ -f "$CUSTOM_THEMES/$THEME_NAME" ]]; then
  THEME_CONFIG="$CUSTOM_THEMES/$THEME_NAME"
else
  THEME_CONFIG="$BUNDLED_THEMES/$THEME_NAME"
fi

# Parse colors from theme file
foreground=$(grep "^foreground = " "$THEME_CONFIG" | awk '{print $3}')
selection_bg=$(grep "^selection-background = " "$THEME_CONFIG" | awk '{print $3}')
palette_1=$(grep "^palette = 1=" "$THEME_CONFIG" | cut -d= -f3)
palette_2=$(grep "^palette = 2=" "$THEME_CONFIG" | cut -d= -f3)
palette_6=$(grep "^palette = 6=" "$THEME_CONFIG" | cut -d= -f3)
palette_8=$(grep "^palette = 8=" "$THEME_CONFIG" | cut -d= -f3)

# Write theme-only lazygit config
cat > "$THEME_FILE" <<EOF
gui:
  theme:
    unstagedChangesColor:
      - "$palette_1"
    selectedLineBgColor:
      - "$selection_bg"
    searchingActiveBorderColor:
      - "$palette_2"
      - "bold"
    activeBorderColor:
      - "$palette_2"
      - "bold"
    optionsTextColor:
      - "$palette_6"
    cherryPickedCommitFgColor:
      - "$palette_6"
    inactiveBorderColor:
      - "$palette_8"
    defaultFgColor:
      - "$foreground"
    cherryPickedCommitBgColor:
      - "$foreground"
EOF
