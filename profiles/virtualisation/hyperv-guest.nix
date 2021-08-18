{ pkgs, ... }: {

  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];

  virtualisation.hypervGuest.enable = true;
  virtualisation.hypervGuest.videoMode = "1920x1080";
}
