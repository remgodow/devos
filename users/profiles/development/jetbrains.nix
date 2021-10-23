{ pkgs, ... }: {
  home.packages = with pkgs; [
    webstorm
    codewithme-guest
    idea-ultimate
  ];

}
