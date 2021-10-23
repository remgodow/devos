{ config, pkgs, ... }: {

  virtualisation.libvirtd = {
    enable = true;
    qemuPackage = pkgs.qemu_kvm;
    qemuOvmf = true;
    qemuVerbatimConfig = ''
      user = "remo"
      vnc_allow_host_audio = 1
    '';
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    looking-glass-client
    qemu-utils
  ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 666 root root"
  ];

}
