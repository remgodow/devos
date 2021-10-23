{ pkgs, ... }:
{
  users.users.dev = {
    uid = 1000;
    isNormalUser = true;
    password = "nixos";
    home = "/home/dev";
    extraGroups = [
      "wheel"
      "docker"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.dev = { suites, ... }: {
    imports = suites.base ++ suites.development ++ [
      ../profiles/communication/slack.nix
      ../profiles/communication/thunderbird.nix
      ../profiles/keepassxc
      ../profiles/webbrowsers/chromium.nix
      ../profiles/office/libreoffice.nix
      ../profiles/office/xournalpp.nix
      ../profiles/development/vscodium.nix
      ../profiles/development/jetbrains.nix
      ../profiles/development/js.nix
    ];

    home.packages = with pkgs; [
      wireshark
    ];

  };
}
