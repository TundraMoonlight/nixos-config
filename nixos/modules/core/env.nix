{...}: {
    environment.sessionVariables = {
        FLAKE = "/home/tundra/.config/nixos";
        NH_FLAKE = "/home/tundra/.config/nixos";
        MANPAGER = "nvim +Man!";

        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
    };
}
