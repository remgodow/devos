{ config, lib, pkgs, suites, ... }:

{

  imports = suites.base ++ [
    ../profiles/graphical
    ../profiles/graphical/x11Gestures.nix

    ../profiles/hardware/amd_cpu.nix
    ../profiles/hardware/nvidia_gpu.nix
    ../profiles/hardware/default_partitions.nix

    ../profiles/desktop/plasma.nix
    ../profiles/desktop/pipewire.nix
  ];

  # some more hardware settings
  nix.maxJobs = lib.mkDefault 16;

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  # fast shutdown is more important than gracefully shuting down
  systemd.extraConfig = "DefaultTimeoutStopSec=5s";

  boot = {
    tmpOnTmpfs = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };


  };

  # make more out of the ram
  zramSwap.enable = true;

}
