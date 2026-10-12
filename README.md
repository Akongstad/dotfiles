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
| `zed/tasks.json` | `~/.config/zed/tasks.json` | C++ test tasks, see below |
| `zed/debug.json` | `~/.config/zed/debug.json` | C++ test debug scenarios, see below |
| `linux/xkb/` | `~/.config/xkb/` | Danish layout with mac-style `{[]}` on AltGr; pick "Danish (custom brace)" in GNOME Settings → Keyboard, then log out and in |

On Linux, `install.sh` also links `~/.local/bin/zed` to `zeditor` (Arch's name for the Zed binary).

## C++ tests in Zed

Select a GoogleTest or doctest test name or suite name in the editor, then:

- **Run:** `ctrl-k c` (`cmd-k c` on macOS) builds and runs every CTest test whose name contains the selection: GoogleTest suites and cases, doctest cases. For a doctest suite, press `alt-shift-t` and pick `C++ test: run doctest suite`.
- **Debug:** press F4 and pick `C++ test: debug doctest case`, `... doctest suite` or `... gtest`. F5 reruns the last session.

Per project:

- Register tests with CTest: `gtest_discover_tests(<target>)` or `doctest_discover_tests(<target> ADD_LABELS 1)`.
- Configure into `build/` with debug info: `cmake -B build -DCMAKE_BUILD_TYPE=Debug`.

Needs cmake 3.20+, ctest and jq on `PATH`. Debugging writes a `zed-test-bin` link to the test binary in `build/`; nothing is written outside the project. The debugger runs the test with the project root as its working directory.

The fish prompt is [Pure](https://github.com/pure-fish/pure): the `fish-pure-prompt` package on CachyOS, `fisher install pure-fish/pure` on macOS.

## Notes

- [`gaming/steam-flags.md`](gaming/steam-flags.md): Steam launch options for CachyOS (HDR, FSR 4)
- [`python/`](python/): pre-commit template (ruff + commitizen) and uv project setup
