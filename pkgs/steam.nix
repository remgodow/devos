final: prev: {

  steam = prev.steam.overrideAttrs (old: rec{
    extraPkgs = [
      final.gnome.zenity
      final.yad
      final.mangohud
    ];
  });

}
