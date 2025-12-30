{ pkgs, ...}:

{
  users.users.butcherrrr = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  security.sudo.enable = true;

  networking.networkmanager.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    ripgrep
    jq
  ];
}
