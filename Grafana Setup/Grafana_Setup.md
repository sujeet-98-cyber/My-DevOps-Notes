# Kubernetes Monitoring Stack — Installation Guide

> **Scope:** Step-by-step installation only.
> For architecture and component details, see `monitoring-stack-info.md`.

---

## Prerequisites

### 1. Verify Kubernetes cluster

```bash
kubectl get nodes
```

All nodes should show `Ready` status.

---

### 2. Install Helm

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version
```

---

### 3. Install NGINX Ingress Controller

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm install ingress-nginx ingress-nginx/ingress-nginx \
  -n ingress-nginx \
  --create-namespace
```

Verify:

```bash
kubectl get svc -n ingress-nginx
```

---

### 4. Install Longhorn (Persistent Storage)

```bash
helm repo add longhorn https://charts.longhorn.io

helm install longhorn longhorn/longhorn \
  -n longhorn-system \
  --create-namespace
```

Verify pods and storage class:

```bash
kubectl get pods -n longhorn-system
kubectl get sc
```

---

## Step 1 — Add Prometheus Helm Repository

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

---

## Step 2 — Create Monitoring Namespace

```bash
kubectl create namespace monitoring
```

---

## Step 3 — Create `monitoring-values.yaml`

Create the file:

```bash
vi monitoring-values.yaml
```

Paste the following:

```yaml
# =============================================================================
# Prometheus Stack Configuration
# =============================================================================
# This values.yaml file is used for configuring:
# - Grafana
# - Prometheus
# - Alertmanager
# - Node Exporter
# - Kube State Metrics
#
# Storage Class Used  : longhorn
# Persistent Storage  : Enabled
# Monitoring Retention: 7 Days
# =============================================================================


# =============================================================================
# Grafana Configuration
# =============================================================================
grafana:

  # ---------------------------------------------------------------------------
  # Grafana Service Configuration
  # ---------------------------------------------------------------------------
  service:
    type: ClusterIP

  # ---------------------------------------------------------------------------
  # Grafana Persistent Storage Configuration
  # ---------------------------------------------------------------------------
  persistence:
    enabled: true
    storageClassName: longhorn
    accessModes:
      - ReadWriteOnce
    size: 5Gi

  # ---------------------------------------------------------------------------
  # Disable Default Dashboards
  # ---------------------------------------------------------------------------
  defaultDashboardsEnabled: false

  # ---------------------------------------------------------------------------
  # Disable Dashboard Provider
  # ---------------------------------------------------------------------------
  dashboardsProvider:
    enabled: false

  # ---------------------------------------------------------------------------
  # Disable External Dashboard ConfigMaps
  # ---------------------------------------------------------------------------
  dashboardsConfigMaps: {}

  # ---------------------------------------------------------------------------
  # Disable Sidecar Containers
  # ---------------------------------------------------------------------------
  sidecar:

    # Disable automatic dashboard discovery
    dashboards:
      enabled: false

    # Disable automatic datasource discovery
    datasources:
      enabled: false


# =============================================================================
# Alertmanager Configuration
# =============================================================================
alertmanager:

  alertmanagerSpec:

    # -------------------------------------------------------------------------
    # Alertmanager Persistent Storage Configuration
    # -------------------------------------------------------------------------
    storage:
      volumeClaimTemplate:
        spec:
          storageClassName: longhorn
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 5Gi


# =============================================================================
# Prometheus Configuration
# =============================================================================
prometheus:

  prometheusSpec:

    # -------------------------------------------------------------------------
    # Metrics Retention Period
    # -------------------------------------------------------------------------
    retention: 7d

    # -------------------------------------------------------------------------
    # Prometheus Persistent Storage Configuration
    # -------------------------------------------------------------------------
    storageSpec:
      volumeClaimTemplate:
        spec:
          storageClassName: longhorn
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 10Gi


# =============================================================================
# Prometheus Node Exporter Configuration
# =============================================================================
# Node Exporter collects hardware and OS-level metrics from Kubernetes nodes.
# Example:
# - CPU Usage
# - Memory Usage
# - Disk Usage
# - Network Statistics
# =============================================================================
prometheus-node-exporter:
  enabled: true


# =============================================================================
# Kube State Metrics Configuration
# =============================================================================
# Kube State Metrics exposes Kubernetes object metrics.
# Example:
# - Pod Status
# - Deployment Status
# - Replica Counts
# - StatefulSet Information
# - Namespace Metrics
# =============================================================================
kube-state-metrics:
  enabled: true
```

---

## Step 4 — Install the Monitoring Stack

```bash
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f monitoring-values.yaml
```

---

## Step 5 — Verify Installation

### Check pods

```bash
kubectl get pods -n monitoring
```

### Check services

```bash
kubectl get svc -n monitoring
```

### Check PVCs (expect 3 — Grafana, Prometheus, Alertmanager)

```bash
kubectl get pvc -n monitoring
```

### Verify Prometheus retention setting

```bash
kubectl get prometheus -n monitoring -o yaml | grep retention
# Expected: retention: 7d
```

---

## Step 6 — Create Grafana Ingress

Create the file:

```bash
vi grafana-ingress.yaml
```

Paste:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: grafana-ingress
  namespace: monitoring
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: grafana.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: kube-prometheus-stack-grafana
            port:
              number: 80
```

Apply:

```bash
kubectl apply -f grafana-ingress.yaml
```

---

## Step 7 — Configure Local DNS

Get the Ingress external IP:

```bash
kubectl get ingress -n monitoring
```

**Linux:**

```bash
sudo vi /etc/hosts
```

**Windows:** `C:\Windows\System32\drivers\etc\hosts`

Add this line (replace with your actual Ingress IP):

```
172.16.106.252 grafana.local
```

---

## Step 8 — Access Grafana

Open in browser:

```
http://grafana.local
```

Retrieve the admin password:

```bash
kubectl get secret -n monitoring kube-prometheus-stack-grafana \
  -o jsonpath="{.data.admin-password}" | base64 -d ; echo
```

Default username: `admin`

---

## Quick Reference — Useful Commands

| Task | Command |
|---|---|
| Check all monitoring pods | `kubectl get pods -n monitoring` |
| Check PVC status | `kubectl get pvc -n monitoring` |
| Check Grafana service | `kubectl get svc -n monitoring` |
| Check Ingress | `kubectl get ingress -n monitoring` |
| Check Prometheus retention | `kubectl describe pod prometheus-kube-prometheus-stack-prometheus-0 -n monitoring \| grep retention` |
| Check Prometheus disk usage | `kubectl exec -it -n monitoring prometheus-kube-prometheus-stack-prometheus-0 -- du -sh /prometheus` |
| Describe a PVC | `kubectl describe pvc <PVC_NAME> -n monitoring` |

---

## Troubleshooting

**Pods stuck in Pending** — Longhorn PVCs not bound. Verify Longhorn is running: `kubectl get pods -n longhorn-system`

**Grafana not accessible** — Check Ingress external IP is set correctly in `/etc/hosts`.

**No metrics in Grafana** — Verify Prometheus datasource is added manually (auto-provisioning is disabled in this config).


## Sample Dashboard

**Kubernetes Dashboard ID** — 15661
