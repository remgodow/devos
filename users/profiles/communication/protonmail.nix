{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    libsecret
    protonmail-bridge
  ];

}
