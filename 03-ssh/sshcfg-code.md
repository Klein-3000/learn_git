# 源代码
```bash
#!/bin/bash
# ssh-config-view: View or edit SSH config blocks (supports nvim/vim only)

set -euo pipefail

CONFIG_FILE="$HOME/.ssh/config"
EDITOR="${EDITOR:-nvim}"

show_help() {
    cat <<EOF
Usage:
  $(basename "$0") <host>                # View config block with includes (colored)
  $(basename "$0") -e <host>             # Edit main config at Host line (nvim/vim only)
  $(basename "$0") -i <include-file>     # Edit ~/.ssh/<include-file>
  $(basename "$0") -h|--help             # Show this help

Options:
  -e, --edit <host>        Open ~/.ssh/config in nvim/vim at matching Host line
  -i, --include <file>     Open ~/.ssh/<file> directly
  -h, --help               Show help

Note:
  - Editing requires 'nvim' or 'vim' as \$EDITOR (default: nvim)
  - Include files are assumed to be in ~/.ssh/
EOF
}

# 初始化
mode="view"          # "view", "edit-host", "edit-include"
target=""

# 解析参数
while [[ $# -gt 0 ]]; do
    case "$1" in
        -e|--edit)
            if [[ "$mode" != "view" ]]; then
                echo "Error: Only one mode (-e or -i) allowed." >&2
                exit 1
            fi
            mode="edit-host"
            shift
            target="$1"
            ;;
        -i|--include)
            if [[ "$mode" != "view" ]]; then
                echo "Error: Only one mode (-e or -i) allowed." >&2
                exit 1
            fi
            mode="edit-include"
            shift
            target="$1"
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -*)
            echo "Unknown option: $1" >&2
            show_help >&2
            exit 1
            ;;
        *)
            if [[ "$mode" != "view" ]] || [[ -n "$target" ]]; then
                echo "Error: Unexpected argument: $1" >&2
                exit 1
            fi
            target="$1"
            ;;
    esac
    shift
done

if [[ -z "$target" ]]; then
    echo "Error: Host or include file name required." >&2
    show_help >&2
    exit 1
fi

# ========== 模式 1: 编辑 include 文件 (-i) ==========
if [[ "$mode" == "edit-include" ]]; then
    include_path="$HOME/.ssh/$target"
    if [[ ! -f "$include_path" ]]; then
        echo "File '$include_path' does not exist." >&2
        exit 1
    fi

    # 检查编辑器是否为 nvim/vim
    if [[ "$EDITOR" != "nvim" && "$EDITOR" != "vim" ]]; then
        echo "Only nvim or vim is supported for editing." >&2
        exit 1
    fi

    exec "$EDITOR" "$include_path"
fi

# ========== 模式 2: 编辑主配置 (-e) ==========
if [[ "$mode" == "edit-host" ]]; then
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "Error: $CONFIG_FILE not found." >&2
        exit 1
    fi

    # 查找 Host 行号
    line_num=$(awk -v h="$target" '
        /^Host[[:space:]]/ {
            for (i = 2; i <= NF; i++) if ($i == h) { print NR; exit }
        }
    ' "$CONFIG_FILE")

    if [[ -z "$line_num" ]]; then
        echo "Host '$target' not found in $CONFIG_FILE." >&2
        exit 1
    fi

    # 仅允许 nvim/vim
    if [[ "$EDITOR" != "nvim" && "$EDITOR" != "vim" ]]; then
        echo "Only nvim or vim is supported for editing." >&2
        exit 1
    fi

    exec "$EDITOR" "+$line_num" "$CONFIG_FILE"
fi

# ========== 模式 3: 查看配置（默认）==========
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: $CONFIG_FILE not found." >&2
    exit 1
fi

CYAN='\033[36m'
RESET='\033[0m'

awk -v target="$target" -v home="$HOME" -v cyan="$CYAN" -v reset="$RESET" '
BEGIN {
    in_block = 0
    found = 0
    ssh_dir = home "/.ssh"
}
/^Host[[:space:]]/ {
    match_host = 0
    for (i = 2; i <= NF; i++) {
        if ($i == target) {
            match_host = 1
            break
        }
    }
    if (match_host) {
        in_block = 1
        found = 1
        print $0
    } else {
        in_block = 0
    }
    next
}
in_block && /^[[:space:]]/ {
    print $0
    if (tolower($1) == "include") {
        for (i = 2; i <= NF; i++) {
            include_file = $i
            if (include_file != "") {
                full_path = ssh_dir "/" include_file
                while ((getline line < full_path) > 0) {
                    printf "    %s# [from %s] %s%s\n", cyan, include_file, line, reset
                }
                close(full_path)
            }
        }
    }
    next
}
in_block && /^[^[:space:]]/ {
    in_block = 0
}
END {
    if (!found) {
        print "Host '" target "' not found in " ENVIRON["CONFIG_FILE"] "." > "/dev/stderr"
        exit 1
    }
}
' "$CONFIG_FILE"
```
