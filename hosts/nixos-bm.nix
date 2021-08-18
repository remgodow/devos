{ config, lib, pkgs, suites, ... }:

{

  imports = suites.base ++ suites.daily ++ suites.development ++ [

    ../profiles/hardware/amd_cpu.nix
    ../profiles/hardware/nvidia_gpu.nix
    ../profiles/hardware/default_partitions.nix
    ../profiles/hardware/bluetooth.nix

    ../profiles/desktop/plasma.nix
    ../profiles/desktop/pipewire.nix
    ../profiles/desktop/apps.nix

    ../profiles/virtualisation/docker.nix
  ];

  # some more hardware settings
  nix.maxJobs = lib.mkDefault 16;

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  # fast shutdown is more important than gracefully shuting down
  systemd.extraConfig = "DefaultTimeoutStopSec=5s";

  networking.networkmanager.enable = true;

  boot = {
    tmpOnTmpfs = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "ntfs" ];
  };

  # make more out of the ram
  zramSwap.enable = true;

}
