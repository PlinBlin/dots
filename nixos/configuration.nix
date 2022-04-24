{ config, pkgs, ... }:

{
  imports = [
    ./modules/nvidia.nix
    ./profile/gaming.nix
    ./profile/desktop.nix
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware.cpu.intel.updateMicrocode = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  users.users.macit = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  networking = {
    hostName = "NixOS";
    firewall.enable = false;
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    steam-run
  ];

  system.stateVersion = "22.05";
}