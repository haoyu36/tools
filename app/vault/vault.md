

# 概览

## 配置管理

在应用程序生命周期内，需要读取配置，特别是在微服务架构下，使用环境变量和配置文件都是不可取的，这时就需要配置中心统一管理所有配置

配置中心选型使用是 apollo，但 apollo 中的数据都是以明文格式存储的，且读取数据不需要进行验证。所以 apollo 更适合存储业务类的数据。对于一些隐私的数据，比如密码、证书、密钥是不适合存储在 apollo 中的，需要使用其他存储方案


对于这类数据目前有以下存储方案：

1. 使用 k8s 的资源对象 Secret
2. 仍使用 apollo，将隐私数据加密后存入 apollo，然后客户端自己解密
3. 使用 vault


使用 Secret 相对是不安全的，只是使用 Base64 编码了一下


## vault

在 k8s 中部署 vault 之后，会使用和 istio 一样的方式注入 sidecar，为 Vault Agent。 Vault Agent 会监听 vault 服务器获取配置，并判断是否往 pod 中写入配置，只有 pod 写入特定声明时才会写入，注意写入到 pod 中的配置是解密之后的配置。写入路径为  /vault/secrets


Vault 用于保存登录密码、Token、证书、API Key 等私密信息，可以很方便的通用 RESTful API 和第三方包访问


- 权限控制很严格
- 安全到位，每一次 Vault 启动后都需要解封


根令牌是用于配置保险柜的初始访问令牌。它具有root特权，因此可以在Vault中执行任何操作


root 和default策略是必填策略，不能删除。该 default策略提供一组通用的权限，默认情况下包含在所有令牌中。该root策略授予令牌超级管理员权限，类似于linux计算机上的root用户。


## 架构

![1588156117](http://pic.haoyu95.cn/uploads/big/aac682ac390034e6edc84f2cc9c5dbd8.png)

Storage Bankend：负责数据的持久化，常见的后端有 Consul


# 安装

可以直接使用二进制文件安装，也可以使用 docker 或 k8s 安装

## 二进制文件

通过二进制文件安装后，可以使用 `vault server -dev` 启动一个开发环境下的 vault，此模式下数据存储在内存中，并且 Unseal Key 和 Root Token 都在控制台输出

在生产环境第一次运行 vault 时，需要一些初始化操作

```shell
# 初始化 vault
vault operator init

# 解封
vault operator unseal [Key1 | Key2 | Key3]
```


## k8s 安装

```shell
# 使用 helm 直接部署
helm install vault https://github.com/hashicorp/vault-helm/archive/v0.5.0.tar.gz
```

如果不加任何参数，则以 standalone 模式运行，即具有文件存储后端的单个Vault服务器。生产中需要在高可用性（HA）模式下运行，即运行多个 vault 服务器，这里以 mysql 作为存储后端，并设置高可用

```shell
git clone https://github.com/hashicorp/vault-helm.git
cd vault-helm
git checkout v0.5.0    # Checkout a tagged version
```

把后端存储 consul 改为 mysql

```yaml
ha:
  ...
  config: |
    ...
    storage "mysql" {
      address = "192.168.5.214:3306"
      username = "root"
      password = "Admin123"
      database = "vault"
      ha_enabled = "true"
    }
```

然后执行 `helm install vault --set "server.ha.enabled=true" ./` 部署，部署好之后执行 初始化操作

```shell
# 查看所有 vault pod 的运行状态，因为没有解封，所以不会立即启动
kubectl get pods -l app.kubernetes.io/name=vault

# 初始化其中一台 Vault 服务器，会获得根 Token 和多个解封 key
kubectl exec -ti vault-0 -- vault operator init

# 对所有 vault 服务器解封
kubectl exec -ti vault-0 -- vault operator unseal Key
```

# api 使用

## CLI

```shell
# 设置环境变量
export VAULT_ADDR='your api address'    # 以 http 或 https 开头
export VAULT_TOKEN='your token'

# 当前 vault 状态
vault status
```

### Secrets Engines

```shell
# 创建一个 v2 版本的 kv 存储引擎 zijin
vault secrets enable -path=zijin kv-v2 

# 当前所有 secrets engine
vault secrets list

# 列出 secrets engine 中的所有健
vault kv list zijin

# 禁用 secrets engine
vault secrets disable zijin/
```

### kv

```shell
# 往路径 zijin/hello 中写入键值
vault kv put zijin/a name=haoyu

# 当然，路径可以为多层
vault kv put zijin/b/c app=vault

# 也可以写入多个键值
vault kv put zijin/d lan1=python lan2=go

# 读取 zijin/d 路径下的数据
vault kv get zijin/d

# 把数据转为 json 格式
vault kv get -format=json zijin/d

# 删除 zijin/d 路径下的数据
vault kv delete zijin/d
```

### token

```shell
# 创建 token，继承自 root
➜  ~ vault token create
Key                  Value
---                  -----
token                s.02h2f2O0JFQVtGwgkz8BcByL
token_accessor       a62cBlNdaoKuOvTX5aOGAcH4
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]

# 移除 token
vault token revoke s.02h2f2O0JFQVtGwgkz8BcByL

# 续签 token
vault token renew s.02h2f2O0JFQVtGwgkz8BcByL
```


## curl

```shell
export VAULT_TOKEN='your token'

curl -H "X-Vault-Token: $VAULT_TOKEN" -X GET http://192.168.1.66:8200/v1/zijin/data/hello
```


## python

```python
import hvac
client = hvac.Client(url='your ip addr', token='your token')
client.secrets.kv.v2.read_secret_version(path='hello', mount_point='zijin')
```


# k8s 使用 vault

Vault 提供了 Kubernetes 身份验证方法，使客户端可以使用 Kubernetes 服务帐户令牌进行身份验证。令牌在创建时会提供给每个 pod。在身份验证期间，Vault通过查询已配置的 Kubernetes 端点来验证服务帐户令牌是否有效


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



# 扩展阅读

- [官方网站](https://www.vaultproject.io/)
- [中文文档](https://www.shipengqi.top/vault-docs-Zh-CN/)
- [python 库](https://hvac.readthedocs.io/en/stable/usage/index.html)


- [云原生安全-更安全的密文管理 Vault on ACK](https://yq.aliyun.com/articles/741424)
- [Vault+K8S 最佳实践](https://www.sagittarius.ai/blog/2018/10/21/vault-k8s-best-practice)
- [在 Kubernetes 上部署 Vault](https://www.qikqiak.com/post/deploy-vault-on-k8s/)

- [chiflix/vault-best-practice](https://github.com/chiflix/vault-best-practice)
