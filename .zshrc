# --- 基础选项 ---
# 设置历史记录
HISTSIZE=5000                # 内存中保留的历史命令数
SAVEHIST=5000                # 保存到文件的历史命令数
HISTFILE=~/.zsh_history      # 历史文件路径
setopt APPEND_HISTORY        # 允许多个终端会话都追加到同一个历史文件
setopt SHARE_HISTORY         # 实时共享历史记录
setopt HIST_IGNORE_DUPS      # 忽略连续的重复命令
setopt HIST_IGNORE_SPACE     # 忽略以空格开头的命令（不会记录到历史）

# --- 启用强大的补全系统（zsh 自带）---
autoload -Uz compinit
compinit

# 让补全菜单更友好：按 Tab 时直接显示所有选项
setopt AUTO_MENU

# 大小写不敏感匹配（对文件名补全很有用）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 补全时用不同颜色区分文件类型（需终端支持颜色）
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# --- 加载 arch 官方仓库中的 zsh-completions ---
# 正常情况下 zsh-completions 会自动被加载，保险起见手动添加路径
if [[ -d /usr/share/zsh/site-functions ]]; then
    fpath=(/usr/share/zsh/site-functions $fpath)
fi

# 重新编译补全缓存（如果首次使用或补全文件有更新）
autoload -Uz compinit && compinit

# --- 改善命令行体验 ---
# 允许用方向键在已输入的命令中移动
bindkey -e

# 按 Ctrl+R 搜索历史时，用更友好的界面
bindkey '^R' history-incremental-search-backward

# 修正拼写错误时的补全建议（可选，按需开启）
setopt CORRECT
# 只对命令名进行修正，不修正文件名（减少干扰）
setopt CORRECT_ALL

# --- 提示符美化（极简风格）---
# 显示格式：[用户@主机 当前目录]$
# 普通用户显示 $，root 用户显示 #
autoload -Uz colors && colors
PROMPT="%{$fg[green]%}%n@%m%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%} %# "

# --- 别名（可选）---
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'

# --- Vi 模式 (等价于 set -o vi) ---
bindkey -v                    # 启用 Vi 模式

# 映射 "jj" 和 "JJ" 从插入模式退出到命令模式
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'JJ' vi-cmd-mode

# - 插入模式：绿色 [插入] + 竖线光标
# - 命令模式：红色 [命令] + 方块光标

# 定义模式显示更新函数
function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
        # 命令模式：红色提示 + 方块光标
        echo -ne '\e[2 q'
        PROMPT="%{$fg[red]%}[命令]%{$reset_color%} [%n@%m %1~]%# "
    else
        # 插入模式：绿色提示 + 竖线光标
        echo -ne '\e[6 q'
        PROMPT="%{$fg[green]%}[插入]%{$reset_color%} [%n@%m %1~]%# "
    fi
    zle reset-prompt
}

# 确保每次命令行初始化时也刷新一次
function zle-line-init {
    zle-keymap-select
}

# 注册钩子函数
zle -N zle-keymap-select
zle -N zle-line-init

# 加载颜色支持
autoload -Uz colors && colors

# 默认先设置为插入模式的提示符（防止初次启动无显示）
PROMPT="%{$fg[green]%}[插入]%{$reset_color%} [%n@%m %1~]%# "

