{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./nix-conf/nvidia.nix
    ];
  # Allow install proprietary pkgs (NVidia driver)
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.cpu.intel.updateMicrocode = true;
  
  # Automatic Upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  
  # HostName
  networking.hostName = "NixOS";

  # Set your time zone.
  time.timeZone = "Asia/Krasnoyarsk";
  
  # Network
  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;
  
  # Enable pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };
  hardware.pulseaudio.enable = false;
  
  # Use zsh by default
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

    # Enable the GNOME Desktop Environment.
    xserver.displayManager.gdm.enable = true;
    xserver.desktopManager.gnome.enable = true;
    
    # Enable Flatpak
    flatpak.enable = true;
  };
  
  environment.gnome.excludePackages = [ pkgs.gnome.cheese pkgs.gnome-photos pkgs.gnome.gnome-music pkgs.epiphany pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem pkgs.gnome.tali pkgs.gnome.iagno pkgs.gnome.hitori pkgs.gnome.atomix pkgs.gnome-tour  pkgs.gnome.geary pkgs.gnome.gnome-maps pkgs.gnome.gnome-weather pkgs.gnome.gnome-clocks pkgs.gnome.gnome-contacts ];

  system.stateVersion = "22.05";
}