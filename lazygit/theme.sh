#!/bin/bash
# Sync lazygit colors with the active Ghostty or iTerm2 theme.
# Called by the lazygit() shell wrapper before launching lazygit.
# Writes a theme-only config that gets layered on top of the main config
# via LG_CONFIG_FILE.
#
# Ghostty doesn't resolve the light:/dark: selector in +show-config, and iTerm2
# stores separate profile colors for each appearance. In both cases we detect
# the current macOS appearance and resolve the selection color ourselves.
#
# Usage: add the following shell function to your aliases:
#
#   lazygit() {
#     ~/.config/lazygit/theme.sh
#     LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/theme.yml" command lazygit "$@"
#   }

THEME_FILE="$HOME/.config/lazygit/theme.yml"

if defaults read -g AppleInterfaceStyle &>/dev/null; then
    APPEARANCE="Dark"
else
    APPEARANCE="Light"
fi

if [[ "$TERM_PROGRAM" == "iTerm.app" || "$LC_TERMINAL" == "iTerm2" ]]; then
    # ITERM_PROFILE identifies the profile used by this session. Exporting the
    # preferences first also works when iTerm2 uses a custom preferences folder.
    [[ -z "$ITERM_PROFILE" ]] && exit 0

    ITERM_PREFS=$(mktemp /tmp/lazygit-iterm2.XXXXXX.plist) || exit 0
    defaults export com.googlecode.iterm2 "$ITERM_PREFS" &>/dev/null || {
        rm -f "$ITERM_PREFS"
        exit 0
    }

    profile_index=0
    while profile_name=$(/usr/libexec/PlistBuddy -c "Print :'New Bookmarks':$profile_index:Name" "$ITERM_PREFS" 2>/dev/null); do
        if [[ "$profile_name" == "$ITERM_PROFILE" ]]; then
            break
        fi
        profile_index=$((profile_index + 1))
    done

    [[ "$profile_name" != "$ITERM_PROFILE" ]] && {
        rm -f "$ITERM_PREFS"
        exit 0
    }

    color_key="Selection Color"
    separate_colors=$(/usr/libexec/PlistBuddy -c "Print :'New Bookmarks':$profile_index:'Use Separate Colors for Light and Dark Mode'" "$ITERM_PREFS" 2>/dev/null)
    if [[ "$separate_colors" == "true" ]]; then
        color_key="Selection Color ($APPEARANCE)"
    fi

    red=$(/usr/libexec/PlistBuddy -c "Print :'New Bookmarks':$profile_index:'$color_key':'Red Component'" "$ITERM_PREFS" 2>/dev/null)
    green=$(/usr/libexec/PlistBuddy -c "Print :'New Bookmarks':$profile_index:'$color_key':'Green Component'" "$ITERM_PREFS" 2>/dev/null)
    blue=$(/usr/libexec/PlistBuddy -c "Print :'New Bookmarks':$profile_index:'$color_key':'Blue Component'" "$ITERM_PREFS" 2>/dev/null)
    rm -f "$ITERM_PREFS"

    [[ -z "$red" || -z "$green" || -z "$blue" ]] && exit 0
    selection_bg=$(awk -v r="$red" -v g="$green" -v b="$blue" 'BEGIN {
        printf "#%02x%02x%02x", int(r * 255 + 0.5), int(g * 255 + 0.5), int(b * 255 + 0.5)
    }')
else
    # Parse the Ghostty config; supports both "theme = name" and
    # "theme = light:name,dark:name" formats.
    GHOSTTY_THEME=$(ghostty +show-config 2>/dev/null | grep "^theme = " | cut -d' ' -f3-)

    if [[ "$GHOSTTY_THEME" == *"light:"* ]]; then
        LIGHT_THEME=$(echo "$GHOSTTY_THEME" | sed 's/light:\([^,]*\).*/\1/')
        DARK_THEME=$(echo "$GHOSTTY_THEME" | sed 's/.*dark:\(.*\)/\1/')

        if [[ "$APPEARANCE" == "Dark" ]]; then
            THEME_NAME="$DARK_THEME"
        else
            THEME_NAME="$LIGHT_THEME"
        fi
    else
        THEME_NAME="$GHOSTTY_THEME"
    fi

    [[ -z "$THEME_NAME" ]] && exit 0

    CUSTOM_THEMES="$HOME/.config/ghostty/themes"
    BUNDLED_THEMES="/Applications/Ghostty.app/Contents/Resources/ghostty/themes"

    if [[ -f "$CUSTOM_THEMES/$THEME_NAME" ]]; then
        THEME_CONFIG="$CUSTOM_THEMES/$THEME_NAME"
    else
        THEME_CONFIG="$BUNDLED_THEMES/$THEME_NAME"
    fi

    selection_bg=$(grep "^selection-background = " "$THEME_CONFIG" | awk '{print $3}')
fi

[[ -z "$selection_bg" ]] && exit 0

# Write theme-only lazygit config
# cat > "$THEME_FILE" <<EOF
# gui:
#   theme:
#     unstagedChangesColor:
#       - "$palette_1"
#     selectedLineBgColor:
#       - "$selection_bg"
#     searchingActiveBorderColor:
#       - "$palette_2"
#       - "bold"
#     activeBorderColor:
#       - "$palette_2"
#       - "bold"
#     optionsTextColor:
#       - "$palette_6"
#     cherryPickedCommitFgColor:
#       - "$palette_6"
#     inactiveBorderColor:
#       - "$palette_8"
#     defaultFgColor:
#       - "$foreground"
#     cherryPickedCommitBgColor:
#       - "$foreground"
# EOF

cat >"$THEME_FILE" <<EOF
gui:
  theme:
    selectedLineBgColor:
      - "$selection_bg"
EOF
