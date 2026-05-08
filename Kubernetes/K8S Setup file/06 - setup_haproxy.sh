#!/bin/bash
# HAProxy + kubectl bootstrap for Kubernetes Bastion

set -e

# ======= MASTER IPs (EDIT THESE) =======
MASTER1_IP="MASTER01_PRIVATE_IP"
MASTER2_IP="MASTER02_PRIVATE_IP"
MASTER3_IP=""

echo "========== Updating system =========="
apt update -y

# ======= Install HAProxy =======
echo "========== Installing HAProxy =========="
apt install -y haproxy

# ======= Install kubectl (official repo) =======
echo "========== Installing kubectl =========="
apt-get install -y ca-certificates curl gnupg

mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key \
 | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" \
| tee /etc/apt/sources.list.d/kubernetes.list

apt update -y
apt install -y kubectl

# ======= Setup kubeconfig (NO connection error fix) =======
echo "========== Setting kubeconfig =========="
mkdir -p $HOME/.kube

# Copy from first master
scp root@$MASTER1_IP:/etc/kubernetes/admin.conf $HOME/.kube/config

chmod 600 $HOME/.kube/config

export KUBECONFIG=$HOME/.kube/config

# ======= HAProxy backup =======
if [ -f /etc/haproxy/haproxy.cfg ]; then
    cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak
fi

# ======= HAProxy config =======
echo "========== Writing HAProxy config =========="
cat > /etc/haproxy/haproxy.cfg <<EOF
global
    log /dev/log local0
    log /dev/log local1 notice
    daemon
    maxconn 2000

defaults
    mode tcp
    timeout connect 10s
    timeout client 1m
    timeout server 1m

frontend k8s_api
    bind *:6443
    default_backend k8s_api_backend

backend k8s_api_backend
    balance roundrobin
    option tcp-check
    server master01 $MASTER1_IP:6443 check
    server master02 $MASTER2_IP:6443 check
EOF

if [ ! -z "$MASTER3_IP" ]; then
cat >> /etc/haproxy/haproxy.cfg <<EOF
    server master03 $MASTER3_IP:6443 check
EOF
fi

# ======= Restart HAProxy =======
systemctl restart haproxy
systemctl enable haproxy

# ======= FINAL TESTS =======
echo "========== VERIFY SETUP =========="

echo "HAProxy:"
systemctl is-active haproxy

echo "kubectl version:"
kubectl version --client

echo "Cluster nodes:"
kubectl get nodes || echo "⚠️ Cluster not reachable yet (check masters/API)"

echo "========== SETUP COMPLETE =========="
