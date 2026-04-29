{pkgs, ...}: {
    fonts = {
        fontconfig.enable = true;

        packages = [
            pkgs.nerd-fonts.blex-mono
            pkgs.nerd-fonts.liberation
            pkgs.nerd-fonts.fira-code
            pkgs.nerd-fonts.adwaita-mono
            pkgs.nerd-fonts.inconsolata
            pkgs.nerd-fonts.jetbrains-mono
            pkgs.nerd-fonts.lilex
            pkgs.nerd-fonts.commit-mono
            pkgs.nerd-fonts.space-mono
            pkgs.maple-mono.NF
        ];
    };
}
