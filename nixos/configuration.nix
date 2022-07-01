# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  nverStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nverBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;
  nvidiaPackage =
    if (lib.versionOlder nverBeta nverStable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  
  networking = {
    hostName = "nix"; 
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Krasnoyarsk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  security.rtkit.enable = true;

  services = {
  	xserver = {
  	    # Enable the X11 windowing system.
  		enable = true;
  		
  		# Enable the GNOME Desktop Environment.
  		displayManager.gdm.enable = true;
  		desktopManager.gnome.enable = true; 

  		videoDrivers = [ "nvidia" ];
  	};
  	pipewire = {
  		enable = true;
  		alsa.enable = true;
  		alsa.support32Bit = true;
  		pulse.enable = true;
  		jack.enable = true;
  		media-session.enable = false;
  		wireplumber.enable = true;
  	};
  	flatpak = {
  		enable = true;
  	};
  	udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  xdg.portal = {
  	enable = true;
  	gtkUsePortal = true:
  };

  hardware = {
  	pulseaudio.enable = false;
  	
    nvidia.powerManagement.enable = false;
    nvidia.modesetting.enable = true;
    nvidia.package = nvidiaPackage;
    opengl.driSupport32Bit = true;
    opengl.enable = true;
  }

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.macit = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "";
  };

  programs = {
    dconf.enable = true;
    steam.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      firefox
      steam
      gimp
      wget

      gnome.gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
    ];
    gnome.excludePackages = with pkgs; [
      gnome.cheese
      gnome.gnome-music
      gnome.gedit
      epiphany
      gnome.gnome-characters
      gnome.tali
      gnome.iagno
      gnome.hitori
      gnome.atomix
      gnome-tour
      gnome.geary
    ];
    variables = {
    	MOZ_ENABLE_WAYLAND = "1";
    	QT_QPA_PLATFORM = "wayland";
    };
  };

  system = {
  	stateVersion = "22.11";
  	autoUpgrade = {
  		enable = true;
  		allowReboot = false;
  	};
  };

}
