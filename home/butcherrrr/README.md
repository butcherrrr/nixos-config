# Home Manager Modules

This directory contains modular home-manager configurations for user `butcherrrr`.

## Structure

```
butcherrrr/
├── packages.nix         # User packages and custom scripts
├── shell.nix            # Zsh, zoxide, and eza configuration
├── git.nix              # Git and delta configuration
├── neovim.nix           # Neovim with Nixvim
├── hyprland.nix         # Hyprland window manager settings
├── waybar.nix           # Status bar configuration
├── waybar-style.gtk.css # Waybar styling (Catppuccin Mocha)
├── rofi.nix             # Application launcher configuration
├── ghostty.nix          # Terminal emulator configuration
├── zed.nix              # Zed editor configuration
├── hyprlock.nix         # Lock screen configuration
├── services.nix         # Background services (mako notifications)
├── spicetify.nix        # Spotify theming
├── theme.nix            # Cursor theming and wallpaper
└── README.md            # This file
```

## Main Configuration

The main file `../butcherrrr.nix` imports all modules:

```nix
imports = [
  ./butcherrrr/packages.nix
  ./butcherrrr/shell.nix
  ./butcherrrr/git.nix
  ./butcherrrr/neovim.nix
  ./butcherrrr/hyprland.nix
  ./butcherrrr/waybar.nix
  ./butcherrrr/rofi.nix
  ./butcherrrr/ghostty.nix
  ./butcherrrr/zed.nix
  ./butcherrrr/hyprlock.nix
  ./butcherrrr/services.nix
  ./butcherrrr/spicetify.nix
  ./butcherrrr/theme.nix
];
```

## Module Descriptions

### packages.nix

User packages and custom scripts:

- **Packages**: Only packages WITHOUT home-manager modules
  - Development tools (nodejs, python3, go, rustup)
  - Applications (firefox, slack, obsidian)
  - Media viewers (imv, mpv)
  - Wayland utilities (swaybg, swayidle)
  - System utilities (fastfetch, brightnessctl)
  - Icons (papirus-icon-theme)
- **Scripts**: Custom scripts installed to `~/.local/bin/`
  - `toggle-terminal` - Focus or launch terminal (Hyper+Return)
  - `toggle-zed` - Focus or launch Zed editor (Hyper+E)
  - `toggle-firefox` - Focus or launch Firefox (Hyper+B)
  - `volume` - Volume control with notifications
  - `brightness` - Brightness control with notifications

### shell.nix

Shell configuration with modern tools:

**Eza** - Modern `ls` replacement:

- Icons for file types
- Git status integration
- Directories listed first
- Column headers
- Automatic Zsh integration
- Aliases: `ls`, `ll`, `la`, `lt`

**Zsh** - Shell configuration:

- oh-my-zsh framework
- Powerlevel10k theme
- Syntax highlighting (paths unhighlighted)
- Autosuggestions
- Tab completion
- Plugins: git, sudo, docker
- Custom aliases

**Zoxide** - Smart `cd` replacement:

- Learns frequently used directories
- Jump to directories with `z <pattern>`
- Interactive selection with `zi`
- Full Zsh integration

**fzf** - Fuzzy finder:

- Ctrl+R - Fuzzy search command history
- Ctrl+T - Fuzzy find files
- Alt+C - Fuzzy find and cd into directories
- Catppuccin Mocha colors
- Integrated with Zsh and other tools

### git.nix

Git configuration with modern tooling:

**Git settings**:

- User identity (name, email)
- Default branch: `main`
- Pull: rebase with fast-forward only
- Push: auto setup remote tracking
- Merge: diff3 conflict style
- Include local config: `~/.gitconfig.local`

**Aliases**:

- `st` - status
- `co` - checkout
- `br` - branch
- `ci` - commit
- `unstage` - reset staged files
- `last` - show last commit
- `ls` - compact log with dates
- `ll` - detailed log with stats
- `graph` - visual commit graph

**Delta** - Syntax-highlighting pager:

- Side-by-side diffs
- Line numbers
- Navigation (n/N between sections)
- Dark theme

### neovim.nix

Neovim with Nixvim (declarative configuration):

**Configuration**:

- Fully declarative configuration in Nix
- Catppuccin Mocha colorscheme
- Default editor for system
- Aliases: `vi`, `vim`, `vimdiff` → `nvim`

**Language Servers**:

- Nix (nil)
- Lua (lua-language-server)
- TypeScript/JavaScript (tsserver)
- HTML/CSS/JSON (vscode-langservers)
- Python (pyright)
- Go (gopls)
- Rust (rust-analyzer)

**Formatters**:

