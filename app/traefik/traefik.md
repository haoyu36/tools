

# 概述

Traefik 作为反向代理工具，能截获服务器流量，并将流量转发至目标服务或地址，且具有无须重启即可更新配置，自动的服务发现与负载均衡的特点


首先，当启动 Traefik 时，需要定义 entrypoints。然后，根据连接到这些 entrypoints 的 路由 来分析传入的请求，来查看他们是否与一组 规则 相匹配，如果匹配，则路由可能会将请求通过一系列 中间件 转换过后再转发到你的 服务 上去


- Providers 来发现基础设施上存在的服务（它们的 IP、运行状况等...）
- Entrypoints 监听传入的流量（端口等...）
- Routers 分析请求（host, path, headers, SSL, ...）
- Services 将请求转发到你的服务（load balancing, ...）
- Middlewares 中间件，用来修改请求或者根据请求来做出一些判断 （authentication, rate limiting, headers, ...）


```yaml
version: '3.3'

services:
  # 改镜像会暴露出自身的 `header` 信息
  whoami:
    image: containous/whoami
    labels:
      # 设置Host 为 whoami.docker.localhost 进行域名访问
      - "traefik.http.routers.whoami.rule=Host(`whoami.haoyu95.cn`)"

# 使用已存在的 traefik 的 network
networks:
  default:
    external:
      name: traefik_default
```




- [Traefik中文文档](https://www.qikqiak.com/traefik-book/)
- [更好的反向代理工具 Traefik 配置入门——Docker 篇](https://juejin.im/post/5e01c8a151882512243fa6d5#heading-7)



