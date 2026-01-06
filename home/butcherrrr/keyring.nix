{ pkgs, ... }:

{
  # ============================================================================
  # GNOME Keyring Configuration
  # ============================================================================

  # GNOME Keyring provides secure storage for passwords, keys, and certificates
  # Required for applications like Zed to persist login credentials
  services.gnome-keyring = {
    enable = true;
    # Components to enable
    components = [
      "secrets"   # Password and secret storage (needed for Zed)
      "ssh"       # SSH key management
    ];
  };

  # Add libsecret for Secret Service API support
  # seahorse provides a GUI to manage keyring passwords
  home.packages = with pkgs; [
    libsecret
    seahorse
  ];
}
