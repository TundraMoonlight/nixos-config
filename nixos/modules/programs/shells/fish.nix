{...}: {
    programs.fish = {
        enable = true;
        generateCompletions = true;
        shellAliases = {
            nixupdate = "nh os switch";
            nixtest = "nh os test";
        };

        shellInit = ''
            set -x SUDO_PROMPT (set_color red --bold)"Password: "(set_color normal)

            function starship_transient_prompt_func
                starship module character
            end
            starship init fish | source
            enable_transience
        '';
    };
}
