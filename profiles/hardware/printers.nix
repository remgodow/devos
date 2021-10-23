{ config, pkgs, ... }: {
  services.printing = {
    enable = true;
    startWhenNeeded = true;
    webInterface = true;
  };

  environment.systemPackages = [
    pkgs.cups-filters
  ];

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  programs.system-config-printer.enable = true;

  hardware.sane = {
    enable = true;
    brscan4 = {
      enable = true;
      netDevices."DCP-9020CDW" = {
        ip = "192.168.1.201";
        model = "DCP-9020CDW";
      };
    };
  };
}
