
# Kubernetes Cluster Setup – Step-by-Step SOP

## PREREQUISITES
- Root access on all nodes
- Password-based SSH initially enabled
- Master node can reach all worker nodes over SSH
- Internet connectivity available on all nodes
- Ubuntu OS on all nodes

## STEP 1: Login to Master Node
```bash
ssh root@<MASTER_IP>
```

## STEP 2: Verify SSH Connectivity from Master to Workers
```bash
ssh root@<WORKER1_IP>
ssh root@<WORKER2_IP>
```

**IF SSH FAILS:**
- Refer to: `SSH Issue Resolution.txt`
- Fix SSH issues first
- Do NOT proceed until SSH works from master to all workers

## STEP 3: Update Master and Worker Nodes (UPDATE ONLY)
**Run on MASTER:**
```bash
apt update -y
```

**Run on WORKERS from MASTER using SSH:**
```bash
ssh root@<WORKER1_IP> "apt update -y"
ssh root@<WORKER2_IP> "apt update -y"
```

## STEP 4: Generate SSH Key on Master
```bash
ls -l ~/.ssh/id_rsa
```

If not present, generate key:
```bash
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
```

## STEP 5: Copy SSH Key to Workers (From Master Only)
```bash
ssh-copy-id root@<WORKER1_IP>
ssh-copy-id root@<WORKER2_IP>
```

Verify passwordless SSH:
```bash
ssh root@<WORKER1_IP>
ssh root@<WORKER2_IP>
```

## STEP 6: Create Required Script Files on Master
```bash
vi master.sh
vi worker.sh
vi master-init.sh
```

## STEP 7: Make Scripts Executable
```bash
chmod +x master.sh
chmod +x worker.sh
chmod +x master-init.sh
```

## STEP 8: Run Master Setup Script (On Master)
```bash
./master.sh
```

## STEP 9: Run Worker Setup Script on Workers (FROM MASTER)
```bash
ssh root@<WORKER1_IP> "/root/worker.sh"
ssh root@<WORKER2_IP> "/root/worker.sh"
```

## STEP 10: Initialize Kubernetes Master
```bash
./master-init.sh
```
*This will generate the kubeadm join command*

## STEP 11: Join Workers to Cluster (FROM MASTER)
```bash
ssh root@<WORKER1_IP> "<kubeadm join command>"
ssh root@<WORKER2_IP> "<kubeadm join command>"
```

## STEP 12: Verify Cluster Status
```bash
kubectl get nodes
kubectl get pods -A
```

## EXPECTED RESULT
- Master node in Ready state
- All worker nodes in Ready state
- Kubernetes cluster successfully initialized

## IMPORTANT NOTES
- Always execute worker operations FROM MASTER via SSH
- Do NOT manually log into workers unless required
- Do NOT upgrade OS packages during setup
- Ensure DNS and network connectivity before starting

# END OF DOCUMENT
