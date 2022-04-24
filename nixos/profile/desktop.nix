{ config, pkgs, lib, ... }:

{
  boot.plymouth.enable = true;

  services = {
    xserver.enable = true;
    xserver.useGlamor = true;
    xserver.displayManager.gdm.enable = true;

    xserver.desktopManager.xterm.enable = false;
    xserver.desktopManager.gnome.enable = true;
  };
  # enable flatpak support
  #services.flatpak.enable = true;
  #xdg.portal.enable = true;

  environment.systemPackages = with pkgs; [
    librewolf
  ];
}
