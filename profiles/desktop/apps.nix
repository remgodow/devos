{ config, pkgs, lib, ... }: {

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
  ]
  ++ lib.optional config.hardware.sane.enable pkgs.gscan2pdf;

}
