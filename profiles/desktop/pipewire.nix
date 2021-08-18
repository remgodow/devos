{ config, pkgs, ... }: {

  hardware.pulseaudio.enable = false;

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
  };
}

