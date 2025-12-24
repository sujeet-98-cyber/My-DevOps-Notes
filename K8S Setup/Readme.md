# README.md

# Kubernetes Cluster Setup – Step-by-Step SOP

## PREREQUISITES
- Root access on all nodes
- Password-based SSH initially enabled
- Master node can reach all worker nodes over SSH
- Internet connectivity available on all nodes
- Ubuntu OS on all nodes

## STEP 1: Login to Master Node
Login to the master node as root:
ssh root@<MASTER_IP>

## STEP 2: Verify SSH Connectivity from Master to Workers
From the master node, try SSH to each worker:
ssh root@<WORKER1_IP>
ssh root@<WORKER2_IP>

**IF SSH FAILS:**
- Refer to: SSH Issue Resolution.txt
- Fix SSH issues first
- Do NOT proceed until SSH works from master to all workers

## STEP 3: Update Master and Worker Nodes (UPDATE ONLY)
**NOTE:** Only `apt update`, NO `apt upgrade`

**Run on MASTER:**
apt update -y

**Run on WORKERS FROM MASTER USING SSH:**
ssh root@<WORKER1_IP> "apt update -y"
ssh root@<WORKER2_IP> "apt update -y"

## STEP 4: Generate SSH Key on Master
Check if SSH key exists:
ls -l ~/.ssh/id_rsa

If not present, generate key:
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa

## STEP 5: Copy SSH Key to Workers (From Master Only)
ssh-copy-id root@<WORKER1_IP>
ssh-copy-id root@<WORKER2_IP>

Verify passwordless SSH:
ssh root@<WORKER1_IP>
ssh root@<WORKER2_IP>

## STEP 6: Create Required Script Files on Master
Create the following files using vi:
vi master.sh
vi worker.sh
vi master-init.sh

## STEP 7: Make Scripts Executable
chmod +x master.sh
chmod +x worker.sh
chmod +x master-init.sh

## STEP 8: Run Master Setup Script (On Master)
./master.sh

## STEP 9: Run Worker Setup Script on Workers (FROM MASTER)
ssh root@<WORKER1_IP> "/root/worker.sh"
ssh root@<WORKER2_IP> "/root/worker.sh"

## STEP 10: Initialize Kubernetes Master
Run on MASTER:
./master-init.sh

This will generate the kubeadm join command.

## STEP 11: Join Workers to Cluster (FROM MASTER)
Copy the join command output and run it remotely:
ssh root@<WORKER1_IP> "<kubeadm join command>"
ssh root@<WORKER2_IP> "<kubeadm join command>"

## STEP 12: Verify Cluster Status
On master:
kubectl get nodes
kubectl get pods -A

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
