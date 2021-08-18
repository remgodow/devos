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
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.remo = { suites, ... }: {
    imports = suites.base ++ [
      ../profiles/gaming
      ../profiles/shell
      ../profiles/communication/thunderbird.nix
      ../profiles/keepassxc
      ../profiles/entertainment
    ];
  };
}
