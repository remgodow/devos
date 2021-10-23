{ pkgs, lib, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions =
      let
        createChromiumExtensionFor = browserVersion: { id, sha256, version }:
          {
            inherit id;
            crxPath = builtins.fetchurl {
              url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
              name = "${id}.crx";
              inherit sha256;
            };
            inherit version;
          };
        createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
      in
      [
        (createChromiumExtension {
          # google hangouts
          id = "nckgahadagoaajjgafhacjanaoiihapd";
          sha256 = "2c09c3f892c5c8c8410177e3711151bbdf089d4a0da74e32a0d9e8d475e4066c";
          version = "2020.803.419.1";
        })
        (createChromiumExtension {
          # ublock origin
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          sha256 = "95d4559e07fbbbbb60022dd0e8358067a15ec48bb193df804b2f9f4e301fd408";
          version = "1.38.0";
        })
        (createChromiumExtension {
          #firecamp
          id = "eajaahbjpnhghjcdaclbkeamlkepinbl";
          sha256 = "3852f7c64db453aa61231b6d43741368f7e7fb380afdca5b4737203c16422292";
          version = "2.2.1";
        })
        (createChromiumExtension {
          #cookie autodelete
          id = "fhcgjolkccmbidfldomjliifgaodjagh";
          sha256 = "7295049ac2f6e17fb3d812d7219b85c4bd2d8ac43a88e28fc8be52ef8e9ddff0";
          version = "3.6.0";
        })
      ];
  };
}
