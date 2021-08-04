{ suites, lib, pkgs, ... }:
{
  ### root password is empty by default ###
  imports = suites.base ++ suites.gui ++ suites.development;

  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "boot.shell_on_fail" ];


  virtualisation.hypervGuest.enable = true;
  virtualisation.hypervGuest.videoMode = "1920x1080";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/7eed9ad2-cff5-4fff-824f-d0623683ee5a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/32B7-2C61";
      fsType = "vfat";
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/d391690d-66db-4f43-aaa9-cdde4b4c6041";
      fsType = "ext4";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/a05d977f-fe9e-4620-be91-ccda8bc0063c"; }];

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Configure keymap in X11
  services.xserver.layout = "pl";
  services.xserver.xkbOptions = "eurosign:e";

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  networking.firewall.allowedUDPPorts = [ 3389 ];
  networking.firewall.allowedTCPPorts = [ 3389 ];

  system.stateVersion = "21.05";
}
