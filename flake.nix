{
  description = "A highly structured configuration database.";

  nixConfig.extra-experimental-features = "nix-command flakes ca-references";
  nixConfig.extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs =
    {
      nixos.url = "github:nixos/nixpkgs/release-21.05";
      latest.url = "github:nixos/nixpkgs/nixos-unstable";

      digga.url = "github:divnix/digga";
      digga.inputs.nixpkgs.follows = "nixos";
      digga.inputs.nixlib.follows = "nixos";
      digga.inputs.home-manager.follows = "home";
      digga.inputs.deploy.follows = "nixos";

      bud.url = "github:divnix/bud";
      bud.inputs.nixpkgs.follows = "nixos";
      bud.inputs.beautysh.follows = "nixos";
      bud.inputs.devshell.follows = "digga/devshell";

      home.url = "github:nix-community/home-manager/release-21.05";
      home.inputs.nixpkgs.follows = "nixos";

      darwin.url = "github:LnL7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixos";

      deploy.follows = "digga/deploy";

      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "nixos";

      flake-compat = {
        url = "github:edolstra/flake-compat";
        flake = false;
      };

      nvfetcher.url = "github:berberman/nvfetcher";
      nvfetcher.inputs.nixpkgs.follows = "nixos";
      nvfetcher.inputs.flake-compat.follows = "flake-compat";
      nvfetcher.inputs.flake-utils.follows = "digga/flake-utils-plus/flake-utils";

      naersk.url = "github:nmattia/naersk";
      naersk.inputs.nixpkgs.follows = "nixos";

      nixos-hardware.url = "github:nixos/nixos-hardware";

      nvidiavgpu.url = "github:remgodow/nixos-nvidia-vgpu/5.10-460.32";
      nix-ld.url = "github:Mic92/nix-ld";
      nix-ld.inputs.nixpkgs.follows = "nixos";

      # start ANTI CORRUPTION LAYER
      # remove after https://github.com/NixOS/nix/pull/4641
      nixpkgs.follows = "nixos";
      nixlib.follows = "digga/nixlib";
      blank.follows = "digga/blank";
      flake-utils-plus.follows = "digga/flake-utils-plus";
      flake-utils.follows = "digga/flake-utils";
      # end ANTI CORRUPTION LAYER

    };

  outputs =
    { self
    , digga
    , bud
    , nixos
    , latest
    , home
    , nixos-hardware
    , nur
    , agenix
    , nvidiavgpu
    , nvfetcher
    , deploy
    , naersk
    , nix-ld
    , ...
    } @ inputs:
    digga.lib.mkFlake
      {
        inherit self inputs;

        channelsConfig = { allowUnfree = true; };

        channels = {
          nixos = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [
              digga.overlays.patchedNix
              nur.overlay
              agenix.overlay
              nvfetcher.overlay
              #deploy.overlay
              naersk.overlay
              ./pkgs/wine.nix
              ./pkgs/default.nix
              ./pkgs/steam.nix
            ];
          };
          latest = { };
        };

        lib = import ./lib { lib = digga.lib // nixos.lib; };

        sharedOverlays = [
          (final: prev: {
            __dontExport = true;
            lib = prev.lib.extend (lfinal: lprev: {
              our = self.lib;
            });
          })
        ];

        nixos = {
          hostDefaults = {
            system = "x86_64-linux";
            channelName = "nixos";
            imports = [ (digga.lib.importModules ./modules) ];
            externalModules = [
              { lib.our = self.lib; }
              digga.nixosModules.bootstrapIso
              digga.nixosModules.nixConfig
              home.nixosModules.home-manager
              agenix.nixosModules.age
              bud.nixosModules.bud
              nvidiavgpu.nixosModules.nvidia-vgpu
              nix-ld.nixosModules.nix-ld
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts) ];
          hosts = {
            nixos-hyperv = { };
            nixos-bm = { };
          };
          importables = rec {
            profiles = digga.lib.rakeLeaves ./profiles // {
              users = digga.lib.rakeLeaves ./users;
            };
            suites = with profiles; rec {
              base = [ core users.root ];
              development = [ users.dev ];
              daily = [ users.remo ];
            };
          };
        };

        home = {
          imports = [ (digga.lib.importModules ./users/modules) ];
          externalModules = [ ];
          importables = rec {
            profiles = digga.lib.rakeLeaves ./users/profiles;
            suites = with profiles; rec {
              base = [ direnv git ];
              development = [ shell xrdp ];
            };
          };
        };

        devshell = ./shell;

        homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

        deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

        defaultTemplate = self.templates.bud;
        templates.bud.path = ./.;
        templates.bud.description = "bud template";

      }
    //
    {
      budModules = { devos = import ./bud; };
    }
  ;
}
