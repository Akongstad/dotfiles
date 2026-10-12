#!/usr/bin/env bash
# Symlink the configs in this repo into place, asking per tool. Safe to re-run.
# Existing files that differ from the repo are moved to <file>.bak.<timestamp>.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
config="${XDG_CONFIG_HOME:-$HOME/.config}"
stamp="$(date +%Y%m%d-%H%M%S)"

case "$(uname -s)" in
  Linux) os=linux ;;
  Darwin) os=macos ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

pretty() { echo "${1/#$HOME/\~}"; }

# ask <question> <default: y|n>. Empty answer (or no terminal) picks the default.
ask() {
  local hint reply
  if [[ $2 == y ]]; then hint="[Y/n]"; else hint="[y/N]"; fi
  read -r -p "$1 $hint " reply || true
  [[ ${reply:-$2} =~ ^[Yy] ]]
}

backup() {
  mv "$1" "$1.bak.$stamp"
  echo "backup  $(pretty "$1") -> .bak.$stamp"
}

# link <path in repo> <destination>
link() {
  local src="$repo/$1" dst="$2"
  if [[ -L $dst && $(readlink "$dst") == "$src" ]]; then
    echo "ok      $(pretty "$dst")"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  if [[ -f $dst && ! -L $dst ]] && cmp -s "$src" "$dst"; then
    rm "$dst"
  elif [[ -e $dst || -L $dst ]]; then
    backup "$dst"
  fi
  ln -s "$src" "$dst"
  echo "linked  $(pretty "$dst")"
}

if ask "Install fish config?" y; then
  link terminal/fish/config.fish "$config/fish/config.fish"
fi

if ask "Install zed settings + keymap?" y; then
  link zed/settings.json "$config/zed/settings.json"
  link "zed/keymap.$os.json" "$config/zed/keymap.json"
  link zed/tasks.json "$config/zed/tasks.json"
  link zed/debug.json "$config/zed/debug.json"

  # Arch packages Zed as `zeditor`; expose it as `zed` so EDITOR="zed --wait" works
  zed_bin="$HOME/.local/bin/zed"
  if [[ $os == linux && -L $zed_bin ]]; then
    echo "ok      $(pretty "$zed_bin")"
  elif [[ $os == linux ]] && ! command -v zed >/dev/null && command -v zeditor >/dev/null; then
    mkdir -p "$(dirname "$zed_bin")"
    ln -s "$(command -v zeditor)" "$zed_bin"
    echo "linked  $(pretty "$zed_bin") -> zeditor"
  fi
fi

if ask "Install ghostty config?" y; then
  link "terminal/ghostty/config.$os" "$config/ghostty/config"

  if [[ $os == macos ]]; then
    # Ghostty also loads this file after ~/.config/ghostty/config, so it would override the repo config
    app_support="$HOME/Library/Application Support/com.mitchellh.ghostty"
    for f in "$app_support/config" "$app_support/config.ghostty"; do
      if [[ -e $f ]]; then backup "$f"; fi
    done
  fi
fi

if [[ $os == linux ]] && ask "Install xkb keyboard layout (Danish custom brace)?" n; then
  link linux/xkb/symbols/mydk "$config/xkb/symbols/mydk"
  link linux/xkb/rules/evdev.xml "$config/xkb/rules/evdev.xml"
fi
