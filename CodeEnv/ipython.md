> IPython 是一种基于 Python 的交互式解释器，提供了强大的编辑和交互功能

## 一：基本

在 shell 中输入表达式时，只要按下 Tab 键，当前命名空间任何与已输入的字符串相匹配的变量(对象，函数)就会被找出来

- 对象后面输入一个句号完成方法与属性的输入 `b.<Tab>`
- 应用在模块上 `datetime.<Tab>`
- 匹配本地文件路径（使用正斜杠 `'/'` ，文件夹或文件名中间不能有空格）

在变量的前面或后面加一个问号 `?` 显示该对象的一些通用信息，如果该对象是一个函数或实例方法，会显示docstring。使用 `??` 将显示该函数的源代码


## 二：快捷键

| 操作            |    解释  |
| :-------------- | :------------------- |
| Ctrl-P  |    或上箭头键 后向搜索命令历史中以当前输入的文本开头的命令|
| Ctrl-N  |   或下箭头键 前向搜索命令历史中以当前输入的文本开头的命令|
| Ctrl-R  |   按行读取的反向历史搜索（部分匹配）|
| Ctrl-Shift-v  |   从剪贴板粘贴文本|
| Ctrl-C  |   中止当前正在执行的代码|
| Ctrl-A  |   将光标移动到行首|
| Ctrl-E  |   将光标移动到行尾
| Ctrl-K  |   删除从光标开始至行尾的文本|
| Ctrl-U  |   清除当前行的所有文本译注12|
| Ctrl-F  |   将光标向前移动一个字符|
| Ctrl-b  |   将光标向后移动一个字符|
| Ctrl-L  |   清屏|


## 三：魔术命令

| 操作            |    解释  |
| :-------------- | :------------------- |
|%quickref    |   显示IPython的快速参考|
|%magic   |      显示所有魔术命令的详细文档|
|%debug   |    从最新的异常跟踪的底部进入交互式调试器|
|%hist   |      打印输入命令的历史|
|%pdb   |       在异常发生后自动进入调试器|
|%paste   |      执行剪贴板中的Python代码|
|%reset    |      删除命名空间中的全部变量/名称|
|%page OBJECT   |     通过分页器打印输出OBJECT|
|%run script.py   |   在IPython中执行一个Python脚本文件|
|%prun statement   |    通过cProfile执行statement，并打印分析器的输出结果|
|%time statement   |    报告statement的执行时间|
|%timeit statement   |   多次执行statement以计算系综平均执行时间|
|%who`、`%whos    |  显示命名空间中定义的变量|
|%logstart   | 记录输出|

## 四：与操作系统的交互

| 操作            |    解释  |
| :-------------- | :------------------- |
|%!cmd|   在系统shell中执行cmd|
|%output  = !cmd args|   执行cmd，并将stdout存放在output中|
|%alias alias_name cmd |  为系统shell命令定义别名|
|%bookmark |  使用IPython的目录书签系统|
|%cd directory|   将系统工作目录更改为directory|
|%pwd |  返回系统的当前工作目录|
|%pushd directory |  将目前目录入栈，并转向目标目录|
|%popd|   弹出栈顶目录，并转向该目录|
|%dirs|   返回一个含有当前目录栈的列表|
|%dhist|   打印目录访问历史|
|%env|   以dict形式返回系统环境变量|

## 五：扩展阅读

- [IPython Documentation](https://ipython.readthedocs.io/en/stable/#)