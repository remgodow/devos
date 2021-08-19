{ config, pkgs, ... }: {

  boot.kernelModules = [ "v4l2loopback" ];

  environment.systemPackages = with pkgs; [
    webcamoid
  ];

}
