# Kubernetes Cluster Setup – Step-by-Step SOP (HA with Bastion)

## PREREQUISITES
- Root access on all nodes
- Password-based SSH initially enabled
- Bastion can reach all Master and Worker nodes
- Internet connectivity on all nodes
- Ubuntu OS on all nodes
- Required ports open (6443, 2379-2380, 10250, 10257, 10259, etc.)
- Firewall disabled or properly configured

---

## STEP 1: Login to Bastion Node
```bash
ssh root@<BASTION_IP>
```

---

## STEP 2: Verify SSH Connectivity
```bash
ssh root@<MASTER1_IP>
ssh root@<MASTER2_IP>
ssh root@<WORKER1_IP>
ssh root@<WORKER2_IP>
```

---

## STEP 3: Update Nodes (ONLY UPDATE, NO UPGRADE)

**Run on Bastion:**
```bash
apt update -y
```

**Run from Bastion on all nodes:**
```bash
ssh root@<MASTER1_IP> "apt update -y"
ssh root@<MASTER2_IP> "apt update -y"
ssh root@<WORKER1_IP> "apt update -y"
ssh root@<WORKER2_IP> "apt update -y"
```

---

## STEP 4: Generate SSH Key (Bastion)
```bash
ls -l ~/.ssh/id_rsa
```

**If not present:**
```bash
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
```

---

## STEP 5: Copy SSH Key to All Nodes
```bash
ssh-copy-id root@<MASTER1_IP>
ssh-copy-id root@<MASTER2_IP>
ssh-copy-id root@<WORKER1_IP>
ssh-copy-id root@<WORKER2_IP>
```

---

## STEP 6: Create Required Scripts (on Bastion)
```bash
vi setup_haproxy.sh
vi master.sh
vi worker.sh
vi master-init.sh
```

---

## STEP 7: Make Scripts Executable
```bash
chmod +x setup_haproxy.sh
chmod +x master.sh
chmod +x worker.sh
chmod +x master-init.sh
```

---

## STEP 8: Copy Scripts to All Nodes
```bash
scp *.sh root@<MASTER1_IP>:/root/
scp *.sh root@<MASTER2_IP>:/root/
scp *.sh root@<WORKER1_IP>:/root/
scp *.sh root@<WORKER2_IP>:/root/
```

---

## STEP 9: Setup HAProxy (on Bastion)
```bash
./setup_haproxy.sh
```

---

## STEP 10: Run Master & Worker Setup Scripts
```bash
ssh root@<MASTER1_IP> "bash /root/master.sh"
ssh root@<MASTER2_IP> "bash /root/master.sh"
ssh root@<WORKER1_IP> "bash /root/worker.sh"
ssh root@<WORKER2_IP> "bash /root/worker.sh"
```

---

## STEP 11: Initialize Kubernetes Cluster (ONLY on MASTER1)

> Ensure controlPlaneEndpoint = <BASTION_IP>:6443

```bash
ssh root@<MASTER1_IP> "bash /root/master-init.sh"
```

---

## STEP 12: Join Nodes to Cluster
```bash
ssh root@<MASTER2_IP> "<kubeadm join command> --control-plane"
ssh root@<WORKER1_IP> "<kubeadm join command>"
ssh root@<WORKER2_IP> "<kubeadm join command>"
```

---

## STEP 13: Configure kubectl (on Bastion)
```bash
mkdir -p $HOME/.kube
scp root@<MASTER1_IP>:/etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

---

## STEP 14: Install CNI (MANDATORY)
```bash
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

---

## STEP 15: Verify Cluster
```bash
kubectl get nodes
kubectl get pods -A
```

---

## EXPECTED RESULT
- All Master nodes in Ready state
- All Worker nodes in Ready state
- Kubernetes cluster successfully initialized

---

# END OF DOCUMENT
