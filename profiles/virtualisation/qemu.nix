{ config, pkgs, ... }: {

  virtualisation.libvirtd = {
    qemuPackage = pkgs.qemu_kvm
      qemuOvmf = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];

}
