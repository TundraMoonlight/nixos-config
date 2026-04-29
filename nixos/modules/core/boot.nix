{pkgs, ...}: {
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        plymouth.enable = true;

        plymouth = {
        };
        loader = {
            efi = {
                canTouchEfiVariables = true;
            };

            systemd-boot = {
                enable = true;
                configurationLimit = 10;
            };

            # limine = {
            #   enable = true;
            #   maxGenerations = 20;
            #
            #   style = {
            #     graphicalTerminal = {
            #       palette = "1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
            #       brightPalette = "585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
            #
            #       background = "181825";
            #       foreground = "cdd6f4";
            #
            #       brightBackground = "1e1e2e";
            #       brightForeground = "cdd6f4";
            #     };
            #   };
            # };
        };
    };
}
