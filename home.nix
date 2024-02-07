{ config, pkgs, ... }:
{
  home-manager.users.user = 
  { pkgs, ... }: {
  home.packages = with pkgs;[ 
    atool
    httpie 
    chromium
    librewolf
    brave
    emacs29-pgtk
    vscode
    gopls
    go
    rustup
    nextcloud-client
    audacious
    audacious-plugins
    vlc
    mpv
    yewtube
    libreoffice-fresh
    pandoc
    xiphos
    keepassxc
    plasma-browser-integration
    git
  ];
   nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.05"; 
  programs.zsh = 
  { enable = true; 
    oh-my-zsh.enable = true; 
    oh-my-zsh.plugins = ["z"]; 
    }; 
  }; 
}
