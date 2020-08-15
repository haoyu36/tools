### K8s 安装

K8s 中部署共需 4 个镜像，需要自己打包，打包过程见[官方文档](https://github.com/ctripcorp/apollo/tree/master/scripts/apollo-on-kubernetes)，注意应保持版本号一致

k8s 中部署也同时支持 4 种环境，不过环境的命名相较与本地有一些不同。本地部署环境为 dev、fat、uat、pro，k8s 中环境为 dev、alpha、beta、pro。不同环境的命名规则建议保留，因为 k8s 中部署的 yaml 文件里多处使用了 alpha，beta 的命名，而且数据库命名也有所不同

```shell
#!/bin/bash

# 从 github 拉特别慢，可以导入码云后从码云拉
# git clone https://github.com/ctripcorp/apollo.git
cp -r apollo/scripts/apollo-on-kubernetes .
cd apollo-on-kubernetes/

# 这个也可能很慢。。。
ReleaseVersion="1.6.1"
wget https://github.com/ctripcorp/apollo/releases/download/v${ReleaseVersion}/apollo-adminservice-${ReleaseVersion}-github.zip
wget https://github.com/ctripcorp/apollo/releases/download/v${ReleaseVersion}/apollo-configservice-${ReleaseVersion}-github.zip
wget https://github.com/ctripcorp/apollo/releases/download/v${ReleaseVersion}/apollo-portal-${ReleaseVersion}-github.zip


# 准备构建文件
unzip apollo-adminservice-${ReleaseVersion}-github.zip -d temp
cp temp/apollo-adminservice-${ReleaseVersion}.jar apollo-admin-server/apollo-adminservice.jar
rm -rf temp

unzip apollo-configservice-${ReleaseVersion}-github.zip -d temp
cp temp/apollo-configservice-${ReleaseVersion}.jar apollo-config-server/apollo-configservice.jar
rm -rf temp

unzip apollo-portal-${ReleaseVersion}-github.zip -d temp
cp temp/apollo-portal-${ReleaseVersion}.jar apollo-portal-server/apollo-portal.jar
rm -rf temp


# 构建并推送镜像
ImageRepo="registry.cn-shenzhen.aliyuncs.com/haoyu36"

cd apollo-admin-server
docker build -t ${ImageRepo}/apollo-admin-server:v${ReleaseVersion} .

cd ../apollo-config-server/
docker build -t ${ImageRepo}/apollo-config-server:v${ReleaseVersion} .

cd ../apollo-portal-server
docker build -t ${ImageRepo}/apollo-portal-server:v${ReleaseVersion} .

docker push ${ImageRepo}/apollo-admin-server:v${ReleaseVersion}
docker push ${ImageRepo}/apollo-config-server:v${ReleaseVersion}
docker push ${ImageRepo}/apollo-portal-server:v${ReleaseVersion}
```

接下来以部署 beta 环境为例

```shell
.
├── apollo-env-test-beta                  # beta 部署 yaml
│   ├── service-apollo-admin-server-test-beta.yaml
│   ├── service-apollo-config-server-test-beta.yaml
│   └── service-mysql-for-apollo-test-beta-env.yaml
├── kubectl-apply.sh                      # 一键部署
├── kubectl-delete.sh                     # 一键删除
└── service-apollo-portal-server.yaml     # apollo ui 部署 yaml
```

注意部署时需要在官方提供的 yaml 文件上进行一些修改

- 所有镜像地址改为自己镜像对应的仓库地址
- 注释掉所有 nodePort
- admin、config、portal 填写 apollo 数据库账户密码
- service-mysql、portal 中填写 apollo 数据库的 ip，只能是 ip 地址
- portal 注释掉 dev、alpha、pro 相关内容
