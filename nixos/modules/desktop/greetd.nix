{...}: {
    services.greetd = {
        enable = true;

        settings = {
            default_session = {
                command = "uwsm start -S hyprland-uwsm.desktop";
                user = "tundra";
            };
        };
    };
}
