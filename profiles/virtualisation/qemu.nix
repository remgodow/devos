{ config, pkgs, ... }: {

  virtualisation.libvirtd = {
    enable = true;
    qemuPackage = pkgs.qemu_kvm;
    qemuOvmf = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];

}
