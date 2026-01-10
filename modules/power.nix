{
  pkgs,
  ...
}:

# Power Management Configuration
#
# This module configures TLP for optimal battery health and power efficiency.
#
# BATTERY CHARGE THRESHOLDS (20%-80%):
# The laptop will show "plugged" but not "charging" when between 20-80%.
# This is intentional and extends battery lifespan by 2-3x by reducing
# high-voltage stress. Charging to 100% constantly degrades batteries faster.
#
# To temporarily charge to 100%, run: sudo tlp fullcharge BAT0
# To adjust thresholds, modify START_CHARGE_THRESH_BAT0 and STOP_CHARGE_THRESH_BAT0

{
  # TLP - Advanced power management for Linux
  # Optimizes battery life and power consumption on laptops
  services.tlp = {
    enable = true;
    settings = {
      # CPU Settings
      # Use "schedutil" for dynamic scaling based on load
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

      # Energy Performance Preference (for Intel CPUs with HWP)
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Minimum and maximum CPU frequency
      # On battery: limit max frequency to save power (increased to 85% for better performance)
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 85;

      # Enable CPU boost on AC and battery (set to 1 to reduce lag)
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1;

      # Platform Profile (for newer laptops with platform_profile support)
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";

      # Battery Charge Thresholds (helps preserve battery health)
      # Start charging when below 20%, stop at 80% to reduce wear
      START_CHARGE_THRESH_BAT0 = 20;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # Runtime Power Management for devices
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      # PCI Express Active State Power Management
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # WiFi power saving
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # Sound power saving (Intel HDA, AC97)
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;

      # Disable Wake-on-LAN on battery
      WOL_DISABLE = "Y";

      # USB autosuspend - enable on battery for power savings
      USB_AUTOSUSPEND = 1;

      # Optical drive runtime power management
      AHCI_RUNTIME_PM_ON_AC = "on";
      AHCI_RUNTIME_PM_ON_BAT = "auto";
    };
  };

  # Thermald - Thermal management daemon (primarily for Intel CPUs)
  # Prevents overheating and thermal throttling
  services.thermald.enable = true;

  # Power management settings
  powerManagement = {
    enable = true;
    # CPU frequency scaling is handled by TLP settings above
    # Don't set cpuFreqGovernor here as it conflicts with TLP
    # Powertop auto-tune disabled - can cause lag and performance issues
    powertop.enable = false;
  };

  # Note: Power button and lid switch behavior is configured in modules/core.nix
  # This keeps input handling separate from power optimization

  # Install useful power management tools
  environment.systemPackages = with pkgs; [
    powertop # Power consumption monitor and tuning tool
    acpi # Battery and AC adapter information
    tlp # TLP command-line tools
  ];

  # Disable GNOMEs power management (if using GNOME)
  # TLP conflicts with it, but you're using Hyprland so this is just a safeguard
  services.power-profiles-daemon.enable = false;
}
