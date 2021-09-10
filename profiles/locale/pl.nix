{ pkgs, ... }: {

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  # Configure keymap in X11
  services.xserver.layout = "pl";

}
