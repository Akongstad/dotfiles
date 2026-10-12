# Steam launch options (CachyOS)

Set per game in Steam → Properties → General → Launch Options.

- `game-performance` is CachyOS's wrapper that switches to the performance power profile while the game runs.
- `--skip-launcher` goes to the game itself; only use it for games that accept it.

## Default

```text
game-performance %command%
```

## HDR on Wayland

Proton's native Wayland driver, with FSR 4:

```text
PROTON_ENABLE_WAYLAND=1 PROTON_ENABLE_HDR=1 PROTON_FSR4_UPGRADE=1 game-performance %command% --skip-launcher
```

DXVK through the Vulkan HDR WSI layer:

```text
DXVK_HDR=1 ENABLE_HDR_WSI=1 SDL_VIDEODRIVER=wayland game-performance %command% --skip-launcher
```

## FSR 4 (RDNA 4)

```text
PROTON_FSR4_UPGRADE=1 game-performance %command%
```

Guide: https://discuss.cachyos.org/t/how-to-use-fsr4-on-rdna4-gpus/9004

Packages installed for it:

```bash
sudo pacman -S mesa-git lib32-mesa-git
```
