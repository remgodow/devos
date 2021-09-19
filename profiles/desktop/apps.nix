{ config, pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [
    firefox
  ]
  ++ lib.optional config.hardware.sane.enable pkgs.gscan2pdf;

}
