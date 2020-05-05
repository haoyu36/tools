


# Terraform

Terraform 是一个 IT 基础架构自动化编排工具



# 使用




# 阿里云

## Provide

使用阿里云的 Provide, 需要提供凭据，可以使用环境变量提供，但为了安全，一般是使用 RAM 角色访问


```shell
# 设置环境变量
export ALICLOUD_ACCESS_KEY=""
export ALICLOUD_SECRET_KEY=""
export ALICLOUD_REGION=""

# .tf
provider "alicloud" {}
```

使用 RAM 角色访问:

首先创建用户


请为RAM用户添加系统策略（AliyunSTSAssumeRoleAccess）或自定义策


创建角色并授权管理所有云资源


```


```


## 



执行 `terraform plan` 时报错

![1572335904](http://pic.haoyu95.cn/uploads/big/c3ab8129e422516e54b62124263af71f.png)

原因：没有更新机器时间

解决：执行命令 `ntpdate -u ntp.api.bz`


## 扩展阅读

- [Terraform 学习笔记](https://www.jianshu.com/p/e0dd50f7ee98)
- [Alibaba Cloud Provider](https://www.terraform.io/docs/providers/alicloud/index.html)
- [玩转阿里云 Terraform(二)：Terraform 的几个关键概念](https://zhuanlan.zhihu.com/p/87364600)





