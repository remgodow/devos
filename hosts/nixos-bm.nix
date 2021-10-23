{ config, lib, pkgs, suites, ... }:

{

  imports = suites.base ++ suites.daily ++ suites.development ++ [

    ../profiles/hardware/amd_cpu.nix
    ../profiles/hardware/nvidia_gpu.nix
    ../profiles/hardware/default_partitions.nix
    ../profiles/hardware/bluetooth.nix
    ../profiles/hardware/webcams.nix
    ../profiles/hardware/smartphone.nix
    ../profiles/hardware/printers.nix

    ../profiles/locale/pl.nix

    ../profiles/desktop/plasma.nix
    ../profiles/desktop/pipewire.nix
    ../profiles/desktop/apps.nix
    ../profiles/desktop/xdg.nix

    ../profiles/virtualisation/docker.nix
    ../profiles/virtualisation/qemu.nix
  ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  home-manager.useGlobalPkgs = true;

  fileSystems."/mnt/Gry" =
    {
      device = "/dev/disk/by-label/Gry";
      fsType = "ntfs";
      options = [
        "noauto"
        "x-systemd.automount"
      ];
    };

  fileSystems."/mnt/Filmy" =
    {
      device = "/dev/disk/by-label/Filmy";
      fsType = "ntfs";
      options = [
        "noauto"
        "x-systemd.automount"
      ];
    };

  #hardware.nvidia.vgpu.enable = true; # Enable NVIDIA KVM vGPU + GRID driver
  #hardware.nvidia.vgpu.unlock.enable = true; # Unlock vGPU functionality on consumer cards using DualCoder/vgpu_unlock project

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

    kernelPackages = pkgs.linuxPackages_5_13;
  };

  # make more out of the ram
  zramSwap.enable = true;

}
