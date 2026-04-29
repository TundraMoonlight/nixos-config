{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        nvf.url = "github:notashelf/nvf";
        nixcord.url = "github:FlameFlag/nixcord";
        awww = {
            url = "git+https://codeberg.org/LGFae/awww";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        accela.url = "github:ciscosweater/enter-the-wired";

        qml-niri = {
            url = "github:imiric/qml-niri/main";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.quickshell.follows = "quickshell";
        };

        helium = {
            url = "github:AlvaroParker/helium-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        sls-steam = {
            url = "github:AceSLS/SLSsteam";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        lutgen-studio = {
            url = "github:ozwaldorf/lutgen-rs";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        firefox-addons = {
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake/beta";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                home-manager.follows = "home-manager";
            };
        };
    };

    outputs = inputs @ {
        sls-steam,
        firefox-addons,
        zen-browser,
        accela,
        self,
        quickshell,
        awww,
        qml-niri,
        helium,
        lutgen-studio,
        nixcord,
        nvf,
        nixpkgs,
        home-manager,
    }: {
        # nixpkgs.overlays = [ inputs.millennium.overlays.default ];

        nixosConfigurations.moonlight = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;};

            modules = [
                ./nixos/configuration.nix

                nvf.nixosModules.default
                nixcord.nixosModules.nixcord

                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        backupFileExtension = "back";
                        extraSpecialArgs = {inherit inputs;};
                        users.tundra = import ./home/home.nix;
                    };
                }
            ];
        };
    };
}
