#!/bin/bash

# 智能图片预览：chafa 优先（在 lf 中最稳定）
preview_image() {
    local file="$1"
    local width="${2:-60}"

    # 优先 chafa：在所有终端都稳定，lf 无需 cleaner
    if command -v chafa &>/dev/null; then
        chafa -s "${width}x40" --animate off "$file"
        return
    fi

    # Kitty 原生协议：需要 cleaner 但效果好
    if [[ -n "$KITTY_WINDOW_ID" ]] && command -v kitty &>/dev/null; then
        kitty +kitten icat --transfer-mode=memory --stdin=no --place="${width}x40@0x0" "$file"
        return
    fi

    # viu 降级：sixel 或 block mode
    if command -v viu &>/dev/null; then
        viu -w "$width" "$file"
        return
    fi

    # 最后显示文件信息
    file "$file" | cut -d: -f2-
    echo "[提示] 安装 chafa 获得最佳预览: brew install chafa"
}

filetype=$(file --mime-type -Lb "$1")
case "$filetype" in
image/*)
    preview_image "$1" 60
    ;;
text/*)
    bat --style=plain --color=always "$1" 2>/dev/null || cat "$1"
    ;;
*)
    file "$1" | cut -d: -f2-
    ;;
esac
