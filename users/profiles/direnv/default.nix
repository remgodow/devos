{
  programs.direnv = {
    enable = true;
    #enableNixDirenvIntegration = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };
}
