# ---- METADATA ----
# Target: /etc/nixos/configuration.nix
# Author: Hentioe (绅士喵)
# CreatedAt: 2020-12-15
# UpdatedAt: 2024-05-11
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

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  # 修改 systemd 的终止超时时间。
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.enableIPv6 = false;

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
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-rime
    ];
  };

  # Configure keymap/X11/Wayland
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.videoDrivers = [ "amdgpu" ];
  # 避免 NVIDIA GPU 画面撕裂（无需在应用层开启垂直同步）。
  # TODO: 构建以后将此配置输出为独立的 .conf 文件（如果可能）。
  # services.xserver.screenSection = ''
  #   Option "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
  # '';
  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat"; # 禁用鼠标加速
  };
  # 设置 DPI 值 (仅适用 X.org，4k 分辨率)，在 KDE Plasma 6 下不生效（被 KDE 设置覆盖）。
  services.xserver.dpi = 144; # 96 * 1.5
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings = {
      General = {
        DisplayServer = "x11";
        # 设置缩放和字体 DPI（对 x11 和 wayland 都起作用）
        GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=1.5,QT_FONT_DPI=144";
      };
      X11 = {
        # 设置 X11 下的 DPI 值，在 KDE Plasma 6 疑似已不起作用。
        #ServerArguments = "-nolisten tcp -dpi 144";
      };
    };
  };
  services.desktopManager.plasma6.enable = true;

  # XRDP server
  # services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "startplasma-x11";
  # networking.firewall.allowedTCPPorts = [ 3389 ];

  # 启用 GNOME 密钥环。
  services.gnome.gnome-keyring.enable = true;
  # 登录以后自动解锁 GNOME 密钥环。
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  # 登录后自动解锁 KDE 钱包。
  security.pam.services.sddm.enableKwallet = true;

  # Gconf service (GNOME 2 era)
  # services.dbus.packages = with pkgs; [ gnome2.GConf ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable Flatpak.
  services.flatpak.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # 启用 OpenGL 对 32 位程序的支持。
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ amdvlk ];
  hardware.opengl.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # 虚拟化配置。
  virtualisation = {
    # 启用虚拟化服务，Docker、LXD 和 libvirtd。
    libvirtd.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        experimental = true;
      };
    };
    lxd.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hentioe = {
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "wheel"
      "libvirtd"
      "docker"
      "dialout"
      "lxd"
      "wireshark"
    ];
  };

  # 启用 Zsh。
  programs.zsh.enable = true;
  # 为用户配置默认 Shell。
  users.extraUsers.hentioe = {
    shell = pkgs.zsh;
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  # 启用 dconf（Peek 需求）。
  programs.dconf.enable = true;

  # Steam 配置。
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # 注意：此处仅添加系统的基础包，额外软件通过 home-manager 管理。
  environment.systemPackages = with pkgs; [
    home-manager # 用户环境 Nix 包管理器
    direnv # 自动加载/卸载 Shell 环境
    bash-completion # Bash 补全合集
    wezterm # GPU 加速的跨平台终端
    parted # 分区工具
    bind # DNS 工具集
    lshw # 查看硬件
    usbutils # USB 工具集
    git # Git
    nixfmt-rfc-style # Nix 代码格式化工具
    helix # 替代 Vim 的终端编辑器
    gnupg # PGP 签名和加密
    latte-dock # 独立的 Dock 栏
    kdePackages.qtstyleplugin-kvantum # Kvantum 主题引擎
    kdePackages.kate # KDE 的文本编辑器
    kdePackages.kde-gtk-config # KDE 的 GTK 设置
    kdePackages.kcolorpicker # KDE 的颜色选择器
    #xsettingsd # X 设置的守护进程（KDE Plasma 6 疑似已不需要）
    zsh # Zsh
    file # 查看文件信息
    smartmontools # 查看硬盘的 SMART 统计
  ];

  # 排除的 Kde Plasma 6 包。
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole # 被 wezterm 替代
  ];

  environment.sessionVariables = {
    # 配置 Steam 缩放
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
  };

  # 配置字体。
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Noto 系列字体
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      # 文泉驿字体（备用）
      wqy_zenhei
    ];

    fontDir.enable = true;
    fontconfig = {
      # 配置默认字体。
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK SC" ];
        monospace = [ "Noto Sans Mono CJK SC" ];
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
  # adb/fastboot 无需 sudo。
  services.udev.packages = [ pkgs.android-udev-rules ];

  networking.firewall.enable = false;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;
  #networking.nftables.enable = false;
  # 将 LXD 桥接接口加入信任列表，避免 LXC 容器和虚拟机获取不到 IPv4 地址。
  networking.firewall.trustedInterfaces = [ "lxdbr0" ];

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
