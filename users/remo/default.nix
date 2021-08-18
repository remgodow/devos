 { pkgs, ... }:
{
  users.users.remo = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.dev = { suites, ... }: {
    imports = suites.base;
};
