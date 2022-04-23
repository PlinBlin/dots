{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    windowManager.awesome.enable = true;

    layout = ["us" "ru"];
    xkbOptions = "grp:alt_shift_toggle";
  };
}