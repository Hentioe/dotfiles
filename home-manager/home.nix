# ---- METADATA ----
# Target: ~/.config/home-manager/home.nix
# Author: Hentioe (绅士喵)
# CreatedAt: 2021-03-09
# UpdatedAt: 2023-09-05
# ---- METADATA ----

{ config, pkgs, callPackage, ... }:

let
  personal = rec {
    # Define some variables
    username = "hentioe";
    homeDirectory = "/home/${username}";
    # git clone git@github.com:Hentioe/nur-packages.git ~/.nur-packages
    localNurPackages = "${homeDirectory}/.nur-packages";
    # git clone git@github.com:NixOS/nixpkgs.git ~/.nixpkgs
    localNixpkgsRepo = "${homeDirectory}/.nixpkgs";
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
    # 本地 NUR 软件包
    besttrace # 包含地理位置的路由追踪工具
    # 系统外观
    jetbrains-mono # Jetbrains 的等宽字体
    papirus-icon-theme # Papirus 图标主题包
    # 非自由软件
    discord # Discord
    tdesktop # Telegram
    microsoft-edge # Edge 浏览器
    #googleearth-pro # Google 地球
    # 系统工具
    qemu # 模拟器
    virt-manager # 虚拟机管理器
    wezterm # GPU 加速的跨平台终端
    unzip # .zip 解压/压缩
    unrar # .rar 解压
    ark # 解压工具
    (mpv-unwrapped.override { ffmpeg_5 = ffmpeg_5-full; }) # 视频播放器
    feh # 轻量级图片查看器
    gwenview # KDE 的图片查看器
    # 实用工具
    youtube-dl # 在线视频下载器
    rclone # 同步工具
    termius # 多窗口 SSH 客户端
    remmina # RDP 客户端
    mosh # 使用 UDP 协议的 SSH 替代品
    obsidian # Markdown 编辑器
    mailspring # 邮件客户端
    ffmpeg-full # 音视频工具集
    imagemagick # 全能的图片转换工具
    # 独立的命令行工具
    autojump # 快捷跳转目录
    htop # 查看进程信息
    iperf3 # 网速测试
    pciutils # PCI 实用程序
    gping # 带有图表的 ping
    liquidctl # 查看水冷温度
    xorg.xdpyinfo # 显示 X 服务器信息
    speedtest-cli # 网速测试
    radeontop # 查看 AMD GPU 占用
    neofetch # 查看系统信息
    payload-dumper-go # 解压 Android ROM
    tree # 以树状显示目录的结构
    killall # 便捷的杀死进程
    aria2 # 下载工具
    wget # 网络文件检索
    dua # 查看磁盘占用
    dysk # 查看文件系统信息
    procs # ps 的替代品
    xh # curl 的替代品
    # 编程语言工具链
    clang_16 # Clang
    android-tools # Android 平台工具集
    rustup # Rustup
    nodejs # Node.js
    lua5_4 # Lua
    luarocks # Lua 包管理工具
    flutter # Flutter
    solc # Solidity 编译器
    # 开发环境工具链
    vscode # VS Code
    android-studio # Android Studio
    platformio # PlatformIO
    just # 命令运行器（在通用场景可替代 make）
    cloc # 统计代码行数
    tokei # 统计代码行数（现代化）
    postman # 图形化 HTTP 客户端
    inotify-tools # 提供 inotify 接口
    # 其它工具
    gimp # 图像编辑器
    kdenlive # 视频编辑器
    bitwarden # 密码管理器
    google-chrome # Chrome 浏览器
    firefox # Firefox 浏览器
    tor-browser-bundle-bin # Tor 浏览器
    freecad # 开源 CAD
    openscad # 基于代码建模的开源 CAD
    fstl # 3D 模型查看器
    cura # Cura 切片软件
    meshlab # 3D 模型文件编辑
    flameshot # 截图工具
    peek # 屏幕录制机
    #google-cloud-sdk-gce # GCP 命令行客户端
    #azure-cli # Azure 命令行客户端
    awscli2 # AWS 命令行客户端
    inkscape # 矢量图形编辑器
    wireshark # 抓包工具
    blender # 3D 创作工具
    #libreoffice # 开源的 Office 替代品
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

