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
$env.config.buffer_editor = "vi"            # 使用 vi 编辑配置
$env.config.show_banner = "short"           # 仅显示 banner 的启动时间
$env.config.history.file_format = "sqlite"  # 使用 SQLite 存储历史
$env.config.history.isolation = true        # 会话之间隔离历史
$env.PROMPT_COMMAND_RIGHT = {||
    date now | format date "%H:%M:%S"
}                                           # 修改右侧提示符的时间格式（仅显示时分秒）

# ---- ENV ----
$env.GOPATH = $"($env.HOME)/.local/share/go"
$env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"
# ---- ENV ----

# ---- PATH ----
use std/util "path add"             # 导入 PATH 添加工具
#path add $"($env.GOPATH)/bin"      # 追加 Go 的 bin（被 mise 覆盖）
path add $"($env.PNPM_HOME)/bin"    # 追加 pnpm 的 bin
# ---- PATH ----

# ---- COMPLETION ----
use my-modules/doer-completions.nu *
use nu_scripts/custom-completions/cargo/cargo-completions.nu *
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
# ---- COMPLETION ----
