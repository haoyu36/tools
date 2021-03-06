#!/bin/bash

# 下载 ApolloPortalDB 和 ApolloConfigDB 初始 sql 文件，地址 https://github.com/ctripcorp/apollo/tree/master/scripts/sql 
wget https://raw.githubusercontent.com/ctripcorp/apollo/master/scripts/sql/apolloconfigdb.sql
wget https://raw.githubusercontent.com/ctripcorp/apollo/master/scripts/sql/apolloportaldb.sql


# 部署多个环境: dev、fat、uat、pro 
# apolloconfigdb.sql 复制 4 份，并分别加环境后缀
rm -rf init-sql && mkdir init-sql
cp apolloconfigdb.sql init-sql/apolloconfigdbdev.sql
cp apolloconfigdb.sql init-sql/apolloconfigdbfat.sql
cp apolloconfigdb.sql init-sql/apolloconfigdbuat.sql
cp apolloconfigdb.sql init-sql/apolloconfigdbpro.sql
cp apolloportaldb.sql init-sql/apolloportaldb.sql


# 修改 sql 文件里的数据库名称
# 修改 ServerConfig 表的 eureka.service.url，dev、fat、uat、pro 分别为 8080、8081、8082、8083
sed -i 's@ApolloConfigDB@ApolloConfigDBDev@g' init-sql/apolloconfigdbdev.sql
sed -i 's@http://localhost:8080/eureka/@http://localhost:8081/eureka/@g' init-sql/apolloconfigdbdev.sql

sed -i 's@ApolloConfigDB@ApolloConfigDBFat@g' init-sql/apolloconfigdbfat.sql
sed -i 's@http://localhost:8080/eureka/@http://localhost:8081/eureka/@g' init-sql/apolloconfigdbfat.sql

sed -i 's@ApolloConfigDB@ApolloConfigDBUat@g' init-sql/apolloconfigdbuat.sql
sed -i 's@http://localhost:8080/eureka/@http://localhost:8082/eureka/@g' init-sql/apolloconfigdbuat.sql

sed -i 's@ApolloConfigDB@ApolloConfigDBPro@g' init-sql/apolloconfigdbpro.sql
sed -i 's@http://localhost:8080/eureka/@http://localhost:8083/eureka/@g' init-sql/apolloconfigdbpro.sql

# 增加环境
sed -i "s@'apollo.portal.envs', 'dev'@'apollo.portal.envs', 'dev,fat,uat,pro'@g" init-sql/apolloportaldb.sql

rm -rf apolloconfigdb.sql apolloportaldb.sql

