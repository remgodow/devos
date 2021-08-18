 { pkgs, ... }:
{
  users.users.remo = {
    uid = 1001;
    isNormalUser = true;
    home = "/home/remo";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.dev = { suites, ... }: {
    imports = suites.base ++ [
    ../profiles/gaming
    ];
  };
}
