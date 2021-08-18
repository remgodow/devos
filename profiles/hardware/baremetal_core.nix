{ config, pkgs, ... }: {

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];

  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;

}
