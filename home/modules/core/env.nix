{
    lib,
    inputs,
    pkgs,
    ...
}: {
    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        FLAKE = "/home/tundra/.config/nixos/";
        NIXPKGS_ALLOW_UNFREE = 1;
        NH_FLAKE = lib.mkForce "/home/tundra/.config/nixos/";
        QML_IMPORT_PATH = "${inputs.qml-niri.packages.x86_64-linux.quickshell}/lib/qt-6/qml";
        # QML2_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml";
        NIXOS_OZONE_WL = 1;
    };
}
