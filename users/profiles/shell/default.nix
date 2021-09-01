{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.fzf.enable = true;

  programs.bat.enable = true;

  programs.zoxide = {
    enable = true;
    options = [ "--hook pwd" ];
  };

  programs.starship = {
    enable = true;
  };

  home.packages = with pkgs; [
    wezterm
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

}
