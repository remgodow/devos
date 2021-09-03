{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    xrdp
    xorg.xhost
  ];

  services.xserver.displayManager.setupCommands = "${pkgs.xorg.xhost}/bin/xhost +local:";

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  networking.firewall.allowedUDPPorts = [ 3389 ];
  networking.firewall.allowedTCPPorts = [ 3389 ];
}
