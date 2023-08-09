# ---- METADATA ----
# Target: ~/.config/home-manager/home.nix
# Author: Hentioe (绅士喵)
# CreatedAt: 2021-03-09
# UpdatedAt: 2023-08-09
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
    besttrace # 包含地理位置的路由追踪工具
    # 字体/主题/图标
    jetbrains-mono # Jetbrains 的等宽字体
    papirus-icon-theme # 图标包
    # 娱乐/办公/多媒体
    discord # Discord
    feh # 轻量级图片查看器
    gwenview # KDE 的图片查看器
    ffmpeg-full # 音视频工具集
    mpv-unwrapped # 视频播放器
    tdesktop # Telegram
    mailspring # 邮件客户端
    obsidian # Markdown 编辑器
    #googleearth-pro
    # 系统工具
    android-tools # Android 平台工具集
    payload-dumper-go # 解压 Android ROM
    htop # 查看进程信息
    neofetch # 查看系统信息
    mosh # 使用 UDP 的 SSH 替代品
    remmina # RDP 客户端
    termius # 多窗口 SSH 客户端
    unzip # .zip 解压/压缩
    unrar # .rar 解压
    virt-manager # 虚拟机管理器
    xorg.xdpyinfo # 显示 X 服务器信息
    rclone # 同步工具
    inotify-tools # 提供 inotify 接口的包
    pciutils # PCI 实用程序
    youtube-dl # 在线视频下载器
    gping # 带有图表的 ping
    iperf3 # 网速测试
    qemu # 模拟器
    liquidctl # 查看水冷温度
    speedtest-cli # 网速测试
    radeontop # 查看 AMD GPU 占用
    dua # 查看磁盘占用
    dysk # 查看文件系统信息
    procs # ps 的替代品
    tokei # 统计代码行数
    xh # 命令行 HTTP 客户端
    wezterm # GPU 加速的跨平台终端
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
    just
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

