# create namespace
kubectl create namespace sre


# uat-env(test-beta-env)
kubectl apply -f apollo-env-test-beta/service-mysql-for-apollo-test-beta-env.yaml --record
kubectl apply -f apollo-env-test-beta/service-apollo-config-server-test-beta.yaml --record
kubectl apply -f apollo-env-test-beta/service-apollo-admin-server-test-beta.yaml --record



# portal
kubectl apply -f service-apollo-portal-server.yaml --record

kubectl apply -f apollo_ingress.yaml -n sre
