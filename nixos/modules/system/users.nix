{pkgs, ...}: {
    users.users.tundra = {
        isNormalUser = true;
        shell = pkgs.fish;
        description = "tundra";
        extraGroups = [
            "networkmanager"
            "wheel"
            "input"
            "docker"
        ];
        packages = [];
    };

    environment.systemPackages = [
        pkgs.fish
    ];
}
