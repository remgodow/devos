{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    freetube
    vlc
  ];

}
