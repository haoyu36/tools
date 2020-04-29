# 一：Git

版本控制是一种记录一个或若干文件内容变化，以便将来查阅特定版本修订情况的系统

每一次的克隆操作，都是一次对代码仓库的完整备份


- 版本库 (Repository) 是 Git 用来保存项目的元数据和对象数据库的地方
- 工作区 (working diretory) 是对项目的某个版本独立提取出来的内容
- 暂存区 (Stage) 是一个文件，保存了下次将提交的文件列表信息


# 二：配置

```shell
git --version                                         # 查看版本
git config --list                                     # 查看所有配置
git config --global user.name "Your Name"             # 配置用户名
git config --global user.email "email@example.com"    # 配置邮箱地址
git config --global alias.st status                   # 设置别名
git config --global color.ui true                     # 开启颜色显示
git config --global core.pager "less -R"              # 分页显示
git config --global help.autocorrect 1                # 纠错
```

在 linux 或 mac 下中可以使用 oh-my-zsh 的 git 插件设置别名。详细别名见[官网](https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh)

```shell
alias g='git'
gaa='git add --all'
gcmsg='git commit -m'
gst='git status'
alias gl='git pull'
alias gp='git push'

glg='git log --stat'
glgga='git log --graph --decorate --all'
gloga='git log --oneline --decorate --graph --all'
glola
```

# 三：基本命令

```shell
git init                      # 初始化Git仓库
git add <file>                # 把文件提交到暂存区
git commit -m <message>       # 把暂存区的内容提交到当前分支
git status                    # 查看工作区的状态用命令
git diff                      # 查看修改内容，当前区域与暂存的差异
git push origin master        # 推送到远程
git pull origin master        # 从远程获取最新版本并merge到本地
git remote add origin ...git  # 关联到远程库
git clone ...git              # 从远程仓库克隆
```

# 四：版本回退

HEAD指向的是当前版本，上一个版本是HEAD^，上上个版本HEAD^g^，上一百个版本HEAD\~100

```shell
git log                    # 查看提交历史
git log --pretty=oneline   # 简洁的查看
git reflog                 # 查看命令历史
reset HEAD <file>          # 取消暂存
git reset --hard HEAD^
git reset --hard 1094a     # 散列值号
```


# 五：git分支

```shell
git branch               # 查看分支
git branch <name>        # 创建分支
git checkout <name>      # 切换分支
git checkout -b <name>   # 创建+切换分支
git merge <name>         # 合并某分支到当前分支
git branch -d <name>     # 删除分支
git fetch origin         # 远程抓取本地没有的数据，并更新本地数据库
git rebase
```

# 六：参考资料


- [廖雪峰教程](https://www.liaoxuefeng.com/)
- [git资料库资料汇总](https://github.com/xirong/my-git)
- [在线练习](https://learngitbranching.js.org/)