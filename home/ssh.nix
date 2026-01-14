{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = ["config.d/*"];
    settings = {
      "github.com" = {
        identityFile = "~/.ssh/id_rsa";
      };
      "*" = {
        AddKeysToAgent = "yes";
        UseKeychain = "yes";
      };
    };
  };
}
