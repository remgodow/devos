{ config, pkgs, ... }: {
  services.printing = {
    enable = true;
    startWhenNeeded = true;
    webInterface = false;
  };
}
