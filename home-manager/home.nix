# ---- METADATA ----
# Target: ~/.config/home-manager/home.nix
# Author: Hentioe (绅士喵)
# CreatedAt: 2021-03-09
# UpdatedAt: 2026-02-12
# ---- METADATA ----

{
  config,
  pkgs,
  callPackage,
  ...
}:

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
in
rec {
  # Nix 的版本
  nix.package = pkgs.nixVersions.latest;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # McFly（Shell 历史搜索）
  programs.mcfly.enable = true;
  # MPV 播放器
  programs.mpv = {
    enable = true;
    scripts = [
      pkgs.mpvScripts.thumbfast
      pkgs.mpvScripts.autosubsync-mpv
      pkgs.mpvScripts.uosc
    ];
  };
  # OBS（屏幕录制/推流）
  programs.obs-studio = {
    enable = true;
    plugins = [
      pkgs.obs-studio-plugins.obs-vaapi
    ];
  };
  # 轻量级图片查看器
  programs.feh.enable = true;

  # Flameshot 截图工具
  #services.flameshot.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = personal.username;
  home.homeDirectory = personal.homeDirectory;

  fonts.fontconfig.enable = true;

  nixpkgs.overlays = [
    (import "${personal.localNurPackages}/overlay.nix")
    (self: super: {
      vscode = super.vscode.override {
        commandLineArgs = "--ozone-platform=x11";
      };
    })
  ];
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };

  # 用户软件包列表
  home.packages = with pkgs; [
    # 本地 NUR 软件包
    trzsz-ssh # 命令行版 SSH 连接管理
    tcping2
    pping
    # 系统外观
    jetbrains-mono # Jetbrains 的等宽字体
    papirus-icon-theme # Papirus 图标主题包
    #qogir-kde # KDE 主题
    # 非自由软件
    qq
    discord # Discord
    telegram-desktop # Telegram
    #microsoft-edge # Edge 浏览器
    brave # Brave 浏览器
    google-chrome # Chrome 浏览器
    #googleearth-pro # Google 地球
    android-studio
    #davinci-resolve # 视频编辑（达芬奇）
    # 多媒体工具
    peek # 屏幕录制机
    #gimp3 # 图像编辑器（被 Flatpak 包取代）
    #kdenlive # 视频编辑器
    #audacity # 音频编辑器（被 Flatpak 包取代）
    libavif # AVIF 工具集/库
    #f3d # 3D 模型查看器
    asciinema_3 # 终端录制
    # 游戏
    luanti # 原 Minetest
    # 系统工具
    qemu # 模拟器
    virt-manager # 虚拟机管理器
    unzip # .zip 解压/压缩
    unrar # .rar 解压
    #ark # 解压工具
    openssl # SSL 工具包
    gparted # GUI 分区编辑工具
    bootiso # USB 启动器制作
    # 实用工具
    amdgpu_top # 查看 AMD 显卡占用
    yt-dlp # 替代 youtube-dl 的视频下载器
    rclone # 支持多网盘的同步工具
    termius # 多窗口 SSH 客户端
    #pot
    electron
    openjdk
    kotlin
    ktfmt
    rogcat
    genymotion
    remmina # RDP 客户端
    mosh # 使用 UDP 协议的 SSH 替代品
    #obsidian # Markdown 编辑器
    mailspring # 邮件客户端
    ffmpeg-full # 音视频工具集
    #av1an # 命令行 AV1 视频/图像转换工具
    svt-av1 # SVT AV1 编码器
    libaom # AOM 的 AV1 编码器
    rav1e # Xiph 的 AV1 编码器
    imagemagick # 全能的图片转换工具
    magic-wormhole # 使用令牌传输文件
    warp # 窗口化 magic-wormhole 文件传输
    syncthing # 私有文件同步工具
    upscayl # 图片 AI 放大
    lux # Go 实现的命令行下载器
    q # 命令行 DNS 客户端
    # 独立的命令行工具
    autojump # 快捷跳转目录
    htop # 查看进程信息
    iperf3 # 网速测试
    wrk # HTTP 服务基准测试
    httpie # 命令行 HTTP 客户端
    sysbench # CPU 基础测试
    pciutils # PCI 实用程序
    gping # 带有图表的 ping
    liquidctl # 查看水冷温度
    #xorg.xdpyinfo # 显示 X 服务器信息
    vulkan-tools # 显示 Vulkan 信息
    speedtest-cli # 网速测试
    radeontop # 查看 AMD GPU 占用
    fastfetch # C 实现的类 neofetch
    payload-dumper-go # 解压 Android ROM
    tree # 以树状显示目录的结构
    aria2 # 下载工具
    wget # 网络文件检索
    dua # 查看文件占用
    gdu # 交互式查看文件占用
    yazi # 命令行文件管理器
    bandwhich # 查看网络使用情况
    dysk # 查看文件系统信息
    procs # ps 的替代品
    bottom # btm 命令，htop 的替代品
    lsd # ls 的替代品
    xh # curl 的替代品
    git-interactive-rebase-tool # 交互式 git rebase
    figlet # 将文字转换为 ASCII Art
    chafa # 终端图片查看器
    # 编程语言工具链
    clang # Clang
    android-tools # Android 平台工具集
    rustup # Rustup
    nodejs # Node.js
    bun # Bun
    #quickjs # QuicjJS
    #luajit # LuaJIT
    micropython
    typescript # Typescript 编译器
    dotnet-sdk # .NET Core
    lua5_5_compat # Lua
    luau # Luau
    #ruby_4_0 # Ruby 4.0
    lua-language-server # Lua 语言服务器
    #flutter # 跨平台 UI 框架
    # 开发环境工具
    vscode # VS Code
    #android-studio # Android Studio
    #claude-code # Claude Code
    #opencode # OpenCode
    just # 命令运行器（在一般任务场景中替代 make）
    cloc # 统计代码行数
    tokei # 统计代码行数（现代化）
    insomnia # 图形化 HTTP 客户端
    jq # 命令行解析 JSON
    htmlq # 命令行解析 HTML
    bat # 支持高亮显示的 cat 克隆
    inotify-tools # 提供 inotify 接口
    #imhex # Hex 编辑器
    mise # 替代 asdf 的版本管理工具
    dblab # 命令行数据库客户端
    websocat # WebSocket 客户端
    proxypin # 抓包工具
    #helix # 替代 Vim 的终端编辑器
    # 一些无聊的小程序
    cowsay # 打印一只牛替你表达
    #oneko # 创造一只猫跟随你的鼠标
    #hollywood # 假装你很忙
    # 其它工具
    #screenkey # 在屏幕上显示按键
    gpick # 取色器
    anki-bin # Anki 桌面版
    bitwarden-desktop # 密码管理器
    firefox # Firefox 浏览器
    f2fs-tools # mkfs.f2fs 命令
    tor-browser # Tor 浏览器
    #freecad # 开源 CAD（被 Flatpak 包取代）
    openscad # 基于代码建模的开源 CAD
    fstl # 3D 模型查看器
    #cura # Cura 切片软件
    #meshlab # 3D 模型文件编辑
    #google-cloud-sdk-gce # GCP 命令行客户端
    #azure-cli # Azure 命令行客户端
    #awscli2 # AWS 命令行客户端
    #inkscape # 矢量图形编辑器
    #blender # 3D 创作工具
    mumble # 语音软件
    #stellarium # 天象模拟
    libreoffice # 开源的 Office 替代品
    (wxGTK32.override { withWebKit = true; })
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
  home.stateVersion = "23.11";
}