- Nix (nixpkgs-fmt)
- Lua (stylua)
- JS/TS/JSON/YAML/Markdown (prettier)
- Python (black)

**Features**:

- Treesitter syntax highlighting
- Fuzzy finding (telescope with ripgrep, fd)
- Git integration
- Auto-completion
- Format on save
- Line numbers (absolute + relative)
- Clipboard integration
- Persistent undo

**Plugins**:

- LSP (Language Server Protocol) integration
- nvim-cmp (completion)
- Telescope (fuzzy finder)
- Neo-tree (file explorer)
- Gitsigns (git integration)
- Lualine (status line)
- Bufferline (buffer tabs)
- Which-key (keybinding hints)
- Alpha (dashboard)
- Conform.nvim (formatting)

### hyprland.nix

Hyprland window manager configuration:

**Display**:

- Multi-monitor support
- HDMI-A-1: 4K@60Hz, 2x scaling (workspaces 1-5)
- eDP-1: 1080p@60Hz, 1.5x scaling (workspaces 6-8)

**Input**:

- Keyboard: Swedish (se-nodeadkeys)
- Repeat rate: 40, delay: 300ms
- Numlock on by default
- Touchpad: no natural scrolling

**Appearance**:

- Gaps: 8px inner, 16px outer
- Border: 1px
- Rounded corners: 5px
- Blur effects enabled
- Smooth animations

**Window Rules**:

- Global opacity: 95%
- Ghostty → Workspace 1
- Zed → Workspace 2
- Firefox → Workspace 3

**Keybindings**:

- Main mod: SUPER (Windows key)
- Window management (close, fullscreen, floating, etc.)
- Workspace switching (1-9)
- Move windows between workspaces
- Focus movement (arrows, HJKL)
- Window movement (SHIFT + arrows/HJKL)
- Mouse bindings (move/resize)

**Hyper Key Bindings** (Caps Lock):

- T → Toggle terminal
- Z → Toggle Zed
- F → Toggle Firefox

**Media Keys**:

- Volume control (with notifications)
- Brightness control (with notifications)
- Screenshots (Print key)

**Auto-start**:

- Waybar (status bar)
- Swaybg (wallpaper)
- Mako (notifications)
- Swayidle (auto-lock and power management)
- Hyprlock (immediate lock on boot for auto-login)

### waybar.nix

Status bar configuration:

**Modules**:

- Left: Hyprland workspaces
- Center: Hyprland window title
- Right: System tray, network, CPU, memory, battery, clock

**Workspace behavior**:

- Shows all workspaces
- Highlights active workspace
- Click to switch workspaces

**System monitoring**:

- CPU usage percentage
- Memory usage percentage
- Battery status with icon
- Network status

**Clock**:

- 24-hour format
- Full date on tooltip

**Styling**:

- Custom CSS in `waybar-style.gtk.css`
- Catppuccin Mocha colors
- Semi-transparent background
- Rounded corners
- Smooth transitions

### rofi.nix

Application launcher with fuzzy search:

**Features**:

- Icon support (Papirus-Dark)
- Fuzzy matching (fzf algorithm)
- Launch applications, run commands, switch windows
- Display format: application name only
- 6 visible items

**Appearance**:

- Compact width: 420px
- Semi-transparent background
- Rounded corners: 6px
- Catppuccin Mocha colors (auto via theme)
- JetBrainsMono Nerd Font 9pt

**Behavior**:

- History enabled
- Terminal: ghostty
- Search placeholder: "Search..."

### ghostty.nix

Modern terminal emulator:

**Theme**: Catppuccin Mocha (built-in)

**Font**:

- Family: JetBrainsMono Nerd Font
- Size: 14pt

**Window**:

- Padding: 14px (balanced)
- No decorations (Hyprland manages borders)

**Cursor**:

- Style: bar
- Blinking enabled

**Shell**:

- Integration: Zsh
- Features: cursor, sudo, title

**Behavior**:

- Mouse: hide while typing
- Copy on select: enabled
- No close confirmation

### zed.nix

Modern code editor:

**Fonts**:

- UI: 16pt
- Buffer: JetBrainsMono Nerd Font 14pt
- Terminal: JetBrainsMono Nerd Font 14pt

**Editor**:

- Tab size: 2 spaces
- Soft wrap at editor width
- Remove trailing whitespace on save
- Ensure final newline on save
- Format on save
- Autosave on focus change

**Git**:

- Git gutter on tracked files
- Inline blame enabled

**LSP**:

- Rust: rust-analyzer (from nixpkgs)
- Nix: nixd (from nixpkgs)
- Auto-configured via home-manager

**Terminal**:

