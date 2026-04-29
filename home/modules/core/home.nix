{lib, ...}: {
    home = {
        username = "tundra";
        homeDirectory = lib.mkForce "/home/tundra/";
        stateVersion = "25.11";
    };
}
