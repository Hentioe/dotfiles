# dotfiles

我的配置文件仓库，主要用于 Linux 系统。也有部分跨平台软件的配置。

> [!NOTE]
> 注意：由于 NixOS 是我的主力系统，所以很多配置可能没有单独的文件。

## 列表（按最近更新顺序）

- Home Manager
  - [`~/.config/home-manager/home.nix`](https://github.com/Hentioe/dotfiles/blob/master/home-manager/home.nix)
- NixOS
  - [`/etc/nixos/configuration.nix`](./nixos/configuration.nix)
- Trippy
  - [`~/.config/trippy/trippy.toml`](./trippy/trippy.toml)
- Vim（[教程](https://blog.hentioe.dev/posts/vim-basic-configuration.html)）
  - [`/etc/vimrc`](./vim/vimrc)
  - [`~/.vim/after/indent/yaml.vim`](./vim/indent/yaml.vim)
- Kanata（[教程](https://blog.hentioe.dev/posts/advanced-keymapping-kanata-tutorial.html)）
  - [`/etc/kanata/61.kbd`](kanata/61.kbd)
- Visual Studio Code
  - [`~/.config/Code/User/settings.json`](https://github.com/Hentioe/dotfiles/blob/master/vscode/settings.json)
- keyd（[教程](https://blog.hentioe.dev/posts/advanced-keymapping-keyd-tutorial.html)）
  - [`/etc/keyd/61.conf`](keyd/61.conf)
- Plasma Workspace
  - [`~/.config/plasma-workspace/env/path.sh`](https://github.com/Hentioe/dotfiles/blob/master/plasma-workspace/env/path.sh)
  - [`~/.config/plasma-workspace/env/kwin-vars.sh`](https://github.com/Hentioe/dotfiles/blob/master/plasma-workspace/env/kwin-vars.sh)
- mpv（[教程](https://blog.hentioe.dev/posts/getting-to-know-mpv.html)）
  - [`~/.config/mpv/mpv.conf`](https://github.com/Hentioe/dotfiles/blob/master/mpv/mpv.conf)
  - [`~/.config/mpv/input.conf`](https://github.com/Hentioe/dotfiles/blob/master/mpv/input.conf)
  - [`~/.config/mpv/script-opts/uosc.conf`](https://github.com/Hentioe/dotfiles/blob/master/mpv/script-opts/uosc.conf)
- OpenWrt（[教程](https://blog.hentioe.dev/posts/openwrt-getting-started-build-your-own-firmware-from-source.html)）
  - [Xiaomi Redmi AX6000](https://github.com/Hentioe/dotfiles/blob/master/openwrt/ax6000/)
  - [NanoPi R5S/OA](https://github.com/Hentioe/dotfiles/blob/master/openwrt/r5s-oa/)
  - [NanoPi R5S/Official](https://github.com/Hentioe/dotfiles/blob/master/openwrt/r5s-official/)
- Zsh
  - [`~/.zshrc`](https://github.com/Hentioe/dotfiles/blob/master/zsh/.zshrc)
- WezTerm
  - [`~/.config/wezterm`](https://github.com/Hentioe/wezterm-config)
- Neovide
  - [`~/.config/neovide/config.toml`](https://github.com/Hentioe/dotfiles/blob/master/neovide/config.toml)
- Neovim
  - [`~/.nvim.lua`](https://github.com/Hentioe/dotfiles/blob/master/neovim/.nvim.lua)
  - [`~/.config/nvim/init.vim`](https://github.com/Hentioe/dotfiles/blob/master/neovim/deprecated/init.vim)
  - [`/usr/share/nvim/sysinit.vim`](https://github.com/Hentioe/dotfiles/blob/master/neovim/deprecated/sysinit.vim)
- Fcitx5
  - [`~/.config/fcitx5/conf/classicui.conf`](https://github.com/Hentioe/dotfiles/blob/master/fcitx5/classicui.conf)
- ~~Alacritty（已弃用）~~
  - [`~/.config/alacritty/alacritty.yml`](https://github.com/Hentioe/dotfiles/blob/master/alacritty/alacritty.yml)
- Aria2
  - [`~/.aria2/aria2.conf`](https://github.com/Hentioe/dotfiles/blob/master/aria2/aria2.conf)
- ~~Helix（已弃用）~~
  - [`~/.config/helix/config.toml`](https://github.com/Hentioe/dotfiles/blob/master/helix/config.toml)
- ~~Kitty（已弃用）~~
  - [`~/.config/kitty/kitty.conf`](https://github.com/Hentioe/dotfiles/blob/master/kitty/kitty.conf)
- ~~Redshift（已弃用）~~
  - [`~/.config/redshift.conf`](https://github.com/Hentioe/dotfiles/blob/master/redshift/redshift.conf)
  - [`~/.config/systemd/user/default.target.wants/redshift.service`](https://github.com/Hentioe/dotfiles/blob/master/redshift/redshift.service)
- Rime
  - [`~/.config/fcitx/rime/default.custom.yaml`](https://github.com/Hentioe/dotfiles/blob/master/rime/default.custom.yaml)
  - [`~/.config/fcitx/rime/luna_pinyin_simp.custom.yaml`](https://github.com/Hentioe/dotfiles/blob/master/rime/luna_pinyin_simp.custom.yaml)
- ~~Tilix（已弃用）~~
  - [`dconf load /com/gexperts/Tilix/ < tilix/tilix.dconf`](https://github.com/Hentioe/dotfiles/blob/master/tilix/tilix.dconf)
- ~~Latte Dock（已弃用）~~
  - [`~/.config/lattedockrc`](https://github.com/Hentioe/dotfiles/blob/master/latte-dock/lattedockrc)
  - [`~/.config/latte/我的布局.layout.latte`](https://github.com/Hentioe/dotfiles/blob/master/latte-dock/我的布局.layout.latte)
- ~~X11（已弃用）~~
  - [`/etc/X11/xorg.conf.d/20-intel.conf`](https://github.com/Hentioe/dotfiles/blob/master/X11/20-intel.conf)
  - [`/etc/X11/xorg.conf.d/20-nvidia.conf`](https://github.com/Hentioe/dotfiles/blob/master/X11/20-nvidia.conf)

## 疑问

希望这些配置能给你带来参考。如果有任何问题，可打开 issue 交流。我的[博客](https://blog.hentioe.dev/)有很多教程，也可以去那里看看。
