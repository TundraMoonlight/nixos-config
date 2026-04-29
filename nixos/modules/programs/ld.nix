{pkgs, ...}: {
    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
            qt6.qtbase
            xorg.libxcb
            xorg.libX11
            xorg.libXrender
            xorg.libXext
        ];
    };
}
