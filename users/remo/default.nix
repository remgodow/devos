{ pkgs, ... }:
{
  users.users.remo = {
    uid = 1001;
    isNormalUser = true;
    home = "/home/remo";
    hashedPassword = "$6$/xRh0UGhm59i$W91wf1riZy5945JZsECBT7p3RXmSi.eiTjc1Zmkwnn3s.CTZ050sX3mAhBwkFhLxQkXl8GDuByyRZXEX2Qiyb0";

    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "libvirtd"
      "qemu-libvirtd"
      "adbusers"
    ];
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
      ../profiles/keepassxc
      ../profiles/entertainment
      ../profiles/office/libreoffice.nix
    ];
  };
}
