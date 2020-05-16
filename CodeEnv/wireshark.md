


## 过滤

### 抓包过滤器

- 类型：host net port
- 方向：src, dst
- 协议：ether, ip, tcp, udp, http, ftp
- 逻辑运算符：或与非  || && !

```shell
# 过滤 MAC 地址
ether host 00:0e:c6:5c:4e:22
ether src host 00:0e:c6:5c:4e:22

# 过滤 IP 地址
host 192.168.31.101
dst host 192.168.31.101

# 过滤端口
port 80
src port 80

# 过滤协议
arp
```



### 显示过滤器

- 比较操作符：== != > <
- 逻辑操作符：and or not

```shell
# 过滤 ip 地址
ip.addr == 192.168.31.102
ip.src==192.168.31.101
ip.dst==192.168.31.101

# 过滤端口
tcp.port == 80
tcp.srcport == 80

# 过滤协议
smb2

# 其他
http.request.method=="GET"       显示 HTTP GET方法
```


# 功能




## 扩展阅读

- [官方文档](https://www.wireshark.org/docs/wsug_html_chunked/index.html)


- [使用wireshark抓包分析-抓包实用技巧](https://www.cnblogs.com/Jack-Blog/p/11106195.html)
- [tcpdump/wireshark 抓包及分析（2019）](https://arthurchiao.github.io/blog/tcpdump-practice-zh/)


