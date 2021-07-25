{ pkgs, ... }:
{
  users.users.dev = {
    uid = 1000;
    description = "default";
    isNormalUser = true;
    password = "nixos";
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  home-manager.users.dev = { suites, pkgs, ... }: {
    imports = suites.base;
  };
}
