{ pkgs, ... }:

{
  # GNOME Keyring Configuration

  # Required for applications persist login credentials
  services.gnome-keyring = {
    enable = true;
    components = [
      "secrets" # Password and secret storage (needed for Zed)
      "ssh" # SSH key management
    ];
  };

  # Add libsecret for Secret Service API support
  # seahorse provides a GUI to manage keyring passwords
  home.packages = with pkgs; [
    libsecret
    seahorse
  ];
}
