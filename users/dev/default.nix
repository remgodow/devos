{ pkgs, ... }:
{
  users.users.dev = {
    uid = 1000;
    isNormalUser = true;
    password = "nixos";
    homeDirectory = "/home/dev";
    extraGroups = [
      "wheel"
      "docker"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.dev = { suites, ... }: {
    imports = suites.base ++ suites.development;
  };
}
