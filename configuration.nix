{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Krasnoyarsk";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = false;
  };
  
  networking = {
    useDHCP = false;
    hostName = "NixOS";
    interfaces.enp5s0.useDHCP = true;
  };
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };
  
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
  	enable = true;
  };

  users.extraUsers.username = {
    password = " ";
    shell = "${pkgs.zsh}/bin/zsh";
    group = "wheel";
   };

  services = {
    xserver.enable = true;

    xserver.displayManager.gdm.enable = true;
    xserver.desktopManager.gnome.enable = true;
    
    flatpak.enable = true;
  };
  
  system.stateVersion = "22.05";
}