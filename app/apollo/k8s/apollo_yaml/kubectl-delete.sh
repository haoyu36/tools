

# kubectl delete -f apollo_mysql.yaml --force --grace-period=0
# kubectl delete namespace sre

kubectl delete -f apollo-env-test-beta/service-mysql-for-apollo-test-beta-env.yaml
kubectl delete -f apollo-env-test-beta/service-apollo-config-server-test-beta.yaml
kubectl delete -f apollo-env-test-beta/service-apollo-admin-server-test-beta.yaml


# portal
kubectl delete -f service-apollo-portal-server.yaml


kubectl delete -f apollo_ingress.yaml -n sre

