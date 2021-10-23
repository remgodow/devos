final: prev: {
  # keep sources this first
  sources = prev.callPackage (import ./_sources/generated.nix) { };
  # then, call packages with `final.callPackage`
  protonmail-bridge = final.callPackage (import ./proton-bridge/default.nix) { };

  freetube = prev.freetube.overrideAttrs (old: rec{
    inherit (final.sources.freetube) pname version src;
    appimageContents = prev.appimageTools.extractType2 {
      name = "${pname}-${version}";
      inherit src;
    };
    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin $out/share/${pname} $out/share/applications
      cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
      cp -a ${appimageContents}/freetube.desktop $out/share/applications/${pname}.desktop
      cp -a ${appimageContents}/usr/share/icons $out/share
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
      runHook postInstall
    '';
  });

  manix = prev.manix.overrideAttrs (o: rec{
    inherit (final.sources.manix) pname version src;
  });

  looking-glass-client = final.callPackage (import ./looking-glass/default.nix) { };

  #   starship = final.naersk.buildPackage {
  #     inherit (final.sources.starship) pname src;
  #     name = "starship";
  #     version = builtins.replaceStrings ["v"] [""] final.sources.starship.version;
  #   };

  nix-autobahn = final.callPackage (import ./nix-autobahn/default.nix) { };

  gamehub = final.callPackage (import ./gamehub/default.nix) { };

  dxvk = final.callPackage (import ./dxvk/default.nix) { };

  vkd3d-proton = final.callPackage (import ./vkd3d-proton) {
    wine = final.wine;
  };

  discord = prev.discord.overrideAttrs (old: rec {
    inherit (final.sources.discord) version src;
  });

  webstorm = prev.jetbrains.webstorm.overrideAttrs (old: rec {
    inherit (final.sources.webstorm) version src;
  });

  idea-ultimate = prev.jetbrains.idea-ultimate.overrideAttrs (old: rec {
    inherit (final.sources.idea-ultimate) version src;
  });

  codewithme-guest = final.callPackage (import ./jetbrains) { };

}
