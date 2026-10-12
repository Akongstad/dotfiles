# dotfiles

Configs for my CachyOS desktop and Mac.

## Install

```bash
./install.sh
```

Asks per tool, then symlinks its config into `~/.config`, picking the Linux or macOS variant automatically.
Fish, Zed and Ghostty default to yes; the xkb layout defaults to no.
Existing files that differ from the repo are kept as `<file>.bak.<timestamp>`. Safe to re-run.
Because the live files are symlinks, changes made from Zed's settings UI land directly in this repo.

## Configs

| Repo | Linked to | Notes |
| --- | --- | --- |
| `terminal/fish/config.fish` | `~/.config/fish/config.fish` | CachyOS defaults on Linux, Homebrew on macOS |
| `terminal/ghostty/config.{linux,macos}` | `~/.config/ghostty/config` | Generator: https://ghostty.zerebos.com |
| `zed/settings.json` | `~/.config/zed/settings.json` | Shared; extensions listed under `auto_install_extensions` |
| `zed/keymap.{linux,macos}.json` | `~/.config/zed/keymap.json` | Linux keymap adds macOS-style text navigation |
| `linux/xkb/` | `~/.config/xkb/` | Danish layout with mac-style `{[]}` on AltGr; pick "Danish (custom brace)" in GNOME Settings → Keyboard, then log out and in |

On Linux, `install.sh` also links `~/.local/bin/zed` to `zeditor` (Arch's name for the Zed binary).

The fish prompt is [Pure](https://github.com/pure-fish/pure): the `fish-pure-prompt` package on CachyOS, `fisher install pure-fish/pure` on macOS.

## Notes

- [`gaming/steam-flags.md`](gaming/steam-flags.md): Steam launch options for CachyOS (HDR, FSR 4)
- [`python/`](python/): pre-commit template (ruff + commitizen) and uv project setup
