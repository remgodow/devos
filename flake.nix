{
  description = "A highly structured configuration database.";

  inputs =
    {
      unstable.url = "nixpkgs/nixos-unstable";
      latest.url = "nixpkgs";
      stable.url = "nixpkgs/nixos-21.05";

      digga.url = "github:divnix/digga/v0.2.0";
      digga.inputs.nixpkgs.follows = "stable";
      home.url = "github:nix-community/home-manager/release-21.05";
      home.inputs.nixpkgs.follows = "stable";
      naersk.url = "github:nmattia/naersk";
      naersk.inputs.nixpkgs.follows = "stable";
      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "stable";
      nixos-hardware.url = "github:nixos/nixos-hardware";

      pkgs.url = "path:./pkgs";
      pkgs.inputs.nixpkgs.follows = "stable";

      nvidiavgpu.url = "github:remgodow/nixos-nvidia-vgpu/5.10-460.32";

    };

  outputs =
    { self
    , pkgs
    , digga
    , home
    , nixos-hardware
    , nur
    , agenix
    , stable
    , unstable
    , latest
    , nvidiavgpu
    , ...
    } @ inputs:
    digga.lib.mkFlake {
      inherit self inputs;

      channelsConfig = { allowUnfree = true; };

      channels = {
        unstable = { };
        latest = { };
        stable = {
          imports = [ (digga.lib.importers.overlays ./overlays) ];
          overlays = [
            ./pkgs/default.nix
            pkgs.overlay # for `srcs`
            nur.overlay
            agenix.overlay
          ];
        };
      };

      lib = import ./lib { lib = digga.lib // stable.lib; };

      sharedOverlays = [
        (final: prev: {
          lib = prev.lib.extend (lfinal: lprev: {
            our = self.lib;
          });
        })
      ];

      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "stable";
          modules = ./modules/module-list.nix;
          externalModules = [
            { _module.args.ourLib = self.lib; }
            home.nixosModules.home-manager
            agenix.nixosModules.age
            ./modules/customBuilds.nix
            nvidiavgpu.nixosModules.nvidia-vgpu
          ];
        };

        imports = [ (digga.lib.importers.hosts ./hosts) ];
        hosts = {
          nixos-hyperv = { };
          nixos-bm = { };
        };
        importables = rec {
          profiles = digga.lib.importers.rakeLeaves ./profiles // {
            users = digga.lib.importers.rakeLeaves ./users;
          };
          suites = with profiles; rec {
            base = [ core users.root ];
            development = [ users.dev ];
            daily = [ users.remo ];
          };
        };
      };

      home = {
        modules = ./users/modules/module-list.nix;
        externalModules = [ ];
        importables = rec {
          profiles = digga.lib.importers.rakeLeaves ./users/profiles;
          suites = with profiles; rec {
            base = [ direnv git ];
            development = [ vscodium shell xrdp jetbrains ];
          };
        };
      };

      devshell.externalModules = { pkgs, ... }: {
        packages = [ pkgs.agenix ];
      };

      homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

      defaultTemplate = self.templates.flk;
      templates.flk.path = ./.;
      templates.flk.description = "flk template";

    }
  ;
}
