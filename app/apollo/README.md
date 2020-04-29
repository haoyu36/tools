



> Apollo 作为分布式配置中心，能管理不同环境、不同集群的配置，具有实时推送、权限控制、流程治理、回滚等等功能


# 一：概览



# 架构






# 部署

apollo 的部署分为两种方式，单容器部署和分布式部署。本地开发环境一般采用单容器部署，k8s 集群中采用分布式部署

以下所有配置文件都可以在我的仓库里找到 [haoyu36/tools](https://github.com/haoyu36/tools.git)

## 单容器部署

单容器部署采用第三方打包的镜像，一个 All in one 版本，即 [idoop/docker-apollo](https://hub.docker.com/r/idoop/docker-apollo)

### 部署文件

部署相关文件如下：

```bash
.
├── data                              # 将 apollo 与数据库分开部署的
│   ├── docker-compose.yaml           # mysql 的 docker-compose 文件
│   └── init                          # 初始化数据库
│       ├── apolloconfigdbdev.sql
│       ├── apolloconfigdbfat.sql
│       ├── apolloconfigdbpro.sql
│       ├── apolloconfigdbuat.sql
│       └── apolloportaldb.sql
└── docker-compose.yaml               # apollo 的 docker-compose 文件
```

### 配置修改

在 [这里](https://github.com/ctripcorp/apollo/tree/master/scripts/sql) 找到 ApolloPortalDB 和ApolloConfigDB 的 sql 文件

如需要部署多个环境 (dev、fat、uat、pro ) 需修改 sql 文件

- `apolloconfigdb.sql`  复制 4 份，并分别加环境后缀，如 `apolloconfigdbdev.sql`
- 修改每个 sql 文件里的数据库名称，如 `ApolloConfigDB` 改为 `ApolloConfigDBDev`
- 修改每个 sql 文件 `ServerConfig` 表的 `eureka.service.url`，dev、fat、uat、pro 分别为 8080、8081、8082、8083
- `apolloportaldb.sql` 修改 `ServerConfig` 表的 `envs` 项，如 `dev,fat,uat,pro`，`organizations` 改为自己的部门列表


## K8s 部署

### 构建镜像

分布式部署共需 4 个镜像，需要自己打包，打包过程见 [官方文档](https://github.com/ctripcorp/apollo/tree/master/scripts/apollo-on-kubernetes)，注意应保持版本号一致

分布式部署也同时支持 4 种环境，不过环境的命名相较与本地有一些不同。本地部署环境为 dev、fat、uat、pro，分布式部署环境为 dev、alpha（fat）、beta（uat）、pro。不同环境的命名规则建议保留，因为分布式部署的 yaml 文件里多处使用了 alpha，beta 的命名，而且数据库命名也有所不同


### 部署文件

接下来以部署 beta 环境为例

```bash
.
├── sql                                # 数据库 sql 
│   ├── ApolloPortalDB.sql
│   └── TestBetaApolloConfigDB.sql
└── apollo_yaml
    ├── apollo-env-test-beta           # beta 部署 yaml
    │   ├── service-apollo-admin-server-test-beta.yaml
    │   ├── service-apollo-config-server-test-beta.yaml
    │   └── service-mysql-for-apollo-test-beta-env.yaml
    ├── apollo_ingress.yaml            # k8s 部署 ingress 规则
    ├── kubectl-apply.sh               # 一键部署
    ├── kubectl-delete.sh              # 一键删除
    └── service-apollo-portal-server.yaml      # apollo ui 部署 yaml
```

### 配置修改


注意部署时需要在官方提供的 yaml 文件上进行一些修改

1. 所有镜像地址改为自己镜像对应的仓库地址
2. 注释掉所有 nodePort
3. admin、config、portal 填写 apollo 数据库账户密码
4. service-mysql、portal 中填写 apollo 数据库的 ip，只能是 ip 地址
5. portal 注释掉 dev、alpha、pro 相关内容




# 最佳实践


安全性






# 参考资料

- [Docker部署Apollo配置中心](https://juejin.im/post/5c261387e51d4558bf3974e1)