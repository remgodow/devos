{ pkgs, lib, config, ... }:
{
  users.users.remo = {
    uid = 1001;
    isNormalUser = true;
    home = "/home/remo";
    hashedPassword = "$6$/xRh0UGhm59i$W91wf1riZy5945JZsECBT7p3RXmSi.eiTjc1Zmkwnn3s.CTZ050sX3mAhBwkFhLxQkXl8GDuByyRZXEX2Qiyb0";

    extraGroups = [
      "wheel"
    ]
    ++ lib.optional config.networking.networkmanager.enable "networkmanager"
    ++ lib.optional config.virtualisation.docker.enable "docker"
    ++ lib.optional config.virtualisation.libvirtd.enable "libvirtd"
    ++ lib.optional config.virtualisation.libvirtd.enable "qemu-libvirtd"
    ++ lib.optional config.programs.adb.enable "adbusers"
    ++ lib.optional config.services.avahi.enable "avahi"
    ++ lib.optional config.services.printing.enable "lp"
    ++ lib.optional config.hardware.sane.enable "scanner";

    shell = pkgs.zsh;
  };

  programs.steam.enable = true;

  home-manager.users.remo = { suites, ... }: {
    imports = suites.base ++ [
      ../profiles/xdg
      ../profiles/gaming
      ../profiles/shell
      ../profiles/communication/thunderbird.nix
      ../profiles/communication/protonmail.nix
      ../profiles/communication/nheko.nix
      ../profiles/keepassxc
      ../profiles/entertainment
      ../profiles/office/libreoffice.nix
    ];

    home.packages = [
      pkgs.helix
    ];
  };

}
