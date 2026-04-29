{
    config,
    lib,
    pkgs,
    modulesPath,
    ...
}: {
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/5a2b7a60-77ce-4506-8388-fc6820339daa";
        fsType = "ext4";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/91E9-69B8";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
    };

    swapDevices = [
        {device = "/dev/disk/by-uuid/73d0ce16-36a8-48c7-b89f-283ea9eff5a4";}
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
