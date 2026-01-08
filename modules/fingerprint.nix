{ pkgs, ... }:

# Fingerprint Authentication Configuration

# Enables fingerprint reader for login, sudo, and hyprlock.
# Parallel authentication: fingerprint OR password, whichever completes first.

# 1. Enroll as your user: fprintd-enroll
# 2. Verify: fprintd-verify

{
  # Enable fingerprint reader
  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix;
  };

  # PAM configuration
  security.pam.services = {
    # greetd uses password only to unlock keyring on login
    greetd.fprintAuth = false;
    sudo.fprintAuth = true;
    hyprlock.fprintAuth = true; # Parallel auth handled by hyprlock config
    polkit-1.fprintAuth = true;
  };

  # Allow users to enroll their own fingerprints (without sudo)
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.match("net.reactivated.fprint.device.")) {
        return polkit.Result.YES;
      }
    });
  '';

  # Fingerprint management tools
  environment.systemPackages = with pkgs; [
    fprintd
  ];
}
