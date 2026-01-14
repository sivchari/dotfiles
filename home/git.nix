{...}: {
  programs.git = {
    enable = true;

    signing = {
      format = "ssh";
      key = "~/.ssh/id_rsa.pub";
      signByDefault = true;
    };

    settings = {
      url."git@github.com:".insteadOf = "https://github.com/";
      user = {
        name = "sivchari";
        email = "shibuuuu5@gmail.com";
      };
      alias = {
        a = "add";
        br = "branch";
        cm = "commit -s";
        cma = "commit --amend -s";
        olog = "log --oneline";
        ph = "push origin HEAD";
        phf = "push --force-with-lease origin HEAD";
        plh = "pull origin HEAD";
        rb = "rebase";
        st = "status";
        sts = "stash";
        stsp = "stash pop";
        swc = "switch -c";
        sw = "switch";
      };
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        ignorecase = false;
        excludesfile = "~/.config/git/ignore";
      };
      diff = {
        colorMoved = "default";
        external = "difft";
      };
      ghq.root = "~/workspace";
    };
  };
}
