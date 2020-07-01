# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH="/Users/zhaohaoyu/.oh-my-zsh"
export ZSH="${HOME}/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# 是否区分大小写   
# CASE_SENSITIVE="true"

# sensitive completion must be off. _ and - will be interchangeable.
# 对连字符是否敏感 - 与 —
HYPHEN_INSENSITIVE="true"

# 命令自动更正
ENABLE_CORRECTION="true"

# 等待完成时显示红点 
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="mm/dd/yyyy"

# 插件
plugins=(
  git
  bundler
  history
  last-working-dir
  zsh_reload
)

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8
export EDITOR='vim'

