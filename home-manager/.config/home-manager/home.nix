{ config, pkgs, ... }:


{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.tree
    pkgs.htop
    (pkgs.nerdfonts.override { fonts = [ "GeistMono" ]; })
  ];
  fonts.fontconfig.enable = true;

  programs.bat.enable = true;

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;

  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.git.userName = "rfletchr";
  programs.git.userEmail = "rcsfletcher@protonmail.com";
  programs.git.extraConfig = {
    init = {
      defaultBranch = "master";
    };
    pull = {
      rebase = false;
    };

  };

  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";

  programs.go.enable = true;

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    cat = "bat --theme zenburn";
    ll = "ls -lah";
  };


  programs.bash.initExtra = ''
    source ~/user_functions.sh
  '';

  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;

    profile.b1dcc9dd-5262-4d8d-a863-c897e6d979b9 = {
      default = true;
      visibleName = "dev";

      showScrollbar = false;
      transparencyPercent = 10;
      font = "GeistMono Nerd Font 14";

      colors = {
        palette = [
          "#1c2023"
          "#c7ae95"
          "#95c7ae"
          "#aec795"
          "#ae95c7"
          "#c795ae"
          "#95aec7"
          "#c7ccd1"
          "#747c84"
          "#c7ae95"
          "#95c7ae"
          "#aec795"
          "#ae95c7"
          "#c795ae"
          "#95aec7"
          "#f3f4f5"
        ];

        backgroundColor = "#262626";
        foregroundColor = "#c7ccd1";
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
