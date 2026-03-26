# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/mnt/boot";
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
 
  programs.nix-ld.enable = true;
 
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  services.flatpak.enable = true;
  #programs.flatpak.enable = true;
  #xdg.portal.enable = true;
  #Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;   
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  
  #Hyprland  
  #programs.hyprland = {
  #  enable = true;
  #  withUWSM = true;
  #  xwayland.enable = true;
  #};

  # Enable Plasma 
  services.desktopManager.plasma6.enable = true;

  # Default display manager for Plasma
  services.displayManager.sddm = {
    enable = true;
  
  # To use Wayland (Experimental for SDDM)
    wayland.enable = true;
  };

  # Optionally enable xserver
  services.xserver.enable = true;

  programs.zsh = {
  enable = true;
  autosuggestions.enable = true;
  ohMyZsh.enable = true;
  promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  histSize = 10000;
  };
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.mofest = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      packages = with pkgs; [
      ];
    };
  };

  services.getty.autologinUser = "mofest";
  

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     fastfetch
     htop
     #kitty
     kdePackages.dolphin
     steam
     #waybar
     #matugen
     obsidian
     #hyprlock
     cava
     cmatrix
     pipes
     git
     pavucontrol
     zsh-powerlevel10k
     #grim
     #slurp
     #wl-clipboard
     jetbrains.idea-oss
     jetbrains.pycharm-oss
     wofi
     #swaybg
     python3
     obs-studio
     krita
     mpv
   ];

   fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    fira-code
    fira-code-symbols
    noto-fonts-color-emoji
    font-awesome
  ];

  system.stateVersion = "25.11"; # Did you read the comment?

}

