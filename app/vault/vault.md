


# 概览

Vault 用于保存登录密码、Token、证书、API Key 等私密信息，可以很方便的通用 RESTful API 和第三方包访问


- 权限控制很严格
- 安全到位，每一次 Vault 启动后都需要解封


# 安装

可以直接使用二进制文件安装，也可以使用 docker 或 k8s 安装

# 架构

![1588156117](https://pic.haoyu95.cn/uploads/big/aac682ac390034e6edc84f2cc9c5dbd8.png)


Storage Bankend：负责数据的持久化，常见的后端有 Consul










- [官方网站](https://www.vaultproject.io/)
- [中文文档](https://www.shipengqi.top/vault-docs-Zh-CN/)
- [python 库](https://hvac.readthedocs.io/en/stable/usage/index.html)


- [云原生安全-更安全的密文管理 Vault on ACK](https://yq.aliyun.com/articles/741424)
- [Vault+K8S 最佳实践](https://www.sagittarius.ai/blog/2018/10/21/vault-k8s-best-practice)
- [在 Kubernetes 上部署 Vault](https://www.qikqiak.com/post/deploy-vault-on-k8s/)


```
client.secrets.kv.v2.list_secrets(path='this', mount_point='test')


curl -H "X-Vault-Token: s.xMN376JwdDvlX7zabND4Clfk" -X GET http://192.168.1.66:8200/secret/tl

curl -H "X-Vault-Token: s.xMN376JwdDvlX7zabND4Clfk" -X GET http://192.168.1.66:8200/v2/tl/metadata/confg1

import hvac
client = hvac.Client(url='http://vault.wiqun.com', token='s.xMN376JwdDvlX7zabND4Clfk')
client.secrets.kv.v2.read_secret_version(path='this', mount_point='test')
```


## 使用 ctl

```shell
# 设置环境变量
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN='s.xMN376JwdDvlX7zabND4Clfk'


```




{
  "keys": [
    "a9481bdf156b82f34112745f687084a169cedc79bd697da7ae29b2fbe625d0acca",
    "1852eb5c1585e2b0a43ef9d7d86d30dc479a4518e70a8593a291225e3f244027a9",
    "85c556ee154a596fb76380b9b712ba18e5146051a2bce9a6962f249fc8d646441f"
  ],
  "keys_base64": [
    "qUgb3xVrgvNBEnRfaHCEoWnO3Hm9aX2nrimy++Yl0KzK",
    "GFLrXBWF4rCkPvnX2G0w3EeaRRjnCoWTopEiXj8kQCep",
    "hcVW7hVKWW+3Y4C5txK6GOUUYFGivOmmli8kn8jWRkQf"
  ],
  "root_token": "s.xMN376JwdDvlX7zabND4Clfk"
}