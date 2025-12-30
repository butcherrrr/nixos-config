{ pkgs, ... }:

{
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "Hyprland";
      user = "butcherrrr";
    };
  };
}
