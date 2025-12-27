#!/bin/bash
# HAProxy Setup Script for Kubernetes API Load Balancer
# Run as root on the Bastion/HAProxy server

# ======= CHANGE THESE IPs TO YOUR NEW MASTER NODES =======
MASTER1_IP="MASTER01_PRIVATE_IP"
MASTER2_IP="MASTER02_PRIVATE_IP"
# Uncomment and add more if you have additional masters
# MASTER3_IP="MASTER03_PRIVATE_IP"

# ======= Install HAProxy if not installed =======
echo "Updating packages..."
apt update -y

echo "Installing HAProxy..."
apt install -y haproxy

# ======= Backup existing HAProxy config =======
if [ -f /etc/haproxy/haproxy.cfg ]; then
    echo "Backing up existing HAProxy config..."
    cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak
fi

# ======= Write new HAProxy config =======
echo "Writing new HAProxy configuration..."
cat > /etc/haproxy/haproxy.cfg <<EOF
global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 30s
    user haproxy
    group haproxy
    daemon
    maxconn 2000

defaults
    log global
    mode tcp
    option tcplog
    option dontlognull
    timeout connect 10s
    timeout client 1m
    timeout server 1m
    retries 3

frontend k8s_api
    bind *:6443
    default_backend k8s_api_backend

backend k8s_api_backend
    balance roundrobin
    option tcp-check
    server master01 $MASTER1_IP:6443 check
    server master02 $MASTER2_IP:6443 check
EOF

# Add third master if defined
if [ ! -z "$MASTER3_IP" ]; then
    echo "    server master03 $MASTER3_IP:6443 check" >> /etc/haproxy/haproxy.cfg
fi

# ======= Restart and enable HAProxy =======
echo "Restarting and enabling HAProxy..."
systemctl restart haproxy
systemctl enable haproxy

# ======= Check HAProxy status =======
echo "HAProxy status:"
systemctl status haproxy --no-pager

# ======= Test HAProxy config =======
echo "Testing HAProxy configuration..."
haproxy -c -f /etc/haproxy/haproxy.cfg && echo "HAProxy configuration is valid!"
