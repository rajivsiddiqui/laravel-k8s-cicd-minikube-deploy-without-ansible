#!/bin/bash
# Run this after creating the service account to extract kubeconfig info

SA_NAME=jenkins
NAMESPACE=default
CLUSTER_NAME=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')
SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
SECRET=$(kubectl get sa $SA_NAME -n $NAMESPACE -o jsonpath='{.secrets[0].name}')
CA=$(kubectl get secret $SECRET -n $NAMESPACE -o jsonpath='{.data.ca\.crt}')
TOKEN=$(kubectl get secret $SECRET -n $NAMESPACE -o jsonpath='{.data.token}' | base64 --decode)

cat <<EOF > kubeconfig
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: $CA
    server: $SERVER
  name: $CLUSTER_NAME
contexts:
- context:
    cluster: $CLUSTER_NAME
    user: jenkins
    namespace: $NAMESPACE
  name: jenkins-context
current-context: jenkins-context
users:
- name: jenkins
  user:
    token: $TOKEN
EOF

echo "✅ kubeconfig file created: ./kubeconfig"
