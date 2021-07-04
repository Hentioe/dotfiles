# ---- METADATA ----
# Target: ~/.config/nixpkgs/home.nix
# Author: Hentioe (绅士喵)
# CreatedAt: 2021-03-09
# UpdatedAt: 2021-07-05
# ---- METADATA ----

{ config, pkgs, callPackage, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hentioe";
  home.homeDirectory = "/home/hentioe";

  fonts = { fontconfig = { enable = true; }; };

  # 用户软件包列表
  home.packages = with pkgs; [
    # 字体/主题/图标
    jetbrains-mono
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    papirus-icon-theme
    # 娱乐/通信
    steam
    tdesktop
    # 系统工具
    htop
    neofetch
    mosh
    parted
    remmina
    unzip
    unrar
    virt-manager
    wine
    winetricks
    xorg.xdpyinfo
    # 开发工具
    git
    clang_12
    docker-compose
    erlang
    nodejs
    postman
    rustup
    vscode
    neovim
    jdk
    androidStudioPackages.beta
    cmake
    inotify-tools
    # 其它工具
    gimp
    kdenlive
    ark
    autojump
    bitwarden
    aria
    wget
    google-chrome
    discord
    mpv
    flameshot
    tor-browser-bundle-bin
    peek
    imagemagick
    bash-completion
    libreoffice
    inkscape
  ];

  # services.redshift = {
  #   enable = true;
  #   provider = "manual";
  #   settings.redshift = {
  #     brightness-night = "0.8";
  #     brightness-day = "1";
  #   };
  #   temperature = {
  #     day = 5700;
  #     night = 3600;
  #   };
  #   longitude = "114";
  #   latitude = "22";
  # };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
