#!/bin/bash

echo "======================================"
echo "   NETFLIX KUBERNETES DEPLOYMENT"
echo "======================================"

echo "[1/4] Starting Kind Kubernetes cluster..."
docker start boardgame-control-plane 2>/dev/null || true

echo "[2/4] Checking Kubernetes..."
kubectl wait --for=condition=Ready node/boardgame-control-plane --timeout=120s || exit 1

echo "[3/4] Checking Netflix deployment..."
kubectl rollout status deployment/netflix-app --timeout=120s || exit 1

echo "[4/4] Starting application..."

echo ""
echo "======================================"
echo " NETFLIX IS READY!"
echo " http://localhost:8084"
echo "======================================"
echo ""

kubectl port-forward service/netflix-app 8084:80
