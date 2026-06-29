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
  networking.hostName = "nikitaos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
 
  programs.nix-ld.enable = true;
 
  # Select internationalisation properties.
  i18n.defaultLocale = "uk_UA.UTF-8";
  i18n.supportedLocales = [
    "uk_UA.UTF-8/UTF-8"
  ];
  #console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "us";
  #  useXkbConfig = true; # use xkb.options in tty.
  #};

  # Enable the X11 windowing system.

  #services.libinput = {
  #  enable = true;
  #  mouse.middleEmulation = false;
  #};

  #services.xserver = {
  #  enable = true;
  #  desktopManager = {
  #    xterm.enable = false;
  #    xfce.enable = true;
  #  };
  #};
  #services.displayManager.defaultSession = "xfce";

  systemd.services.disable-boost = {
  description = "Disable CPU Boost";
  wantedBy = [ "multi-user.target" ];
  serviceConfig.Type = "oneshot";
  script = ''
    echo 0 > /sys/devices/system/cpu/cpufreq/boost
  '';
};

  nixpkgs.config.pulseaudio = true;

  services.flatpak.enable = true;
  #programs.flatpak.enable = true;
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  #Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.opengl = { ... };
  hardware.nvidia.modesetting.enable = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;   
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  
  hardware.nvidia.prime = {  
    sync.enable = true;
    nvidiaBusId = "PCI:1@0:0:0";
    amdgpuBusId = "PCI:5@0:0:0";
  };

  #virtualisation.waydroid.enable = true;
  # Newer kernel versions may need
  #virtualisation.waydroid.package = pkgs.waydroid-nftables;

  # Enable clipboard sharing
  #environment.systemPackages = [ pkgs.wl-clipboard ];

#services.xserver = {
#  enable = true;
#  displayManager.lightdm.enable = true;
#  desktopManager.xfce.enable = true;
#};

  #services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;

  #Hyprland  
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Enable Plasma 
  #services.desktopManager.plasma6.enable = true;

  # Default display manager for Plasma
  #services.displayManager.sddm = {
  #  enable = true;
  #};
  # To use Wayland (Experimental for SDDM)
  #  wayland.enable = true;
  #};

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
    alsa.enable = true;
    wireplumber.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
  #services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.mofest = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      packages = with pkgs; [
        libGL
	mesa
	mesa-demos   
      ];
    };
  };

  services.getty.autologinUser = "mofest";
  

  #programs.firefox.enable = true;

  #programs.virt-manager.enable = true;

  powerManagement.cpuFreqGovernor = "schedutil";

  users.groups.libvirtd.members = ["mofest"];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     fastfetch
     linuxPackages.cpupower
     htop
     kitty
     kdePackages.dolphin
     steam
     waybar
     matugen
     obsidian
     hyprlock
     cava
     cmatrix
     pipes
     git
     pavucontrol
     zsh-powerlevel10k
     grim
     slurp
     wl-clipboard
     #jetbrains.idea-oss
     #jetbrains.pycharm-oss
     wofi
     swaybg
     python3
     obs-studio
     krita
     mpv
     #pciutils
     #jetbrains.clion
     gcc
     swaynotificationcenter
     gdb
     #libGL
     #mesa
     #libglvnd
     #xfce4-whiskermenu-plugin
     graphite-gtk-theme
     papirus-icon-theme
     xfce4-xkb-plugin
     python3
     gnome-boxes
     unzip
     p7zip
     unrar-free
     libreoffice
     cowsay
     xinit
     jetbrains.clion
     openssl
     #libglvnd
     #wlr-randr
     #xfce4-eyes-plugin
     #SDL2
     #python3
     #python3Packages.pip
     #openai
     #neovim
     #clang-tools
     #rustc
     #curl.dev
     #curl
     #vscodium
   ];

   fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-lgc-plus
    fira-code
    fira-code-symbols
    noto-fonts-color-emoji
    font-awesome
  ];

  system.stateVersion = "25.11"; # Did you read the comment?

}
