> Flagger 是一种渐进式交付工具，用于发布 Kubernetes 上运行的程序。通过 prometheus 指标和 istio 路由权重实现自动灰度，自动回滚


# 一：Flagger

flagger 架构：

![1583737145](https://pic.haoyu95.cn/uploads/big/694ca891c4e0e9452595ac0bc86f2612.png)


# 二：安装

这里使用 helm 安装，也可以直接使用官方仓库里的 yaml 文件安装

```bash
helm repo add flagger https://flagger.app
kubectl apply -f https://raw.githubusercontent.com/weaveworks/flagger/master/artifacts/flagger/crd.yaml


# 安装 flagger
helm upgrade -i flagger flagger/flagger \
--namespace=istio-system \
--set crd.create=false \
--set meshProvider=istio \
--set metricsServer=http://prometheus:9090 \
--set slack.url=${webhook} \    # slack 的 webhook
--set slack.channel=general \
--set slack.user=flagger
```


helm install flagger ./





# 监控


```bash

```


# 扩展阅读

- [flagger 官方文档](https://docs.flagger.app/v/master/)
- [基于Flagger和Istio实现自动化金丝雀部署](https://www.servicemesher.com/blog/automated-canary-deployments-with-flagger-and-istio/)
- [使用 flagger 实现 automated canary analysis](https://hacpai.com/article/1574058151661)
- [flagger集成istio自动完成金丝雀部署](https://ciweigg2.github.io/2019/06/30/flagger-ji-cheng-istio-zi-dong-wan-cheng-jin-si-que-bu-shu/#!)