- Shell: Zsh
- JetBrainsMono Nerd Font 14pt

**Extensions**:

- Nix language support
- Catppuccin theme

**Privacy**:

- Telemetry disabled (diagnostics & metrics)

**Vim mode**: Enabled

### hyprlock.nix

Lock screen configuration:

**Features**:

- Blurred wallpaper background
- Large clock display (time only)
- Date display below clock
- Password input field
- Catppuccin Mocha colors
- No fade animations (instant appearance)

**Behavior**:

- Runs immediately on boot (for auto-login security)
- Triggered by power button press
- Auto-locks after 5 minutes of inactivity (via swayidle)
- Locks before system sleep/suspend

**Keybinding**:

- `Super+L` - Manual lock

### services.nix

Background services:

**Mako** - Notification daemon:

- Size: 350x100px
- Position: top-right corner
- Margin: 20px from edges
- Padding: 15px vertical, 20px horizontal
- Border: 2px, 2px radius
- Font: JetBrainsMono Nerd Font 11pt
- Timeout: 3 seconds (critical: no timeout)
- Layer: overlay (above waybar)
- Colors: Catppuccin Mocha (auto-applied)
- Progress bar support for volume/brightness

### spicetify.nix

Spotify theming with Spicetify:

**Theme**: Catppuccin Mocha

**Extensions**:

- Hide Podcasts - Cleaner interface
- Better Shuffle - Improved shuffle algorithm

**Note**: Spotify package is managed by spicetify, not in packages.nix

### theme.nix

System theming:

**Cursor**:

- Theme: Banana
- Size: 24px
- GTK integration enabled

**Wallpaper**:

- Location: `~/.config/hypr/wallpaper.jpg`
- Source: `../../backgrounds/minimalist-black-hole.png`
- Displayed via swaybg (started in Hyprland)

## Editing Configuration

### To Add a Package

Edit `packages.nix`:

```nix
home.packages = with pkgs; [
  papirus-icon-theme
  firefox
  new-package  # Add here
];
```

### To Change Shell Alias

Edit `shell.nix`:

```nix
shellAliases = {
  ls = "eza";
  ll = "eza -l";
  myalias = "command-here";  # Add new alias
};
```

### To Modify Eza Options

Edit `shell.nix`:

```nix
programs.eza = {
  enable = true;
  enableZshIntegration = true;
  git = true;  # Show git status
  icons = true;  # Show file icons
  extraOptions = [
    "--group-directories-first"
    "--header"
    "--color=always"  # Add more options
  ];
};
```

### To Change Hyprland Keybinding

Edit `hyprland.nix`:

```nix
bind = [
  "$mainMod, Return, exec, ghostty"
  "$mainMod, Space, exec, rofi -show drun"
  "$mainMod, B, exec, firefox"  # Add new keybinding
];
```

### To Modify Waybar Modules

Edit `waybar.nix`:

```nix
modules-right = ["tray" "network" "cpu" "memory" "battery" "clock"];
# Or add custom modules
```

### To Customize Waybar Colors/Styling

Edit `waybar-style.gtk.css`:

```css
#clock {
  padding: 0 16px;
  color: #cdd6f4;  # Catppuccin text color
  background: rgba(137, 180, 250, 0.1);
}
```

### To Change Rofi Size

Edit `rofi.nix`:

```nix
window = {
  width = mkLiteral "500px";  # Change width
};
```

### To Add Git Alias

Edit `git.nix`:

```nix
alias = {
  st = "status";
  myalias = "git-command-here";  # Add new alias
};
```

### To Change Neovim Plugins

Edit `neovim.nix` and add to the `plugins` attribute set:

```nix
plugins = {
  # Add new plugin
  plugin-name.enable = true;

  # Or configure with settings
  plugin-name = {
    enable = true;
    settings = {
      # plugin options here
    };
  };
};
```

### To Modify Terminal Settings

Edit `ghostty.nix`:

```nix
settings = {
  font-size = 16;  # Larger font
  window-padding-x = 20;  # More padding
};
```

## Benefits of Modular Structure

✅ **Organized** - Each app has its own file
✅ **Easy to find** - Know exactly where to look
✅ **Better git diffs** - Changes isolated per module
✅ **Reusable** - Easy to share specific configs
✅ **Scalable** - Add more modules without clutter
✅ **Maintainable** - Edit one thing without affecting others

## Catppuccin Theming

All modules automatically use Catppuccin theming via centralized configuration in `../butcherrrr.nix`:

```nix
catppuccin = {
  enable = true;
  flavor = "mocha";  # mocha, macchiato, frappe, latte
  accent = "blue";   # blue, lavender, pink, mauve, red, etc.

  # Per-app theming
  rofi.enable = true;
  waybar.enable = false;  # Using custom manual styling
  mako.enable = true;
  hyprland.enable = true;
};
```

