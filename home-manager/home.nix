# ---- METADATA ----
# Target: ~/.config/nixpkgs/home.nix
# Author: Hentioe (绅士喵)
# CreatedAt: 2021-03-09
# UpdatedAt: 2022-06-20
# ---- METADATA ----

{ config, pkgs, callPackage, ... }:

let
  personal = rec {
    username = "hentioe";
    homeDirectory = "/home/${username}";

    # git clone git@github.com:Hentioe/nur-packages.git ~/nur-packages
    localNurPackages = "${homeDirectory}/nur-packages";
    # git clone git@github.com:NixOS/nixpkgs.git ~/nixpkgs
    localNixpkgsRepo = "${homeDirectory}/nixpkgs";

    localizedNixpkgs = import "${localNixpkgsRepo}/default.nix" { };
  };

in rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = personal.username;
  home.homeDirectory = personal.homeDirectory;

  fonts.fontconfig.enable = true;

  nixpkgs.overlays = [ (import "${personal.localNurPackages}/overlay.nix") ];

  # 用户软件包列表
  home.packages = with pkgs; [
    # 我的 NUR 软件包。
    # linuxqq
    dart
    besttrace
    # hmcl
    # 字体/主题/图标
    jetbrains-mono
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    papirus-icon-theme
    materia-kde-theme
    # 娱乐/通信/多媒体
    nur.repos.linyinfeng.icalingua-plus-plus
    steam
    discord
    feh
    gwenview
    ffmpeg-full
    (mpv-unwrapped.override { ffmpeg = ffmpeg-full; })
    tdesktop
    kotatogram-desktop
    mailspring
    # 系统工具
    latte-dock
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
    pciutils
    gparted
    tilix
    youtube-dl
    gping
    # 开发工具
    vscode
    rustup
    gcc
    llvmPackages_12.bintools-unwrapped
    docker-compose
    nodejs
    lua5_4
    luarocks
    postman
    neovim
    android-studio
    flutter
    arduino
    platformio
    librepcb
    cloc
    # 其它工具
    gimp
    kdenlive
    ark
    autojump
    bitwarden
    aria
    wget
    openjdk
    google-chrome
    microsoft-edge
    freecad
    openscad
    cura
    prusa-slicer
    meshlab
    # chromium
    flameshot
    tor-browser-bundle-bin
    peek
    imagemagick
    bash-completion
    google-cloud-sdk-gce
    azure-cli
    inkscape
    tree
    killall
    wireshark
    blender
    samba4Full
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
