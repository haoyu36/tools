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

