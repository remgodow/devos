{ config, pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  # Additional KDE software
  environment.systemPackages = with pkgs; [
    kate
    kwallet-pam
    xorg.xhost
  ];

  services.xserver.displayManager.setupCommands = "${pkgs.xorg.xhost}/bin/xhost +local:";

  # systemd.services.xhoster = {
  #   script = ''
  #     export DISPLAY=:0
  #     ${pkgs.xorg.xhost}/bin/xhost +local:
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };
}
