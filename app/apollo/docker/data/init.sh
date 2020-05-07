#!/bin/bash



wget https://raw.githubusercontent.com/ctripcorp/apollo/master/scripts/sql/apolloconfigdb.sql

wget https://raw.githubusercontent.com/ctripcorp/apollo/master/scripts/sql/apolloportaldb.sql


rm -rf init && mkdir init
cp apolloconfigdb.sql init/apolloconfigdbdev.sql
cp apolloconfigdb.sql init/apolloconfigdbfat.sql
cp apolloconfigdb.sql init/apolloconfigdbuat.sql
cp apolloconfigdb.sql init/apolloconfigdbpro.sql
cp apolloportaldb.sql init/apolloportaldb.sql


sed -i 's@ApolloConfigDB@ApolloConfigDBDev@g' init/apolloconfigdbdev.sql
sed -i 's@http://localhost:8080/eureka/@http://localhost:8081/eureka/@g' init/apolloconfigdbdev.sql

sed -i 's@ApolloConfigDB@ApolloConfigDBFat@g' init/apolloconfigdbfat.sql
sed -i 's@http://localhost:8080/eureka/@http://localhost:8081/eureka/@g' init/apolloconfigdbfat.sql

sed -i 's@ApolloConfigDB@ApolloConfigDBUat@g' init/apolloconfigdbuat.sql
sed -i 's@http://localhost:8080/eureka/@http://localhost:8082/eureka/@g' init/apolloconfigdbuat.sql

sed -i 's@ApolloConfigDB@ApolloConfigDBPro@g' init/apolloconfigdbpro.sql
sed -i 's@http://localhost:8080/eureka/@http://localhost:8083/eureka/@g' init/apolloconfigdbpro.sql



sed -i "s@'apollo.portal.envs', 'dev'@'apollo.portal.envs', 'dev,fat,uat,pro'@g" init/apolloportaldb.sql
sed -i 's@TEST1@TL@g' init/apolloportaldb.sql
sed -i 's@样例部门1@initialize@g' init/apolloportaldb.sql


rm -rf apolloconfigdb.sql apolloportaldb.sql

