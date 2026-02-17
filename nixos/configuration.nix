# ---- METADATA ----
# Target: /etc/nixos/configuration.nix
# Author: Hentioe (绅士喵)
# CreatedAt: 2020-12-15
# UpdatedAt: 2026-02-17
# ---- METADATA ----

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings = {
    experimental-features = [];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "bcachefs" ];
  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 10;
  # Use the GRUB boot loader.
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    gfxmodeEfi = "1024x768";
  };
  # 修改 systemd 的终止任务的超时时间
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };
  systemd.user.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.enableIPv6 = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = true;
  # networking.interfaces.enp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-rime
    ];
  };

  # Configure keymap/X11/Wayland
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.videoDrivers = [ "amdgpu" ];
  # 避免 NVIDIA GPU 画面撕裂（无需在应用层开启垂直同步）。
  # services.xserver.screenSection = ''
  #   Option "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
  # '';
  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat"; # 禁用鼠标加速
  };
  # 设置 DPI 值 (仅适用 X.org，4k 分辨率)，在 KDE Plasma 6 下不生效（被 KDE 设置覆盖）。
  #services.xserver.dpi = 144; # 96 * 1.5
  services.displayManager.sddm = {
    enable = true;
    settings = {
      General = {
        DisplayServer = "wayland";
        # 设置缩放和字体 DPI（对 X11 和 Wayland 都起作用）
        #GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=1.5,QT_FONT_DPI=144";
        GreeterEnvironment = "KWIN_USE_OVERLAYS=1";
      };
      X11 = {
        # 设置 X11 下的 DPI 值，KDE Plasma 6 疑似已不起作用。
        #ServerArguments = "-nolisten tcp -dpi 144";
      };
    };
  };
  services.desktopManager.plasma6.enable = true;

  # XRDP server
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-wayland";
  # networking.firewall.allowedTCPPorts = [ 3389 ];

  # 启用 GNOME 密钥环
  services.gnome.gnome-keyring.enable = true;
  # 登录以后自动解锁 GNOME 密钥环
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  # 登录后自动解锁 KDE 钱包
  security.pam.services.sddm.enableKwallet = true;

  # Gconf service (GNOME 2 era)
  # services.dbus.packages = with pkgs; [ gnome2.GConf ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable Flatpak.
  services.flatpak.enable = true;
  # Enable fwupd.
  services.fwupd.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true; # # If compatibility with 32-bit applications is desired.
  hardware.graphics = {
    extraPackages = with pkgs; [ rocmPackages.clr.icd ]; # 达芬奇需要
    #extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    enable = true;
    enable32Bit = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # 虚拟化配置
  virtualisation = {
    # 启用虚拟化服务
    libvirtd.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        experimental = true;
      };
    };
    incus.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hentioe = {
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "wheel"
      "kvm"
      "libvirtd"
      "docker"
      "dialout"
      "incus-admin"
    ];
  };

  # 启用 Zsh
  programs.zsh.enable = true;
  # 为用户配置默认 Shell
  users.extraUsers.hentioe = {
    shell = pkgs.zsh;
  };
  # AppImage 支持
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  # Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    configure = {
      customRC = ''
        " 语法高亮
        syntax on
        " 显示行号
        set number
        " 显示光标所在行
        set cursorline
        " 高亮显示匹配的括号
        set showmatch
        " 自动读取外部更改
        set autoread
        " 始终显示状态栏
        set laststatus=2
        " 显示光标的当前位置
        set ruler
        " 设置缩进
        set expandtab " 使用空格代替制表符
        set tabstop=2 " 制表符宽度
        set shiftwidth=2 " 缩进宽度
        set softtabstop=2 " 退格键宽度
        " 命令行补全
        set wildmenu
        " 搜索时忽略大小写，但在有大写字母时敏感
        set ignorecase
        set smartcase
        " 高亮搜索结果
        set hlsearch
        " 增量搜索
        set incsearch
        " 允许在未保存的缓冲区间切换
        set hidden
        " 使用空格键作为 leader 键
        let mapleader=" "
        " 快速保存
        nnoremap <leader>w :w<CR>
        " 快速退出
        nnoremap <leader>q :q<CR>
        " 启用鼠标
        set mouse=a
        " 启用基于文件类型的插件和缩进
        filetype plugin indent on
        " 共享系统剪切板
        set clipboard+=unnamedplus
        " 设置主题
        color dracula
        " 自动保存
        lua require'auto-save'.setup{}
        " 记住上次编辑位置
        lua require'nvim-lastplace'.setup{}
        " 注释插件
        lua require'Comment'.setup{}
        " 加载用户的 lua 配置
        if filereadable(expand("~/.nvim.lua"))
          luafile ~/.nvim.lua
        endif
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          dracula-vim
          nvim-lastplace
          auto-save-nvim
          comment-nvim
        ];
      };
    };
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  # 启用 dconf（Peek 需要）
  programs.dconf.enable = true;

  # Steam 配置
  programs.steam = {
    package = pkgs.steam.override {
      extraEnv = {
        STEAM_FORCE_DESKTOPUI_SCALING = 1.5; # 配置缩放
      };
    };
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  programs.coolercontrol.enable = true;
  # 自动加载/卸载 Shell 环境
  programs.direnv.enable = true;
  # GPG Agent
  programs.gnupg.agent = {
    enable = true;
  };

  environment.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx"; # 使用 Wayland 前端的 Fcitx5 时，此变量可避免 Electron 应用漏字
    #QT_IM_MODULE = "fcitx";

  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # 注意：此处仅添加系统的基础包，额外软件通过 home-manager 管理。
  environment.systemPackages = with pkgs; [
    home-manager # 用户环境 Nix 包管理器
    patchelf # 修补 ELF 的工具
    bash-completion # Bash 补全合集
    wezterm # GPU 加速的跨平台终端
    parted # 分区工具
    bind # DNS 工具集
    lshw # 查看硬件
    usbutils # USB 工具集
    nvme-cli # NVMe 用户空间工具
    git # Git
    nixfmt # Nix 代码格式化
    nix-tree # 依赖树查看
    gnupg # PGP 签名和加密
    desktop-file-utils # 桌面条目相关的工具
    file # 查看文件信息
    smartmontools # 查看硬盘的 SMART 统计
    neovide # Neovim 编辑器的 GUI
    xclip # 命令行操作剪切板（Neovim 需要）
    killall # 按名称杀进程
    libva-utils # vainfo 命令，验证 VA-API 设置
    zip # Zig 压缩
    #xsettingsd # X 设置的守护进程（KDE Plasma 6 疑似已不需要）
    kdePackages.qtstyleplugin-kvantum # Kvantum 主题引擎
    kdePackages.kde-gtk-config # KDE 的 GTK 设置
    kdePackages.kcolorpicker # KDE 的颜色选择器
    kdePackages.qtbase # 包含 update-desktop-database
    kdePackages.xdg-desktop-portal-kde
    plasma-panel-colorizer # 面板定制
    kde-rounded-corners # KDE 的圆角效果插件
    xwininfo # X11 的窗口信息工具
    #xdotool # X11 的自动化工具（移动/调整窗口大小等）
    #xdg-desktop-portal-gtk
    #glib
  ];

  # 排除的 KDE 包
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole # 被 Wezterm 替代
    kate # 被 Neovide 替代
    akonadi-contacts # 联系人管理，不需要
  ];

  # 配置字体
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      # Noto 系列作为主字体
      noto-fonts
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin
      noto-fonts-monochrome-emoji
      monaspace # 编程字体
      mononoki # Neovide 字体
    ];

    fontconfig = {
      # 配置默认字体。
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Noto Serif CJK SC"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK SC"
        ];
        monospace = [
          "Noto Sans Mono"
          "Noto Sans Mono CJK SC"
        ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # adb/fastboot 无需 sudo
  # services.udev.packages = [ pkgs.android-udev-rules ];
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  networking.firewall.enable = false;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    1420 # Tauri app development
  ];
  #networking.firewall.allowedUDPPorts = [];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.nftables.enable = true;
  # 将 LXD 桥接接口加入信任列表，避免 LXC 容器和虚拟机获取不到 IPv4 地址。
  networking.firewall.trustedInterfaces = [ "incusbr0" ];
  # Hosts
  #networking.extraHosts = '''';

  # services.octoprint.enable = true;
  # systemd.services.octoprint.path = [ pkgs.python3Packages.pip ];
  #systemd.user.services.xsettingsd = {
  #  wantedBy = [ "graphical-session.target" ];
  #  serviceConfig = {
  #    ExecStart = "${pkgs.xsettingsd}/bin/xsettingsd";
  #  };
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
