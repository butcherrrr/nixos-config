# Backgrounds

Place your background images in this directory.

## Adding a Background

1. Copy your background file here:
   ```bash
   cp ~/Downloads/my-background.jpg backgrounds/
   ```

2. Update the symlink in `home/butcherrrr/theme.nix`:
   ```nix
   home.file.".config/hypr/wallpaper.jpg" = {
     source = ../../backgrounds/my-background.jpg;
   };
   ```

3. The background is automatically loaded by swaybg (configured in `home/butcherrrr/hyprland.nix`):
   ```nix
   exec-once = [
     "swaybg -i ~/.config/hypr/wallpaper.jpg -m fill"
   ];
   ```

4. Rebuild:
   ```bash
   sudo nixos-rebuild switch --flake .#$(hostname)
   ```

## Per-Host Backgrounds

For different backgrounds per host, use conditional logic in `home/butcherrrr/theme.nix`:

```nix
home.file.".config/hypr/wallpaper.jpg" = {
  source = 
    if hostname == "laptop" 
    then ../../backgrounds/laptop-background.jpg
    else ../../backgrounds/desktop-background.jpg;
};
```

## Supported Formats

- PNG
- JPG/JPEG
- WebP

## Current Backgrounds

- `minimalist-black-hole.png` - Primary background

## Notes

- Backgrounds are symlinked in `home/butcherrrr/theme.nix`
- Swaybg displays the wallpaper and is started via Hyprland's `exec-once` in `home/butcherrrr/hyprland.nix`
- The wallpaper is also used by hyprlock for the lock screen background