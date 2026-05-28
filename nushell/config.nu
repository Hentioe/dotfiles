# ---- METADATA ----
# Target: ~/.config/nushell/config.nu
# Author: Hentioe (绅士喵)
# CreatedAt: 2026-05-29
# UpdatedAt: 2026-05-29
# ---- METADATA ----

# config.nu
# See https://www.nushell.sh/book/configuration.html
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config.buffer_editor = "vi"    # 使用 vi 编辑配置

# ---- ENV ----
$env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"
# ---- ENV ----

# ---- PATH ----
use std/util "path add"             # 导入 PATH 添加工具
path add $"($env.PNPM_HOME)/bin"    # 追加 PNPM 的 bin
# ---- PATH ----