**Note:** Waybar uses custom CSS styling (`waybar-style.gtk.css`) instead of the catppuccin module to allow fine-grained control over colors and layout.

## Rebuilding

After editing any module:

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#guinea-pig
```

Or use the shell alias:

```bash
nrs
```

Then reload applications as needed:

```bash
hyprctl reload              # Hyprland (or SUPER+SHIFT+R)
pkill waybar && waybar &    # Waybar
# Rofi, Ghostty, and Zed read config on next launch
```

## Adding New Modules

To add a new program module:

1. **Create the file**: `touch butcherrrr/newprogram.nix`

2. **Add configuration**:

   ```nix
   { pkgs, ... }:
   {
     programs.newprogram = {
       enable = true;
       # ... settings
     };
   }
   ```

3. **Import in `../butcherrrr.nix`**:

   ```nix
   imports = [
     # ... existing imports
     ./butcherrrr/newprogram.nix
   ];
   ```

4. **Rebuild**: `sudo nixos-rebuild switch --flake .#$(hostname)`

## Custom Scripts

Scripts are located in `../../scripts/` and installed to `~/.local/bin/`:

### toggle-terminal

Bound to `Hyper+Return` - Opens or focuses the terminal:

- If ghostty is running: switches to workspace 1 and focuses it
- If ghostty is not running: switches to workspace 1 and opens it
- Ghostty is always bound to workspace 1 via window rules

### toggle-zed

Bound to `Hyper+E` - Opens or focuses Zed editor:

- Same behavior as toggle-terminal but for workspace 2

### toggle-firefox

Bound to `Hyper+B` - Opens or focuses Firefox:

- Same behavior as toggle-terminal but for workspace 3

### volume

Volume control with visual feedback:

```bash
volume up     # Increase volume 5%
volume down   # Decrease volume 5%
volume mute   # Toggle mute
```

Shows notification with current volume level and icon.

### brightness

Brightness control with visual feedback:

```bash
brightness up     # Increase brightness 5%
brightness down   # Decrease brightness 5%
```

Shows notification with current brightness level and icon.

## Shell Configuration

### Powerlevel10k

The p10k theme configuration is NOT managed in the repo to avoid language detection issues on GitHub. Each machine configures its own prompt:

1. Run `p10k configure` on the machine
2. The `.p10k.zsh` file is saved locally in the home directory
3. It persists across rebuilds (not managed by home-manager)

To reconfigure at any time:

```bash
p10k configure
```

### Eza Configuration

Eza is configured with sensible defaults and Zsh integration:

**Built-in aliases** (from `enableZshIntegration`):

- Additional helpful aliases beyond what's in shellAliases
- Auto-completion for eza commands
- Better integration with Zsh's file completion

**Custom options**:

- `--group-directories-first` - Directories listed before files
- `--header` - Show column headers in long format

**All features**:

```bash
eza               # Basic listing with icons
eza -l            # Long format with details
eza -la           # Long format with hidden files
eza --tree        # Tree view
eza -l --git      # Show git status (auto-enabled)
```

### Syntax Highlighting

Zsh syntax highlighting is enabled with custom colors:

- **Paths**: No highlighting (to avoid the "red = error" association)
- **Slashes**: No highlighting
- **Other elements**: Use default colors from theme

This makes the shell cleaner and less visually noisy.

## Tips & Tricks

### Finding Home Manager Options

```bash
# Search for available options
home-manager option programs.ghostty
home-manager option programs.eza

# Or visit
# https://home-manager-options.extranix.com/
```

### Testing Changes Without Committing

```bash
sudo nixos-rebuild test --flake .#$(hostname)
# Changes are temporary until reboot
```

### Viewing Logs

```bash
# Hyprland logs
cat ~/.local/share/hyprland/hyprland.log

# Systemd user services
journalctl --user -u mako
journalctl --user -u waybar

# Greetd (display manager)
journalctl -u greetd -b
```

### Conditional Configuration

Nix expressions can be used for conditional config:

```nix
home.packages = with pkgs; [
  firefox
] ++ (if hostname == "laptop" then [ laptop-specific-package ] else []);
```

## Resources

- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Home Manager Options Search](https://home-manager-options.extranix.com/)
- [Catppuccin/nix Documentation](https://github.com/catppuccin/nix)
- [Nix Language Basics](https://nixos.org/guides/nix-language.html)
- [Hyprland Configuration](https://wiki.hyprland.org/Configuring/Configuring-Hyprland/)
