{
  programs.foot = {
    enable = true;
    settings = {
      url.protocols = builtins.concatStringsSep "," [
        "file"
        "http"
        "https"
        "steam"
      ];
    };
  };
}
