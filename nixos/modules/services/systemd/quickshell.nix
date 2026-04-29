{...}: {
  systemd.services = {
    quickshell = {
      enable = true;
      name = "quickshell";

      unitConfig = ''
        PartOf=graphical-session.target
        After=graphical-session.target
        Requisite=graphical-session.target
      '';

      serviceConfig = ''
        ExecStart=quickshell
        Restart=on-failure
      '';
    };
  };
}
