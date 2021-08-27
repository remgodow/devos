{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    libsecret
    electron-mail
  ];

}
