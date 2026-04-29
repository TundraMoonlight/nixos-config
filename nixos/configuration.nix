{
    pkgs,
    inputs,
    ...
}: {
    imports = [
        ./hardware-configuration.nix

        ./modules/core/default.nix
        ./modules/system/default.nix
        ./modules/services/default.nix
        ./modules/desktop/default.nix
        ./modules/programs/default.nix
    ];

    environment.systemPackages = with pkgs; [
        git
        vim
        wget
        mpc
        xwayland-satellite
        file
        proton-pass
        nh
        nwg-look
        nicotine-plus
        brightnessctl
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        wl-clipboard
        docker-compose
        adi1090x-plymouth-themes
        desktop-file-utils
        unzip
        fishPlugins.autopair
        fishPlugins.bang-bang

        inkscape

        catppuccin-cursors.mochaDark
        inputs.sls-steam.packages.${pkgs.system}.wrapped
    ];
}
