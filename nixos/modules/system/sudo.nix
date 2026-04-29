{...}: {
    security = {
        sudo = {
            enable = true;

            extraConfig = ''
                Defaults timestamp_timeout=10
                Defaults timestamp_type=ppid
                Defaults passwd_timeout=0
                Defaults pwfeedback
                Defaults insults
            '';
        };
    };
}
