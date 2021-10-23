{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yarn
    nodejs-16_x
    nodePackages.nodemon
  ];
}
