# ---- METADATA ----
# Target: ~/.config/home-manager/home.nix
# Author: Hentioe (绅士喵)
# CreatedAt: 2021-03-09
# UpdatedAt: 2023-07-29
# ---- METADATA ----

{ config, pkgs, callPackage, ... }:

let
  personal = rec {
    # Define some variables
    username = "hentioe";
    homeDirectory = "/home/${username}";
    # git clone git@github.com:Hentioe/nur-packages.git ~/nur-packages
    localNurPackages = "${homeDirectory}/nur-packages";
    # git clone git@github.com:NixOS/nixpkgs.git ~/nixpkgs
    localNixpkgsRepo = "${homeDirectory}/nixpkgs";
    # Localized Nix repository
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
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball
        "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
    };
    permittedInsecurePackages = [ "nodejs-16.20.0" ];
  };

  # 用户软件包列表
  home.packages = with pkgs; [
    # 我的 NUR 软件包
    besttrace
    # 字体/主题/图标
    jetbrains-mono
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    papirus-icon-theme
    # 娱乐/办公/多媒体
    discord
    feh
    gwenview
    ffmpeg-full
    mpv-unwrapped
    tdesktop
    mailspring
    yuzu-mainline
    obsidian
    # 系统工具
    android-tools
    payload-dumper-go
    htop
    neofetch
    mosh
    remmina
    termius
    unzip
    unrar
    virt-manager
    wine
    winetricks
    xorg.xdpyinfo
    rclone
    inotify-tools
    pciutils
    gparted
    youtube-dl
    gping
    iperf3
    liquidctl # 查看水冷温度
    qemu
    speedtest-cli
    # 开发工具
    vscode
    rustup
    gcc
    llvmPackages_12.bintools-unwrapped
    nodejs
    lua5_4
    luarocks
    postman
    android-studio
    flutter
    platformio
    librepcb
    cloc
    crystal
    shards
    solc
    helix
    # 其它工具
    gimp
    kdenlive
    ark
    autojump
    bitwarden
    aria
    wget
    google-chrome
    microsoft-edge
    firefox
    freecad
    openscad
    fstl
    cura
    meshlab
    flameshot
    tor-browser-bundle-bin
    peek
    imagemagick
    bash-completion
    google-cloud-sdk-gce
    azure-cli
    awscli2
    inkscape
    tree
    killall
    wireshark
    blender
    samba
    libreoffice
  ];

  #config.permittedInsecurePackages = [];

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

