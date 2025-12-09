{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages to install
  home.packages = [
    pkgs.htop
    pkgs.ripgrep
    pkgs.fd
    pkgs.bat
  ];

  programs.git = {
    enable = true;
    # Using settings (new format)
    settings = {
      user = {
        name = "m8a user";
        email = "user@m8a.io";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "home-manager switch";
    };
  };
  
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Optional: configure starship here or let it read ~/.config/starship.toml
    # For now, default starship is infinitely better than plain zsh
  };
}
