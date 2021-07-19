# ---- METADATA ----
# Target: ~/.config/nixpkgs/home.nix
# Author: Hentioe (绅士喵)
# CreatedAt: 2021-03-09
# UpdatedAt: 2021-07-19
# ---- METADATA ----

{ config, pkgs, callPackage, ... }:

let
  mine = rec {
    username = "hentioe";
    homeDirectory = "/home/${username}";

    # git clone git@github.com:Hentioe/nur-packages.git ~/nur-packages
    nurPackages = "${homeDirectory}/nur-packages";
    # git clone git@github.com:NixOS/nixpkgs.git ~/nixpkgs
    localizedNixpkgs = "${homeDirectory}/nixpkgs";

    callLocalNixpkg = { baseDir, drvFile, args ? { } }:
      pkgs.callPackage "${localizedNixpkgs}/pkgs/${baseDir}/${drvFile}.nix"
      args;
  };

in rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = mine.username;
  home.homeDirectory = mine.homeDirectory;

  fonts.fontconfig.enable = true;

  nixpkgs.overlays = [ (import "${mine.nurPackages}/overlay.nix") ];

  # 用户软件包列表
  home.packages = with pkgs; [
    # 我的 NUR 软件包。
    linuxqq
    dart
    besttrace
    # 字体/主题/图标
    jetbrains-mono
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    papirus-icon-theme
    # 娱乐/通信/多媒体
    steam
    tdesktop
    discord
    gwenview
    nomacs
    mpv
    # 系统工具
    patchelf
    htop
    neofetch
    mosh
    remmina
    unzip
    unrar
    virt-manager
    wine
    winetricks
    xorg.xdpyinfo
    (wxGTK30.override {
      withWebKit = true;
      withGtk2 = false;
    })
    inotify-tools
    # 开发工具
    (mine.callLocalNixpkg {
      baseDir = "applications/editors/vscode";
      drvFile = "vscode";
    })
    rustup
    clang_12
    llvmPackages_12.bintools-unwrapped
    docker-compose
    nodejs
    postman
    neovim
    jdk
    androidStudioPackages.beta
    # 其它工具
    gimp
    kdenlive
    ark
    autojump
    bitwarden
    aria
    wget
    google-chrome
    flameshot
    tor-browser-bundle-bin
    peek
    imagemagick
    bash-completion
    libreoffice
    inkscape
    tree
    killall
    wireshark
  ];

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
