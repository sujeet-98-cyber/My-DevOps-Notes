# ArgoCD + MetalLB + NGINX Ingress — Complete Installation Guide

| Setting | Value |
|---|---|
| Domain | `argocd.local` |
| Load Balancer IP | `172.16.106.252` |

> **Fixes included:** No login loop · No 401 errors · Working NGINX Ingress config

---

## Step 1 — Install MetalLB

```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
```

---

## Step 2 — Wait for MetalLB Pods

```bash
kubectl get pods -n metallb-system -w
```

---

## Step 3 — Create MetalLB IP Pool

```bash
cat <<EOF | kubectl apply -f -
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: production-pool
  namespace: metallb-system
spec:
  addresses:
  - 172.16.106.252-172.16.106.252
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: production-l2
  namespace: metallb-system
spec:
  ipAddressPools:
  - production-pool
EOF
```

---

## Step 4 — Verify MetalLB

```bash
kubectl get ipaddresspool -n metallb-system
kubectl get l2advertisement -n metallb-system
```

---

## Step 5 — Install NGINX Ingress

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

---

## Step 6 — Wait for Ingress Pods

```bash
kubectl get pods -n ingress-nginx -w
```

---

## Step 7 — Assign External IP

```bash
kubectl patch svc ingress-nginx-controller \
  -n ingress-nginx \
  -p '{"spec":{"type":"LoadBalancer","loadBalancerIP":"172.16.106.252"}}'
```

---

## Step 8 — Verify External IP

```bash
kubectl get svc -n ingress-nginx
```

**Expected output:**

```
EXTERNAL-IP
172.16.106.252
```

---

## Step 9 — Install ArgoCD

```bash
kubectl create namespace argocd

kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

---

## Step 10 — Wait for ArgoCD Pods

```bash
kubectl get pods -n argocd -w
```

---

## Step 11 — Enable Insecure Mode

> **Required** to avoid login loop and 401 errors.

```bash
kubectl patch configmap argocd-cmd-params-cm \
  -n argocd \
  --type merge \
  -p '{"data":{"server.insecure":"true"}}'
```

---

## Step 12 — Restart ArgoCD Server

```bash
kubectl rollout restart deployment argocd-server -n argocd
```

---

## Step 13 — Verify ArgoCD Service

```bash
kubectl get svc argocd-server -n argocd
```

**Expected output:**

```
PORT(S)
80/TCP,443/TCP
```

---

## Step 14 — Create Ingress Resource

```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd-ingress
  namespace: argocd
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    nginx.ingress.kubernetes.io/proxy-buffer-size: "16k"
spec:
  ingressClassName: nginx
  rules:
  - host: argocd.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: argocd-server
            port:
              number: 80
EOF
```

---

## Step 15 — Verify Ingress

```bash
kubectl get ingress -n argocd
```

---

## Step 16 — Update Hosts File (Windows / Laptop)

Edit the hosts file at:

```
C:\Windows\System32\drivers\etc\hosts
```

Add the following entry:

```
172.16.106.252    argocd.local
```

---

## Step 17 — Access ArgoCD

Open in your browser:

```
http://argocd.local
```

---

## Step 18 — Get Initial Admin Password

```bash
kubectl get secret argocd-initial-admin-secret \
  -n argocd \
  -o jsonpath="{.data.password}" | base64 -d && echo
```

**Login credentials:**

| Field | Value |
|---|---|
| Username | `admin` |
| Password | *(output from command above)* |

---

## Step 19 — Optional Verification

```bash
kubectl get nodes
kubectl get pods -A
kubectl get svc -A
kubectl get ingress -A
```

---

## Troubleshooting

**Check NGINX Ingress logs:**

```bash
kubectl logs -n ingress-nginx deploy/ingress-nginx-controller
```

**Check ArgoCD Server logs:**

```bash
kubectl logs -n argocd deploy/argocd-server
```

---

## Expected Results

- ✅ MetalLB working
- ✅ Ingress working
- ✅ ArgoCD accessible at `http://argocd.local`
- ✅ Login successful
- ✅ No login loop
- ✅ No 401 errors
