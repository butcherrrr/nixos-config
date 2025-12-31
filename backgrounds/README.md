# Backgrounds

Place your background images in this directory.

## Adding a Background

1. Copy your background file here:
   ```bash
   cp ~/Downloads/my-background.jpg backgrounds/
   ```

2. Symlink it in `home/butcherrrr.nix`:
   ```nix
   home.file.".config/hypr/wallpaper.jpg".source = ../backgrounds/my-background.jpg;
   ```

3. Set it in `dotfiles/hyprland.conf`:
   ```conf
   exec-once = swaybg -i ~/.config/hypr/wallpaper.jpg
   ```

4. Rebuild:
   ```bash
   sudo nixos-rebuild switch --flake .#$(hostname)
   ```

## Per-Host Backgrounds

For different backgrounds per host, use conditional logic in home-manager:

```nix
home.file.".config/hypr/wallpaper.jpg".source = 
  if hostname == "laptop" 
  then ../backgrounds/laptop-background.jpg
  else ../backgrounds/desktop-background.jpg;
```

## Supported Formats

- PNG
- JPG/JPEG
- WebP

## Current Backgrounds

- `minimalist-black-hole.png` - Primary background