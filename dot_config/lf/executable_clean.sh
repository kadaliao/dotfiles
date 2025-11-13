#!/bin/bash
# lf cleaner 脚本：清理预览窗口

# chafa 和 viu 使用字符块，不需要特殊清理
# 只需清空预览区域即可
if [[ -n "$1" ]]; then
    # $1 是预览文件路径，清空这个区域
    printf '\033[2J'  # 清屏
fi
