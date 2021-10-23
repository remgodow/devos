{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    steam
    lutris
    discord
    xboxdrv
    gamehub
    dxvk
    wine
    winetricks
    protontricks
    gnome.zenity
    yad
    mangohud
  ];
}
