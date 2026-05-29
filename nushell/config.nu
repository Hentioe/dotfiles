# ---- METADATA ----
# Target: ~/.config/nushell/config.nu
# Author: Hentioe (绅士喵)
# CreatedAt: 2026-05-29
# UpdatedAt: 2026-05-30
# ---- METADATA ----

# config.nu
# See https://www.nushell.sh/book/configuration.html
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
$env.config = ($env.config | merge deep {
    buffer_editor: vi               # 使用 vi 编辑配置
    show_banner: short              # 仅显示 banner 的启动时间
    cursor_shape: {
        emacs: blink_line           # Emacs 模式的光标
    }
    history: {
        file_format: sqlite         # 使用 SQLite 存储历史
        isolation: true             # 会话之间隔离历史
    }
})

def get-right-prompt [] {
    date now | format date "%H:%M:%S"
}

# ---- ENV ----
$env.EDITOR = "vi"
# $env.PROMPT_COMMAND_RIGHT = { get-right-prompt }  # 设置右侧提示符时间（被 oh-my-posh 覆盖）
$env.GOPATH = $"($env.HOME)/.local/share/go"        # 设置 Go 的 GOPATH
$env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"   # 设置 pnpm 的 HOME
# ---- ENV ----

# ---- PATH ----
use std/util "path add"             # 导入 PATH 添加工具
# path add $"($env.GOPATH)/bin"     # 追加 Go 的 bin（被 mise 覆盖）
path add $"($env.PNPM_HOME)/bin"    # 追加 pnpm 的 bin
# ---- PATH ----

# ---- ALIASES ----
use my-scripts/nixos-aliases.nu *
# ---- ALIASES ----

# ---- COMPLETIONS ----
use my-scripts/cargo-completions.nu *
use my-scripts/doer-completions.nu *
use my-scripts/home-manager-completions.nu *
use my-scripts/nixos-rebuild-completions.nu *
use nu_scripts/custom-completions/curl/curl-completions.nu *
use nu_scripts/custom-completions/docker/docker-completions.nu *
use nu_scripts/custom-completions/git/git-completions.nu *
use nu_scripts/custom-completions/just/just-completions.nu *
use nu_scripts/custom-completions/nix/nix-completions.nu *
use nu_scripts/custom-completions/pnpm/pnpm-completions.nu *
use nu_scripts/custom-completions/rustup/rustup-completions.nu *
use nu_scripts/custom-completions/tar/tar-completions.nu *
use nu_scripts/custom-completions/vscode/vscode-completions.nu *
use nu_scripts/custom-completions/zig/zig-completions.nu *
# ---- COMPLETIONS ----

# ---- INTEGRATION ----
source ~/.zoxide.nu
# ---- INTEGRATION ----

def reinit-plugins [] {
  plugin add (nix-build <nixpkgs> -A nushellPlugins.query --no-out-link)/bin/nu_plugin_query
}

# ---- PERIODICS ----
use my-scripts/utils.nu run-periodic

run-periodic 2wk "update_nu_scripts" "是否更新 Nushell 脚本？" {
    cd ~/.config/nushell/nu_scripts; git pull;
}
run-periodic 4wk "reinit_plugins" "是否重新初始化 Nushell 插件？" {
    reinit-plugins; print "插件已重新初始化。"
}
# ---- PERIODICS ----
