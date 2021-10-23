{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      gtkUsePortal = true;
    };
    mime = {
      enable = true;
    };
    icons = {
      enable = true;
    };
    autostart = {
      enable = true;
    };
    menus = {
      enable = true;
    };
  };
}
