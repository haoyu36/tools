
# 一：概述

## 安装

系统默认的是 bash，zsh 是一款很强大的终端软件，兼容 bash

```shell
cat /etc/shells     # 查看系统的所有Shell
echo $SHELL         # 当前使用的shell
sudo apt-get install zsh
chsh -s /bin/zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sudo apt-get install -y tmux
```

# 二：使用

## 2.1 使用别名

有时候某个命令很长，即使 tab 补全也麻烦，可以使用别名很容易打出来，在 `.zshrc` 文件中可设置别名

```shell
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias -s py='vim'
alias -s md='vim'
alias md='mkdir -p'
alias rd='rmdir'
alias rm='rm -i'
alias h='history'
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias cls='clear'
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
```

## 2.2 历史命令

```python
h/history   # 查看历史命令
!历史数字    # 加载指定历史命令
```

# 三：oh-my-zsh

oh-my-zsh 是一个开源的框架，用于管理 Zsh 配置及插件，安装及使用教程见[官网](https://ohmyz.sh/)



# 四：参考资料

- [终极shell](http://macshuo.com/?p=676)
- [zsh全程指南](https://wdxtub.com/2016/02/18/oh-my-zsh/)
- [A User's Guide to the Z-Shell](http://zsh.sourceforge.net/Guide/zshguide.html)
- [Master Your Z Shell with These Outrageously Useful Tips](http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/)
- [manpagez: man pages & more](http://www.manpagez.com/man/1/zshmisc/)


- [Linux终极shell-Z Shell--用强大的zsh & oh-my-zsh把Bash换掉](https://blog.csdn.net/gatieme/article/details/52741221)
