{
  pkgs,
  lib,
  ...
}:

{
  # TLP - Advanced power management for Linux
  # Optimizes battery life and power consumption on laptops
  services.tlp = {
    enable = true;
    settings = {
      # CPU Settings
      # Use "powersave" governor when on battery for better battery life
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Energy Performance Preference (for Intel CPUs with HWP)
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Minimum and maximum CPU frequency
      # On battery: limit max frequency to save power
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;

      # Enable CPU boost on AC, disable on battery
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # Platform Profile (for newer laptops with platform_profile support)
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

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
    # Enable CPU frequency scaling
    cpuFreqGovernor = lib.mkDefault "powersave";
    # Powertop auto-tune on startup (applies power saving tweaks)
    powertop.enable = true;
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
