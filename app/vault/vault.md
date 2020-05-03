

# 概览

Vault 用于保存登录密码、Token、证书、API Key 等私密信息，可以很方便的通用 RESTful API 和第三方包访问


- 权限控制很严格
- 安全到位，每一次 Vault 启动后都需要解封


# 架构

![1588156117](http://pic.haoyu95.cn/uploads/big/aac682ac390034e6edc84f2cc9c5dbd8.png)


Storage Bankend：负责数据的持久化，常见的后端有 Consul



# 安装

可以直接使用二进制文件安装，也可以使用 docker 或 k8s 安装


## k8s 安装

使用 helm 部署

helm install vault https://github.com/hashicorp/vault-helm/archive/v0.5.0.tar.gz

Helm 默认以standalone模式运行。即具有文件存储后端的单个Vault服务器，生产中需要在高可用性（HA）模式下运行，即运行多个 vault 服务器

helm 部署好之后执行一些初始化操作

```shell
# 查看所有 vault pod 的运行状态，因为没有解封，所以不会立即启动
kubectl get pods -l app.kubernetes.io/name=vault

# 初始化其中一台 Vault 服务器，会获得根 Token 和多个解封 key
kubectl exec -ti vault-0 -- vault operator init

# 对所有 vault 服务器解封
kubectl exec -ti vault-0 -- vault operator unseal [Key1 | Key2 | Key3]
```


# k8s 使用 vault

在应用程序生命周期内，需要读取配置，特别是在微服务架构下，使用环境变量和配置文件都是不可取的，这时就需要配置中心统一管理所有配置

使用较多的就是 apollo，但 apollo 中的数据都是以明文格式存储的，且读取数据不需要进行验证。所以 apollo 更适合存储业务类的数据，面向开发运营方面的数据，对于一些隐私的数据，比如密码、证书、密钥是不适合存储在 apollo 中的，对于这类数据目前有以下存储方案

1. 仍使用 apollo，将隐私数据加密后存入 apollo，然后客户端自己解密
2. 使用 k8s 的资源对象 Secret
3. 使用 vault


使用 Secret 相对是不安全的，只是使用 Base64 编码了一下



维护成本

- apollo: 需要自己实现加密解密方法
- vault: 维护 vault 服务器、注入 sidecar、修改 yaml 模版


泄漏风险


- apollo 通过 api 读取任何数据、vault 不能随意调用
- apollo 解密方法泄漏所有数据泄漏，vault 获取了 token，只能查看对于的数据
- vault 如果登录到容器里就能查看一部分配置，apollo 代码加密，


泄漏后维护

- apollo 加密方法泄漏后需修改代码，重新打包部署
- vault token 泄漏后刷新 token 就行



使用 Vault 

Vault 提供了 Kubernetes 身份验证方法，使客户端可以使用 Kubernetes 服务帐户令牌进行身份验证。令牌在创建时会提供给每个 pod

在身份验证期间，Vault通过查询已配置的Kubernetes端点来验证服务帐户令牌是否有效


```shell
# 创建一个 v2 版本的 kv 存储引擎 internal
vault secrets enable -path=internal kv-v2

# 在 internal 中创建路径的 database/config 的配置项
vault kv put internal/database/config username="haoyu" password="zijin"

# 验证配置项是否成功创建
vault kv get internal/database/config


# 开启 Kubernetes 身份验证方法
vault auth enable kubernetes

# 配置 Kubernetes 身份验证方法以使用服务帐户令牌，Kubernetes 主机的位置及其证书
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt


# 定义策略 internal-app，使其能够读取 internal/data/database/config
vault policy write internal-app - <<EOF
path "internal/data/database/config" {
  capabilities = ["read"]
}
EOF

# 创建 Kubernetes 身份验证角色 internal-app
vault write auth/kubernetes/role/internal-app \
   bound_service_account_names=internal-app \
   bound_service_account_namespaces=default \
   policies=internal-app \
   ttl=24h
```


在 k8s 中

创建服务账号 internal-app

```yaml
# service-account-internal-app.yml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: internal-app
```

创建测试程序 orgchart

```yaml
# deployment-orgchart.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: orgchart
  labels:
    app: vault-agent-injector-demo
spec:
  selector:
    matchLabels:
      app: vault-agent-injector-demo
  replicas: 1
  template:
    metadata:
      annotations:
        vault.hashicorp.com/agent-inject: "true"    # 启用 Vault Agent 注入
        vault.hashicorp.com/agent-inject-status: "update"    # 通知重新注入
        vault.hashicorp.com/role: "internal-app"    # Vault Kubernetes 身份验证角色
        vault.hashicorp.com/agent-inject-secret-vault-config.json: "internal/data/database/config"
        vault.hashicorp.com/agent-inject-template-vault-config.json: |
          {{- with secret "internal/data/database/config" -}}
          {"username":"{{ .Data.data.username }}","password":"{{ .Data.data.password }}"}
          {{- end -}}
      labels:
        app: vault-agent-injector-demo
    spec:
      serviceAccountName: internal-app
      containers:
        - name: orgchart
          image: jweissig/app:0.0.1
```


在 k8s 中部署 vault 之后，会使用和 istio 一样的方式注入 sidecar，为 Vault Agent。 Vault Agent 会监听 vault 服务器获取配置，并判断是否往 pod 中写入配置，只有 pod 写入特定声明时才会写入，注意写入到 pod 中的配置是解密之后的配置。写入路径为  /vault/secrets








helm install vault --set "server.ha.enabled=true" ./

Unseal Key 1: ts43hfoKtMxdHGWRi1BGNUse0BNQK9vd1/ZqLWbPMVH1
Unseal Key 2: ZklnTeIfBBh28srC+5YqYqsMa4YvWOoj+eu/z4mbxah1
Unseal Key 3: 65p6R0jEevbe5r2bh568HzXr97AZ0ALrHQAhaxAHugDf
Unseal Key 4: 4d4CoHws2wQ377I8m6j5xG2akfTcuDeW0Znwg7taJd73
Unseal Key 5: Ad9PTImBaEGQvAkWETirrc2i4wzCBeMxeT6CAoEipF1E

Initial Root Token: s.nfKtUVpx5M1nEC5g1eMcPcYU







# api 好实用

```shell
# 设置环境变量
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN='s.xMN376JwdDvlX7zabND4Clfk'


vault kv put test/t1 name=haoyu age=22    # 写入数据
vault kv get test/t1    # 读取数据

```


```shell
client.secrets.kv.v2.list_secrets(path='this', mount_point='test')


curl -H "X-Vault-Token: s.xMN376JwdDvlX7zabND4Clfk" -X GET http://192.168.1.66:8200/secret/tl

curl -H "X-Vault-Token: s.xMN376JwdDvlX7zabND4Clfk" -X GET http://192.168.1.66:8200/v2/tl/metadata/confg1

import hvac
client = hvac.Client(url='http://vault.wiqun.com', token='s.xMN376JwdDvlX7zabND4Clfk')
client.secrets.kv.v2.read_secret_version(path='this', mount_point='test')
```



# 扩展阅读

- [官方网站](https://www.vaultproject.io/)
- [中文文档](https://www.shipengqi.top/vault-docs-Zh-CN/)
- [python 库](https://hvac.readthedocs.io/en/stable/usage/index.html)


- [云原生安全-更安全的密文管理 Vault on ACK](https://yq.aliyun.com/articles/741424)
- [Vault+K8S 最佳实践](https://www.sagittarius.ai/blog/2018/10/21/vault-k8s-best-practice)
- [在 Kubernetes 上部署 Vault](https://www.qikqiak.com/post/deploy-vault-on-k8s/)
