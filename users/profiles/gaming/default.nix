{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    steam
    lutris
    discord
    xboxdrv
  ];
}
