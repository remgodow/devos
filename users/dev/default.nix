{ ... }:
{
  users.users.dev = {
    uid = 1000;
    isNormalUser = true;
    password = "nixos";
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  home-manager.users.dev = { suites, ... }: {
    imports = suites.base;
  };
}