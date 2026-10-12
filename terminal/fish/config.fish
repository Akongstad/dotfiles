switch (uname)
    case Linux
        # CachyOS defaults: fastfetch greeting, eza aliases, `done` notifications, ...
        if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
            source /usr/share/cachyos-fish-config/cachyos-config.fish
        end
    case Darwin
        if test -x /opt/homebrew/bin/brew
            /opt/homebrew/bin/brew shellenv | source
        end
end

# Uncomment to drop the fastfetch greeting
# function fish_greeting; end

# Missing directories are skipped, so this is safe on every machine
fish_add_path ~/.local/bin ~/go/bin ~/.opencode/bin
