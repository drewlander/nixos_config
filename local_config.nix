{ config, pkgs, ... }:

{
  networking.firewall.enable = true; 
  services.printing.drivers = [ pkgs.hplip pkgs.brlaser ];
  services.xserver.displayManager.defaultSession = "plasmawayland";
  environment.systemPackages = with pkgs; [
  neovim 
  virt-manager
  ntfs3g
  x264
  ffmpeg_6-full
  xdg-desktop-portal
  xdg-desktop-portal-gtk
  xdg-desktop-portal-gnome
  libsForQt5.xdg-desktop-portal-kde
  libsForQt5.yakuake
  cifs-utils
  flatpak
  jdk17
  i2p
  pinentry-qt
  plasma-browser-integration
  evolution
  evolution-ews
  ];

nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 10d";
};

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.flatpak.enable = true;
    xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
    };
  security.apparmor.enable = true;
  security.chromiumSuidSandbox.enable = true;
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];
  services.earlyoom.enable = true;
programs.gnupg.agent = {                                                      
  enable = true;
  enableSSHSupport = true;
  pinentryFlavor = "qt";
};
services.udev.packages = [ pkgs.yubikey-personalization ];
services.pcscd.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.ovmf.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.dconf.enable = true;

  # For mount.cifs, required unless domain name resolution is not needed.
  fileSystems."/mnt/share" = {
    device = "//192.168.1.129/media";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };
fonts.fontDir.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
